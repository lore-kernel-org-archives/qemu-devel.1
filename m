Received: from eggs.gnu.org ([209.51.188.92]:60749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghES9-0002hV-VM
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghES8-0003IF-FJ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:03:29 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  9 Jan 2019 15:03:23 +0100
Message-Id: <1547042603-21147-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr: Encode the SCSI channel (bus) in
 the SRP LUNs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>

In hw/scsi/spapr_vio.c we declare that the controller supports multiple
buses by specifying "max_channel = 7" there. So in the code that fixes
up the device tree nodes, we must encode the channel number (a.k.a. bus
number in the "Logical unit addressing format" table of SAM5) into the
64-bit LUN, too.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1663160
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5671608..1f49489 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2905,10 +2905,11 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
         if (spapr) {
             /*
              * Replace "channel@0/disk@0,0" with "disk@8000000000000000":
-             * We use SRP luns of the form 8000 | (bus << 8) | (id << 5) | lun
-             * in the top 16 bits of the 64-bit LUN
+             * In the top 16 bits of the 64-bit LUN, we use SRP luns of the form
+             * 0x8000 | (target << 8) | (bus << 5) | lun
+             * (see the "Logical unit addressing format" table in SAM5)
              */
-            unsigned id = 0x8000 | (d->id << 8) | d->lun;
+            unsigned id = 0x8000 | (d->id << 8) | (d->channel << 5) | d->lun;
             return g_strdup_printf("%s@%"PRIX64, qdev_fw_name(dev),
                                    (uint64_t)id << 48);
         } else if (virtio) {
-- 
1.8.3.1
