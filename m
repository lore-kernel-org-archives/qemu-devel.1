Received: from eggs.gnu.org ([2001:4830:134:3::10]:45110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f5ira-0005hi-B6
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f5irZ-0003Xb-Ap
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:18:26 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f5irZ-0003X9-1y
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:18:25 -0400
Received: by mail-lf0-x241.google.com with SMTP id j20-v6so9379846lfk.2
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 19:18:24 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  9 Apr 2018 19:17:45 -0700
Message-Id: <20180410021745.32378-2-jcmvbkbc@gmail.com>
In-Reply-To: <20180410021745.32378-1-jcmvbkbc@gmail.com>
References: <20180410021745.32378-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 1/1] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>

preadv/pwritev accept low and high parts of file offset in two separate
parameters. When host bitness doesn't match guest bitness these parts
must be appropriately recombined.
Introduce target_to_host_low_high that does this recombination and use
it in preadv/pwritev syscalls.

This fixes glibc testsuite test misc/tst-preadvwritev64.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/syscall.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5ef517613577..0eab5cc6ade1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3386,6 +3386,23 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
     return ret;
 }
 
+/* Convert target low/high pair representing file offset into the host
+ * low/high pair. This function doesn't handle offsets bigger than 64 bits
+ * as the kernel doesn't handle them either.
+ */
+static void target_to_host_low_high(abi_ulong tlow,
+                                    abi_ulong thigh,
+                                    unsigned long *hlow,
+                                    unsigned long *hhigh)
+{
+    uint64_t off = tlow |
+        ((unsigned long long)thigh << TARGET_LONG_BITS / 2) <<
+        TARGET_LONG_BITS / 2;
+
+    *hlow = off;
+    *hhigh = (off >> HOST_LONG_BITS / 2) >> HOST_LONG_BITS / 2;
+}
+
 static struct iovec *lock_iovec(int type, abi_ulong target_addr,
                                 abi_ulong count, int copy)
 {
@@ -10449,7 +10466,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         {
             struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
             if (vec != NULL) {
-                ret = get_errno(safe_preadv(arg1, vec, arg3, arg4, arg5));
+                unsigned long low, high;
+
+                target_to_host_low_high(arg4, arg5, &low, &high);
+                ret = get_errno(safe_preadv(arg1, vec, arg3, low, high));
                 unlock_iovec(vec, arg2, arg3, 1);
             } else {
                 ret = -host_to_target_errno(errno);
@@ -10462,7 +10482,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         {
             struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
             if (vec != NULL) {
-                ret = get_errno(safe_pwritev(arg1, vec, arg3, arg4, arg5));
+                unsigned long low, high;
+
+                target_to_host_low_high(arg4, arg5, &low, &high);
+                ret = get_errno(safe_pwritev(arg1, vec, arg3, low, high));
                 unlock_iovec(vec, arg2, arg3, 0);
             } else {
                 ret = -host_to_target_errno(errno);
-- 
2.11.0
