Received: from eggs.gnu.org ([2001:4830:134:3::10]:35365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cEfhN-0002SR-NU
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cEfhI-0000Wi-Ot
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:08:05 -0500
From: vijay.kilari@gmail.com
Date: Wed,  7 Dec 2016 22:36:13 +0530
Message-Id: <1481130374-5147-4-git-send-email-vijay.kilari@gmail.com>
In-Reply-To: <1481130374-5147-1-git-send-email-vijay.kilari@gmail.com>
References: <1481130374-5147-1-git-send-email-vijay.kilari@gmail.com>
Subject: [Qemu-devel] [PATCH v5 3/3] utils: Add prefetch for Thunderx
 platform
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

Thunderx pass2 chip requires explicit prefetch
instruction to give prefetch hint.

To speed up live migration on Thunderx platform,
prefetch instruction is added in zero buffer check
function.The below results show live migration time improvement
with prefetch instruction. VM with 4 VCPUs, 8GB RAM is migrated.

Code for decoding cache size is taken from Richard's patch.

With 1K page size and without prefetch
======================================
Migration status: completed
total time: 13556 milliseconds
downtime: 380 milliseconds
setup: 15 milliseconds
transferred ram: 265557 kbytes
throughput: 160.51 mbps
remaining ram: 0 kbytes
total ram: 8519872 kbytes
duplicate: 8344672 pages
skipped: 0 pages
normal: 190724 pages
normal bytes: 190724 kbytes
dirty sync count: 3

With 1K page size and with prefetch
===================================
Migration status: completed
total time: 8218 milliseconds
downtime: 395 milliseconds
setup: 15 milliseconds
transferred ram: 274484 kbytes
throughput: 273.67 mbps
remaining ram: 0 kbytes
total ram: 8519872 kbytes
duplicate: 8341921 pages
skipped: 0 pages
normal: 199606 pages
normal bytes: 199606 kbytes
dirty sync count: 3
(qemu)

With 4K page size and without prefetch
======================================
Migration status: completed
total time: 11121 milliseconds
downtime: 372 milliseconds
setup: 5 milliseconds
transferred ram: 231777 kbytes
throughput: 170.77 mbps
remaining ram: 0 kbytes
total ram: 8519872 kbytes
duplicate: 2082158 pages
skipped: 0 pages
normal: 53265 pages
normal bytes: 213060 kbytes
dirty sync count: 3

With 4K page size and with prefetch
===================================
Migration status: completed
total time: 5893 milliseconds
downtime: 359 milliseconds
setup: 5 milliseconds
transferred ram: 225795 kbytes
throughput: 313.96 mbps
remaining ram: 0 kbytes
total ram: 8519872 kbytes
duplicate: 2081903 pages
skipped: 0 pages
normal: 51773 pages
normal bytes: 207092 kbytes
dirty sync count: 3

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
---
 util/bufferiszero.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 421d945..ed3b31d 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -25,6 +25,11 @@
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
+#include "qemu/aarch64-cpuid.h"
+
+static uint32_t cache_line_size = 64;
+static uint32_t prefetch_line_dist = 1;
+static uint32_t prefetch_distance = 8;
 
 static bool
 buffer_zero_int(const void *buf, size_t len)
@@ -49,7 +54,7 @@ buffer_zero_int(const void *buf, size_t len)
         const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
 
         for (; p + 8 <= e; p += 8) {
-            __builtin_prefetch(p + 8, 0, 0);
+            __builtin_prefetch(p + prefetch_distance, 0, 0);
             if (t) {
                 return false;
             }
@@ -293,17 +298,45 @@ bool test_buffer_is_zero_next_accel(void)
 }
 #endif
 
+static void __attribute__((constructor)) init_cache_size(void)
+{
+#if defined(__aarch64__)
+    uint64_t t;
+
+    /* Use the DZP block size as a proxy for the cacheline size,
+       since the later is not available to userspace.  This seems
+       to work in practice for existing implementations.  */
+    asm("mrs %0, dczid_el0" : "=r"(t));
+    if ((1 << ((t & 0xf) + 2)) >= 128) {
+        cache_line_size = 128;
+    }
+#endif
+
+    get_aarch64_cpu_id();
+    if (is_thunderx_pass2_cpu()) {
+        prefetch_line_dist = 3;
+        prefetch_distance = (prefetch_line_dist * cache_line_size) /
+                             sizeof(uint64_t);
+    }
+}
+
 /*
  * Checks if a buffer is all zeroes
  */
 bool buffer_is_zero(const void *buf, size_t len)
 {
+    int i;
+    uint32_t prefetch_distance_bytes;
+
     if (unlikely(len == 0)) {
         return true;
     }
 
     /* Fetch the beginning of the buffer while we select the accelerator.  */
-    __builtin_prefetch(buf, 0, 0);
+    prefetch_distance_bytes = prefetch_line_dist * cache_line_size;
+    for (i = 0; i < prefetch_distance_bytes && i < len; i += cache_line_size) {
+        __builtin_prefetch(buf + i, 0, 0);
+    }
 
     /* Use an optimized zero check if possible.  Note that this also
        includes a check for an unrolled loop over 64-bit integers.  */
-- 
1.9.1
