Received: from eggs.gnu.org ([2001:4830:134:3::10]:49927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTeKm-00011J-FC
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTeKk-0000dp-K0
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:65450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gTeKk-0000Zq-CQ
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:51:42 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon,  3 Dec 2018 10:18:30 +0800
Message-Id: <1543803511-34793-7-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v10 6/7] migration/ram.c: add a function to
 disable the bulk stage
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
index 15f8d00..47e7ff5 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -37,6 +37,7 @@ void precopy_infrastructure_init(void);
 void precopy_add_notifier(NotifierWithReturn *n);
 void precopy_remove_notifier(NotifierWithReturn *n);
 int precopy_notify(PrecopyNotifyReason reason, Error **errp);
+void precopy_disable_bulk_stage(void);
 
 void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
diff --git a/migration/ram.c b/migration/ram.c
index b90a3f2..739dc97 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -354,6 +354,15 @@ int precopy_notify(PrecopyNotifyReason reason, Error **errp)
     return notifier_with_return_list_notify(&precopy_notifier_list, &pnd);
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
