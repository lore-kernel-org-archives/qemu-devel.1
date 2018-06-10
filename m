Received: from eggs.gnu.org ([2001:4830:134:3::10]:41283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfU-000489-8o
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfR-0004Pj-2g
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:24 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:44846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfQ-0004OE-R0
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:20 -0400
Received: by mail-pg0-x242.google.com with SMTP id p21-v6so8128641pgd.11
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:55 -1000
Message-Id: <20180610030220.3777-84-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 083/108] linux-user: Split out mincore
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

All targets define mincore; remove the ifdef.

At the same time, fix two bugs in the implementation:
(1) The pages to check need not be readable, only valid.
(2) The third argument is an output vector, which
(2a) needs to be writable, and
(2b) sized properly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fc7f301519..afe6df5efa 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9144,6 +9144,31 @@ IMPL(lstat64)
 }
 #endif
 
+IMPL(mincore)
+{
+    void *a, *p;
+    size_t veclen;
+    abi_long ret;
+
+    /* Note that this is not the same as VERIFY_WRITE or VERIFY_READ.
+     * Moreover, we want to test the exact pages of guest memory.
+     */
+    if (page_check_range(arg1, arg2, PAGE_VALID)) {
+        return -TARGET_ENOMEM;
+    }
+    a = g2h(arg1);
+
+    veclen = DIV_ROUND_UP(arg2, TARGET_PAGE_SIZE);
+    p = lock_user(VERIFY_WRITE, arg3, veclen, 0);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+
+    ret = get_errno(mincore(a, arg2, p));
+    unlock_user(p, arg3, veclen);
+    return ret;
+}
+
 #ifdef TARGET_NR_mkdir
 IMPL(mkdir)
 {
@@ -11986,24 +12011,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_mincore
-    case TARGET_NR_mincore:
-        {
-            void *a = lock_user(VERIFY_READ, arg1, arg2, 0);
-            if (!a) {
-                return -TARGET_ENOMEM;
-            }
-            p = lock_user_string(arg3);
-            if (!p) {
-                ret = -TARGET_EFAULT;
-            } else {
-                ret = get_errno(mincore(a, arg2, p));
-                unlock_user(p, arg3, ret);
-            }
-            unlock_user(a, arg1, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_arm_fadvise64_64
     case TARGET_NR_arm_fadvise64_64:
         /* arm_fadvise64_64 looks like fadvise64_64 but
@@ -13328,6 +13335,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_lstat64
         SYSCALL(lstat64);
 #endif
+        SYSCALL(mincore);
 #ifdef TARGET_NR_mkdir
         SYSCALL(mkdir);
 #endif
-- 
2.17.1
