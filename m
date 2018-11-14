Received: from eggs.gnu.org ([2001:4830:134:3::10]:60070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuUm-0003ME-G2
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuUl-0003m0-MQ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuUl-0003ll-HE
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:42:11 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:30 +0400
Message-Id: <20181114123643.24091-29-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 28/41] slirp: replace error_report()
 with g_critical()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Reduce dependency on QEMU. QEMU could use a custom log handler if it
wants to redirect/filter it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/ip6_icmp.c | 2 +-
 slirp/misc.c     | 4 ++--
 slirp/slirp.c    | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 71d95daef0..e2e23d57bd 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -418,7 +418,7 @@ void icmp6_input(struct mbuf *m)
             icmp6_send_echoreply(m, slirp, ip, icmp);
         } else {
             /* TODO */
-            error_report("external icmpv6 not supported yet");
+            g_critical("external icmpv6 not supported yet");
         }
         break;
=20
diff --git a/slirp/misc.c b/slirp/misc.c
index dd2b3512a8..17361b79a4 100644
--- a/slirp/misc.c
+++ b/slirp/misc.c
@@ -119,7 +119,7 @@ slirp_socketpair_with_oob(int sv[2])
     return 0;
=20
 err:
-    error_report("Error: slirp_socketpair(): %s", strerror(errno));
+    g_critical("slirp_socketpair(): %s", strerror(errno));
     if (s >=3D 0) {
         closesocket(s);
     }
@@ -162,7 +162,7 @@ fork_exec(struct socket *so, const char *ex)
     g_strfreev(argv);
=20
     if (err) {
-        error_report("%s", err->message);
+        g_critical("fork_exec: %s", err->message);
         g_error_free(err);
         closesocket(sp[0]);
         closesocket(sp[1]);
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 864a9b5a7a..b1270a0309 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1215,8 +1215,8 @@ static int sbuf_tmp_post_load(void *opaque, int ver=
sion)
     }
     if (tmp->woff >=3D requested_len ||
         tmp->roff >=3D requested_len) {
-        error_report("invalid sbuf offsets r/w=3D%u/%u len=3D%u",
-                     tmp->roff, tmp->woff, requested_len);
+        g_critical("invalid sbuf offsets r/w=3D%u/%u len=3D%u",
+                   tmp->roff, tmp->woff, requested_len);
         return -EINVAL;
     }
=20
@@ -1324,7 +1324,7 @@ static int ss_family_post_load(void *opaque, int ve=
rsion_id)
         tss->parent->ss.ss_family =3D AF_INET6;
         break;
     default:
-        error_report("invalid ss_family type %x", tss->portable_family);
+        g_critical("invalid ss_family type %x", tss->portable_family);
         return -EINVAL;
     }
=20
--=20
2.19.1.708.g4ede3d42df
