Received: from eggs.gnu.org ([2001:4830:134:3::10]:57195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbQRT-0004tF-OL
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbQRR-0005OE-Uz
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:06:31 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Jul 2018 15:06:18 +0200
Message-Id: <20180706130620.5647-3-cohuck@redhat.com>
In-Reply-To: <20180706130620.5647-1-cohuck@redhat.com>
References: <20180706130620.5647-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 2/4] Revert "block: Remove deprecated
 -drive option serial"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>

This reverts commit b0083267444a5e0f28391f6c2831a539f878d424.

Hold off removing this for one more QEMU release (current libvirt
release still uses it.)

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 block/block-backend.c     |  1 +
 blockdev.c                | 10 ++++++++++
 hw/block/block.c          | 13 +++++++++++++
 hw/block/nvme.c           |  1 +
 hw/block/virtio-blk.c     |  1 +
 hw/ide/qdev.c             |  1 +
 hw/scsi/scsi-disk.c       |  1 +
 hw/usb/dev-storage.c      |  1 +
 include/hw/block/block.h  |  1 +
 include/sysemu/blockdev.h |  1 +
 qemu-doc.texi             |  5 +++++
 qemu-options.hx           |  6 +++++-
 tests/ahci-test.c         |  6 +++---
 tests/ide-test.c          |  8 ++++----
 14 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 6b75bca317..f7155942ac 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -419,6 +419,7 @@ static void drive_info_del(DriveInfo *dinfo)
         return;
     }
     qemu_opts_del(dinfo->opts);
+    g_free(dinfo->serial);
     g_free(dinfo);
 }
 
diff --git a/blockdev.c b/blockdev.c
index 37eb40670b..6c530769fd 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -730,6 +730,10 @@ QemuOptsList qemu_legacy_drive_opts = {
             .name = "if",
             .type = QEMU_OPT_STRING,
             .help = "interface (ide, scsi, sd, mtd, floppy, pflash, virtio)",
+        },{
+            .name = "serial",
+            .type = QEMU_OPT_STRING,
+            .help = "disk serial number",
         },{
             .name = "file",
             .type = QEMU_OPT_STRING,
@@ -772,10 +776,12 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     const char *werror, *rerror;
     bool read_only = false;
     bool copy_on_read;
+    const char *serial;
     const char *filename;
     Error *local_err = NULL;
     int i;
     const char *deprecated[] = {
+        "serial"
     };
 
     /* Change legacy command line options into QMP ones */
@@ -943,6 +949,9 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         goto fail;
     }
 
