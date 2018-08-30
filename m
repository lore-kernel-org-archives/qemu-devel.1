Received: from eggs.gnu.org ([2001:4830:134:3::10]:42149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fvGBE-0000wg-39
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fvGBB-0002pg-7r
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:11:44 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40028
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fvGBA-0002pG-Vs
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:11:41 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 30 Aug 2018 07:11:28 +0100
Message-Id: <20180830061129.4157-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180830061129.4157-1-mark.cave-ayland@ilande.co.uk>
References: <20180830061129.4157-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/2] sabre: generate correct fw path for sabre
 PCI host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Set the fw_name property to "pci" and also set an explicit OFW address
using the value of the special_base property.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/sabre.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index e2f4ee480e..e33bd46967 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -496,6 +496,15 @@ static const TypeInfo sabre_pci_info = {
     },
 };
 
+static char *sabre_ofw_unit_address(const SysBusDevice *dev)
+{
+    SabreState *s = SABRE_DEVICE(dev);
+
+    return g_strdup_printf("%x,%x",
+               (uint32_t)((s->special_base >> 32) & 0xffffffff),
+               (uint32_t)(s->special_base & 0xffffffff));
+}
+
 static Property sabre_properties[] = {
     DEFINE_PROP_UINT64("special-base", SabreState, special_base, 0),
     DEFINE_PROP_UINT64("mem-base", SabreState, mem_base, 0),
@@ -505,11 +514,14 @@ static Property sabre_properties[] = {
 static void sabre_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
 
     dc->realize = sabre_realize;
     dc->reset = sabre_reset;
     dc->props = sabre_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "pci";
+    sbc->explicit_ofw_unit_address = sabre_ofw_unit_address;
 }
 
 static const TypeInfo sabre_info = {
-- 
2.11.0
