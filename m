Received: from eggs.gnu.org ([2001:4830:134:3::10]:57652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNF5I-0003nF-Kz
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gNF5H-0000tw-JP
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:14567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gNF5H-0000oM-AE
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:41:15 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Thu, 15 Nov 2018 18:08:02 +0800
Message-Id: <1542276484-25508-7-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v9 6/8] migration/ram.c: add a function to
 disable the bulk stage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com, wei.w.wang@intel.com

This patch adds a function to enable a precopy notifier callback outside
the migration subsystem to disable the bulk stage flag. This is needed by
the free page optimization offered by virtio-balloon.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 +
 migration/ram.c          | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 0bac623..67cb275 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -30,6 +30,7 @@ typedef enum PrecopyNotifyReason {
 void precopy_infrastructure_init(void);
 void precopy_add_notifier(Notifier *n);
 void precopy_remove_notifier(Notifier *n);
+void precopy_disable_bulk_stage(void);
 
 void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
diff --git a/migration/ram.c b/migration/ram.c
index 65b1223..8745ca3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -352,6 +352,15 @@ static void precopy_notify(PrecopyNotifyReason reason)
     notifier_list_notify(&precopy_notifier_list, &reason);
 }
 
+void precopy_disable_bulk_stage(void)
+{
+    if (!ram_state) {
+        return;
+    }
+
+    ram_state->ram_bulk_stage = false;
+}
+
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
-- 
1.8.3.1
