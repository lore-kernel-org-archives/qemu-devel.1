Received: from eggs.gnu.org ([2001:4830:134:3::10]:43350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBux-0000kS-Tw
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuv-00087k-Ls
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:51 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:25 +0100
Message-Id: <1487689130-30373-30-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 29/54] hw/block: Request permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This makes all device emulations with a qdev drive property request
permissions on their BlockBackend. The only thing we block at this point
is resizing images for some devices that can't support it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/block.c                 | 22 +++++++++++++++++++++-
 hw/block/fdc.c                   | 25 +++++++++++++++++++++++--
 hw/block/m25p80.c                |  8 ++++++++
 hw/block/nand.c                  |  7 +++++++
 hw/block/nvme.c                  |  8 +++++++-
 hw/block/onenand.c               |  7 +++++++
 hw/block/pflash_cfi01.c          | 18 ++++++++++++------
 hw/block/pflash_cfi02.c          | 19 +++++++++++++------
 hw/block/virtio-blk.c            |  8 +++++++-
 hw/core/qdev-properties-system.c |  1 -
 hw/ide/qdev.c                    |  7 +++++--
 hw/nvram/spapr_nvram.c           |  8 ++++++++
 hw/scsi/scsi-disk.c              |  9 +++++++--
 hw/sd/sd.c                       |  6 ++++++
 hw/usb/dev-storage.c             |  6 +++++-
 include/hw/block/block.h         |  3 ++-
 tests/qemu-iotests/051.pc.out    |  6 +++---
 17 files changed, 141 insertions(+), 27 deletions(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index 8dc9d84..7059ba1 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -51,11 +51,31 @@ void blkconf_blocksizes(BlockConf *conf)
     }
 }
 
