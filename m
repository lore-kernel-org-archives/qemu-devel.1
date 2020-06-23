Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DAFC4345D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC53E20716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvgKGs6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC53E20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjvN-0001pM-VV
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpr-0001jA-6U
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpm-0007iq-3w
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592922213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0ukBk+vFB/2xy408CQsPZXSLpUEV8XGE6+TsdkpUHo=;
 b=VvgKGs6wMheW3ew9eFPlrUa6GY8cqQJFxELQMo9D770DS60GOn/BSis+lwpFzH6F+ez2tN
 2YSC7ucervjbNhPknBXjIEqJpj3IQM7BAUZlzEpaIjWyoOxQflwEhTDEZ57eBCLZkj71gY
 oZpJy23N2+SZ+4Gm7muTZcaueQkJZdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-FIp5vtHJO4aFHmLB8gzEkA-1; Tue, 23 Jun 2020 10:23:29 -0400
X-MC-Unique: FIp5vtHJO4aFHmLB8gzEkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A780800597
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 14:23:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE74A5C541
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 14:23:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 42BF21138472; Tue, 23 Jun 2020 16:23:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] fdc: Reject clash between -drive if=floppy and -global
 isa-fdc
Date: Tue, 23 Jun 2020 16:23:14 +0200
Message-Id: <20200623142326.2349416-5-armbru@redhat.com>
In-Reply-To: <20200623142326.2349416-1-armbru@redhat.com>
References: <20200623142326.2349416-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The floppy controller devices desugar their drive properties into
floppy devices (since commit a92bd191a4 "fdc: Move qdev properties to
FloppyDrive", v2.8.0).  This involves some bad magic in
fdctrl_connect_drives(), and exists for backward compatibility.

The functions for boards to create floppy controller devices
fdctrl_init_isa(), fdctrl_init_sysbus(), and sun4m_fdctrl_init()
desugar -drive if=floppy to these floppy controller drive properties.

If you use both -drive if=floppy (or its -fda / -fdb sugar) and
-global isa-fdc for the same floppy device, -global silently loses the
conflict, and both backends involved end up with the floppy device
frontend attached, as demonstrated by iotest 172 (see commit before
previous).  This is wrong.

Desugar -drive if=floppy straight to floppy devices instead, with
helper fdctrl_init_drives().  The conflict now gets rejected cleanly:
first, fdctrl_connect_drives() creates the floppy for the controller's
property, then fdctrl_init_drives() attempts to create the floppy for
-drive if=floppy, but fails because the unit is already in use.

Output of iotest 172 changes in three ways:

1. The clash gets rejected.

2. In one test case, "info qtree" has the floppy devices swapped, and
   "info block" has their QOM paths swapped.  This is because the
   floppy device for -fda now gets created after the one for -global
   isa-fdc.driveB.

3. The error message for -global floppy.drive=floppy0 changes.  Before
   the patch, we set isa-fdc.driveA to -fda's block backend, then
   create the floppy device for it, then move the backend from
   isa-fdc.driveA to floppy.drive.  Floppy creation fails when
   applying -global floppy.drive=floppy0, because floppy0 is still
   attached to isa-fdc.  After the patch, we create the floppy for
   -fda, then set its drive property to floppy0.  Now floppy creation
   succeeds, but setting the drive property fails, because -global
   already set it.  Yes, this is exasperatingly complicated.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200622094227.1271650-5-armbru@redhat.com>
---
 include/hw/block/fdc.h     |   1 +
 hw/block/fdc.c             |  51 ++++++------
 hw/isa/isa-superio.c       |  18 ++--
 hw/sparc64/sun4u.c         |   9 +-
 tests/qemu-iotests/172     |   3 +-
 tests/qemu-iotests/172.out | 164 ++++++++++---------------------------
 6 files changed, 79 insertions(+), 167 deletions(-)

diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index c15ff4c623..8855d3476c 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -9,6 +9,7 @@
 
 #define TYPE_ISA_FDC "isa-fdc"
 
+void isa_fdc_init_drives(ISADevice *fdc, DriveInfo **fds);
 ISADevice *fdctrl_init_isa(ISABus *bus, DriveInfo **fds);
 void fdctrl_init_sysbus(qemu_irq irq, int dma_chann,
                         hwaddr mmio_base, DriveInfo **fds);
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index be0674e4aa..2650dcb0df 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2497,6 +2497,29 @@ static void fdctrl_result_timer(void *opaque)
 }
 
 /* Init functions */