+    /* Serial number */
+    serial = qemu_opt_get(legacy_opts, "serial");
+
     /* no id supplied -> create one */
     if (qemu_opts_id(all_opts) == NULL) {
         char *new_id;
@@ -1017,6 +1026,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     dinfo->type = type;
     dinfo->bus = bus_id;
     dinfo->unit = unit_id;
+    dinfo->serial = g_strdup(serial);
 
     blk_set_legacy_dinfo(blk, dinfo);
 
diff --git a/hw/block/block.c b/hw/block/block.c
index cf0eb826f1..b6c80ab0b7 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -15,6 +15,19 @@
 #include "qapi/qapi-types-block.h"
 #include "qemu/error-report.h"
 
+void blkconf_serial(BlockConf *conf, char **serial)
+{
+    DriveInfo *dinfo;
+
+    if (!*serial) {
+        /* try to fall back to value set with legacy -drive serial=... */
+        dinfo = blk_legacy_dinfo(conf->blk);
+        if (dinfo) {
+            *serial = g_strdup(dinfo->serial);
+        }
+    }
+}
+
 void blkconf_blocksizes(BlockConf *conf)
 {
     BlockBackend *blk = conf->blk;
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fc7dacb816..5e508ab1b3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1217,6 +1217,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
 
+    blkconf_serial(&n->conf, &n->serial);
     if (!n->serial) {
         error_setg(errp, "serial property not set");
         return;
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 225fe44b7a..50b5c869e3 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -935,6 +935,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    blkconf_serial(&conf->conf, &conf->serial);
     if (!blkconf_apply_backend_options(&conf->conf,
                                        blk_is_read_only(conf->conf.blk), true,
                                        errp)) {
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 573b022e1e..f395d24592 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -188,6 +188,7 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
         return;
     }
 
+    blkconf_serial(&dev->conf, &dev->serial);
     if (kind != IDE_CD) {
         if (!blkconf_geometry(&dev->conf, &dev->chs_trans, 65535, 16, 255,
                               errp)) {
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 32f3f96ff8..d7df357029 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2378,6 +2378,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
         return;
     }
 
+    blkconf_serial(&s->qdev.conf, &s->serial);
     blkconf_blocksizes(&s->qdev.conf);
 
     if (s->qdev.conf.logical_block_size >
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index cd5551d94f..45a9487cdb 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -599,6 +599,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
         return;
     }
 
+    blkconf_serial(&s->conf, &dev->serial);
     blkconf_blocksizes(&s->conf);
     if (!blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk), true,
                                        errp)) {
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index e9f9e2223f..d4f4dfffab 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -72,6 +72,7 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
 
 /* Configuration helpers */
 
+void blkconf_serial(BlockConf *conf, char **serial);
 bool blkconf_geometry(BlockConf *conf, int *trans,
                       unsigned cyls_max, unsigned heads_max, unsigned secs_max,
                       Error **errp);
diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
index 24954b94e0..c0ae3700ec 100644
--- a/include/sysemu/blockdev.h
+++ b/include/sysemu/blockdev.h
@@ -35,6 +35,7 @@ struct DriveInfo {
     bool is_default;            /* Added by default_drive() ?  */
     int media_cd;
     QemuOpts *opts;
+    char *serial;
     QTAILQ_ENTRY(DriveInfo) next;
 };
 
diff --git a/qemu-doc.texi b/qemu-doc.texi
index d3924e928e..d343affd6d 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2887,6 +2887,11 @@ with ``-device ...,netdev=x''), or ``-nic user,smb=/some/dir''
 (for embedded NICs). The new syntax allows different settings to be
 provided per NIC.
 
+@subsection -drive serial=... (since 2.10.0)
+
+The drive serial argument is replaced by the the serial argument
+that can be specified with the ``-device'' parameter.
+
 @subsection -usbdevice (since 2.10.0)
 
 The ``-usbdevice DEV'' argument is now a synonym for setting
diff --git a/qemu-options.hx b/qemu-options.hx
index 16208f63f2..381648b9cb 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -805,7 +805,7 @@ ETEXI
 DEF("drive", HAS_ARG, QEMU_OPTION_drive,
     "-drive [file=file][,if=type][,bus=n][,unit=m][,media=d][,index=i]\n"
     "       [,cache=writethrough|writeback|none|directsync|unsafe][,format=f]\n"
-    "       [,snapshot=on|off][,rerror=ignore|stop|report]\n"
+    "       [,snapshot=on|off][,serial=s][,rerror=ignore|stop|report]\n"
     "       [,werror=ignore|stop|report|enospc][,id=name][,aio=threads|native]\n"
     "       [,readonly=on|off][,copy-on-read=on|off]\n"
     "       [,discard=ignore|unmap][,detect-zeroes=on|off|unmap]\n"
@@ -879,6 +879,10 @@ The default mode is @option{cache=writeback}.
 Specify which disk @var{format} will be used rather than detecting
 the format.  Can be used to specify format=raw to avoid interpreting
 an untrusted format header.
+@item serial=@var{serial}
+This option specifies the serial number to assign to the device. This
+parameter is deprecated, use the corresponding parameter of @code{-device}
+instead.
 @item werror=@var{action},rerror=@var{action}
 Specify which @var{action} to take on write and read errors. Valid actions are:
 "ignore" (ignore the error and try to continue), "stop" (pause QEMU),
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 937ed2f910..1a7b761304 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -180,12 +180,12 @@ static AHCIQState *ahci_boot(const char *cli, ...)
         s = ahci_vboot(cli, ap);
         va_end(ap);
     } else {
-        cli = "-drive if=none,id=drive0,file=%s,cache=writeback,format=%s"
+        cli = "-drive if=none,id=drive0,file=%s,cache=writeback,serial=%s"
+            ",format=%s"
             " -M q35 "
             "-device ide-hd,drive=drive0 "
-            "-global ide-hd.serial=%s "
             "-global ide-hd.ver=%s";
-        s = ahci_boot(cli, tmp_path, imgfmt, "testdisk", "version");
+        s = ahci_boot(cli, tmp_path, "testdisk", imgfmt, "version");
     }
 
     return s;
diff --git a/tests/ide-test.c b/tests/ide-test.c
index f39431b1a9..2384c2c3e2 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -529,8 +529,8 @@ static void test_bmdma_no_busmaster(void)
 static void test_bmdma_setup(void)
 {
     ide_test_start(
-        "-drive file=%s,if=ide,cache=writeback,format=raw "
-        "-global ide-hd.serial=%s -global ide-hd.ver=%s",
+        "-drive file=%s,if=ide,serial=%s,cache=writeback,format=raw "
+        "-global ide-hd.ver=%s",
         tmp_path, "testdisk", "version");
     qtest_irq_intercept_in(global_qtest, "ioapic");
 }
@@ -561,8 +561,8 @@ static void test_identify(void)
     int ret;
 
     ide_test_start(
-        "-drive file=%s,if=ide,cache=writeback,format=raw "
-        "-global ide-hd.serial=%s -global ide-hd.ver=%s",
+        "-drive file=%s,if=ide,serial=%s,cache=writeback,format=raw "
+        "-global ide-hd.ver=%s",
         tmp_path, "testdisk", "version");
 
     dev = get_pci_device(&bmdma_bar, &ide_bar);
-- 
2.14.4
