Received: from eggs.gnu.org ([2001:4830:134:3::10]:56589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fk2oT-0005T6-V6
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fk2oT-0001Li-8Z
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:41:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:40271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fk2oS-0001LU-VT
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:41:53 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 30 Jul 2018 15:13:57 +0800
Message-Id: <1532934837-5966-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1532934837-5966-1-git-send-email-wei.w.wang@intel.com>
References: <1532934837-5966-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH 2/2] bitmap: fix bitmap_count_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, quintela@redhat.com
Cc: mst@redhat.com

Since "nbits = 0" is not applicable to the BITMAP_LAST_WORD_MASK macro,
callers need to avoid passing "nbits = 0" to this macro, which generates
incorrect results.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/qemu/bitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index f53c640..e45e9c0 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -223,7 +223,7 @@ static inline int bitmap_intersects(const unsigned long *src1,
 static inline long bitmap_count_one(const unsigned long *bitmap, long nbits)
 {
     if (small_nbits(nbits)) {
-        return ctpopl(*bitmap & BITMAP_LAST_WORD_MASK(nbits));
+        return nbits ? ctpopl(*bitmap & BITMAP_LAST_WORD_MASK(nbits)) : 0;
     } else {
         return slow_bitmap_count_one(bitmap, nbits);
     }
-- 
2.7.4
