Received: from eggs.gnu.org ([2001:4830:134:3::10]:60362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2gy-0003LC-Fv
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZ2gx-0008Lz-Hv
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:08 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZ2gx-0008LG-A5
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 18:16:07 -0400
Received: by mail-lf0-x244.google.com with SMTP id p11so5151612lfd.1
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 15:16:07 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 01:15:42 +0300
Message-Id: <1500761743-1669-6-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH v2 5/6] hw/pci: add bus_reserve property to
 pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, marcel@redhat.com, kraxel@redhat.com, seabios@seabios.org, Aleksandr Bezzubikov <zuban32s@gmail.com>

To enable hotplugging of a newly created pcie-pci-bridge,
we need to tell firmware (SeaBIOS in this case) to reserve
additional buses for pcie-root-port, that allows us to 
hotplug pcie-pci-bridge into this root port.
The number of buses to reserve is provided to the device via a corresponding
property, and to the firmware via new PCI capability (next patch).
The property's default value is 1 as we want to hotplug at least 1 bridge.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 hw/pci-bridge/pcie_root_port.c | 1 +
 include/hw/pci/pcie_port.h     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 4d588cb..b0e49e1 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -137,6 +137,7 @@ static void rp_exit(PCIDevice *d)
 static Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_UINT8("bus_reserve", PCIEPort, bus_reserve, 1),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 1333266..1b2dd1f 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -34,6 +34,9 @@ struct PCIEPort {
 
     /* pci express switch port */
     uint8_t     port;
+
+    /* additional buses to reserve on firmware init */
+    uint8_t     bus_reserve;
 };
 
 void pcie_port_init_reg(PCIDevice *d);
-- 
2.7.4
