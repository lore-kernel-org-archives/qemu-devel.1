Received: from eggs.gnu.org ([2001:4830:134:3::10]:41362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfg-0004LR-28
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfe-0004eh-1Y
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:35 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:46239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfd-0004dh-RS
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:33 -0400
Received: by mail-pl0-x241.google.com with SMTP id 30-v6so10377909pld.13
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:02 -1000
Message-Id: <20180610030220.3777-91-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 090/108] linux-user: Fix clock_nanosleep
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

When we switched from using clock_nanosleep to safe_clock_nanosleep,
we changed from the user-level API to the kernel-level ABI.  These
have different senses of the errno value.

The special handling for PowerPC is not requied while we're following
the kernel ABI.

Fixes: 9e518226f43
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6f19f75c67..1c1e05dc26 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7884,18 +7884,20 @@ IMPL(clock_nanosleep)
     struct timespec ts;
     abi_long ret;
 
-    target_to_host_timespec(&ts, arg3);
-    ret = get_errno(safe_clock_nanosleep(arg1, arg2, &ts, arg4 ? &ts : NULL));
-    if (arg4) {
-        host_to_target_timespec(arg4, &ts);
+    /* Note that while the user-level api for clock_nanosleep
+     * returns a positive errno values, the kernel-level api
+     * continues to return negative errno values.  Also note
+     * that safe_clock_nanosleep mirrors the kernel api.
+     */
+    ret = target_to_host_timespec(&ts, arg3);
+    if (ret == 0) {
+        ret = safe_clock_nanosleep(arg1, arg2, &ts, arg4 ? &ts : NULL);
+        if (ret) {
+            ret = -host_to_target_errno(-ret);
+        } else if (arg4) {
+            ret = host_to_target_timespec(arg4, &ts);
+        }
     }
-#if defined(TARGET_PPC)
-    /* clock_nanosleep is odd in that it returns positive errno values.
-     * On PPC, CR0 bit 3 should be set in such a situation. */
-    if (ret && ret != -TARGET_ERESTARTSYS) {
-        ((CPUPPCState *)cpu_env)->crf[0] |= 1;
-    }
-#endif
     return ret;
 }
 
-- 
2.17.1