+
+static void fdctrl_init_drives(FloppyBus *bus, DriveInfo **fds)
+{
+    DeviceState *dev;
+    int i;
+
+    for (i = 0; i < MAX_FD; i++) {
+        if (fds[i]) {
+            dev = qdev_new("floppy");
+            qdev_prop_set_uint32(dev, "unit", i);
+            qdev_prop_set_enum(dev, "drive-type", FLOPPY_DRIVE_TYPE_AUTO);
+            qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(fds[i]),
+                                &error_fatal);
+            qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
+        }
+    }
+}
+
+void isa_fdc_init_drives(ISADevice *fdc, DriveInfo **fds)
+{
+    fdctrl_init_drives(&ISA_FDC(fdc)->state.bus, fds);
+}
+
 static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
                                   Error **errp)
 {
@@ -2544,25 +2567,15 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
 
 ISADevice *fdctrl_init_isa(ISABus *bus, DriveInfo **fds)
 {
-    DeviceState *dev;
     ISADevice *isadev;
 
     isadev = isa_try_new(TYPE_ISA_FDC);
     if (!isadev) {
         return NULL;
     }
-    dev = DEVICE(isadev);
-
-    if (fds[0]) {
-        qdev_prop_set_drive(dev, "driveA", blk_by_legacy_dinfo(fds[0]),
-                            &error_fatal);
-    }
-    if (fds[1]) {
-        qdev_prop_set_drive(dev, "driveB", blk_by_legacy_dinfo(fds[1]),
-                            &error_fatal);
-    }
     isa_realize_and_unref(isadev, bus, &error_fatal);
 
+    isa_fdc_init_drives(isadev, fds);
     return isadev;
 }
 
@@ -2578,18 +2591,12 @@ void fdctrl_init_sysbus(qemu_irq irq, int dma_chann,
     sys = SYSBUS_FDC(dev);
     fdctrl = &sys->state;
     fdctrl->dma_chann = dma_chann; /* FIXME */
-    if (fds[0]) {
-        qdev_prop_set_drive(dev, "driveA", blk_by_legacy_dinfo(fds[0]),
-                            &error_fatal);
-    }
-    if (fds[1]) {
-        qdev_prop_set_drive(dev, "driveB", blk_by_legacy_dinfo(fds[1]),
-                            &error_fatal);
-    }
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sbd, &error_fatal);
     sysbus_connect_irq(sbd, 0, irq);
     sysbus_mmio_map(sbd, 0, mmio_base);
+
+    fdctrl_init_drives(&sys->state.bus, fds);
 }
 
 void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
@@ -2599,15 +2606,13 @@ void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
     FDCtrlSysBus *sys;
 
     dev = qdev_new("SUNW,fdtwo");
-    if (fds[0]) {
-        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(fds[0]),
-                            &error_fatal);
-    }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sys = SYSBUS_FDC(dev);
     sysbus_connect_irq(SYS_BUS_DEVICE(sys), 0, irq);
     sysbus_mmio_map(SYS_BUS_DEVICE(sys), 0, io_base);
     *fdc_tc = qdev_get_gpio_in(dev, 0);
