Received: from eggs.gnu.org ([2001:4830:134:3::10]:49846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTeKd-0000sk-7u
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTeKa-0000aO-GJ
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:65450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gTeKa-0000Zq-91
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:32 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon,  3 Dec 2018 10:18:25 +0800
Message-Id: <1543803511-34793-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v10 1/7] bitmap: fix bitmap_count_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Cc: pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com

BITMAP_LAST_WORD_MASK(nbits) returns 0xffffffff when "nbits=0", which
makes bitmap_count_one fail to handle the "nbits=0" case. It appears to be
preferred to remain BITMAP_LAST_WORD_MASK identical to the kernel
implementation that it is ported from.

So this patch fixes bitmap_count_one to handle the nbits=0 case.

Inital Discussion Link:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg554316.html
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/qemu/bitmap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 509eedd..679f1bd 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -221,6 +221,10 @@ static inline int bitmap_intersects(const unsigned long *src1,
 
 static inline long bitmap_count_one(const unsigned long *bitmap, long nbits)
 {
+    if (unlikely(!nbits)) {
+        return 0;
+    }
+
     if (small_nbits(nbits)) {
         return ctpopl(*bitmap & BITMAP_LAST_WORD_MASK(nbits));
     } else {
-- 
1.8.3.1
