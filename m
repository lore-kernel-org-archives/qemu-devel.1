Received: from eggs.gnu.org ([2001:4830:134:3::10]:51061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPKt6-00035l-Ie
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPKt5-0007TY-3V
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:08:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cPKt4-0007TD-Pl
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:08:15 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E650E15561
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 03:08:14 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  6 Jan 2017 11:08:01 +0800
Message-Id: <1483672082-5512-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1483672082-5512-1-git-send-email-peterx@redhat.com>
References: <1483672082-5512-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] migration: allow to prioritize save
 state entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Amit Shah <amit.shah@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

During migration, save state entries are saved/loaded without a specific
order - we just traverse the savevm_state.handlers list and do it one by
one. This might not be enough.

There are requirements that we need to load specific device's vmstate
first before others. For example, VT-d IOMMU contains DMA address
remapping information, which is required by all the PCI devices to do
address translations. We need to make sure IOMMU's device state is
loaded before the rest of the PCI devices, so that DMA address
translation can work properly.

This patch provide a VMStateDescription.priority value to allow specify
the priority of the saved states. The loadvm operation will be done with
those devices with higher vmsd priority.

Before this patch, we are possibly achieving the ordering requirement by
an assumption that the ordering will be the same with the ordering that
objects are created. A better way is to mark it out explicitly in the
VMStateDescription table, like what this patch does.

Current ordering logic is still naive and slow, but after all that's not
a critical path so IMO it's a workable solution for now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h |  6 ++++++
 migration/savevm.c          | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1638ee5..1a22887 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -186,6 +186,11 @@ enum VMStateFlags {
     VMS_MULTIPLY_ELEMENTS = 0x4000,
 };
 
+typedef enum {
+    MIG_PRI_DEFAULT = 0,
+    MIG_PRI_MAX,
+} MigrationPriority;
+
 typedef struct {
     const char *name;
     size_t offset;
@@ -207,6 +212,7 @@ struct VMStateDescription {
     int version_id;
     int minimum_version_id;
     int minimum_version_id_old;
+    MigrationPriority priority;
     LoadStateHandler *load_state_old;
     int (*pre_load)(void *opaque);
     int (*post_load)(void *opaque, int version_id);
diff --git a/migration/savevm.c b/migration/savevm.c
index 0363372..f9c06e9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -532,6 +532,34 @@ static int calculate_compat_instance_id(const char *idstr)
     return instance_id;
 }
 
+static inline MigrationPriority save_state_priority(SaveStateEntry *se)
+{
+    if (se->vmsd) {
+        return se->vmsd->priority;
+    }
+    return MIG_PRI_DEFAULT;
+}
+
+static void savevm_state_handler_insert(SaveStateEntry *nse)
+{
+    MigrationPriority priority = save_state_priority(nse);
+    SaveStateEntry *se;
+
+    assert(priority <= MIG_PRI_MAX);
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (save_state_priority(se) < priority) {
+            break;
+        }
+    }
+
+    if (se) {
+        QTAILQ_INSERT_BEFORE(se, nse, entry);
+    } else {
+        QTAILQ_INSERT_TAIL(&savevm_state.handlers, nse, entry);
+    }
+}
+
 /* TODO: Individual devices generally have very little idea about the rest
    of the system, so instance_id should be removed/replaced.
    Meanwhile pass -1 as instance_id if you do not already have a clearly
@@ -578,8 +606,7 @@ int register_savevm_live(DeviceState *dev,
         se->instance_id = instance_id;
     }
     assert(!se->compat || se->instance_id == 0);
-    /* add at the end of list */
-    QTAILQ_INSERT_TAIL(&savevm_state.handlers, se, entry);
+    savevm_state_handler_insert(se);
     return 0;
 }
 
@@ -662,8 +689,7 @@ int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
         se->instance_id = instance_id;
     }
     assert(!se->compat || se->instance_id == 0);
-    /* add at the end of list */
-    QTAILQ_INSERT_TAIL(&savevm_state.handlers, se, entry);
+    savevm_state_handler_insert(se);
     return 0;
 }
 
-- 
2.7.4
