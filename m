Received: from eggs.gnu.org ([2001:4830:134:3::10]:38114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVD-0003AV-Fo
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV9-0008CV-Vk
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:15 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:45 +1100
Message-Id: <20170222063348.32176-41-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 40/43] hw/net/spapr_llan: 6 byte mac address
 device tree entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Sam Bobroff <sam.bobroff@au1.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

The spapr-vlan device in QEMU has always presented it's MAC address in
the device tree as an 8 byte value, even though PAPR requires it to be
6 bytes.  This is because, at the time, AIX required the value to be 8
bytes.  However, modern versions of AIX support the (correct) 6
byte value so they no longer require the workaround.

It would be neatest to always provide a 6 byte value but that would
cause a problem with old Linux kernel ibmveth drivers, so the old 8
byte value is still presented when necessary.

Since commit 13f85203e (3.10, May 2013) the driver has been able to
handle 6 or 8 byte addresses so versions after that don't need to be
considered specially.

Drivers from kernels before that can also handle either type of
address, but not always:
* If the first byte's lowest bits are 10, the address must be 6 bytes.
* Otherwise, the address must be 8 bytes.
(The two bits in question are significant in a MAC address: they
indicate a locally-administered unicast address.)

So to maintain compatibility the old 8 byte value is presented when
the lowest two bits of the first byte are not 10.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/net/spapr_llan.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 058908d..d239e4b 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -385,18 +385,24 @@ static int spapr_vlan_devnode(VIOsPAPRDevice *dev, void *fdt, int node_off)
     int ret;
 
     /* Some old phyp versions give the mac address in an 8-byte
-     * property.  The kernel driver has an insane workaround for this;
+     * property.  The kernel driver (before 3.10) has an insane workaround;
      * rather than doing the obvious thing and checking the property
      * length, it checks whether the first byte has 0b10 in the low
      * bits.  If a correct 6-byte property has a different first byte
      * the kernel will get the wrong mac address, overrunning its
      * buffer in the process (read only, thank goodness).
      *
-     * Here we workaround the kernel workaround by always supplying an
-     * 8-byte property, with the mac address in the last six bytes */
-    memcpy(&padded_mac[2], &vdev->nicconf.macaddr, ETH_ALEN);
-    ret = fdt_setprop(fdt, node_off, "local-mac-address",
-                      padded_mac, sizeof(padded_mac));
+     * Here we return a 6-byte address unless that would break a pre-3.10
+     * driver.  In that case we return a padded 8-byte address to allow the old
+     * workaround to succeed. */
+    if ((vdev->nicconf.macaddr.a[0] & 0x3) == 0x2) {
+        ret = fdt_setprop(fdt, node_off, "local-mac-address",
+                          &vdev->nicconf.macaddr, ETH_ALEN);
+    } else {
+        memcpy(&padded_mac[2], &vdev->nicconf.macaddr, ETH_ALEN);
+        ret = fdt_setprop(fdt, node_off, "local-mac-address",
+                          padded_mac, sizeof(padded_mac));
+    }
     if (ret < 0) {
         return ret;
     }
-- 
2.9.3
