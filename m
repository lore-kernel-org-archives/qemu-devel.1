Received: from eggs.gnu.org ([2001:4830:134:3::10]:54714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1etYZN-0004c2-I0
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:53:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1etYZM-0000Wx-BZ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:53:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:58183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1etYZM-0000VH-0w
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:53:20 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed,  7 Mar 2018 20:34:23 +0800
Message-Id: <1520426065-40265-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v4 2/4] migration: API to clear bits of guest
 free pages from the dirty bitmap
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

This patch adds an API to clear bits corresponding to guest free pages
from the dirty bitmap. Spilt the free page block if it crosses the QEMU
RAMBlock boundary.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 include/migration/misc.h |  2 ++
 migration/ram.c          | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 77fd4f5..fae1acf 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -14,11 +14,13 @@
 #ifndef MIGRATION_MISC_H
 #define MIGRATION_MISC_H
 
+#include "exec/cpu-common.h"
 #include "qemu/notify.h"
 
 /* migration/ram.c */
 
 void ram_mig_init(void);
+void qemu_guest_free_page_hint(void *addr, size_t len);
 
 /* migration/block.c */
 
diff --git a/migration/ram.c b/migration/ram.c
index 5e33e5c..e172798 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2189,6 +2189,27 @@ static int ram_init_all(RAMState **rsp)
     return 0;
 }
 
+void qemu_guest_free_page_hint(void *addr, size_t len)
+{
+    RAMBlock *block;
+    ram_addr_t offset;
+    size_t used_len, start, npages;
+
+    for (used_len = len; len > 0; len -= used_len) {
+        block = qemu_ram_block_from_host(addr, false, &offset);
+        if (unlikely(offset + len > block->used_length)) {
+            used_len = block->used_length - offset;
+            addr += used_len;
+        }
+
+        start = offset >> TARGET_PAGE_BITS;
+        npages = used_len >> TARGET_PAGE_BITS;
+        ram_state->migration_dirty_pages -=
+                      bitmap_count_one_with_offset(block->bmap, start, npages);
+        bitmap_clear(block->bmap, start, npages);
+    }
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
-- 
1.8.3.1
