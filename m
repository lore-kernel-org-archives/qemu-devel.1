Received: from eggs.gnu.org ([2001:4830:134:3::10]:40991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeq-0003V2-75
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqep-0003uj-9K
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:44 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:40578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqep-0003tw-3O
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:43 -0400
Received: by mail-pf0-x241.google.com with SMTP id z24-v6so8491137pfe.7
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:35 -1000
Message-Id: <20180610030220.3777-64-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 063/108] linux-user: Split out fdatasync,
 getsid, _sysctl
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

All targets define fdatasync; remove the ifdef.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 07fa043965..1907b32499 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8043,6 +8043,11 @@ IMPL(fcntl)
 }
 #endif
 
+IMPL(fdatasync)
+{
+    return get_errno(fdatasync(arg1));
+}
+
 IMPL(flock)
 {
     /* The flock constant seems to be the same for every Linux platform. */
@@ -8403,6 +8408,11 @@ IMPL(getrusage)
     return ret;
 }
 
+IMPL(getsid)
+{
+    return get_errno(getsid(arg1));
+}
+
 #ifdef TARGET_NR_getsockname
 IMPL(getsockname)
 {
@@ -10465,6 +10475,14 @@ IMPL(syncfs)
 }
 #endif
 
+#ifdef TARGET_NR__sysctl
+IMPL(_sysctl)
+{
+    /* We don't implement this, but ENOTDIR is always a safe return value. */
+    return -TARGET_ENOTDIR;
+}
+#endif
+
 IMPL(sysinfo)
 {
     struct sysinfo value;
@@ -10841,18 +10859,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_getsid:
-        return get_errno(getsid(arg1));
-#if defined(TARGET_NR_fdatasync) /* Not on alpha (osf_datasync ?) */
-    case TARGET_NR_fdatasync:
-        return get_errno(fdatasync(arg1));
-#endif
-#ifdef TARGET_NR__sysctl
-    case TARGET_NR__sysctl:
-        /* We don't implement this, but ENOTDIR is always a safe
-           return value. */
-        return -TARGET_ENOTDIR;
-#endif
     case TARGET_NR_sched_getaffinity:
         {
             unsigned int mask_size;
@@ -12958,6 +12964,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_fcntl
         SYSCALL(fcntl);
 #endif
+        SYSCALL(fdatasync);
         SYSCALL(flock);
 #ifdef TARGET_NR_fork
         SYSCALL(fork);
@@ -12996,6 +13003,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(getrandom);
         SYSCALL(getrlimit);
         SYSCALL(getrusage);
+        SYSCALL(getsid);
 #ifdef TARGET_NR_getsockname
         SYSCALL(getsockname);
 #endif
@@ -13234,6 +13242,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(sync);
 #ifdef CONFIG_SYNCFS
         SYSCALL(syncfs);
+#endif
+#ifdef TARGET_NR__sysctl
+        SYSCALL(_sysctl);
 #endif
         SYSCALL(sysinfo);
         SYSCALL(syslog);
-- 
2.17.1
