Received: from eggs.gnu.org ([2001:4830:134:3::10]:53586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPvsx-0001AD-Lv
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fPvsu-0002n9-E7
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:15:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fPvst-0002mn-W5
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:15:20 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  4 Jun 2018 22:14:38 +0200
Message-Id: <1528143278-247932-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vl.c: make default main_loop_wait() timeout
 independed of slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jan.kiszka@siemens.com, pbonzini@redhat.com, ldoktor@redhat.com, mreitz@redhat.com, mprivozn@redhat.com, berrange@redhat.com, ehabkost@redhat.com

Since commit (047f7038f58 cli: add --preconfig option) QEMU is
stuck with indefinite timeout in os_host_main_loop_wait()
at RUN_STATE_PRECONFIG even if --preconfig option wasn't used
when it's started with -nodefaults CLI option like this:

  ./s390x-softmmu/qemu-system-s390x -nodefaults

It's caused by the fact that slirp_pollfds_fill() bails out early
and slirp_update_timeout() won't be called to update timeout
to a reasonable value (1 sec) so timeout would be left with
infinite value (0xFFFFFFFF).

Default infinite timeout though doen't make sense and reducing
it to 1 second as in slirp_update_timeout() won't affect host.
Fix issue by simplifying default timeout to the same 1sec as it
is in slirp_update_timeout() and cleanup the later. It makes
default timeout the same regardless of slirp_pollfds_fill()
exited early or not (i.e. -nodefaults won't have any effect on
main_loop_wait() anymore, which would provide more consistent
behavior between both variants of startup).

Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
PS:
it doesn't fix issue reported by Max where
  "echo foo | $QEMU"
is also broken due to commit 047f7038f58, but there is antoher fix
on the list to fix that (either Michal's or Daniel's).
---
 slirp/slirp.c    | 10 ++--------
 util/main-loop.c | 13 ++-----------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/slirp/slirp.c b/slirp/slirp.c
index 1cb6b07..1112f86 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -358,13 +358,8 @@ void slirp_cleanup(Slirp *slirp)
 static void slirp_update_timeout(uint32_t *timeout)
 {
     Slirp *slirp;
-    uint32_t t;
=20
-    if (*timeout <=3D TIMEOUT_FAST) {
-        return;
-    }
-
-    t =3D MIN(1000, *timeout);
+    assert(*timeout > TIMEOUT_FAST);
=20
     /* If we have tcp timeout with slirp, then we will fill @timeout wit=
h
      * more precise value.
@@ -375,10 +370,9 @@ static void slirp_update_timeout(uint32_t *timeout)
             return;
         }
         if (slirp->do_slowtimo) {
-            t =3D MIN(TIMEOUT_SLOW, t);
+            *timeout =3D MIN(TIMEOUT_SLOW, *timeout);
         }
     }
-    *timeout =3D t;
 }
=20
 void slirp_pollfds_fill(GArray *pollfds, uint32_t *timeout)
diff --git a/util/main-loop.c b/util/main-loop.c
index 992f9b0..fd23166 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -497,25 +497,16 @@ static int os_host_main_loop_wait(int64_t timeout)
 void main_loop_wait(int nonblocking)
 {
     int ret;
-    uint32_t timeout =3D UINT32_MAX;
     int64_t timeout_ns;
+    uint32_t timeout =3D nonblocking ? 0 : 1000 /* milliseconds */;
=20
-    if (nonblocking) {
-        timeout =3D 0;
-    }
=20
     /* poll any events */
     g_array_set_size(gpollfds, 0); /* reset for new iteration */
     /* XXX: separate device handlers from system ones */
     slirp_pollfds_fill(gpollfds, &timeout);
=20
-    if (timeout =3D=3D UINT32_MAX) {
-        timeout_ns =3D -1;
-    } else {
-        timeout_ns =3D (uint64_t)timeout * (int64_t)(SCALE_MS);
-    }
-
-    timeout_ns =3D qemu_soonest_timeout(timeout_ns,
+    timeout_ns =3D qemu_soonest_timeout((uint64_t)timeout * (int64_t)(SC=
ALE_MS),
                                       timerlistgroup_deadline_ns(
                                           &main_loop_tlg));
=20
--=20
2.7.4
