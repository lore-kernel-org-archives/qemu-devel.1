Received: from eggs.gnu.org ([2001:4830:134:3::10]:34065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvAaI-0005qi-8H
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvAaH-0001fx-7c
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dvAaH-0001ey-2A
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 445C9C0587C9
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 23:08:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 22 Sep 2017 01:08:05 +0200
Message-Id: <20170921230812.7095-12-quintela@redhat.com>
In-Reply-To: <20170921230812.7095-1-quintela@redhat.com>
References: <20170921230812.7095-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 11/18] bitmap: introduce bitmap_count_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

Count how many bits set in the bitmap.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/qemu/bitmap.h | 10 ++++++++++
 util/bitmap.c         | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index c318da12d7..2718706edb 100644
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
+        return ctpopl(*bitmap & BITMAP_LAST_WORD_MASK(nbits));
+    } else {
+        return slow_bitmap_count_one(bitmap, nbits);
+    }
+}
+
 void bitmap_set(unsigned long *map, long i, long len);
 void bitmap_set_atomic(unsigned long *map, long i, long len);
 void bitmap_clear(unsigned long *map, long start, long nr);
diff --git a/util/bitmap.c b/util/bitmap.c
index efced9a7d8..90a42ff625 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -355,3 +355,18 @@ int slow_bitmap_intersects(const unsigned long *bitmap1,
     }
     return 0;
 }
+
+long slow_bitmap_count_one(const unsigned long *bitmap, long nbits)
+{
+    long k, lim = nbits / BITS_PER_LONG, result = 0;
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
2.13.5
