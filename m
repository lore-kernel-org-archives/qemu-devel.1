Received: from eggs.gnu.org ([209.51.188.92]:52277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJV4N-0001u8-U5
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJV4K-0006c0-4h
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:29:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:62410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJV4J-0006ZL-Rd
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:29:04 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Thu, 25 Apr 2019 11:28:31 +0800
Message-Id: <20190425032831.22551-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] bitmap: get last word mask from nr directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, corentincj@iksaif.net, pl@kamp.de, Wei Yang <richardw.yang@linux.intel.com>

The value left in nr is the number of bits for the last word, which
could be calculate the last word mask directly.

Remove the unnecessary size.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 util/bitmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/bitmap.c b/util/bitmap.c
index cb618c65a5..5aa60b8717 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -160,7 +160,6 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 void bitmap_set(unsigned long *map, long start, long nr)
 {
     unsigned long *p = map + BIT_WORD(start);
-    const long size = start + nr;
     int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
     unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
 
@@ -174,7 +173,7 @@ void bitmap_set(unsigned long *map, long start, long nr)
         p++;
     }
     if (nr) {
-        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
+        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
         *p |= mask_to_set;
     }
 }
@@ -221,7 +220,6 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
 void bitmap_clear(unsigned long *map, long start, long nr)
 {
     unsigned long *p = map + BIT_WORD(start);
-    const long size = start + nr;
     int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
     unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
 
@@ -235,7 +233,7 @@ void bitmap_clear(unsigned long *map, long start, long nr)
         p++;
     }
     if (nr) {
-        mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+        mask_to_clear &= BITMAP_LAST_WORD_MASK(nr);
         *p &= ~mask_to_clear;
     }
 }
-- 
2.19.1
