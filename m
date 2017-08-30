Received: from eggs.gnu.org ([2001:4830:134:3::10]:33891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyQb-0006ju-Dv
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyQa-000388-JH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:32:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmyQa-00037p-Cu
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:32:48 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Aug 2017 16:31:59 +0800
Message-Id: <1504081950-2528-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1504081950-2528-1-git-send-email-peterx@redhat.com>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 02/33] bitmap: introduce bitmap_count_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Count how many bits set in the bitmap.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/bitmap.h | 10 ++++++++++
 util/bitmap.c         | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index c318da1..a13bd28 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -82,6 +82,7 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
                        const unsigned long *bitmap2, long bits);
 int slow_bitmap_intersects(const unsigned long *bitmap1,
                            const unsigned long *bitmap2, long bits);
+long slow_bitmap_count_one(const unsigned long *bitmap, long nbits);
 
 static inline unsigned long *bitmap_try_new(long nbits)
 {
@@ -216,6 +217,15 @@ static inline int bitmap_intersects(const unsigned long *src1,
     }
 }
 
+static inline long bitmap_count_one(const unsigned long *bitmap, long nbits)
+{
+    if (small_nbits(nbits)) {
+        return (ctpopl(*bitmap & BITMAP_LAST_WORD_MASK(nbits)));
+    } else {
+        return slow_bitmap_count_one(bitmap, nbits);
+    }
+}
+
 void bitmap_set(unsigned long *map, long i, long len);
 void bitmap_set_atomic(unsigned long *map, long i, long len);
 void bitmap_clear(unsigned long *map, long start, long nr);
diff --git a/util/bitmap.c b/util/bitmap.c
index efced9a..3446d72 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -355,3 +355,18 @@ int slow_bitmap_intersects(const unsigned long *bitmap1,
     }
     return 0;
 }
+
+long slow_bitmap_count_one(const unsigned long *bitmap, long nbits)
+{
+    long k, lim = nbits/BITS_PER_LONG, result = 0;
+
+    for (k = 0; k < lim; k++) {
+        result += ctpopl(bitmap[k]);
+    }
+
+    if (nbits % BITS_PER_LONG) {
+        result += ctpopl(bitmap[k] & BITMAP_LAST_WORD_MASK(nbits));
+    }
+
+    return result;
+}
-- 
2.7.4
