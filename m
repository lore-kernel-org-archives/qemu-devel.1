Received: from eggs.gnu.org ([2001:4830:134:3::10]:36090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gZURn-0004LC-H9
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 00:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gZURk-0005ye-CO
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 00:31:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:9470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gZURk-0005tJ-2B
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 00:31:04 -0500
From: Yang Weijiang <weijiang.yang@intel.com>
Date: Wed, 19 Dec 2018 13:34:24 +0800
Message-Id: <20181219053424.18881-1-weijiang.yang@intel.com>
Subject: [Qemu-devel] [PATCH v1][RESEND] bitmap: fix the "n=0" corner case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, peterx@redhat.com, wei.w.wang@intel.com
Cc: Yang Weijiang <weijiang.yang@intel.com>

This patch enhances bitmap op function input check and ambiguous return.
BITMAP_LAST_WORD_MASK(nbits) returns 0xffffffff when "nbits=0", this leads
to error returns in some functions. This patch also checks bits input in
some slow bitmap op functions, if bits = 0, do early return to keep the
dst data unchanged.

This patch is a follow-up patch of :
https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg03510.html

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 include/qemu/bitmap.h | 24 ++++++++++++++++++++++++
 util/bitmap.c         | 24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

RESEND ChangeLog:
- git commit log format change.

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 509eeddece..b6ce0ed551 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -113,6 +113,10 @@ static inline void bitmap_zero(unsigned long *dst, long nbits)
 
 static inline void bitmap_fill(unsigned long *dst, long nbits)
 {
+    if (unlikely(!nbits)) {
+        return;
+    }
+
     size_t nlongs = BITS_TO_LONGS(nbits);
     if (!small_nbits(nbits)) {
         long len = (nlongs - 1) * sizeof(unsigned long);
@@ -174,6 +178,10 @@ static inline void bitmap_complement(unsigned long *dst,
                                      const unsigned long *src,
                                      long nbits)
 {
+    if (unlikely(!nbits)) {
+        return;
+    }
+
     if (small_nbits(nbits)) {
         *dst = ~(*src) & BITMAP_LAST_WORD_MASK(nbits);
     } else {
@@ -184,6 +192,10 @@ static inline void bitmap_complement(unsigned long *dst,
 static inline int bitmap_equal(const unsigned long *src1,
                                const unsigned long *src2, long nbits)
 {
+    if (unlikely(!nbits)) {
+        return 0;
+    }
+
     if (small_nbits(nbits)) {
         return ! ((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
     } else {
@@ -193,6 +205,10 @@ static inline int bitmap_equal(const unsigned long *src1,
 
 static inline int bitmap_empty(const unsigned long *src, long nbits)
 {
+    if (unlikely(!nbits)) {
+        return 0;
+    }
+
     if (small_nbits(nbits)) {
         return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
     } else {
@@ -202,6 +218,10 @@ static inline int bitmap_empty(const unsigned long *src, long nbits)
 
 static inline int bitmap_full(const unsigned long *src, long nbits)
 {
+    if (unlikely(!nbits)) {
+        return 0;
+    }
+
     if (small_nbits(nbits)) {
         return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
     } else {
@@ -212,6 +232,10 @@ static inline int bitmap_full(const unsigned long *src, long nbits)
 static inline int bitmap_intersects(const unsigned long *src1,
                                     const unsigned long *src2, long nbits)
 {
+    if (unlikely(!nbits)) {
+        return 0;
+    }
+
     if (small_nbits(nbits)) {
         return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
     } else {
diff --git a/util/bitmap.c b/util/bitmap.c
index cb618c65a5..64bb16a46a 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -42,6 +42,10 @@ int slow_bitmap_empty(const unsigned long *bitmap, long bits)
 {
     long k, lim = bits/BITS_PER_LONG;
 
+    if (unlikely(!bits)) {
+        return 0;
+    }
+
     for (k = 0; k < lim; ++k) {
         if (bitmap[k]) {
             return 0;
@@ -60,6 +64,10 @@ int slow_bitmap_full(const unsigned long *bitmap, long bits)
 {
     long k, lim = bits/BITS_PER_LONG;
 
+    if (unlikely(!bits)) {
+        return 0;
+    }
+
     for (k = 0; k < lim; ++k) {
         if (~bitmap[k]) {
             return 0;
@@ -80,6 +88,10 @@ int slow_bitmap_equal(const unsigned long *bitmap1,
 {
     long k, lim = bits/BITS_PER_LONG;
 
+    if (unlikely(!bits)) {
+        return 0;
+    }
+
     for (k = 0; k < lim; ++k) {
         if (bitmap1[k] != bitmap2[k]) {
             return 0;
@@ -116,6 +128,10 @@ int slow_bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
     long nr = BITS_TO_LONGS(bits);
     unsigned long result = 0;
 
+    if (unlikely(!bits)) {
+        return 0;
+    }
+
     for (k = 0; k < nr; k++) {
         result |= (dst[k] = bitmap1[k] & bitmap2[k]);
     }
@@ -342,6 +358,10 @@ int slow_bitmap_intersects(const unsigned long *bitmap1,
 {
     long k, lim = bits/BITS_PER_LONG;
 
+    if (unlikely(!bits)) {
+        return 0;
+    }
+
     for (k = 0; k < lim; ++k) {
         if (bitmap1[k] & bitmap2[k]) {
             return 1;
@@ -360,6 +380,10 @@ long slow_bitmap_count_one(const unsigned long *bitmap, long nbits)
 {
     long k, lim = nbits / BITS_PER_LONG, result = 0;
 
+    if (unlikely(!nbits)) {
+        return 0;
+    }
+
     for (k = 0; k < lim; k++) {
         result += ctpopl(bitmap[k]);
     }
-- 
2.17.1
