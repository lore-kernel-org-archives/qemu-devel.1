Received: from eggs.gnu.org ([2001:4830:134:3::10]:43731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1cPHGF-0002AY-VT
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 18:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1cPHGE-0007ao-9G
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 18:15:55 -0500
Received: from smtp7.web4u.cz ([81.91.87.87]:57171 helo=mx-8.mail.web4u.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pisa@cmp.felk.cvut.cz>)
	id 1cPHGE-0007aO-2W
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 18:15:54 -0500
From: pisa@cmp.felk.cvut.cz
Date: Fri,  6 Jan 2017 00:11:26 +0100
Message-Id: <af380121337bf56948a5579f95ad35005fc125a2.1483655894.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1483655893.git.pisa@cmp.felk.cvut.cz>
References: <cover.1483655893.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1483655893.git.pisa@cmp.felk.cvut.cz>
References: <cover.1483655893.git.pisa@cmp.felk.cvut.cz>
Subject: [Qemu-devel] [PATCH 4/6] Fixed IRQ problem for CAN device
 can_pcm3680_pci.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Konrad Frederic <fred.konrad@greensocs.com>, Deniz Eren <deniz.eren@icloud.com>, Oliver Hartkopp <socketcan@hartkopp.net>

From: Deniz Eren <deniz.eren@icloud.com>

---
 hw/can/can_pcm3680_pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/can/can_pcm3680_pci.c b/hw/can/can_pcm3680_pci.c
index 6e5c9f2..9d8d3f7 100644
--- a/hw/can/can_pcm3680_pci.c
+++ b/hw/can/can_pcm3680_pci.c
@@ -61,6 +61,7 @@ typedef struct Pcm3680iPCIState {
     MemoryRegion    sja_io[2];
 
     CanSJA1000State sja_state[2];
+    qemu_irq        irq;
 
     char            *model; /* The model that support, only SJA1000 now. */
     char            *canbus[2];
@@ -69,10 +70,16 @@ typedef struct Pcm3680iPCIState {
 
 static void pcm3680i_pci_irq_raise(void *opaque)
 {
+    Pcm3680iPCIState *d = (Pcm3680iPCIState *)opaque;
+
+    qemu_irq_raise(d->irq);
 }
 
 static void pcm3680i_pci_irq_lower(void *opaque)
 {
+    Pcm3680iPCIState *d = (Pcm3680iPCIState *)opaque;
+
+    qemu_irq_lower(d->irq);
 }
 
 static void
@@ -202,6 +209,8 @@ static int pcm3680i_pci_init(PCIDevice *pci_dev)
     pci_conf = pci_dev->config;
     pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
 
+    d->irq = pci_allocate_irq(&d->dev);
+
     can_sja_init(s1, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower, d);
     can_sja_init(s2, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower, d);
 
@@ -248,6 +257,8 @@ static void pcm3680i_pci_exit(PCIDevice *pci_dev)
 
     can_sja_exit(s1);
     can_sja_exit(s2);
+
+    qemu_free_irq(d->irq);
 }
 
 static const VMStateDescription vmstate_pcm3680i_pci = {
-- 
1.9.1
