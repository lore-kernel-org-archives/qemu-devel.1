Received: from eggs.gnu.org ([209.51.188.92]:56562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbll-0006AN-PE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblj-0006HU-Vt
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:41 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbli-0005ob-4g
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:39 -0500
Received: by mail-pg1-x542.google.com with SMTP id t13so6635893pgr.11
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:33:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:20 +1100
Message-Id: <20190118213122.22865-47-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 47/49] linux-user: Move syscall_init to the
 end
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

No functional change.  This will aid moving everything
related to ioctls to a separate file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 113 +++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 52 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 33d536262f..82b7267b20 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4778,58 +4778,6 @@ _syscall1(int, sys_setgid, gid_t, gid)
 _syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
 _syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
 
-void syscall_init(void)
-{
-    IOCTLEntry *ie;
-    const argtype *arg_type;
-    int size;
-    int i;
-
-    thunk_init(STRUCT_MAX);
-
-#define STRUCT(name, ...) thunk_register_struct(STRUCT_ ## name, #name, struct_ ## name ## _def);
-#define STRUCT_SPECIAL(name) thunk_register_struct_direct(STRUCT_ ## name, #name, &struct_ ## name ## _def);
-#include "syscall_types.h"
-#undef STRUCT
-#undef STRUCT_SPECIAL
-
-    /* Build target_to_host_errno_table[] table from
-     * host_to_target_errno_table[]. */
-    for (i = 0; i < ERRNO_TABLE_SIZE; i++) {
-        target_to_host_errno_table[host_to_target_errno_table[i]] = i;
-    }
-
-    /* we patch the ioctl size if necessary. We rely on the fact that
-       no ioctl has all the bits at '1' in the size field */
-    ie = ioctl_entries;
-    while (ie->target_cmd != 0) {
-        if (((ie->target_cmd >> TARGET_IOC_SIZESHIFT) & TARGET_IOC_SIZEMASK) ==
-            TARGET_IOC_SIZEMASK) {
-            arg_type = ie->arg_type;
-            if (arg_type[0] != TYPE_PTR) {
-                fprintf(stderr, "cannot patch size for ioctl 0x%x\n",
-                        ie->target_cmd);
-                exit(1);
-            }
-            arg_type++;
-            size = thunk_type_size(arg_type, 0);
-            ie->target_cmd = (ie->target_cmd &
-                              ~(TARGET_IOC_SIZEMASK << TARGET_IOC_SIZESHIFT)) |
-                (size << TARGET_IOC_SIZESHIFT);
-        }
-
-        /* automatic consistency check if same arch */
-#if (defined(__i386__) && defined(TARGET_I386) && defined(TARGET_ABI32)) || \
-    (defined(__x86_64__) && defined(TARGET_X86_64))
-        if (unlikely(ie->target_cmd != ie->host_cmd)) {
-            fprintf(stderr, "ERROR: ioctl(%s): target=0x%x host=0x%x\n",
-                    ie->name, ie->target_cmd, ie->host_cmd);
-        }
-#endif
-        ie++;
-    }
-}
-
 static inline uint64_t target_offset64(abi_ulong word0, abi_ulong word1)
 {
 #if TARGET_ABI_BITS == 64
@@ -8983,3 +8931,64 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     trace_guest_user_syscall_ret(cpu, num, ret);
     return ret;
 }
+
+void syscall_init(void)
+{
+    IOCTLEntry *ie;
+    const argtype *arg_type;
+    int size;
+    int i;
+
+    thunk_init(STRUCT_MAX);
+
+#define STRUCT(name, ...) \
+    thunk_register_struct(STRUCT_ ## name, #name, struct_ ## name ## _def);
+#define STRUCT_SPECIAL(name) \
+    thunk_register_struct_direct(STRUCT_ ## name, #name, \
+                                 &struct_ ## name ## _def);
+
+#include "syscall_types.h"
+
+#undef STRUCT
+#undef STRUCT_SPECIAL
+
+    /*
+     * Build target_to_host_errno_table[] table from
+     * host_to_target_errno_table[].
+     */
+    for (i = 0; i < ERRNO_TABLE_SIZE; i++) {
+        target_to_host_errno_table[host_to_target_errno_table[i]] = i;
+    }
+
+    /*
+     * We patch the ioctl size if necessary.  We rely on the fact that
+     * no ioctl has all the bits at '1' in the size field.
+     */
+    ie = ioctl_entries;
+    while (ie->target_cmd != 0) {
+        if (((ie->target_cmd >> TARGET_IOC_SIZESHIFT) & TARGET_IOC_SIZEMASK) ==
+            TARGET_IOC_SIZEMASK) {
+            arg_type = ie->arg_type;
+            if (arg_type[0] != TYPE_PTR) {
+                fprintf(stderr, "cannot patch size for ioctl 0x%x\n",
+                        ie->target_cmd);
+                exit(1);
+            }
+            arg_type++;
+            size = thunk_type_size(arg_type, 0);
+            ie->target_cmd = (ie->target_cmd &
+                              ~(TARGET_IOC_SIZEMASK << TARGET_IOC_SIZESHIFT)) |
+                (size << TARGET_IOC_SIZESHIFT);
+        }
+
+        /* automatic consistency check if same arch */
+#if (defined(__i386__) && defined(TARGET_I386) && defined(TARGET_ABI32)) || \
+    (defined(__x86_64__) && defined(TARGET_X86_64))
+        if (unlikely(ie->target_cmd != ie->host_cmd)) {
+            fprintf(stderr, "ERROR: ioctl(%s): target=0x%x host=0x%x\n",
+                    ie->name, ie->target_cmd, ie->host_cmd);
+        }
+#endif
+        ie++;
+    }
+}
-- 
2.17.2