-void blkconf_apply_backend_options(BlockConf *conf)
+void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
+                                   bool resizable, Error **errp)
 {
     BlockBackend *blk = conf->blk;
     BlockdevOnError rerror, werror;
+    uint64_t perm, shared_perm;
     bool wce;
+    int ret;
+
+    perm = BLK_PERM_CONSISTENT_READ;
+    if (!readonly) {
+        perm |= BLK_PERM_WRITE;
+    }
+
+    /* TODO Remove BLK_PERM_WRITE unless explicitly configured so */
+    shared_perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                  BLK_PERM_GRAPH_MOD | BLK_PERM_WRITE;
+    if (resizable) {
+        shared_perm |= BLK_PERM_RESIZE;
+    }
+
+    ret = blk_set_perm(blk, perm, shared_perm, errp);
+    if (ret < 0) {
+        return;
+    }
 
     switch (conf->wce) {
     case ON_OFF_AUTO_ON:    wce = true; break;
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 5f6c496..a328693 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -186,6 +186,7 @@ typedef enum FDiskFlags {
 struct FDrive {
     FDCtrl *fdctrl;
     BlockBackend *blk;
+    BlockConf *conf;
     /* Drive status */
     FloppyDriveType drive;    /* CMOS drive type        */
     uint8_t perpendicular;    /* 2.88 MB access mode    */
@@ -472,6 +473,19 @@ static void fd_revalidate(FDrive *drv)
 static void fd_change_cb(void *opaque, bool load, Error **errp)
 {
     FDrive *drive = opaque;
+    Error *local_err = NULL;
+
+    if (!load) {
+        blk_set_perm(drive->blk, 0, BLK_PERM_ALL, &error_abort);
+    } else {
+        blkconf_apply_backend_options(drive->conf,
+                                      blk_is_read_only(drive->blk), false,
+                                      &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
 
     drive->media_changed = 1;
     drive->media_validated = false;
@@ -508,6 +522,7 @@ static int floppy_drive_init(DeviceState *qdev)
     FloppyDrive *dev = FLOPPY_DRIVE(qdev);
     FloppyBus *bus = FLOPPY_BUS(qdev->parent_bus);
     FDrive *drive;
+    Error *local_err = NULL;
     int ret;
 
     if (dev->unit == -1) {
@@ -533,7 +548,6 @@ static int floppy_drive_init(DeviceState *qdev)
 
     if (!dev->conf.blk) {
         /* Anonymous BlockBackend for an empty drive */
-        /* FIXME Use real permissions */
         dev->conf.blk = blk_new(0, BLK_PERM_ALL);
         ret = blk_attach_dev(dev->conf.blk, qdev);
         assert(ret == 0);
@@ -552,7 +566,13 @@ static int floppy_drive_init(DeviceState *qdev)
      * blkconf_apply_backend_options(). */
     dev->conf.rerror = BLOCKDEV_ON_ERROR_AUTO;
     dev->conf.werror = BLOCKDEV_ON_ERROR_AUTO;
-    blkconf_apply_backend_options(&dev->conf);
+
+    blkconf_apply_backend_options(&dev->conf, blk_is_read_only(dev->conf.blk),
+                                  false, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -1;
+    }
 
     /* 'enospc' is the default for -drive, 'report' is what blk_new() gives us
      * for empty drives. */
@@ -566,6 +586,7 @@ static int floppy_drive_init(DeviceState *qdev)
         return -1;
     }
 
+    drive->conf = &dev->conf;
     drive->blk = dev->conf.blk;
     drive->fdctrl = bus->fdc;
 
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 2d6eb46..190573c 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1215,6 +1215,7 @@ static void m25p80_realize(SSISlave *ss, Error **errp)
 {
     Flash *s = M25P80(ss);
     M25P80Class *mc = M25P80_GET_CLASS(s);
+    int ret;
 
     s->pi = mc->pi;
 
@@ -1222,6 +1223,13 @@ static void m25p80_realize(SSISlave *ss, Error **errp)
     s->dirty_page = -1;
 
     if (s->blk) {
+        uint64_t perm = BLK_PERM_CONSISTENT_READ |
+                        (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE);
+        ret = blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
+        if (ret < 0) {
+            return;
+        }
+
         DB_PRINT_L(0, "Binding to IF_MTD drive\n");
         s->storage = blk_blockalign(s->blk, s->size);
 
diff --git a/hw/block/nand.c b/hw/block/nand.c
index c69e675..0d33ac2 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -373,6 +373,8 @@ static void nand_realize(DeviceState *dev, Error **errp)
 {
     int pagesize;
     NANDFlashState *s = NAND(dev);
+    int ret;
+
 
     s->buswidth = nand_flash_ids[s->chip_id].width >> 3;
     s->size = nand_flash_ids[s->chip_id].size << 20;
@@ -407,6 +409,11 @@ static void nand_realize(DeviceState *dev, Error **errp)
             error_setg(errp, "Can't use a read-only drive");
             return;
         }
+        ret = blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
+                           BLK_PERM_ALL, errp);
+        if (ret < 0) {
+            return;
+        }
         if (blk_getlength(s->blk) >=
                 (s->pages << s->page_shift) + (s->pages << s->oob_shift)) {
             pagesize = 0;
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ae91a18..ae303d4 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -835,6 +835,7 @@ static int nvme_init(PCIDevice *pci_dev)
     int i;
     int64_t bs_size;
     uint8_t *pci_conf;
+    Error *local_err = NULL;
 
     if (!n->conf.blk) {
         return -1;
@@ -850,7 +851,12 @@ static int nvme_init(PCIDevice *pci_dev)
         return -1;
     }
     blkconf_blocksizes(&n->conf);
-    blkconf_apply_backend_options(&n->conf);
+    blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
+                                  false, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -1;
+    }
 
     pci_conf = pci_dev->config;
     pci_conf[PCI_INTERRUPT_PIN] = 1;
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 8d84227..ddf5492 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -778,6 +778,7 @@ static int onenand_initfn(SysBusDevice *sbd)
     OneNANDState *s = ONE_NAND(dev);
     uint32_t size = 1 << (24 + ((s->id.dev >> 4) & 7));
     void *ram;
+    Error *local_err = NULL;
 
     s->base = (hwaddr)-1;
     s->rdy = NULL;
@@ -796,6 +797,12 @@ static int onenand_initfn(SysBusDevice *sbd)
             error_report("Can't use a read-only drive");
             return -1;
         }
+        blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
+                     BLK_PERM_ALL, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -1;
+        }
         s->blk_cur = s->blk;
     }
     s->otp = memset(g_malloc((64 + 2) << PAGE_SHIFT),
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 71b98a3..594d4cf 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -758,6 +758,18 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
 
     if (pfl->blk) {
+        uint64_t perm;
+        pfl->ro = blk_is_read_only(pfl->blk);
+        perm = BLK_PERM_CONSISTENT_READ | (pfl->ro ? 0 : BLK_PERM_WRITE);
+        ret = blk_set_perm(pfl->blk, perm, BLK_PERM_ALL, errp);
+        if (ret < 0) {
+            return;
+        }
+    } else {
+        pfl->ro = 0;
+    }
+
+    if (pfl->blk) {
         /* read the initial flash content */
         ret = blk_pread(pfl->blk, 0, pfl->storage, total_len);
 
@@ -768,12 +780,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    if (pfl->blk) {
-        pfl->ro = blk_is_read_only(pfl->blk);
-    } else {
-        pfl->ro = 0;
-    }
-
     /* Default to devices being used at their maximum device width. This was
      * assumed before the device_width support was added.
      */
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index ef71322..e6c5c6c 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -632,6 +632,19 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     vmstate_register_ram(&pfl->orig_mem, DEVICE(pfl));
     pfl->storage = memory_region_get_ram_ptr(&pfl->orig_mem);
     pfl->chip_len = chip_len;
+
+    if (pfl->blk) {
+        uint64_t perm;
+        pfl->ro = blk_is_read_only(pfl->blk);
+        perm = BLK_PERM_CONSISTENT_READ | (pfl->ro ? 0 : BLK_PERM_WRITE);
+        ret = blk_set_perm(pfl->blk, perm, BLK_PERM_ALL, errp);
+        if (ret < 0) {
+            return;
+        }
+    } else {
+        pfl->ro = 0;
+    }
+
     if (pfl->blk) {
         /* read the initial flash content */
         ret = blk_pread(pfl->blk, 0, pfl->storage, chip_len);
@@ -646,12 +659,6 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     pfl->rom_mode = 1;
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
 
-    if (pfl->blk) {
-        pfl->ro = blk_is_read_only(pfl->blk);
-    } else {
-        pfl->ro = 0;
-    }
-
     pfl->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);
     pfl->wcycle = 0;
     pfl->cmd = 0;
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 843bd2f..98c16a7 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -928,7 +928,13 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     }
 
     blkconf_serial(&conf->conf, &conf->serial);
-    blkconf_apply_backend_options(&conf->conf);
+    blkconf_apply_backend_options(&conf->conf,
+                                  blk_is_read_only(conf->conf.blk), true,
+                                  &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     s->original_wce = blk_enable_write_cache(conf->conf.blk);
     blkconf_geometry(&conf->conf, NULL, 65535, 255, 255, &err);
     if (err) {
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 66ba367..c34be1c 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -79,7 +79,6 @@ static void parse_drive(DeviceState *dev, const char *str, void **ptr,
     if (!blk) {
         BlockDriverState *bs = bdrv_lookup_bs(NULL, str, NULL);
         if (bs) {
-            /* FIXME Use real permissions */
             blk = blk_new(0, BLK_PERM_ALL);
             blk_created = true;
 
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index bb3c377..b588d62 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -170,7 +170,6 @@ static int ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind)
             return -1;
         } else {
             /* Anonymous BlockBackend for an empty drive */
-            /* FIXME Use real permissions */
             dev->conf.blk = blk_new(0, BLK_PERM_ALL);
         }
     }
@@ -197,7 +196,11 @@ static int ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind)
             return -1;
         }
     }
-    blkconf_apply_backend_options(&dev->conf);
+    blkconf_apply_backend_options(&dev->conf, kind == IDE_CD, true, &err);
+    if (err) {
+        error_report_err(err);
+        return -1;
+    }
 
     if (ide_init_drive(s, dev->conf.blk, kind,
                        dev->version, dev->serial, dev->model, dev->wwn,
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 65ba188..aa5d2c1 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -141,9 +141,17 @@ static void rtas_nvram_store(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 static void spapr_nvram_realize(VIOsPAPRDevice *dev, Error **errp)
 {
     sPAPRNVRAM *nvram = VIO_SPAPR_NVRAM(dev);
+    int ret;
 
     if (nvram->blk) {
         nvram->size = blk_getlength(nvram->blk);
+
+        ret = blk_set_perm(nvram->blk,
+                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
+                           BLK_PERM_ALL, errp);
+        if (ret < 0) {
+            return;
+        }
     } else {
         nvram->size = DEFAULT_NVRAM_SIZE;
     }
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index c1ccfad..2c3aaa0 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2328,7 +2328,13 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
             return;
         }
     }
-    blkconf_apply_backend_options(&dev->conf);
+    blkconf_apply_backend_options(&dev->conf,
+                                  blk_is_read_only(s->qdev.conf.blk), true,
+                                  &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
 
     if (s->qdev.conf.discard_granularity == -1) {
         s->qdev.conf.discard_granularity =
@@ -2380,7 +2386,6 @@ static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
 
     if (!dev->conf.blk) {
-        /* FIXME Use real permissions */
         dev->conf.blk = blk_new(0, BLK_PERM_ALL);
     }
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8e31491..ba47bff 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1887,6 +1887,7 @@ static void sd_instance_finalize(Object *obj)
 static void sd_realize(DeviceState *dev, Error **errp)
 {
     SDState *sd = SD_CARD(dev);
+    int ret;
 
     if (sd->blk && blk_is_read_only(sd->blk)) {
         error_setg(errp, "Cannot use read-only drive as SD card");
@@ -1894,6 +1895,11 @@ static void sd_realize(DeviceState *dev, Error **errp)
     }
 
     if (sd->blk) {
+        ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
+                           BLK_PERM_ALL, errp);
+        if (ret < 0) {
+            return;
+        }
         blk_set_dev_ops(sd->blk, &sd_block_ops, sd);
     }
 }
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index c607f76..a71b354 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -603,7 +603,11 @@ static void usb_msd_realize_storage(USBDevice *dev, Error **errp)
 
     blkconf_serial(&s->conf, &dev->serial);
     blkconf_blocksizes(&s->conf);
-    blkconf_apply_backend_options(&s->conf);
+    blkconf_apply_backend_options(&s->conf, blk_is_read_only(blk), true, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
 
     /*
      * Hack alert: this pretends to be a block device, but it's really
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index df9d207..5d462eb 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -73,7 +73,8 @@ void blkconf_geometry(BlockConf *conf, int *trans,
                       unsigned cyls_max, unsigned heads_max, unsigned secs_max,
                       Error **errp);
 void blkconf_blocksizes(BlockConf *conf);
-void blkconf_apply_backend_options(BlockConf *conf);
+void blkconf_apply_backend_options(BlockConf *conf, bool readonly,
+                                   bool resizable, Error **errp);
 
 /* Hard disk geometry */
 
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index f1669c1..eb4b3b5 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -176,7 +176,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Can't use a read-only drive
+(qemu) QEMU_PROG: Block node is read-only
 QEMU_PROG: Initialization of device ide-hd failed: Device initialization failed.
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=scsi,readonly=on
@@ -197,12 +197,12 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-drive,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-drive,drive=disk: Can't use a read-only drive
+(qemu) QEMU_PROG: -device ide-drive,drive=disk: Block node is read-only
 QEMU_PROG: -device ide-drive,drive=disk: Device initialization failed.
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-hd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-hd,drive=disk: Can't use a read-only drive
+(qemu) QEMU_PROG: -device ide-hd,drive=disk: Block node is read-only
 QEMU_PROG: -device ide-hd,drive=disk: Device initialization failed.
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device lsi53c895a -device scsi-disk,drive=disk
-- 
1.8.3.1
