Received: from eggs.gnu.org ([2001:4830:134:3::10]:45188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fiKbT-0000aJ-4A
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fiKbQ-0006lo-4Y
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:17:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57882 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fiKbP-0006lU-VT
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:17:20 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Wed, 25 Jul 2018 16:16:10 +0200
Message-Id: <20180725141610.12075-3-otubo@redhat.com>
In-Reply-To: <20180725141610.12075-1-otubo@redhat.com>
References: <20180725141610.12075-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] RFC: seccomp: prefer SCMP_ACT_KILL_PROCESS
 if available
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

The upcoming libseccomp release should have SCMP_ACT_KILL_PROCESS
action (https://github.com/seccomp/libseccomp/issues/96).

SCMP_ACT_KILL_PROCESS is preferable to immediately terminate the
offending process, rather than having the SIGSYS handler running.

Use SECCOMP_GET_ACTION_AVAIL to check availability of kernel support,
as libseccomp will fallback on SCMP_ACT_KILL otherwise, and we still
prefer SCMP_ACT_TRAP.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
---
 qemu-seccomp.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index b117a92559..505887d5af 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -20,6 +20,7 @@
 #include <sys/prctl.h>
 #include <seccomp.h>
 #include "sysemu/seccomp.h"
+#include <linux/seccomp.h>
=20
 /* For some architectures (notably ARM) cacheflush is not supported unti=
l
  * libseccomp 2.2.3, but configure enforces that we are using a more rec=
ent
@@ -107,12 +108,39 @@ static const struct QemuSeccompSyscall blacklist[] =
=3D {
     { SCMP_SYS(sched_get_priority_min), QEMU_SECCOMP_SET_RESOURCECTL },
 };
=20
+static inline int
+qemu_seccomp(unsigned int operation, unsigned int flags, void *args)
+{
+#ifdef __NR_seccomp
+    return syscall(__NR_seccomp, operation, flags, args);
+#else
+    return -1;
+#endif
+}
+
+static uint32_t qemu_seccomp_get_kill_action(void)
+{
+#if defined(SECCOMP_GET_ACTION_AVAIL) && defined(SCMP_ACT_KILL_PROCESS) =
&& \
+    defined(SECCOMP_RET_KILL_PROCESS)
+    {
+        uint32_t action =3D SECCOMP_RET_KILL_PROCESS;
+
+        if (qemu_seccomp(SECCOMP_GET_ACTION_AVAIL, 0, &action) =3D=3D 0)=
 {
+            return SCMP_ACT_KILL_PROCESS;
+        }
+    }
+#endif
+
+    return SCMP_ACT_TRAP;
+}
+
=20
 static int seccomp_start(uint32_t seccomp_opts)
 {
     int rc =3D 0;
     unsigned int i =3D 0;
     scmp_filter_ctx ctx;
+    uint32_t action =3D qemu_seccomp_get_kill_action();
=20
     ctx =3D seccomp_init(SCMP_ACT_ALLOW);
     if (ctx =3D=3D NULL) {
@@ -125,7 +153,7 @@ static int seccomp_start(uint32_t seccomp_opts)
             continue;
         }
=20
-        rc =3D seccomp_rule_add_array(ctx, SCMP_ACT_TRAP, blacklist[i].n=
um,
+        rc =3D seccomp_rule_add_array(ctx, action, blacklist[i].num,
                                     blacklist[i].narg, blacklist[i].arg_=
cmp);
         if (rc < 0) {
             goto seccomp_return;
--=20
2.17.1
