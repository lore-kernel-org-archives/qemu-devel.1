Received: from eggs.gnu.org ([2001:4830:134:3::10]:54693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f1qZI-00078f-1c
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f1qZG-0007Jj-TC
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:45750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1f1qZG-0007Io-KA
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 05:43:30 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 30 Mar 2018 17:24:34 +0800
Message-Id: <1522401876-39613-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1522401876-39613-1-git-send-email-wei.w.wang@intel.com>
References: <1522401876-39613-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v6 3/5] migration: API to clear bits of guest
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
 migration/ram.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 4ebf24c..113320e 100644
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
index 9a72b1a..0147548 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2198,6 +2198,50 @@ static int ram_init_all(RAMState **rsp)
 }
 
 /*
+ * This function clears bits of the free pages reported by the caller from the
+ * migration dirty bitmap. @addr is the host address corresponding to the
+ * start of the continuous guest free pages, and @len is the total bytes of
+ * those pages.
+ */
+void qemu_guest_free_page_hint(void *addr, size_t len)
+{
+    RAMBlock *block;
+    ram_addr_t offset;
+    size_t used_len, start, npages;
+
+    for (; len > 0; len -= used_len) {
+        block = qemu_ram_block_from_host(addr, false, &offset);
+        if (unlikely(!block)) {
+            return;
+        }
+
+        /*
+         * This handles the case that the RAMBlock is resized after the free
+         * page hint is reported.
+         */
+        if (unlikely(offset > block->used_length)) {
+            return;
+        }
+
+        if (len <= block->used_length - offset) {
+            used_len = len;
+        } else {
+            used_len = block->used_length - offset;
+            addr += used_len;
+        }
+
+        start = offset >> TARGET_PAGE_BITS;
+        npages = used_len >> TARGET_PAGE_BITS;
+
+        qemu_mutex_lock(&ram_state->bitmap_mutex);
+        ram_state->migration_dirty_pages -=
+                      bitmap_count_one_with_offset(block->bmap, start, npages);
+        bitmap_clear(block->bmap, start, npages);
+        qemu_mutex_unlock(&ram_state->bitmap_mutex);
+    }
+}
+
+/*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
  * start to become numerous it will be necessary to reduce the
-- 
1.8.3.1
