Received: from eggs.gnu.org ([2001:4830:134:3::10]:40458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f45Ei-0004r2-Vs
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f45Ed-0001Ds-3X
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:47:33 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f45Ec-0001Df-Se
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:47:27 -0400
Received: by mail-wr0-x242.google.com with SMTP id m13so28536378wrj.5
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 06:47:26 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu,  5 Apr 2018 06:47:02 -0700
Message-Id: <20180405134702.5020-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v3] linux-user: fix preadv/pwritev offsets
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

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v2->v3:
- rename helper to target_to_host_low_high;
- handle cases TARGET_LONG_BITS * 2 > HOST_LONG_BITS and
  TARGET_LONG_BITS < 2 * HOST_LONG_BITS correctly.

Changes v1->v2:
- fix host high computation in TARGET_LONG_BITS > HOST_LONG_BITS case

 linux-user/syscall.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5ef517613577..13ad572e0d3b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3386,6 +3386,30 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
     return ret;
 }
 
+static void target_to_host_low_high(abi_ulong tlow,
+                                    abi_ulong thigh,
+                                    unsigned long *hlow,
+                                    unsigned long *hhigh)
+{
+#if TARGET_LONG_BITS == HOST_LONG_BITS
+        *hlow = tlow;
+        *hhigh = thigh;
+#elif TARGET_LONG_BITS < HOST_LONG_BITS
+        *hlow = tlow | (unsigned long)thigh << TARGET_LONG_BITS;
+#if TARGET_LONG_BITS * 2 <= HOST_LONG_BITS
+        *hhigh = 0;
+#else
+        *hhigh = (unsigned long)thigh >> (HOST_LONG_BITS - TARGET_LONG_BITS);
+#endif
+#else
+        *hlow = (unsigned long)tlow;
+        *hhigh = (unsigned long)(tlow >> HOST_LONG_BITS);
+#if TARGET_LONG_BITS < 2 * HOST_LONG_BITS
+        *hhigh |= (unsigned long)thigh << (TARGET_LONG_BITS - HOST_LONG_BITS);
+#endif
+#endif
+}
+
 static struct iovec *lock_iovec(int type, abi_ulong target_addr,
                                 abi_ulong count, int copy)
 {
@@ -10449,7 +10473,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
@@ -10462,7 +10489,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
