Received: from eggs.gnu.org ([2001:4830:134:3::10]:44212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8it-0005TZ-AX
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8in-00084G-Fw
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40798
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8in-00083f-8K
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:01 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEOr0020504
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:00 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyf6usgbb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:59 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:58 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:54 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-34-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 33/54] usb-storage: Fix share-rw option parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Fam Zheng <famz@redhat.com>

Because usb-storage creates an internal scsi device, we should propagate
options. We already do so for bootindex etc, but failed to take care of
share-rw. Fix it in an apparent way: add a new parameter to
scsi_bus_legacy_add_drive and pass in s->conf.share_rw.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Message-id: 20180117005222.4781-1-famz@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 395b95395934785ca86baafd314d0c31b307d16d)
 Conflicts:
	hw/usb/dev-storage.c
* dropped context dep on ceff3e1f01e
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/scsi-bus.c     | 9 ++++++++-
 hw/usb/dev-storage.c   | 3 ++-
 include/hw/scsi/scsi.h | 1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 977f7bce1f..73ca842327 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -224,6 +224,7 @@ static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
 /* handle legacy '-drive if=scsi,...' cmd line args */
 SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
                                       int unit, bool removable, int bootindex,
+                                      bool share_rw,
                                       const char *serial, Error **errp)
 {
     const char *driver;
@@ -254,6 +255,12 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
         object_unparent(OBJECT(dev));
         return NULL;
     }
+    object_property_set_bool(OBJECT(dev), share_rw, "share-rw", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        object_unparent(OBJECT(dev));
+        return NULL;
+    }
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -288,7 +295,7 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, bool deprecated)
             }
         }
         scsi_bus_legacy_add_drive(bus, blk_by_legacy_dinfo(dinfo),
-                                  unit, false, -1, NULL, &error_fatal);
+                                  unit, false, -1, false, NULL, &error_fatal);
     }
     loc_pop(&loc);
 }
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 8a61ec94c8..ff18ad5324 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -635,7 +635,8 @@ static void usb_msd_realize_storage(USBDevice *dev, Error **errp)
     scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
                  &usb_msd_scsi_info_storage, NULL);
     scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s->removable,
-                                         s->conf.bootindex, dev->serial,
+                                         s->conf.bootindex, s->conf.share_rw,
+                                         dev->serial,
                                          &err);
     blk_unref(blk);
     if (!scsi_dev) {
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 23a8ee6a7d..802a647cdc 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -151,6 +151,7 @@ static inline SCSIBus *scsi_bus_from_device(SCSIDevice *d)
 
 SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
                                       int unit, bool removable, int bootindex,
+                                      bool share_rw,
                                       const char *serial, Error **errp);
 void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, bool deprecated);
 void scsi_legacy_handle_cmdline(void);
-- 
2.11.0
