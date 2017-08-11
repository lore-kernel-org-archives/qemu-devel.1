Received: from eggs.gnu.org ([2001:4830:134:3::10]:57359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dgAaF-0001cJ-Ev
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dgAaB-0003Kh-Bn
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:39 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dgAaB-0003KS-77
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:35 -0400
Received: by mail-qk0-x243.google.com with SMTP id a77so3569308qkb.2
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 07:06:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 11 Aug 2017 11:06:28 -0300
Message-Id: <20170811140628.31935-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] memory: fix access_with_adjusted_size() on
 big-endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

remove unnecessary memory_region_big_endian()

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
This is part of a branch with many cross-endianness tests for 2.11

Frederic does it helps your issues on armeb?

 memory.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/memory.c b/memory.c
index c0adc35410..600f5d5b1a 100644
--- a/memory.c
+++ b/memory.c
@@ -338,15 +338,6 @@ static void flatview_simplify(FlatView *view)
     }
 }
 
-static bool memory_region_big_endian(MemoryRegion *mr)
-{
-#ifdef TARGET_WORDS_BIGENDIAN
-    return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
-#else
-    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
-#endif
-}
-
 static bool memory_region_wrong_endianness(MemoryRegion *mr)
 {
 #ifdef TARGET_WORDS_BIGENDIAN
@@ -572,7 +563,8 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
 {
     uint64_t access_mask;
     unsigned access_size;
-    unsigned i;
+    hwaddr access_addr;
+    unsigned offset;
     MemTxResult r = MEMTX_OK;
 
     if (!access_size_min) {
@@ -585,17 +577,17 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
     /* FIXME: support unaligned access? */
     access_size = MAX(MIN(size, access_size_max), access_size_min);
     access_mask = -1ULL >> (64 - access_size * 8);
-    if (memory_region_big_endian(mr)) {
-        for (i = 0; i < size; i += access_size) {
-            r |= access(mr, addr + i, value, access_size,
-                        (size - access_size - i) * 8, access_mask, attrs);
+    access_addr = addr & ~(access_size - 1);
+    if (access_size < size) {
+        for (offset = 0; offset < size; offset += access_size) {
+            r |= access(mr, access_addr + offset, value, access_size,
+                        offset * 8, access_mask, attrs);
         }
     } else {
-        for (i = 0; i < size; i += access_size) {
-            r |= access(mr, addr + i, value, access_size, i * 8,
-                        access_mask, attrs);
-        }
+        r = access(mr, access_addr, value, access_size,
+                    0, access_mask, attrs);
     }
+
     return r;
 }
 
-- 
2.13.3
