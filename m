Received: from eggs.gnu.org ([2001:4830:134:3::10]:53866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKSjb-00085i-Am
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKSja-0005nL-IA
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:30:19 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:59 +0300
Message-ID: <1482503344-6424-17-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 16/21] hbitmap: add hbitmap_count_between()
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

Add this function only for HBitmap's with greanularity = 0.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 include/qemu/hbitmap.h | 2 ++
 util/hbitmap.c         | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 2873a46..1967e13 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -314,4 +314,6 @@ static inline size_t hbitmap_iter_next_word(HBitmapIter *hbi, unsigned long *p_c
 }
 
 
+uint64_t hbitmap_count_between(HBitmap *hb, uint64_t start, uint64_t end);
+
 #endif
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 48d8b2d..d06bfa3 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -232,6 +232,15 @@ static uint64_t hb_count_between(HBitmap *hb, uint64_t start, uint64_t last)
     return count;
 }
 
+/* hbitmap_count_between() is only for HBitmap's with granularity = 0 */
+uint64_t hbitmap_count_between(HBitmap *hb, uint64_t start, uint64_t end)
+{
+    assert(hb->granularity == 0);
+    assert(start < end);
+
+    return hb_count_between(hb, start, end - 1);
+}
+
 /* Setting starts at the last layer and propagates up if an element
  * changes.
  */
-- 
1.8.3.1