+
+    fdctrl_init_drives(&sys->state.bus, fds);
 }
 
 static void fdctrl_realize_common(DeviceState *dev, FDCtrl *fdctrl,
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index d3d58f9f16..e2e47d8fd9 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -17,6 +17,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/blockdev.h"
 #include "chardev/char.h"
+#include "hw/block/fdc.h"
 #include "hw/isa/superio.h"
 #include "hw/qdev-properties.h"
 #include "hw/input/i8042.h"
@@ -31,7 +32,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
     ISADevice *isa;
     DeviceState *d;
     Chardev *chr;
-    DriveInfo *drive;
+    DriveInfo *fd[MAX_FD];
     char *name;
     int i;
 
@@ -115,7 +116,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
 
     /* Floppy disc */
     if (!k->floppy.is_enabled || k->floppy.is_enabled(sio, 0)) {
-        isa = isa_new("isa-fdc");
+        isa = isa_new(TYPE_ISA_FDC);
         d = DEVICE(isa);
         if (k->floppy.get_iobase) {
             qdev_prop_set_uint32(d, "iobase", k->floppy.get_iobase(sio, 0));
@@ -124,19 +125,12 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_uint32(d, "irq", k->floppy.get_irq(sio, 0));
         }
         /* FIXME use a qdev drive property instead of drive_get() */
-        drive = drive_get(IF_FLOPPY, 0, 0);
-        if (drive != NULL) {
-            qdev_prop_set_drive(d, "driveA", blk_by_legacy_dinfo(drive),
-                                &error_fatal);
-        }
-        /* FIXME use a qdev drive property instead of drive_get() */
-        drive = drive_get(IF_FLOPPY, 0, 1);
-        if (drive != NULL) {
-            qdev_prop_set_drive(d, "driveB", blk_by_legacy_dinfo(drive),
-                                &error_fatal);
+        for (i = 0; i < MAX_FD; i++) {
+            fd[i] = drive_get(IF_FLOPPY, 0, i);
         }
         object_property_add_child(OBJECT(sio), "isa-fdc", OBJECT(isa));
         isa_realize_and_unref(isa, bus, &error_fatal);
+        isa_fdc_init_drives(isa, fd);
         sio->floppy = isa;
         trace_superio_create_floppy(0,
                                     k->floppy.get_iobase ?
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 97e6d3a025..9c8655cffc 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -341,16 +341,9 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     }
     isa_dev = isa_new(TYPE_ISA_FDC);
     dev = DEVICE(isa_dev);
-    if (fd[0]) {
-        qdev_prop_set_drive(dev, "driveA", blk_by_legacy_dinfo(fd[0]),
-                            &error_abort);
-    }
-    if (fd[1]) {
-        qdev_prop_set_drive(dev, "driveB", blk_by_legacy_dinfo(fd[1]),
-                            &error_abort);
-    }
     qdev_prop_set_uint32(dev, "dma", -1);
     isa_realize_and_unref(isa_dev, s->isa_bus, &error_fatal);
+    isa_fdc_init_drives(isa_dev, fd);
 
     /* Power */
     dev = qdev_new(TYPE_SUN4U_POWER);
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 18056bcef7..3abfa72948 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -148,9 +148,10 @@ echo === Mixing -fdX and -global ===
 check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -global isa-fdc.driveB=none0
 check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -global isa-fdc.driveA=none0
 
-# Conflicting (-fdX wins)
+# Conflicting
 check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -global isa-fdc.driveA=none0
 check_floppy_qtree -fdb "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -global isa-fdc.driveB=none0
+# Conflicting, -fdX wins
 check_floppy_qtree -fda "$TEST_IMG" -drive if=none,file="$TEST_IMG.2" -global floppy.drive=none0
 
 echo
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 68e7a5ea5f..340dbd39cb 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -205,22 +205,22 @@ Testing: -fdb
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -675,17 +675,6 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
             isa irq 6
             bus: floppy-bus.0
               type floppy-bus
-              dev: floppy, id ""
-                unit = 1 (0x1)
-                drive = "none0"
-                logical_block_size = 512 (512 B)
-                physical_block_size = 512 (512 B)
-                min_io_size = 0 (0 B)
-                opt_io_size = 0 (0 B)
-                discard_granularity = 4294967295 (4 GiB)
-                write-cache = "auto"
-                share-rw = false
-                drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
@@ -697,13 +686,24 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
+              dev: floppy, id ""
+                unit = 1 (0x1)
+                drive = "none0"
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
+                write-cache = "auto"
+                share-rw = false
+                drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[15]
+    Attached to:      /machine/unattached/device[16]
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
 none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/unattached/device[16]
+    Attached to:      /machine/unattached/device[15]
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
@@ -773,92 +773,10 @@ sd0: [not inserted]
 
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0
-
-          dev: isa-fdc, id ""
-            iobase = 1008 (0x3f0)
-            irq = 6 (0x6)
-            dma = 2 (0x2)
-            driveA = ""
-            driveB = ""
-            check_media_rate = true
-            fdtypeA = "auto"
-            fdtypeB = "auto"
-            fallback = "288"
-            isa irq 6
-            bus: floppy-bus.0
-              type floppy-bus
-              dev: floppy, id ""
-                unit = 0 (0x0)
-                drive = "floppy0"
-                logical_block_size = 512 (512 B)
-                physical_block_size = 512 (512 B)
-                min_io_size = 0 (0 B)
-                opt_io_size = 0 (0 B)
-                discard_granularity = 4294967295 (4 GiB)
-                write-cache = "auto"
-                share-rw = false
-                drive-type = "144"
-floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[15]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/unattached/device[14]
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[22]
-    Removable device: not locked, tray closed
-
-sd0: [not inserted]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+QEMU_PROG: Floppy unit 0 is in use
 
 Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0
-
-          dev: isa-fdc, id ""
-            iobase = 1008 (0x3f0)
-            irq = 6 (0x6)
-            dma = 2 (0x2)
-            driveA = ""
-            driveB = ""
-            check_media_rate = true
-            fdtypeA = "auto"
-            fdtypeB = "auto"
-            fallback = "288"
-            isa irq 6
-            bus: floppy-bus.0
-              type floppy-bus
-              dev: floppy, id ""
-                unit = 1 (0x1)
-                drive = "floppy1"
-                logical_block_size = 512 (512 B)
-                physical_block_size = 512 (512 B)
-                min_io_size = 0 (0 B)
-                opt_io_size = 0 (0 B)
-                discard_granularity = 4294967295 (4 GiB)
-                write-cache = "auto"
-                share-rw = false
-                drive-type = "144"
-floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[15]
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-
-none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/unattached/device[14]
-    Cache mode:       writeback
-
-ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[22]
-    Removable device: not locked, tray closed
-
-sd0: [not inserted]
-    Removable device: not locked, tray closed
-(qemu) quit
-
+QEMU_PROG: Floppy unit 1 is in use
 
 Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global floppy.drive=none0
 
@@ -878,11 +796,11 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global fl
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -1500,11 +1418,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global floppy.drive=none0 -device
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -1546,11 +1464,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -1585,7 +1503,7 @@ Testing: -fda  -device floppy,drive=floppy0
 QEMU_PROG: -device floppy,drive=floppy0: Drive 'floppy0' is already in use because it has been automatically connected to another device (did you need 'if=none' in the drive options?)
 
 Testing: -fda  -global floppy.drive=floppy0
-QEMU_PROG: can't apply global floppy.drive=floppy0: Drive 'floppy0' is already in use because it has been automatically connected to another device (did you need 'if=none' in the drive options?)
+QEMU_PROG: Drive 'floppy0' is already in use because it has been automatically connected to another device (did you need 'if=none' in the drive options?)
 
 Testing: -device floppy,drive=floppy0
 QEMU_PROG: -device floppy,drive=floppy0: Property 'floppy.drive' can't find value 'floppy0'
-- 
2.26.2


