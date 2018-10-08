Received: from eggs.gnu.org ([2001:4830:134:3::10]:41413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNg-0005Al-Ei
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNa-0005nI-Ia
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNa-0005jA-2k
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92DD8313D683
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:24 +0200
Message-Id: <20181008173125.19678-31-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 30/31] blockdev: Convert drive_new() to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Calling error_report() from within a a function that takes an Error **
argument is suspicious.  drive_new() does that, and its caller
drive_init_func() then exit()s.  Its caller main(), via
qemu_opts_foreach(), is fine with it, but clean it up anyway:

* Convert drive_new() to Error

* Update add_init_drive() to report the error received from
  drive_new().

* Make main() pass &error_fatal through qemu_opts_foreach(),
  drive_init_func() to drive_new()

* Make default_drive() pass &error_abort through qemu_opts_foreach(),
  drive_init_func() to drive_new()

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c                | 27 ++++++++++++++-------------
 device-hotplug.c          |  5 ++++-
 include/sysemu/blockdev.h |  3 ++-
 vl.c                      | 11 ++++-------
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a8755bd908..574adbcb7f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -759,7 +759,8 @@ QemuOptsList qemu_legacy_drive_opts = {
     },
 };
 
-DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
+DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
+                     Error **errp)
 {
     const char *value;
     BlockBackend *blk;
@@ -808,7 +809,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         qemu_opt_rename(all_opts, opt_renames[i].from, opt_renames[i].to,
                         &local_err);
         if (local_err) {
-            error_report_err(local_err);
+            error_propagate(errp, local_err);
             return NULL;
         }
     }
@@ -819,7 +820,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         bool writethrough;
 
         if (bdrv_parse_cache_mode(value, &flags, &writethrough) != 0) {
-            error_report("invalid cache option");
+            error_setg(errp, "invalid cache option");
             return NULL;
         }
 
@@ -847,7 +848,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
                                    &error_abort);
     qemu_opts_absorb_qdict(legacy_opts, bs_opts, &local_err);
     if (local_err) {
-        error_report_err(local_err);
+        error_propagate(errp, local_err);
         goto fail;
     }
 
@@ -860,7 +861,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
             media = MEDIA_CDROM;
             read_only = true;
         } else {
-            error_report("'%s' invalid media", value);
+            error_setg(errp, "'%s' invalid media", value);
             goto fail;
         }
     }
@@ -885,7 +886,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
              type++) {
         }
         if (type == IF_COUNT) {
-            error_report("unsupported bus type '%s'", value);
+            error_setg(errp, "unsupported bus type '%s'", value);
             goto fail;
         }
     } else {
@@ -902,7 +903,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
 
     if (index != -1) {
         if (bus_id != 0 || unit_id != -1) {
-            error_report("index cannot be used with bus and unit");
+            error_setg(errp, "index cannot be used with bus and unit");
             goto fail;
         }
         bus_id = drive_index_to_bus_id(type, index);
@@ -921,13 +922,13 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     }
 
     if (max_devs && unit_id >= max_devs) {
-        error_report("unit %d too big (max is %d)", unit_id, max_devs - 1);
+        error_setg(errp, "unit %d too big (max is %d)", unit_id, max_devs - 1);
         goto fail;
     }
 
     if (drive_get(type, bus_id, unit_id) != NULL) {
-        error_report("drive with bus=%d, unit=%d (index=%d) exists",
-                     bus_id, unit_id, index);
+        error_setg(errp, "drive with bus=%d, unit=%d (index=%d) exists",
+                   bus_id, unit_id, index);
         goto fail;
     }
 
@@ -970,7 +971,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     if (werror != NULL) {
         if (type != IF_IDE && type != IF_SCSI && type != IF_VIRTIO &&
             type != IF_NONE) {
-            error_report("werror is not supported by this bus type");
+            error_setg(errp, "werror is not supported by this bus type");
             goto fail;
         }
         qdict_put_str(bs_opts, "werror", werror);
@@ -980,7 +981,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     if (rerror != NULL) {
         if (type != IF_IDE && type != IF_VIRTIO && type != IF_SCSI &&
             type != IF_NONE) {
-            error_report("rerror is not supported by this bus type");
+            error_setg(errp, "rerror is not supported by this bus type");
             goto fail;
         }
         qdict_put_str(bs_opts, "rerror", rerror);
@@ -991,7 +992,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     bs_opts = NULL;
     if (!blk) {
         if (local_err) {
-            error_report_err(local_err);
+            error_propagate(errp, local_err);
         }
         goto fail;
     } else {
diff --git a/device-hotplug.c b/device-hotplug.c
index cd427e2c76..6090d5f1e9 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -28,6 +28,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "sysemu/sysemu.h"
@@ -36,6 +37,7 @@
 
 static DriveInfo *add_init_drive(const char *optstr)
 {
+    Error *err = NULL;
     DriveInfo *dinfo;
     QemuOpts *opts;
     MachineClass *mc;
@@ -45,8 +47,9 @@ static DriveInfo *add_init_drive(const char *optstr)
         return NULL;
 
     mc = MACHINE_GET_CLASS(current_machine);
-    dinfo = drive_new(opts, mc->block_default_type);
+    dinfo = drive_new(opts, mc->block_default_type, &err);
     if (!dinfo) {
+        error_report_err(err);
         qemu_opts_del(opts);
         return NULL;
     }
diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
index 24954b94e0..d34c4920dc 100644
--- a/include/sysemu/blockdev.h
+++ b/include/sysemu/blockdev.h
@@ -54,7 +54,8 @@ DriveInfo *drive_get_next(BlockInterfaceType type);
 QemuOpts *drive_def(const char *optstr);
 QemuOpts *drive_add(BlockInterfaceType type, int index, const char *file,
                     const char *optstr);
-DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_type);
+DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_type,
+                     Error **errp);
 
 /* device-hotplug */
 
diff --git a/vl.c b/vl.c
index 0d25956b2f..101e0123d9 100644
--- a/vl.c
+++ b/vl.c
@@ -1129,7 +1129,7 @@ static int drive_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     BlockInterfaceType *block_default_type = opaque;
 
-    return drive_new(opts, *block_default_type) == NULL;
+    return drive_new(opts, *block_default_type, errp) == NULL;
 }
 
 static int drive_enable_snapshot(void *opaque, QemuOpts *opts, Error **errp)
@@ -1155,8 +1155,7 @@ static void default_drive(int enable, int snapshot, BlockInterfaceType type,
         drive_enable_snapshot(NULL, opts, NULL);
     }
 
-    dinfo = drive_new(opts, type);
-    assert(dinfo);
+    dinfo = drive_new(opts, type, &error_abort);
     dinfo->is_default = true;
 
 }
@@ -4348,10 +4347,8 @@ int main(int argc, char **argv, char **envp)
         qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
                           NULL, NULL);
     }
-    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
-                          &machine_class->block_default_type, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
+                      &machine_class->block_default_type, &error_fatal);
 
     default_drive(default_cdrom, snapshot, machine_class->block_default_type, 2,
                   CDROM_OPTS);
-- 
2.17.1
