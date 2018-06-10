Received: from eggs.gnu.org ([2001:4830:134:3::10]:40861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqec-0003Gr-Dm
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeZ-0003nS-89
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:30 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:36985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeY-0003n7-W9
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:27 -0400
Received: by mail-pl0-x230.google.com with SMTP id 31-v6so10386055plc.4
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:27 -1000
Message-Id: <20180610030220.3777-56-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 055/108] linux-user: Split out ipc syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

This is msgctl, msgget, msgrcv, msgsnd, shmat, shmctl,
shmdt, shmget, semctl, semget, semop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 154 ++++++++++++++++++++++++++++++-------------
 1 file changed, 110 insertions(+), 44 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6ac7532ea6..1c3a4590fb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8636,6 +8636,34 @@ IMPL(mremap)
     return get_errno(target_mremap(arg1, arg2, arg3, arg4, arg5));
 }
 
+#ifdef TARGET_NR_msgctl
+IMPL(msgctl)
+{
+    return do_msgctl(arg1, arg2, arg3);
+}
+#endif
+
+#ifdef TARGET_NR_msgget
+IMPL(msgget)
+{
+    return get_errno(msgget(arg1, arg2));
+}
+#endif
+
+#ifdef TARGET_NR_msgrcv
+IMPL(msgrcv)
+{
+    return do_msgrcv(arg1, arg2, arg3, arg4, arg5);
+}
+#endif
+
+#ifdef TARGET_NR_msgsnd
+IMPL(msgsnd)
+{
+    return do_msgsnd(arg1, arg2, arg3, arg4);
+}
+#endif
+
 IMPL(msync)
 {
     return get_errno(msync(g2h(arg1), arg2, arg3));
@@ -9340,6 +9368,34 @@ IMPL(sgetmask)
 }
 #endif
 
+#ifdef TARGET_NR_shmat
+IMPL(shmat)
+{
+    return do_shmat(cpu_env, arg1, arg2, arg3);
+}
+#endif
+
+#ifdef TARGET_NR_shmctl
+IMPL(shmctl)
+{
+    return do_shmctl(arg1, arg2, arg3);
+}
+#endif
+
+#ifdef TARGET_NR_shmdt
+IMPL(shmdt)
+{
+    return do_shmdt(arg1);
+}
+#endif
+
+#ifdef TARGET_NR_shmget
+IMPL(shmget)
+{
+    return get_errno(shmget(arg1, arg2, arg3));
+}
+#endif
+
 #ifdef TARGET_NR_shutdown
 IMPL(shutdown)
 {
@@ -9358,6 +9414,27 @@ IMPL(select)
 }
 #endif
 
+#ifdef TARGET_NR_semctl
+IMPL(semctl)
+{
+    return do_semctl(arg1, arg2, arg3, arg4);
+}
+#endif
+
+#ifdef TARGET_NR_semget
+IMPL(semget)
+{
+    return get_errno(semget(arg1, arg2, arg3));
+}
+#endif
+
+#ifdef TARGET_NR_semop
+IMPL(semop)
+{
+    return do_semop(arg1, arg2, arg3);
+}
+#endif
+
 #ifdef TARGET_NR_send
 IMPL(send)
 {
@@ -10272,50 +10349,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_semget
-    case TARGET_NR_semget:
-        return get_errno(semget(arg1, arg2, arg3));
-#endif
-#ifdef TARGET_NR_semop
-    case TARGET_NR_semop:
-        return do_semop(arg1, arg2, arg3);
-#endif
-#ifdef TARGET_NR_semctl
-    case TARGET_NR_semctl:
-        return do_semctl(arg1, arg2, arg3, arg4);
-#endif
-#ifdef TARGET_NR_msgctl
-    case TARGET_NR_msgctl:
-        return do_msgctl(arg1, arg2, arg3);
-#endif
-#ifdef TARGET_NR_msgget
-    case TARGET_NR_msgget:
-        return get_errno(msgget(arg1, arg2));
-#endif
-#ifdef TARGET_NR_msgrcv
-    case TARGET_NR_msgrcv:
-        return do_msgrcv(arg1, arg2, arg3, arg4, arg5);
-#endif
-#ifdef TARGET_NR_msgsnd
-    case TARGET_NR_msgsnd:
-        return do_msgsnd(arg1, arg2, arg3, arg4);
-#endif
-#ifdef TARGET_NR_shmget
-    case TARGET_NR_shmget:
-        return get_errno(shmget(arg1, arg2, arg3));
-#endif
-#ifdef TARGET_NR_shmctl
-    case TARGET_NR_shmctl:
-        return do_shmctl(arg1, arg2, arg3);
-#endif
-#ifdef TARGET_NR_shmat
-    case TARGET_NR_shmat:
-        return do_shmat(cpu_env, arg1, arg2, arg3);
-#endif
-#ifdef TARGET_NR_shmdt
-    case TARGET_NR_shmdt:
-        return do_shmdt(arg1);
-#endif
     case TARGET_NR_fsync:
         return get_errno(fsync(arg1));
     case TARGET_NR_clone:
@@ -12943,6 +12976,18 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(mount);
         SYSCALL(mprotect);
         SYSCALL(mremap);
+#ifdef TARGET_NR_msgctl
+        SYSCALL(msgctl);
+#endif
+#ifdef TARGET_NR_msgget
+        SYSCALL(msgget);
+#endif
+#ifdef TARGET_NR_msgrcv
+        SYSCALL(msgrcv);
+#endif
+#ifdef TARGET_NR_msgsnd
+        SYSCALL(msgsnd);
+#endif
         SYSCALL(msync);
         SYSCALL(munlock);
         SYSCALL(munlockall);
@@ -13010,6 +13055,18 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_sgetmask
         SYSCALL(sgetmask);
 #endif
+#ifdef TARGET_NR_shmat
+        SYSCALL(shmat);
+#endif
+#ifdef TARGET_NR_shmctl
+        SYSCALL(shmctl);
+#endif
+#ifdef TARGET_NR_shmdt
+        SYSCALL(shmdt);
+#endif
+#ifdef TARGET_NR_shmget
+        SYSCALL(shmget);
+#endif
 #ifdef TARGET_NR_shutdown
         SYSCALL(shutdown);
 #endif
@@ -13020,6 +13077,15 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(select);
 # endif
 #endif
+#ifdef TARGET_NR_semctl
+        SYSCALL(semctl);
+#endif
+#ifdef TARGET_NR_semget
+        SYSCALL(semget);
+#endif
+#ifdef TARGET_NR_semop
+        SYSCALL(semop);
+#endif
 #ifdef TARGET_NR_send
         SYSCALL(send);
 #endif
-- 
2.17.1
