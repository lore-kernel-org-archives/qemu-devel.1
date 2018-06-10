Received: from eggs.gnu.org ([2001:4830:134:3::10]:41316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfX-0004ED-NA
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfW-0004WO-7u
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:27 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfW-0004VT-0k
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:26 -0400
Received: by mail-pf0-x243.google.com with SMTP id a63-v6so8499989pfl.1
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:58 -1000
Message-Id: <20180610030220.3777-87-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 086/108] linux-user: Split out gettid,
 readahead
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

All targets define readahead; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bcddb28947..0897449273 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8950,6 +8950,11 @@ IMPL(getsockopt)
 }
 #endif
 
+IMPL(gettid)
+{
+    return get_errno(gettid());
+}
+
 IMPL(gettimeofday)
 {
     struct timeval tv;
@@ -10337,6 +10342,20 @@ static abi_long do_readlinkat(abi_long dirfd, abi_long target_path,
     return ret;
 }
 
+IMPL(readahead)
+{
+#if TARGET_ABI_BITS == 32
+    if (regpairs_aligned(cpu_env, num)) {
+        arg2 = arg3;
+        arg3 = arg4;
+        arg4 = arg5;
+    }
+    return get_errno(readahead(arg1, target_offset64(arg2, arg3) , arg4));
+#else
+    return get_errno(readahead(arg1, arg2, arg3));
+#endif
+}
+
 #ifdef TARGET_NR_readlink
 IMPL(readlink)
 {
@@ -12184,22 +12203,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_gettid:
-        return get_errno(gettid());
-#ifdef TARGET_NR_readahead
-    case TARGET_NR_readahead:
-#if TARGET_ABI_BITS == 32
-        if (regpairs_aligned(cpu_env, num)) {
-            arg2 = arg3;
-            arg3 = arg4;
-            arg4 = arg5;
-        }
-        ret = get_errno(readahead(arg1, target_offset64(arg2, arg3) , arg4));
-#else
-        ret = get_errno(readahead(arg1, arg2, arg3));
-#endif
-        return ret;
-#endif
 #ifdef CONFIG_ATTR
 #ifdef TARGET_NR_setxattr
     case TARGET_NR_listxattr:
@@ -13343,6 +13346,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_getsockopt
         SYSCALL(getsockopt);
 #endif
+        SYSCALL(gettid);
         SYSCALL(gettimeofday);
 #ifdef TARGET_NR_getuid
         SYSCALL(getuid);
@@ -13475,6 +13479,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(pwrite64);
         SYSCALL(pwritev);
         SYSCALL(read);
+        SYSCALL(readahead);
 #ifdef TARGET_NR_readlink
         SYSCALL(readlink);
 #endif
-- 
2.17.1
