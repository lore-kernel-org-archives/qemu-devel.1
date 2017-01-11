Received: from eggs.gnu.org ([2001:4830:134:3::10]:33378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhi-0002eN-K5
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhf-00050p-G1
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:3591)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cREhf-0004zB-5y
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:19 -0500
From: Liang Li <liang.z.li@intel.com>
Date: Wed, 11 Jan 2017 16:48:42 +0800
Message-Id: <1484124524-481-5-git-send-email-liang.z.li@intel.com>
In-Reply-To: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
References: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
Subject: [Qemu-devel] [PATCH v4 qemu 4/6] bitmap: Add a new bitmap_move
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com, uintela@redhat.com, amit.shah@redhat.com, mtosatti@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, dave.hansen@intel.com, Liang Li <liang.z.li@intel.com>

Sometimes, it is need to move a portion of bitmap to another place
in a large bitmap, if overlap happens, the bitmap_copy can't not
work correctly, we need a new function to do this work.

Signed-off-by: Liang Li <liang.z.li@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/qemu/bitmap.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 63ea2d0..775d05e 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -37,6 +37,7 @@
  * bitmap_set(dst, pos, nbits)			Set specified bit area
  * bitmap_set_atomic(dst, pos, nbits)   Set specified bit area with atomic ops
  * bitmap_clear(dst, pos, nbits)		Clear specified bit area
+ * bitmap_move(dst, src, nbits)                 Move *src to *dst
  * bitmap_test_and_clear_atomic(dst, pos, nbits)    Test and clear area
  * bitmap_find_next_zero_area(buf, len, pos, n, mask)	Find bit free area
  */
@@ -129,6 +130,18 @@ static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
     }
 }
 
+static inline void bitmap_move(unsigned long *dst, const unsigned long *src,
+                               long nbits)
+{
+    if (small_nbits(nbits)) {
+        unsigned long tmp = *src;
+        *dst = tmp;
+    } else {
+        long len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+        memmove(dst, src, len);
+    }
+}
+
 static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
                              const unsigned long *src2, long nbits)
 {
-- 
1.9.1
