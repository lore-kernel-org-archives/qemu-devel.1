Received: from eggs.gnu.org ([2001:4830:134:3::10]:50305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxt2S-0007GX-AE
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxt2P-0001QS-FP
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:01:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dxt2P-0001Pz-6F
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:00:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16F924E4D1
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 11:00:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 29 Sep 2017 13:00:50 +0200
Message-Id: <20170929110052.6111-2-kraxel@redhat.com>
In-Reply-To: <20170929110052.6111-1-kraxel@redhat.com>
References: <20170929110052.6111-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] hw/usb/bus: Remove bad object_unparent()
 from usb_try_create_simple()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <qemu-devel.nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Valgrind detects an invalid read operation when hot-plugging of an
USB device fails:

$ valgrind x86_64-softmmu/qemu-system-x86_64 -device usb-ehci -nographic -S
==30598== Memcheck, a memory error detector
==30598== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
==30598== Using Valgrind-3.12.0 and LibVEX; rerun with -h for copyright info
==30598== Command: x86_64-softmmu/qemu-system-x86_64 -device usb-ehci -nographic -S
==30598==
QEMU 2.10.50 monitor - type 'help' for more information
(qemu) device_add usb-tablet
(qemu) device_add usb-tablet
(qemu) device_add usb-tablet
(qemu) device_add usb-tablet
(qemu) device_add usb-tablet
(qemu) device_add usb-tablet
==30598== Invalid read of size 8
==30598==    at 0x60EF50: object_unparent (object.c:445)
==30598==    by 0x580F0D: usb_try_create_simple (bus.c:346)
==30598==    by 0x581BEB: usb_claim_port (bus.c:451)
==30598==    by 0x582310: usb_qdev_realize (bus.c:257)
==30598==    by 0x4CB399: device_set_realized (qdev.c:914)
==30598==    by 0x60E26D: property_set_bool (object.c:1886)
==30598==    by 0x61235E: object_property_set_qobject (qom-qobject.c:27)
==30598==    by 0x61000F: object_property_set_bool (object.c:1162)
==30598==    by 0x4567C3: qdev_device_add (qdev-monitor.c:630)
==30598==    by 0x456D52: qmp_device_add (qdev-monitor.c:807)
==30598==    by 0x470A99: hmp_device_add (hmp.c:1933)
==30598==    by 0x3679C3: handle_hmp_command (monitor.c:3123)

The object_unparent() here is not necessary anymore since commit
69382d8b3e8600b3 ("qdev: Fix object reference leak in case device.realize()
fails"), so let's remove it now.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1506526106-30971-1-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index d910f849e7..e56dc3348a 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -341,9 +341,7 @@ static USBDevice *usb_try_create_simple(USBBus *bus, const char *name,
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
-        error_prepend(errp, "Failed to initialize USB device '%s': ",
-                      name);
-        object_unparent(OBJECT(dev));
+        error_prepend(errp, "Failed to initialize USB device '%s': ", name);
         return NULL;
     }
     return dev;
-- 
2.9.3
