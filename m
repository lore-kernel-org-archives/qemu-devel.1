Received: from eggs.gnu.org ([2001:4830:134:3::10]:57001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTMQ-0006MO-U9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTME-0000N6-Kc
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCTME-0000Li-5a
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 565534E90B
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 19:41:53 +0200
Message-Id: <20181016174158.15229-34-armbru@redhat.com>
In-Reply-To: <20181016174158.15229-1-armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 33/38] blockdev: Convert drive_new() to Error
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

Calling error_report() from within a function that takes an Error **
argument is suspicious.  drive_new() calls error_report() even though
it can run within drive_init_func(), which takes an Error ** argument.
drive_init_func()'s caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway:

* Convert drive_new() to Error

* Update add_init_drive() to report the error received from
  drive_new()

* Make main() pass &error_fatal through qemu_opts_foreach(),
  drive_init_func() to drive_new()

* Make default_drive() pass &error_abort through qemu_opts_foreach(),
  drive_init_func() to drive_new()

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 blockdev.c                | 27 ++++++++++++++-------------
 device-hotplug.c          |  5 ++++-
 include/sysemu/blockdev.h |  3 ++-
 vl.c                      |  8 ++++----
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a8755bd908..574adbcb7f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -759,7 +759,8 @@ QemuOptsList qemu_legacy_drive_opts =3D {
     },
 };
=20
-DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_defaul=
t_type)
+DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_defaul=
t_type,
+                     Error **errp)
 {
     const char *value;
     BlockBackend *blk;
@@ -808,7 +809,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfa=
ceType block_default_type)
         qemu_opt_rename(all_opts, opt_renames[i].from, opt_renames[i].to=
,
                         &local_err);
         if (local_err) {
-            error_report_err(local_err);
+            error_propagate(errp, local_err);
             return NULL;
         }
     }
@@ -819,7 +820,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfa=
ceType block_default_type)
         bool writethrough;
=20
         if (bdrv_parse_cache_mode(value, &flags, &writethrough) !=3D 0) =
{
-            error_report("invalid cache option");
+            error_setg(errp, "invalid cache option");
             return NULL;
         }
=20
@@ -847,7 +848,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfa=
ceType block_default_type)
                                    &error_abort);
     qemu_opts_absorb_qdict(legacy_opts, bs_opts, &local_err);
     if (local_err) {
-        error_report_err(local_err);
+        error_propagate(errp, local_err);
         goto fail;
     }
=20
@@ -860,7 +861,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfa=
ceType block_default_type)
             media =3D MEDIA_CDROM;
             read_only =3D true;
         } else {
-            error_report("'%s' invalid media", value);
+            error_setg(errp, "'%s' invalid media", value);
             goto fail;
         }
     }
@@ -885,7 +886,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfa=
ceType block_default_type)
              type++) {
         }
         if (type =3D=3D IF_COUNT) {
-            error_report("unsupported bus type '%s'", value);
+            error_setg(errp, "unsupported bus type '%s'", value);
             goto fail;
         }
     } else {
@@ -902,7 +903,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfa=
ceType block_default_type)
=20
     if (index !=3D -1) {
         if (bus_id !=3D 0 || unit_id !=3D -1) {
-            error_report("index cannot be used with bus and unit");
+            error_setg(errp, "index cannot be used with bus and unit");
             goto fail;
         }
         bus_id =3D drive_index_to_bus_id(type, index);
@@ -921,13 +922,13 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInter=
faceType block_default_type)
     }
=20
     if (max_devs && unit_id >=3D max_devs) {
-        error_report("unit %d too big (max is %d)", unit_id, max_devs - =
1);
+        error_setg(errp, "unit %d too big (max is %d)", unit_id, max_dev=
s - 1);
         goto fail;
     }
=20
     if (drive_get(type, bus_id, unit_id) !=3D NULL) {
-        error_report("drive with bus=3D%d, unit=3D%d (index=3D%d) exists=
",
-                     bus_id, unit_id, index);
+        error_setg(errp, "drive with bus=3D%d, unit=3D%d (index=3D%d) ex=
ists",
+                   bus_id, unit_id, index);
         goto fail;
     }
=20
@@ -970,7 +971,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfa=
ceType block_default_type)
     if (werror !=3D NULL) {
         if (type !=3D IF_IDE && type !=3D IF_SCSI && type !=3D IF_VIRTIO=
 &&
             type !=3D IF_NONE) {
-            error_report("werror is not supported by this bus type");
+            error_setg(errp, "werror is not supported by this bus type")=
;
             goto fail;
         }
         qdict_put_str(bs_opts, "werror", werror);
@@ -980,7 +981,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfa=
ceType block_default_type)
     if (rerror !=3D NULL) {
         if (type !=3D IF_IDE && type !=3D IF_VIRTIO && type !=3D IF_SCSI=
 &&
             type !=3D IF_NONE) {
-            error_report("rerror is not supported by this bus type");
+            error_setg(errp, "rerror is not supported by this bus type")=
;
             goto fail;
         }
         qdict_put_str(bs_opts, "rerror", rerror);
@@ -991,7 +992,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfa=
ceType block_default_type)
     bs_opts =3D NULL;
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
=20
 static DriveInfo *add_init_drive(const char *optstr)
 {
+    Error *err =3D NULL;
     DriveInfo *dinfo;
     QemuOpts *opts;
     MachineClass *mc;
@@ -45,8 +47,9 @@ static DriveInfo *add_init_drive(const char *optstr)
         return NULL;
=20
     mc =3D MACHINE_GET_CLASS(current_machine);
-    dinfo =3D drive_new(opts, mc->block_default_type);
+    dinfo =3D drive_new(opts, mc->block_default_type, &err);
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
 QemuOpts *drive_add(BlockInterfaceType type, int index, const char *file=
,
                     const char *optstr);
-DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_typ=
e);
+DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_typ=
e,
+                     Error **errp);
=20
 /* device-hotplug */
=20
diff --git a/vl.c b/vl.c
index 65366b961e..22beca29d1 100644
--- a/vl.c
+++ b/vl.c
@@ -1129,7 +1129,7 @@ static int drive_init_func(void *opaque, QemuOpts *=
opts, Error **errp)
 {
     BlockInterfaceType *block_default_type =3D opaque;
=20
-    return drive_new(opts, *block_default_type) =3D=3D NULL;
+    return drive_new(opts, *block_default_type, errp) =3D=3D NULL;
 }
=20
 static int drive_enable_snapshot(void *opaque, QemuOpts *opts, Error **e=
rrp)
@@ -1155,8 +1155,7 @@ static void default_drive(int enable, int snapshot,=
 BlockInterfaceType type,
         drive_enable_snapshot(NULL, opts, NULL);
     }
=20
-    dinfo =3D drive_new(opts, type);
-    assert(dinfo);
+    dinfo =3D drive_new(opts, type, &error_abort);
     dinfo->is_default =3D true;
=20
 }
@@ -4396,7 +4395,8 @@ int main(int argc, char **argv, char **envp)
                           NULL, NULL);
     }
     if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
-                          &machine_class->block_default_type, NULL)) {
+                          &machine_class->block_default_type, &error_fat=
al)) {
+        /* We printed help */
         exit(1);
     }
=20
--=20
2.17.1
