Received: from eggs.gnu.org ([2001:4830:134:3::10]:46476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fRCsX-00063O-My
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fRCsW-0000PR-Tf
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:36:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:58067)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fRCsW-0000OZ-Kj
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:36:12 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri,  8 Jun 2018 16:10:39 +0800
Message-Id: <1528445443-43406-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
References: <1528445443-43406-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v8 2/6] migration: use bitmap_mutex in
 migration_bitmap_clear_dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

The bitmap mutex is used to synchronize threads to update the dirty
bitmap and the migration_dirty_pages counter. For example, the free
page optimization clears bits of free pages from the bitmap in an
iothread context. This patch makes migration_bitmap_clear_dirty update
the bitmap and counter under the mutex.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index c53e836..2eabbe9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1093,11 +1093,14 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
 {
     bool ret;
 
+    qemu_mutex_lock(&rs->bitmap_mutex);
     ret = test_and_clear_bit(page, rb->bmap);
 
     if (ret) {
         rs->migration_dirty_pages--;
     }
+    qemu_mutex_unlock(&rs->bitmap_mutex);
+
     return ret;
 }
 
-- 
1.8.3.1
