Received: from eggs.gnu.org ([2001:4830:134:3::10]:35544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=48602c113=anthony.perard@citrix.com>)
	id 1eFM3K-0006Dt-TF
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=48602c113=anthony.perard@citrix.com>)
	id 1eFM3F-00036m-PQ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:26:06 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:65248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=48602c113=anthony.perard@citrix.com>)
	id 1eFM3F-00030o-I4
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:26:01 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 16 Nov 2017 15:14:19 +0000
Message-ID: <20171116151419.694-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 for-2.11] migration,
 xen: Fix block image lock issue on live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Ian Jackson <ian.jackson@eu.citrix.com>, Wei Liu <wei.liu2@citrix.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

When doing a live migration of a Xen guest with libxl, the images for
block devices are locked by the original QEMU process, and this prevent
the QEMU at the destination to take the lock and the migration fail.

>From QEMU point of view, once the RAM of a domain is migrated, there is
two QMP commands, "stop" then "xen-save-devices-state", at which point a
new QEMU is spawned at the destination.

Release locks in "xen-save-devices-state" so the destination can takes
them, if it's a live migration.

This patch add the "live" parameter to "xen-save-devices-state" which
default to true so older version of libxenlight can work with newer
version of QEMU.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
Changes in V2:
- add the live parameter

CC: Kevin Wolf <kwolf@redhat.com>

also CCing libxl maintainers:
CC: Ian Jackson <ian.jackson@eu.citrix.com>
CC: Wei Liu <wei.liu2@citrix.com>
---
 migration/savevm.c  | 23 ++++++++++++++++++++++-
 qapi/migration.json |  6 +++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 4a88228614..7bc4e23e65 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2242,13 +2242,20 @@ int save_snapshot(const char *name, Error **errp)
     return ret;
 }
 
-void qmp_xen_save_devices_state(const char *filename, Error **errp)
+void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
+                                Error **errp)
 {
     QEMUFile *f;
     QIOChannelFile *ioc;
     int saved_vm_running;
     int ret;
 
+    if (!has_live) {
+        /* live default to true so old version of Xen tool stack can have a
+         * successfull live migration */
+        live = true;
+    }
+
     saved_vm_running = runstate_is_running();
     vm_stop(RUN_STATE_SAVE_VM);
     global_state_store_running();
@@ -2263,6 +2270,20 @@ void qmp_xen_save_devices_state(const char *filename, Error **errp)
     qemu_fclose(f);
     if (ret < 0) {
         error_setg(errp, QERR_IO_ERROR);
+    } else {
+        /* libxl calls the QMP command "stop" before calling
+         * "xen-save-devices-state" and in case of migration failure, libxl
+         * would call "cont".
+         * So call bdrv_inactivate_all (release locks) here to let the other
+         * side of the migration take controle of the images.
+         */
+        if (live && !saved_vm_running) {
+            ret = bdrv_inactivate_all();
+            if (ret) {
+                error_setg(errp, "%s: bdrv_inactivate_all() failed (%d)",
+                           __func__, ret);
+            }
+        }
     }
 
  the_end:
diff --git a/qapi/migration.json b/qapi/migration.json
index bbc4671ded..03f57c9616 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1075,6 +1075,9 @@
 # data. See xen-save-devices-state.txt for a description of the binary
 # format.
 #
+# @live: Optional argument to ask QEMU to treat this command as part of a live
+# migration. Default to true. (since 2.11)
+#
 # Returns: Nothing on success
 #
 # Since: 1.1
@@ -1086,7 +1089,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'xen-save-devices-state', 'data': {'filename': 'str'} }
+{ 'command': 'xen-save-devices-state',
+  'data': {'filename': 'str', '*live':'bool' } }
 
 ##
 # @xen-set-replication:
-- 
Anthony PERARD
