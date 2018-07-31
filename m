Received: from eggs.gnu.org ([2001:4830:134:3::10]:57269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fkRuD-0001Zp-IT
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fkRu9-0007SO-KN
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:29:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:39279)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fkRu9-0007S6-B2
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:29:25 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 31 Jul 2018 18:01:18 +0800
Message-Id: <1533031278-5615-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2] bitmap: fix BITMAP_LAST_WORD_MASK
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

When "nbits = 0", which means no bits to mask, this macro is expected to
return 0, instead of 0xffffffff. This patch changes the macro to return
0 when there is no bit needs to be masked.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/qemu/bitmap.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

v1->v2 ChangeLog:
- fix the macro directly, instead of fixing the callers one by one.

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 509eedd..9372423 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -60,7 +60,10 @@
  */
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
-#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
+#define BITMAP_LAST_WORD_MASK(nbits)                       \
+(                                                          \
+    nbits ? (~0UL >> (-(nbits) & (BITS_PER_LONG - 1))) : 0 \
+)
 
 #define DECLARE_BITMAP(name,bits)                  \
         unsigned long name[BITS_TO_LONGS(bits)]
-- 
2.7.4
