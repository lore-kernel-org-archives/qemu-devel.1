Received: from eggs.gnu.org ([2001:4830:134:3::10]:48415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eZ-0007eg-9y
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cg9eW-00083w-FN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cg9eW-000837-6m
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:34:44 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63851C06C9E8
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 12:34:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1LCYgd4012614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:34:43 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 13:34:39 +0100
Message-Id: <1487680479-15132-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1487680479-15132-1-git-send-email-armbru@redhat.com>
References: <1487680479-15132-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 11/11] hw/i386: Deprecate -drive if=scsi with PC
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The PC machines (pc-q35-* pc-i440fx-* pc-* isapc xenfv) automatically
create lsi53c895a SCSI HBAs and SCSI devices to honor -drive if=scsi.
For giggles, try -drive if=scsi,bus=25,media=cdrom --- this makes QEMU
create 25 of them.

lsi53c895a is thoroughly obsolete (PCI Ultra2 SCSI, ca. 2000), and
currently has no maintainer in QEMU.  megasas is a better choice,
except with old OSes that lack drivers.  virtio-scsi is a much better
choice when you have a driver, but only (newish) Linux comes with one
in the box.  There is no good default that works for all guests.

Encourage users to pick a non-obsolete SCSI HBA that works for them by
deprecating -drive if=scsi.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1487161136-9018-4-git-send-email-armbru@redhat.com>
Acked-By: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c                  |  8 +++++++-
 qemu-options.hx               |  5 -----
 tests/qemu-iotests/051.pc.out | 12 ++++++++----
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c2c75e2..60b0946 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1650,9 +1650,15 @@ void pc_pci_device_init(PCIBus *pci_bus)
     int max_bus;
     int bus;
 
+    /* Note: if=scsi is deprecated with PC machine types */
     max_bus = drive_get_max_bus(IF_SCSI);
     for (bus = 0; bus <= max_bus; bus++) {
-        lsi53c895a_create(pci_bus);
+        pci_create_simple(pci_bus, -1, "lsi53c895a");
+        /*
+         * By not creating frontends here, we make
+         * scsi_legacy_handle_cmdline() create them, and warn that
+         * this usage is deprecated.
+         */
     }
 }
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 809b2b0..1e815ef 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -654,11 +654,6 @@ If you don't specify the "file=" argument, you define an empty drive:
 qemu-system-i386 -drive if=ide,index=1,media=cdrom
 @end example
 
-You can connect a SCSI disk with unit ID 6 on the bus #0:
-@example
-qemu-system-i386 -drive file=file,if=scsi,bus=0,unit=6
-@end example
-
 Instead of @option{-fda}, @option{-fdb}, you can use:
 @example
 qemu-system-i386 -drive file=file,index=0,if=floppy
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 603bb76..f8047a2 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -118,7 +118,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive if=scsi,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) QEMU_PROG: -drive if=scsi,media=cdrom: warning: bus=0,unit=0 is deprecated with this machine type
+q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
 
 Testing: -drive if=ide
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -127,7 +128,8 @@ QEMU_PROG: Initialization of device ide-hd failed: Device initialization failed.
 
 Testing: -drive if=scsi
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Initialization of device lsi53c895a failed: Device needs media, but drive is empty
+(qemu) QEMU_PROG: -drive if=scsi: warning: bus=0,unit=0 is deprecated with this machine type
+QEMU_PROG: -drive if=scsi: Device needs media, but drive is empty
 
 Testing: -drive if=virtio
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -172,7 +174,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=scsi,media=cdrom,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=scsi,media=cdrom,readonly=on: warning: bus=0,unit=0 is deprecated with this machine type
+q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -181,7 +184,8 @@ QEMU_PROG: Initialization of device ide-hd failed: Device initialization failed.
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=scsi,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
+(qemu) QEMU_PROG: -drive file=TEST_DIR/t.qcow2,if=scsi,readonly=on: warning: bus=0,unit=0 is deprecated with this machine type
+q[K[Dqu[K[D[Dqui[K[D[D[Dquit[K
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-- 
2.7.4
