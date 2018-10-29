Received: from eggs.gnu.org ([2001:4830:134:3::10]:45414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2k-0004bs-UB
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2f-0002VL-D0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:50 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:58 -0400
Message-Id: <20181029212501.5897-17-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 16/19] bitmap: Update count after a merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Eric Blake <eblake@redhat.com>, qemu-stable@nongnu.org

From: Eric Blake <eblake@redhat.com>

We need an accurate count of the number of bits set in a bitmap
after a merge. In particular, since the merge operation short-circuits
a merge from an empty source, if you have bitmaps A, B, and C where
B started empty, then merge C into B, and B into A, an inaccurate
count meant that A did not get the contents of C.

In the worst case, we may falsely regard the bitmap as empty when
it has had new writes merged into it.

Fixes: be58721db
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20181002233314.30159-1-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 util/hbitmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index d5aca5159f..8d402c59d9 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -759,6 +759,9 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result)
         }
     }
 
+    /* Recompute the dirty count */
+    result->count = hb_count_between(result, 0, result->size - 1);
+
     return true;
 }
 
-- 
2.14.5
