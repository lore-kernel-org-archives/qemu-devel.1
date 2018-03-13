Received: from eggs.gnu.org ([2001:4830:134:3::10]:47241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robinhe@robinhe-hp.sh.intel.com>) id 1ewSvA-0007FE-SS
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robinhe@robinhe-hp.sh.intel.com>) id 1ewSv9-0005V7-TY
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:27:52 -0400
Received: from [112.64.68.174] (port=34617 helo=robinhe-hp.sh.intel.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robinhe@robinhe-hp.sh.intel.com>)
	id 1ewSv8-0005Sq-U1
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:27:51 -0400
From: junyan.he@intel.com
Date: Tue, 13 Mar 2018 16:33:50 +0800
Message-Id: <1520930033-18885-8-git-send-email-junyan.he@intel.com>
In-Reply-To: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
References: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
Subject: [Qemu-devel] [PATCH 07/10] RFC: Add get_current_snapshot_info to
 get the snapshot state.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, rth@twiddle.net, dgilbert@redhat.com, famz@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

We need to know the snapshot saving information when we do dependent
snapshot saving, e.g the name of previous snapshot. Add this global
function to query the snapshot status is usable.

Signed-off-by: Junyan He <junyan.he@intel.com>
---
 include/migration/snapshot.h |  3 +++
 migration/savevm.c           | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index c85b6ec..0b950ce 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -15,7 +15,10 @@
 #ifndef QEMU_MIGRATION_SNAPSHOT_H
 #define QEMU_MIGRATION_SNAPSHOT_H
 
+#include "block/snapshot.h"
+
 int save_snapshot(const char *name, Error **errp);
 int load_snapshot(const char *name, Error **errp);
+int get_current_snapshot_info(QEMUSnapshotInfo *sn);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 1bbd6aa..3a9b904 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2212,6 +2212,29 @@ int qemu_loadvm_state(QEMUFile *f)
     return ret;
 }
 
+static int in_snap_saving;
+static QEMUSnapshotInfo in_snap_saving_sn;
+
+int get_current_snapshot_info(QEMUSnapshotInfo *sn)
+{
+    if (in_snap_saving && sn) {
+        memcpy(sn, &in_snap_saving_sn, sizeof(QEMUSnapshotInfo));
+    }
+
+    return in_snap_saving;
+}
+
+static void set_current_snapshot_info(QEMUSnapshotInfo *sn)
+{
+    if (sn) {
+        memcpy(&in_snap_saving_sn, sn, sizeof(QEMUSnapshotInfo));
+        in_snap_saving = 1;
+    } else {
+        memset(&in_snap_saving_sn, 0, sizeof(QEMUSnapshotInfo));
+        in_snap_saving = 0;
+    }
+}
+
 int save_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs1;
@@ -2282,6 +2305,8 @@ int save_snapshot(const char *name, Error **errp)
         strftime(sn->name, sizeof(sn->name), "vm-%Y%m%d%H%M%S", &tm);
     }
 
+    set_current_snapshot_info(sn);
+
     /* save the VM state */
     f = qemu_fopen_bdrv(bs, 1);
     if (!f) {
@@ -2313,6 +2338,8 @@ int save_snapshot(const char *name, Error **errp)
     ret = 0;
 
  the_end:
+    set_current_snapshot_info(NULL);
+
     if (aio_context) {
         aio_context_release(aio_context);
     }
-- 
2.7.4
