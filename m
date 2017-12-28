Received: from eggs.gnu.org ([2001:4830:134:3::10]:39217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eUdxF-0004qD-8k
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 14:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eUdxB-0000mk-RL
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 14:35:01 -0500
Received: from [2a01:474::1] (port=59179 helo=hera.aquilenet.fr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eUdxB-0000mE-Cg
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 14:34:57 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 28 Dec 2017 20:34:39 +0100
Message-Id: <20171228193439.18835-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH] linux-user: Fix sched_get/setaffinity
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

sched_get/setaffinity linux-user syscalls were missing conversions for
little/big endian, which is hairy since longs may not be the same size
either.

For simplicity, this just introduces loops to convert bit by bit like is
done for select.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 linux-user/syscall.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11c9116c4a..f806cfb9a7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7716,6 +7716,67 @@ static TargetFdTrans target_inotify_trans = {
 };
 #endif
 
+static int target_to_host_cpu_mask(unsigned long *host_mask, size_t host_size, abi_ulong target_addr, size_t target_size)
+{
+    unsigned target_bits = sizeof(abi_ulong) * 8;
+    unsigned host_bits = sizeof(*host_mask) * 8;
+    abi_ulong *target_mask;
+    unsigned i, j;
+
+    assert(host_size >= target_size);
+
+    target_mask = lock_user(VERIFY_READ, target_addr, target_size, 1);
+    if (!target_mask) {
+        return -TARGET_EFAULT;
+    }
+    memset(host_mask, 0, host_size);
+
+    for (i = 0 ; i < target_size / sizeof(abi_ulong); i++) {
+        unsigned bit = i * target_bits;
+        abi_ulong val;
+
+        __get_user(val, &target_mask[i]);
+        for (j = 0; j < target_bits; j++, bit++) {
+            if (val & (1UL << j)) {
+                host_mask[bit / host_bits] |= 1UL << (bit % host_bits);
+            }
+        }
+    }
+
+    unlock_user(target_mask, target_addr, 0);
+    return 0;
+}
+
+static int host_to_target_cpu_mask(const unsigned long *host_mask, size_t host_size, abi_ulong target_addr, size_t target_size)
+{
+    unsigned target_bits = sizeof(abi_ulong) * 8;
+    unsigned host_bits = sizeof(*host_mask) * 8;
+    abi_ulong *target_mask;
+    unsigned i, j;
+
+    assert(host_size >= target_size);
+
+    target_mask = lock_user(VERIFY_WRITE, target_addr, target_size, 0);
+    if (!target_mask) {
+        return -TARGET_EFAULT;
+    }
+
+    for (i = 0 ; i < target_size / sizeof(abi_ulong); i++) {
+        unsigned bit = i * target_bits;
+        abi_ulong val = 0;
+
+        for (j = 0; j < target_bits; j++, bit++) {
+            if (host_mask[bit / host_bits] & (1UL << (bit % host_bits))) {
+                val |= 1UL << j;
+            }
+        }
+        __put_user(val, &target_mask[i]);
+    }
+
+    unlock_user(target_mask, target_addr, target_size);
+    return 0;
+}
+
 /* do_syscall() should always have a single exit point at the end so
    that actions, such as logging of syscall results, can be performed.
    All errnos that do_syscall() returns must be -TARGET_<errcode>. */
@@ -10353,6 +10414,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             mask_size = (arg2 + (sizeof(*mask) - 1)) & ~(sizeof(*mask) - 1);
 
             mask = alloca(mask_size);
+            memset(mask, 0, mask_size);
             ret = get_errno(sys_sched_getaffinity(arg1, mask_size, mask));
 
             if (!is_error(ret)) {
@@ -10372,9 +10434,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     ret = arg2;
                 }
 
-                if (copy_to_user(arg3, mask, ret)) {
-                    goto efault;
-                }
+                ret = host_to_target_cpu_mask(mask, mask_size, arg3, arg2);
             }
         }
         break;
@@ -10392,13 +10452,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                 break;
             }
             mask_size = (arg2 + (sizeof(*mask) - 1)) & ~(sizeof(*mask) - 1);
-
             mask = alloca(mask_size);
-            if (!lock_user_struct(VERIFY_READ, p, arg3, 1)) {
-                goto efault;
+
+            ret = target_to_host_cpu_mask(mask, mask_size, arg3, arg2);
+            if (ret) {
+                break;
             }
-            memcpy(mask, p, arg2);
-            unlock_user_struct(p, arg2, 0);
 
             ret = get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
         }
-- 
2.15.1
