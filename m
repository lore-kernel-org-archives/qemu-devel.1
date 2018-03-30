Received: from eggs.gnu.org ([2001:4830:134:3::10]:54671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f1qZG-000769-5m
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f1qZF-0007J4-DA
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:45750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1f1qZF-0007Io-3C
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:29 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 30 Mar 2018 17:24:33 +0800
Message-Id: <1522401876-39613-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1522401876-39613-1-git-send-email-wei.w.wang@intel.com>
References: <1522401876-39613-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v6 2/5] migration: use bitmap_mutex in
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
Cc: pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

The bitmap mutex is used to synchronize threads to update the dirty
bitmap and the migration_dirty_pages counter. This patch makes
migration_bitmap_clear_dirty update the bitmap and counter under the
mutex.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 migration/ram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 0e90efa..9a72b1a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -795,11 +795,14 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
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
