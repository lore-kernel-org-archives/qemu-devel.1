Received: from eggs.gnu.org ([2001:4830:134:3::10]:40836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeY-0003Co-KX
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeX-0003mR-9I
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:26 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeX-0003mG-1O
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:25 -0400
Received: by mail-pl0-x241.google.com with SMTP id az12-v6so10380409plb.8
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:26 -1000
Message-Id: <20180610030220.3777-55-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 054/108] linux-user: Split out ipc
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

At the same time, merge do_ipc into the new function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 193 ++++++++++++++++++-------------------------
 1 file changed, 82 insertions(+), 111 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a0fbbbbb4a..6ac7532ea6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4962,113 +4962,6 @@ static inline abi_long do_shmdt(abi_ulong shmaddr)
     return rv;
 }
 
-#ifdef TARGET_NR_ipc
-/* ??? This only works with linear mappings.  */
-/* do_ipc() must return target values and target errnos. */
-static abi_long do_ipc(CPUArchState *cpu_env,
-                       unsigned int call, abi_long first,
-                       abi_long second, abi_long third,
-                       abi_long ptr, abi_long fifth)
-{
-    int version;
-    abi_long ret = 0;
-
-    version = call >> 16;
-    call &= 0xffff;
-
-    switch (call) {
-    case IPCOP_semop:
-        ret = do_semop(first, ptr, second);
-        break;
-
-    case IPCOP_semget:
-        ret = get_errno(semget(first, second, third));
-        break;
-
-    case IPCOP_semctl: {
-        /* The semun argument to semctl is passed by value, so dereference the
-         * ptr argument. */
-        abi_ulong atptr;
-        get_user_ual(atptr, ptr);
-        ret = do_semctl(first, second, third, atptr);
-        break;
-    }
-
-    case IPCOP_msgget:
-        ret = get_errno(msgget(first, second));
-        break;
-
-    case IPCOP_msgsnd:
-        ret = do_msgsnd(first, ptr, second, third);
-        break;
-
-    case IPCOP_msgctl:
-        ret = do_msgctl(first, second, ptr);
-        break;
-
-    case IPCOP_msgrcv:
-        switch (version) {
-        case 0:
-            {
-                struct target_ipc_kludge {
-                    abi_long msgp;
-                    abi_long msgtyp;
-                } *tmp;
-
-                if (!lock_user_struct(VERIFY_READ, tmp, ptr, 1)) {
-                    ret = -TARGET_EFAULT;
-                    break;
-                }
-
-                ret = do_msgrcv(first, tswapal(tmp->msgp), second, tswapal(tmp->msgtyp), third);
-
-                unlock_user_struct(tmp, ptr, 0);
-                break;
-            }
-        default:
-            ret = do_msgrcv(first, ptr, second, fifth, third);
-        }
-        break;
-
-    case IPCOP_shmat:
-        switch (version) {
-        default:
-        {
-            abi_ulong raddr;
-            raddr = do_shmat(cpu_env, first, ptr, second);
-            if (is_error(raddr))
-                return get_errno(raddr);
-            if (put_user_ual(raddr, third))
-                return -TARGET_EFAULT;
-            break;
-        }
-        case 1:
-            ret = -TARGET_EINVAL;
-            break;
-        }
-	break;
-    case IPCOP_shmdt:
-        ret = do_shmdt(ptr);
-	break;
-
-    case IPCOP_shmget:
-	/* IPC_* flag values are the same on all linux platforms */
-	ret = get_errno(shmget(first, second, third));
-	break;
-
-	/* IPC_* and SHM_* command values are the same on all linux platforms */
-    case IPCOP_shmctl:
-        ret = do_shmctl(first, second, ptr);
-        break;
-    default:
-	gemu_log("Unsupported ipc call: %d (version %d)\n", call, version);
-	ret = -TARGET_ENOSYS;
-	break;
-    }
-    return ret;
-}
-#endif
-
 /* kernel structure types definitions */
 
 #define STRUCT(name, ...) STRUCT_ ## name,
@@ -8425,6 +8318,85 @@ IMPL(ioctl)
     return ret;
 }
 
+#ifdef TARGET_NR_ipc
+IMPL(ipc)
+{
+    unsigned int call = arg1;
+    abi_long first = arg2;
+    abi_long second = arg3;
+    abi_long third = arg4;
+    abi_long ptr = arg5;
+    abi_long fifth = arg6;
+    int version;
+    abi_long ret;
+    abi_ulong atptr;
+
+    version = call >> 16;
+    call &= 0xffff;
+
+    /* IPC_* and SHM_* command values are the same on all linux platforms */
+    switch (call) {
+    case IPCOP_semop:
+        return do_semop(first, ptr, second);
+    case IPCOP_semget:
+        return get_errno(semget(first, second, third));
+    case IPCOP_semctl:
+        /* The semun argument to semctl is passed by value,
+         * so dereference the ptr argument.
+         */
+        get_user_ual(atptr, ptr);
+        return do_semctl(first, second, third, atptr);
+
+    case IPCOP_msgget:
+        return get_errno(msgget(first, second));
+    case IPCOP_msgsnd:
+        return do_msgsnd(first, ptr, second, third);
+    case IPCOP_msgctl:
+        return do_msgctl(first, second, ptr);
+    case IPCOP_msgrcv:
+        if (version == 0) {
+            struct target_ipc_kludge {
+                abi_long msgp;
+                abi_long msgtyp;
+            } *tmp;
+
+            if (!lock_user_struct(VERIFY_READ, tmp, ptr, 1)) {
+                return -TARGET_EFAULT;
+            }
+
+            ret = do_msgrcv(first, tswapal(tmp->msgp), second,
+                            tswapal(tmp->msgtyp), third);
+            unlock_user_struct(tmp, ptr, 0);
+            return ret;
+        }
+        return do_msgrcv(first, ptr, second, fifth, third);
+
+    case IPCOP_shmat:
+        if (version == 1) {
+            return -TARGET_EINVAL;
+        }
+        ret = do_shmat(cpu_env, first, ptr, second);
+        if (is_error(ret)) {
+            return get_errno(ret);
+        }
+        if (put_user_ual(ret, third)) {
+            return -TARGET_EFAULT;
+        }
+        return ret;
+    case IPCOP_shmdt:
+        return do_shmdt(ptr);
+    case IPCOP_shmget:
+        return get_errno(shmget(first, second, third));
+    case IPCOP_shmctl:
+        return do_shmctl(first, second, ptr);
+
+    default:
+        gemu_log("Unsupported ipc call: %d (version %d)\n", call, version);
+        return -TARGET_ENOSYS;
+    }
+}
+#endif
+
 IMPL(kill)
 {
     return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
@@ -10300,10 +10272,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_ipc
-    case TARGET_NR_ipc:
-        return do_ipc(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
-#endif
 #ifdef TARGET_NR_semget
     case TARGET_NR_semget:
         return get_errno(semget(arg1, arg2, arg3));
@@ -12941,6 +12909,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(getxpid);
 #endif
         SYSCALL(ioctl);
+#ifdef TARGET_NR_ipc
+        SYSCALL(ipc);
+#endif
         SYSCALL(kill);
 #ifdef TARGET_NR_link
         SYSCALL(link);
-- 
2.17.1
