Received: from eggs.gnu.org ([2001:4830:134:3::10]:49296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCO-0000cm-4K
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCK-0000Yw-U8
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49028
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCK-0000YM-Nf
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:36 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE8ib024327
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:36 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epm4y6tpb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:36 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:35 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:15:55 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-3-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 02/55] hw/usb/bus: Remove bad object_unparent()
 from usb_try_create_simple()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

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
(cherry picked from commit f3b2bea3c76ba9283b957f1373e7cebdbf863059)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.11.0
