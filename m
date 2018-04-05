Received: from eggs.gnu.org ([2001:4830:134:3::10]:58754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f3tuP-0006hJ-Is
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f3tuO-0003LC-NE
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:41:49 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f3tuO-0003Js-Gu
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:41:48 -0400
Received: by mail-wm0-x243.google.com with SMTP id r131so2208959wmb.2
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 18:41:48 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed,  4 Apr 2018 18:41:35 -0700
Message-Id: <20180405014135.3235-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

preadv/pwritev accept low and high parts of file offset in two separate
parameters. When host bitness doesn't match guest bitness these parts
must be appropriately recombined.
Introduce target_low_high_to_host_low_high that does this recombination
and use it in preadv/pwritev syscalls.

This fixes glibc testsuite test misc/tst-preadvwritev64.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- fix host high computation in TARGET_LONG_BITS > HOST_LONG_BITS case

 linux-user/syscall.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5ef517613577..7e014066260a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3386,6 +3386,23 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
     return ret;
 }
 
+static void target_low_high_to_host_low_high(abi_ulong tlow,
+                                             abi_ulong thigh,
+                                             unsigned long *hlow,
+                                             unsigned long *hhigh)
+{
+#if TARGET_LONG_BITS == HOST_LONG_BITS
+        *hlow = tlow;
+        *hhigh = thigh;
+#elif TARGET_LONG_BITS < HOST_LONG_BITS
+        *hlow = tlow | (unsigned long)thigh << TARGET_LONG_BITS;
+        *hhigh = 0;
+#else
+        *hlow = (unsigned long)tlow;
+        *hhigh = (unsigned long)(tlow >> HOST_LONG_BITS);
+#endif
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
+                target_low_high_to_host_low_high(arg4, arg5, &low, &high);
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
+                target_low_high_to_host_low_high(arg4, arg5, &low, &high);
+                ret = get_errno(safe_pwritev(arg1, vec, arg3, low, high));
                 unlock_iovec(vec, arg2, arg3, 0);
             } else {
                 ret = -host_to_target_errno(errno);
-- 
2.11.0
