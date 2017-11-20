Received: from eggs.gnu.org ([2001:4830:134:3::10]:57485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGgl3-0006nt-FR
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGgl0-00064l-Ck
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:44:45 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 20 Nov 2017 08:44:38 +0100
Message-Id: <1511163878-11977-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] hw/ppc/spapr: Fix virtio-scsi
 bootindex handling for LUNs >= 256
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

LUNs >= 256 have to be encoded with the so-called "flat space
addressing method" for virtio-scsi, where an additional bit has to
be set. SLOF already took care of this with the following commit:

 https://git.qemu.org/?p=SLOF.git;a=commitdiff;h=f72a37713fea47da
 (see https://bugzilla.redhat.com/show_bug.cgi?id=1431584 for details)

But QEMU does not use this encoding yet for device tree paths
that have to be handed over to SLOF to deal with the "bootindex"
property, so SLOF currently fails to boot from virtio-scsi devices
with LUNs >= 256 in the right boot order. Fix it by using the bit
to indicate the "flat space addressing method" for LUNs >= 256.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d682f01..ff2eec4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2643,6 +2643,10 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
              * swap 0100 or 10 << or 20 << ( target lun-id -- srplun )
              */
             unsigned id = 0x1000000 | (d->id << 16) | d->lun;
+            if (d->lun >= 256) {
+                /* Use the LUN "flat space addressing method" */
+                id |= 0x4000;
+            }
             return g_strdup_printf("%s@%"PRIX64, qdev_fw_name(dev),
                                    (uint64_t)id << 32);
         } else if (usb) {
-- 
1.8.3.1
