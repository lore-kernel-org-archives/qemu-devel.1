Received: from eggs.gnu.org ([2001:4830:134:3::10]:35212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cEfh5-0002D2-7n
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cEfh4-0000RX-88
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:07:47 -0500
From: vijay.kilari@gmail.com
Date: Wed,  7 Dec 2016 22:36:11 +0530
Message-Id: <1481130374-5147-2-git-send-email-vijay.kilari@gmail.com>
In-Reply-To: <1481130374-5147-1-git-send-email-vijay.kilari@gmail.com>
References: <1481130374-5147-1-git-send-email-vijay.kilari@gmail.com>
Subject: [Qemu-devel] [PATCH v5 1/3] cutils: Set __builtin_prefetch optional
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, rth@twiddle.net
Cc: qemu-devel@nongnu.org, vijay.kilari@gmail.com, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Optional parameters of __builtin_prefetch() which specifies
rw and locality to 0's. For checking buffer is zero, set rw as read
and temporal locality to 0.

On arm64, __builtin_prefetch(addr) generates 'prfm    pldl1keep'
where __builtin_prefetch(addr, 0, 0) generates 'prfm pldl1strm'
instruction which is optimal for this use case

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 util/bufferiszero.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index eb974b7..421d945 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -49,7 +49,7 @@ buffer_zero_int(const void *buf, size_t len)
         const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
 
         for (; p + 8 <= e; p += 8) {
-            __builtin_prefetch(p + 8);
+            __builtin_prefetch(p + 8, 0, 0);
             if (t) {
                 return false;
             }
@@ -86,7 +86,7 @@ buffer_zero_sse2(const void *buf, size_t len)
 
     /* Loop over 16-byte aligned blocks of 64.  */
     while (likely(p <= e)) {
-        __builtin_prefetch(p);
+        __builtin_prefetch(p, 0, 0);
         t = _mm_cmpeq_epi8(t, zero);
         if (unlikely(_mm_movemask_epi8(t) != 0xFFFF)) {
             return false;
@@ -127,7 +127,7 @@ buffer_zero_sse4(const void *buf, size_t len)
 
     /* Loop over 16-byte aligned blocks of 64.  */
     while (likely(p <= e)) {
-        __builtin_prefetch(p);
+        __builtin_prefetch(p, 0, 0);
         if (unlikely(!_mm_testz_si128(t, t))) {
             return false;
         }
@@ -162,7 +162,7 @@ buffer_zero_avx2(const void *buf, size_t len)
     if (likely(p <= e)) {
         /* Loop over 32-byte aligned blocks of 128.  */
         do {
-            __builtin_prefetch(p);
+            __builtin_prefetch(p, 0, 0);
             if (unlikely(!_mm256_testz_si256(t, t))) {
                 return false;
             }
@@ -303,7 +303,7 @@ bool buffer_is_zero(const void *buf, size_t len)
     }
 
     /* Fetch the beginning of the buffer while we select the accelerator.  */
-    __builtin_prefetch(buf);
+    __builtin_prefetch(buf, 0, 0);
 
     /* Use an optimized zero check if possible.  Note that this also
        includes a check for an unrolled loop over 64-bit integers.  */
-- 
1.9.1
