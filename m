Received: from eggs.gnu.org ([2001:4830:134:3::10]:33428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fgJYA-0007Q1-KK
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 20:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fgJY9-0003dt-LT
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 20:45:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fgJY9-0003dh-F2
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 20:45:37 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Jul 2018 08:45:28 +0800
Message-Id: <1532047529-17961-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1532047529-17961-1-git-send-email-jasowang@redhat.com>
References: <1532047529-17961-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] e1000e: Prevent MSI/MSI-X storms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Only signal MSI/MSI-X events on rising edges. So far we re-triggered the
interrupt sources even if the guest did no consumed the pending one,
easily causing interrupt storms.

Issue was observable with Linux 4.16 e1000e driver when MSI-X was used.
Vector 2 was causing interrupt storms after the driver activated the
device.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 11 +++++++++++
 hw/net/e1000e_core.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 9504891..2a221c2 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2023,6 +2023,7 @@ e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
     effective_eiac = core->mac[EIAC] & cause;
 
     core->mac[ICR] &= ~effective_eiac;
+    core->msi_causes_pending &= ~effective_eiac;
 
     if (!(core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
         core->mac[IMS] &= ~effective_eiac;
@@ -2119,6 +2120,13 @@ e1000e_send_msi(E1000ECore *core, bool msix)
 {
     uint32_t causes = core->mac[ICR] & core->mac[IMS] & ~E1000_ICR_ASSERTED;
 
+    core->msi_causes_pending &= causes;
+    causes ^= core->msi_causes_pending;
+    if (causes == 0) {
+        return;
+    }
+    core->msi_causes_pending |= causes;
+
     if (msix) {
         e1000e_msix_notify(core, causes);
     } else {
@@ -2156,6 +2164,9 @@ e1000e_update_interrupt_state(E1000ECore *core)
     core->mac[ICS] = core->mac[ICR];
 
     interrupts_pending = (core->mac[IMS] & core->mac[ICR]) ? true : false;
+    if (!interrupts_pending) {
+        core->msi_causes_pending = 0;
+    }
 
     trace_e1000e_irq_pending_interrupts(core->mac[ICR] & core->mac[IMS],
                                         core->mac[ICR], core->mac[IMS]);
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 7d8ff41..63a1551 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -109,6 +109,8 @@ struct E1000Core {
     NICState *owner_nic;
     PCIDevice *owner;
     void (*owner_start_recv)(PCIDevice *d);
+
+    uint32_t msi_causes_pending;
 };
 
 void
-- 
2.7.4
