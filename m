Received: from eggs.gnu.org ([2001:4830:134:3::10]:41617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqgD-0004uI-OU
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqgA-0004v6-Jt
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:09 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqgA-0004ug-E1
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:06 -0400
Received: by mail-pg0-x241.google.com with SMTP id m5-v6so8138272pgd.3
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:06:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:20 -1000
Message-Id: <20180610030220.3777-109-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 108/108] linux-user: Fold away do_syscall1
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7a94a0b0e9..a4cef22436 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13204,23 +13204,6 @@ IMPL(writev)
     return ret;
 }
 
-/* This is an internal helper for do_syscall so that it is easier
- * to have a single return point, so that actions, such as logging
- * of syscall results, can be performed.
- * All errnos that do_syscall() returns must be -TARGET_<errcode>.
- */
-static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
-                            abi_long arg2, abi_long arg3, abi_long arg4,
-                            abi_long arg5, abi_long arg6, abi_long arg7,
-                            abi_long arg8)
-{
-    switch(num) {
-    default:
-        gemu_log("qemu: Unsupported syscall: %d\n", num);
-        return -TARGET_ENOSYS;
-    }
-}
-
 /* The default action for a syscall not listed in syscall_table is to
  * log the missing syscall.  If a syscall is intentionally emulated as
  * not present, then list it with impl_enosys as the implementation,
@@ -13953,8 +13936,8 @@ static impl_fn *syscall_table(unsigned num)
 #undef SYSCALL
 #undef SYSCALL_WITH
 
-    /* After do_syscall1 is fully split, this will be impl_enosys.  */
-    return do_syscall1;
+    gemu_log("qemu: Unsupported syscall: %u\n", num);
+    return impl_enosys;
 }
 
 abi_long do_syscall(void *cpu_env, unsigned num, abi_long arg1,
-- 
2.17.1
