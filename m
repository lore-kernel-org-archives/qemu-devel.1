Received: from eggs.gnu.org ([2001:4830:134:3::10]:56919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fdbba-0001nZ-Lo
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fdbbW-0001C0-RU
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:25:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38632 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fdbbW-0001BN-LE
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:25:54 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Thu, 12 Jul 2018 15:25:38 +0200
Message-Id: <20180712132538.21921-2-otubo@redhat.com>
In-Reply-To: <20180712132538.21921-1-otubo@redhat.com>
References: <20180712132538.21921-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] seccomp: allow sched_setscheduler() with
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
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Current and upcoming mesa releases rely on a shader disk cash. It uses
a thread job queue with low priority, set with
sched_setscheduler(SCHED_IDLE). However, that syscall is rejected by
the "resourcecontrol" seccomp qemu filter.

Since it should be safe to allow lowering thread priority, let's allow
scheduling thread to idle policy.

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1594456

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
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
2.17.1
