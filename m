Received: from eggs.gnu.org ([2001:4830:134:3::10]:49893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTeKh-0000uy-JU
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTeKg-0000cS-Oe
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:65450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gTeKg-0000Zq-Fw
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:38 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon,  3 Dec 2018 10:18:28 +0800
Message-Id: <1543803511-34793-5-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v10 4/7] migration: API to clear bits of guest
 free pages from the dirty bitmap
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

This patch adds an API to clear bits corresponding to guest free pages
from the dirty bitmap. Spilt the free page block if it crosses the QEMU
RAMBlock boundary.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  2 ++
 migration/ram.c          | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

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
index 01d267f..4f7a3fe 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3131,6 +3131,53 @@ static void ram_state_resume_prepare(RAMState *rs, QEMUFile *out)
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
+    MigrationState *s = migrate_get_current();
+
+    /* This function is currently expected to be used during live migration */
+    if (!migration_is_setup_or_active(s->state)) {
+        return;
+    }
+
+    for (; len > 0; len -= used_len, addr += used_len) {
+        block = qemu_ram_block_from_host(addr, false, &offset);
+        if (unlikely(!block || offset > block->used_length)) {
+            /*
+             * The implementation might not support RAMBlock resize during
+             * live migration, but it could happen in theory with future
+             * updates. So we add a check here to capture that case.
+             */
+            error_report_once("%s unexpected error", __func__);
+            return;
+        }
+
+        if (len <= block->used_length - offset) {
+            used_len = len;
+        } else {
+            used_len = block->used_length - offset;
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
