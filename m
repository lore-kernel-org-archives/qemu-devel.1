Received: from eggs.gnu.org ([2001:4830:134:3::10]:46590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0IY-0000Xw-OH
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0IX-0000tB-7j
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1db0IX-0000sq-16
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:01 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 28 Jul 2017 16:06:13 +0800
Message-Id: <1501229198-30588-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-1-git-send-email-peterx@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 04/29] bitmap: introduce bitmap_invert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It is used to invert the whole bitmap.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/bitmap.h | 10 ++++++++++
 util/bitmap.c         | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index c318da1..460d899 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -82,6 +82,7 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
                        const unsigned long *bitmap2, long bits);
 int slow_bitmap_intersects(const unsigned long *bitmap1,
                            const unsigned long *bitmap2, long bits);
+void slow_bitmap_invert(unsigned long *bitmap, long nbits);
 
 static inline unsigned long *bitmap_try_new(long nbits)
 {
@@ -216,6 +217,15 @@ static inline int bitmap_intersects(const unsigned long *src1,
     }
 }
 
+static inline void bitmap_invert(unsigned long *bitmap, long nbits)
+{
+    if (small_nbits(nbits)) {
+        *bitmap ^= BITMAP_LAST_WORD_MASK(nbits);
+    } else {
+        slow_bitmap_invert(bitmap, nbits);
+    }
+}
+
 void bitmap_set(unsigned long *map, long i, long len);
 void bitmap_set_atomic(unsigned long *map, long i, long len);
 void bitmap_clear(unsigned long *map, long start, long nr);
diff --git a/util/bitmap.c b/util/bitmap.c
index efced9a..9b7408c 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -355,3 +355,16 @@ int slow_bitmap_intersects(const unsigned long *bitmap1,
     }
     return 0;
 }
+
+void slow_bitmap_invert(unsigned long *bitmap, long nbits)
+{
+    long k, lim = nbits/BITS_PER_LONG;
+
+    for (k = 0; k < lim; k++) {
+        bitmap[k] ^= ULONG_MAX;
+    }
+
+    if (nbits % BITS_PER_LONG) {
+        bitmap[k] ^= BITMAP_LAST_WORD_MASK(nbits);
+    }
+}
-- 
2.7.4
