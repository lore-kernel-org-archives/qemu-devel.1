Received: from eggs.gnu.org ([2001:4830:134:3::10]:48486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fsqyZ-00040V-LP
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fsqyY-0008H0-TZ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:52:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fsqyY-0008Gh-OC
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:52:42 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Thu, 23 Aug 2018 16:52:30 +0200
Message-Id: <20180823145230.13183-5-otubo@redhat.com>
In-Reply-To: <20180823145230.13183-1-otubo@redhat.com>
References: <20180823145230.13183-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] seccomp: set the seccomp filter to all
 threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, pmoore@redhat.com, berrange@redhat.com, eblake@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

When using "-seccomp on", the seccomp policy is only applied to the
main thread, the vcpu worker thread and other worker threads created
after seccomp policy is applied; the seccomp policy is not applied to
e.g. the RCU thread because it is created before the seccomp policy is
applied and SECCOMP_FILTER_FLAG_TSYNC isn't used.

This can be verified with
for task in /proc/`pidof qemu`/task/*; do cat $task/status | grep Secc ; =
done
Seccomp:	2
Seccomp:	0
Seccomp:	0
Seccomp:	2
Seccomp:	2
Seccomp:	2

Starting with libseccomp 2.2.0 and kernel >=3D 3.17, we can use
seccomp_attr_set(ctx, > SCMP_FLTATR_CTL_TSYNC, 1) to update the policy
on all threads.

libseccomp requirement was bumped to 2.2.0 in previous patch.
libseccomp should fail to set the filter if it can't honour
SCMP_FLTATR_CTL_TSYNC (untested), and thus -sandbox will now fail on
kernel < 3.17.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
---
 qemu-seccomp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index f0c833f3ca..4729eb107f 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -149,6 +149,11 @@ static int seccomp_start(uint32_t seccomp_opts)
         goto seccomp_return;
     }
=20
+    rc =3D seccomp_attr_set(ctx, SCMP_FLTATR_CTL_TSYNC, 1);
+    if (rc !=3D 0) {
+        goto seccomp_return;
+    }
+
     for (i =3D 0; i < ARRAY_SIZE(blacklist); i++) {
         if (!(seccomp_opts & blacklist[i].set)) {
             continue;
--=20
2.17.1
