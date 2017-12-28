Received: from eggs.gnu.org ([2001:4830:134:3::10]:50829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eUYu4-0006tU-D2
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 09:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eUYu1-0005Ez-8W
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 09:11:24 -0500
Received: from [2a01:474::1] (port=58252 helo=hera.aquilenet.fr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eUYu0-0005BU-TG
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 09:11:21 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 28 Dec 2017 15:11:04 +0100
Message-Id: <20171228141104.15198-1-samuel.thibault@ens-lyon.org>
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
 linux-user/syscall.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11c9116c4a..8ec7de96ce 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10341,6 +10341,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         {
             unsigned int mask_size;
             unsigned long *mask;
+            abi_ulong *abimask;
+            unsigned i, j;
 
             /*
              * sched_getaffinity needs multiples of ulong, so need to take
@@ -10353,6 +10355,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             mask_size = (arg2 + (sizeof(*mask) - 1)) & ~(sizeof(*mask) - 1);
 
             mask = alloca(mask_size);
+            memset(mask, 0, mask_size);
             ret = get_errno(sys_sched_getaffinity(arg1, mask_size, mask));
 
             if (!is_error(ret)) {
@@ -10372,9 +10375,27 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     ret = arg2;
                 }
 
-                if (copy_to_user(arg3, mask, ret)) {
+                abimask = lock_user(VERIFY_WRITE, arg3, arg2, 0);
+                if (!abimask) {
                     goto efault;
                 }
+
+                for (i = 0 ; i < arg2 / sizeof(abi_ulong); i++) {
+                    unsigned abi_ubits = sizeof(abi_ulong) * 8;
+                    unsigned ubits = sizeof(*mask) * 8;
+                    unsigned bit = i * abi_ubits;
+                    abi_ulong val = 0;
+
+                    for (j = 0; j < abi_ubits; j++, bit++) {
+                        if (mask[bit / ubits] & (1UL << (bit % ubits))) {
+                            val |= 1UL << j;
+                        }
+                    }
+                    __put_user(val, &abimask[i]);
+                }
+
+                unlock_user(abimask, arg3, arg2);
+
             }
         }
         break;
@@ -10382,6 +10403,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         {
             unsigned int mask_size;
             unsigned long *mask;
+            abi_ulong *abimask;
+            unsigned i, j;
 
             /*
              * sched_setaffinity needs multiples of ulong, so need to take
@@ -10394,11 +10417,28 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             mask_size = (arg2 + (sizeof(*mask) - 1)) & ~(sizeof(*mask) - 1);
 
             mask = alloca(mask_size);
-            if (!lock_user_struct(VERIFY_READ, p, arg3, 1)) {
+            memset(mask, 0, mask_size);
+
+            abimask = lock_user(VERIFY_READ, arg3, arg2, 1);
+            if (!abimask) {
                 goto efault;
             }
-            memcpy(mask, p, arg2);
-            unlock_user_struct(p, arg2, 0);
+
+            for (i = 0 ; i < arg2 / sizeof(abi_ulong); i++) {
+                unsigned abi_ubits = sizeof(abi_ulong) * 8;
+                unsigned ubits = sizeof(*mask) * 8;
+                unsigned bit = i * abi_ubits;
+                abi_ulong val;
+
+                __get_user(val, &abimask[i]);
+                for (j = 0; j < abi_ubits; j++, bit++) {
+                    if (val & (1UL << j)) {
+                        mask[bit / ubits] |= 1UL << (bit % ubits);
+                    }
+                }
+            }
+
+            unlock_user(abimask, arg3, 0);
 
             ret = get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
         }
-- 
2.15.1
