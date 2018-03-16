Received: from eggs.gnu.org ([2001:4830:134:3::10]:51161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewnCt-0008NN-7z
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ewnCp-00075t-8K
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:07:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:53867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ewnCo-0006zV-Sn
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:07:27 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 16 Mar 2018 18:48:25 +0800
Message-Id: <1521197309-13544-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com>
References: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v5 1/5] bitmap: bitmap_count_one_with_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

Count the number of 1s in a bitmap starting from an offset.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/qemu/bitmap.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 509eedd..e3f31f1 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -228,6 +228,19 @@ static inline long bitmap_count_one(const unsigned long *bitmap, long nbits)
     }
 }
 
+static inline long bitmap_count_one_with_offset(const unsigned long *bitmap,
+                                                long offset, long nbits)
+{
+    long aligned_offset = QEMU_ALIGN_DOWN(offset, BITS_PER_LONG);
+    long redundant_bits = offset - aligned_offset;
+    long bits_to_count = nbits + redundant_bits;
+    const unsigned long *bitmap_start = bitmap +
+                                        aligned_offset / BITS_PER_LONG;
+
+    return bitmap_count_one(bitmap_start, bits_to_count) -
+           bitmap_count_one(bitmap_start, redundant_bits);
+}
+
 void bitmap_set(unsigned long *map, long i, long len);
 void bitmap_set_atomic(unsigned long *map, long i, long len);
 void bitmap_clear(unsigned long *map, long start, long nr);
-- 
1.8.3.1
