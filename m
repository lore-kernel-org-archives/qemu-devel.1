Received: from eggs.gnu.org ([2001:4830:134:3::10]:53159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1e78eS-0005n7-Sa
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 19:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1e78eR-0000V0-PL
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 19:30:28 -0400
Received: from smtp8.web4u.cz ([81.91.87.88]:42724 helo=mx-8.mail.web4u.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pisa@cmp.felk.cvut.cz>)
	id 1e78eR-0000Tw-Is
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 19:30:27 -0400
From: pisa@cmp.felk.cvut.cz
Date: Wed, 25 Oct 2017 01:29:44 +0200
Message-Id: <cbfe4b03919c677d132971ed0c352b0d90de5015.1508885974.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <7df70170550e3a10152a3571012f507dd035ba7c.1508885974.git.pisa@cmp.felk.cvut.cz>
References: <7df70170550e3a10152a3571012f507dd035ba7c.1508885974.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1508885974.git.pisa@cmp.felk.cvut.cz>
References: <cover.1508885974.git.pisa@cmp.felk.cvut.cz>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Konrad Frederic <fred.konrad@greensocs.com>, Deniz Eren <deniz.eren@icloud.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marek Vasut <marex@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Deniz Eren <deniz.eren@icloud.com>

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 hw/can/can_pcm3680_pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/can/can_pcm3680_pci.c b/hw/can/can_pcm3680_pci.c
index 77523f2ddb..bc6b164ea7 100644
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
@@ -206,6 +213,8 @@ static int pcm3680i_pci_init(PCIDevice *pci_dev)
     pci_conf = pci_dev->config;
     pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
 
+    d->irq = pci_allocate_irq(&d->dev);
+
     can_sja_init(s1, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower, d);
     can_sja_init(s2, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower, d);
 
@@ -254,6 +263,8 @@ static void pcm3680i_pci_exit(PCIDevice *pci_dev)
 
     can_sja_exit(s1);
     can_sja_exit(s2);
+
+    qemu_free_irq(d->irq);
 }
 
 static const VMStateDescription vmstate_pcm3680i_pci = {
-- 
2.11.0
