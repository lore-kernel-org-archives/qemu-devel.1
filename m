Received: from eggs.gnu.org ([2001:4830:134:3::10]:59641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2weK-00071f-T0
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 06:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2weH-0001jM-MA
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 06:25:16 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f2weH-0001iW-CD
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 06:25:13 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon,  2 Apr 2018 12:24:52 +0200
Message-Id: <20180402102453.9883-2-laurent@vivier.eu>
In-Reply-To: <20180402102453.9883-1-laurent@vivier.eu>
References: <20180402102453.9883-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/2] linux-user: define
 TARGET_ARCH_HAS_KA_RESTORER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

Sparc as an extended sigaction structure containing
the field ka_restorer used in place of sa_restorer.

Define TARGET_ARCH_HAS_KA_RESTORER and use it
with sparc.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c       | 4 ++--
 linux-user/syscall.c      | 7 +++++--
 linux-user/syscall_defs.h | 4 ++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 2ea3e0321f..2b9752b40b 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -2920,8 +2920,8 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     env->pc = ka->_sa_handler;
     env->npc = (env->pc + 4);
     /* 5. return to kernel instructions */
-    if (ka->sa_restorer) {
-        env->regwptr[UREG_I7] = ka->sa_restorer;
+    if (ka->ka_restorer) {
+        env->regwptr[UREG_I7] = ka->ka_restorer;
     } else {
         uint32_t val32;
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 889abbda1e..b8353d8f13 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8699,6 +8699,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                 target_siginitset(&act.sa_mask, old_act->sa_mask);
                 act.sa_flags = old_act->sa_flags;
                 act.sa_restorer = old_act->sa_restorer;
+#ifdef TARGET_ARCH_HAS_KA_RESTORER
+                act.ka_restorer = 0;
+#endif
                 unlock_user_struct(old_act, arg2, 0);
                 pact = &act;
             } else {
@@ -8773,8 +8776,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                 if (!lock_user_struct(VERIFY_READ, act, arg2, 1)) {
                     goto efault;
                 }
-#ifdef TARGET_SPARC
-                act->sa_restorer = restorer;
+#ifdef TARGET_ARCH_HAS_KA_RESTORER
+                act->ka_restorer = restorer;
 #endif
             } else {
                 act = NULL;
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 13fe840239..7473be518b 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -435,6 +435,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 #define TARGET_SA_NODEFER      0x20u
 #define TARGET_SA_RESETHAND    4u
 #define TARGET_ARCH_HAS_SA_RESTORER 1
+#define TARGET_ARCH_HAS_KA_RESTORER 1
 #elif defined(TARGET_MIPS)
 #define TARGET_SA_NOCLDSTOP	0x00000001
 #define TARGET_SA_NOCLDWAIT	0x00010000
@@ -742,6 +743,9 @@ struct target_sigaction {
         abi_ulong sa_restorer;
 #endif
         target_sigset_t sa_mask;
+#ifdef TARGET_ARCH_HAS_KA_RESTORER
+        abi_ulong ka_restorer;
+#endif
 };
 #endif
 
-- 
2.14.3
