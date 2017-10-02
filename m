Received: from eggs.gnu.org ([2001:4830:134:3::10]:36864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=441524c13=anthony.perard@citrix.com>)
	id 1dz3dC-0004Vl-8t
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=441524c13=anthony.perard@citrix.com>)
	id 1dz3d9-0006dZ-1d
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:31:46 -0400
Received: from smtp.citrix.com ([66.165.176.89]:47968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=441524c13=anthony.perard@citrix.com>)
	id 1dz3d8-0006aB-Ri
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:31:42 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Mon, 2 Oct 2017 17:30:58 +0100
Message-ID: <20171002163058.15651-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] migration,
 xen: Fix block image lock issue on live migration
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Wei Liu <wei.liu2@citrix.com>, Juan Quintela <quintela@redhat.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

When doing a live migration of a Xen guest with libxl, the images for
block devices are locked by the original QEMU process, and this prevent
the QEMU at the destination to take the lock and the migration fail.

>From QEMU point of view, once the RAM of a domain is migrated, there is
two QMP commands, "stop" then "xen-save-devices-state", at which point a
new QEMU is spawned at the destination.

Release locks in "xen-save-devices-state" so the destination can takes
them.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
CCing libxl maintainers:
CC: Ian Jackson <ian.jackson@eu.citrix.com>
CC: Wei Liu <wei.liu2@citrix.com>
---
 migration/savevm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 4a88228614..69d904c179 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2263,6 +2263,20 @@ void qmp_xen_save_devices_state(const char *filename, Error **errp)
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
+        if (!saved_vm_running) {
+            ret = bdrv_inactivate_all();
+            if (ret) {
+                error_setg(errp, "%s: bdrv_inactivate_all() failed (%d)",
+                           __func__, ret);
+            }
+        }
     }
 
  the_end:
-- 
Anthony PERARD
