Received: from eggs.gnu.org ([2001:4830:134:3::10]:40800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeT-0003Aw-DS
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeR-0003kp-SB
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:21 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:42385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeR-0003kh-N0
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:19 -0400
Received: by mail-pf0-x244.google.com with SMTP id w7-v6so8478742pfn.9
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:24 -1000
Message-Id: <20180610030220.3777-53-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 052/108] linux-user: Unwrap
 TARGET_NR_syscall early
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

Unwrapping early produces a much nicer log output.
Disallow recursive syscall, as per ARM and MIPS.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4f6c01092b..87374014b1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10230,11 +10230,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     switch(num) {
     case TARGET_NR_vhangup:
         return get_errno(vhangup());
-#ifdef TARGET_NR_syscall
-    case TARGET_NR_syscall:
-        return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
-                          arg6, arg7, arg8, 0);
-#endif
     case TARGET_NR_wait4:
         {
             int status;
@@ -13171,6 +13166,32 @@ abi_long do_syscall(void *cpu_env, unsigned num, abi_long arg1,
         }
     }
 #endif
+#ifdef TARGET_NR_syscall
+    /* For the benefit of strace, unwrap NR_syscall now.  */
+    if (num == TARGET_NR_syscall) {
+        num = arg1 & 0xffff;
+        if (num == TARGET_NR_syscall) {
+            /* Do not allow recursion.  */
+            ret = -TARGET_ENOSYS;
+            trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
+                                     arg5, arg6, arg7, arg8);
+            if (unlikely(do_strace)) {
+                print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+                print_syscall_ret(num, ret);
+            }
+            trace_guest_user_syscall_ret(cpu, num, ret);
+            return ret;
+        }
+        arg1 = arg2;
+        arg2 = arg3;
+        arg3 = arg4;
+        arg4 = arg5;
+        arg5 = arg6;
+        arg6 = arg7;
+        arg7 = arg8;
+        arg8 = 0;
+    }
+#endif
 
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
-- 
2.17.1
