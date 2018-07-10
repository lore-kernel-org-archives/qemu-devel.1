Received: from eggs.gnu.org ([2001:4830:134:3::10]:33570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fcu3o-00089J-Rl
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fcu3k-0005aA-3b
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:56:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fcu3j-0005Zs-UY
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 10:56:08 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jul 2018 16:55:57 +0200
Message-Id: <20180710145557.12902-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] seccomp: allow sched_setscheduler() with
 SCHED_IDLE policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eskultet@redhat.com, kraxel@redhat.com, berrange@redhat.com, gschafer@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Otubo <otubo@redhat.com>

Current and upcoming mesa releases rely on a shader disk cash. It uses
a thread job queue with low priority, set with
sched_setscheduler(SCHED_IDLE). However, that syscall is rejected by
the "resourcecontrol" seccomp qemu filter.

Since it should be safe to allow lowering thread priority, let's allow
scheduling thread to idle policy.

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1594456

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-seccomp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 148e4c6f24..9cd8eb9499 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -34,6 +34,12 @@
 struct QemuSeccompSyscall {
     int32_t num;
     uint8_t set;
+    uint8_t narg;
+    const struct scmp_arg_cmp *arg_cmp;
+};
+
+const struct scmp_arg_cmp sched_setscheduler_arg[] =3D {
+    SCMP_A1(SCMP_CMP_NE, SCHED_IDLE)
 };
=20
 static const struct QemuSeccompSyscall blacklist[] =3D {
@@ -92,7 +98,8 @@ static const struct QemuSeccompSyscall blacklist[] =3D =
{
     { SCMP_SYS(setpriority),            QEMU_SECCOMP_SET_RESOURCECTL },
     { SCMP_SYS(sched_setparam),         QEMU_SECCOMP_SET_RESOURCECTL },
     { SCMP_SYS(sched_getparam),         QEMU_SECCOMP_SET_RESOURCECTL },
-    { SCMP_SYS(sched_setscheduler),     QEMU_SECCOMP_SET_RESOURCECTL },
+    { SCMP_SYS(sched_setscheduler),     QEMU_SECCOMP_SET_RESOURCECTL,
+      ARRAY_SIZE(sched_setscheduler_arg), sched_setscheduler_arg },
     { SCMP_SYS(sched_getscheduler),     QEMU_SECCOMP_SET_RESOURCECTL },
     { SCMP_SYS(sched_setaffinity),      QEMU_SECCOMP_SET_RESOURCECTL },
     { SCMP_SYS(sched_getaffinity),      QEMU_SECCOMP_SET_RESOURCECTL },
@@ -118,7 +125,8 @@ static int seccomp_start(uint32_t seccomp_opts)
             continue;
         }
=20
-        rc =3D seccomp_rule_add(ctx, SCMP_ACT_KILL, blacklist[i].num, 0)=
;
+        rc =3D seccomp_rule_add_array(ctx, SCMP_ACT_KILL, blacklist[i].n=
um,
+                                    blacklist[i].narg, blacklist[i].arg_=
cmp);
         if (rc < 0) {
             goto seccomp_return;
         }
--=20
2.18.0.129.ge3331758f1
