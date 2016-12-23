Received: from eggs.gnu.org ([2001:4830:134:3::10]:53862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKSjb-00085S-2P
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKSja-0005mr-4s
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:30:19 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:58 +0300
Message-ID: <1482503344-6424-16-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 15/21] bitmap: add bitmap_count_between()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com, jcody@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 include/qemu/bitmap.h |  4 ++++
 util/bitmap.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 63ea2d0..3bfc33e 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -216,6 +216,10 @@ static inline int bitmap_intersects(const unsigned long *src1,
     }
 }
 
+unsigned long bitmap_count_between(const unsigned long *src,
+                                   unsigned long start,
+                                   unsigned long end);
+
 void bitmap_set(unsigned long *map, long i, long len);
 void bitmap_set_atomic(unsigned long *map, long i, long len);
 void bitmap_clear(unsigned long *map, long start, long nr);
diff --git a/util/bitmap.c b/util/bitmap.c
index 43ed011..e5aaa1c 100644
--- a/util/bitmap.c
+++ b/util/bitmap.c
@@ -336,3 +336,30 @@ int slow_bitmap_intersects(const unsigned long *bitmap1,
     }
     return 0;
 }
+
+unsigned long bitmap_count_between(const unsigned long *src,
+                                   unsigned long start,
+                                   unsigned long end)
+{
+    unsigned long first = start / BITS_PER_LONG;
+    unsigned long lim = end / BITS_PER_LONG;
+    unsigned long sum, i;
+
+    assert(start < end);
+
+    sum = ctpopl(src[first] & BITMAP_FIRST_WORD_MASK(start));
+
+    for (i = first + 1; i < lim; ++i) {
+        sum += ctpopl(src[i]);
+    }
+
+    if (end % BITS_PER_LONG) {
+        if (first == lim) {
+            sum -= ctpopl(src[first] & BITMAP_FIRST_WORD_MASK(end));
+        } else {
+            sum += ctpopl(src[i] & BITMAP_LAST_WORD_MASK(end));
+        }
+    }
+
+    return sum;
+}
-- 
1.8.3.1
