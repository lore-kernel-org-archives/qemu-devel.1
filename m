Received: from eggs.gnu.org ([2001:4830:134:3::10]:34447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlxn-0006SN-Gw
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlxl-00024m-MN
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:27:51 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 26 Jan 2017 16:27:34 +0100
Message-Id: <1485444454-30749-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1485444454-30749-1-git-send-email-armbru@redhat.com>
References: <1485444454-30749-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] hw/i386: Deprecate -drive if=scsi with PC
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
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

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
---
 hw/i386/pc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c345c04..ceb28c7 100644
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
 
-- 
2.7.4
