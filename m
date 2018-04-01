Received: from eggs.gnu.org ([2001:4830:134:3::10]:47989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f2kMS-0001OF-9S
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f2kMP-00061G-3t
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:18:00 -0400
Received: from mout.web.de ([212.227.15.14]:57529)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1f2kMO-00060k-Pj
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:17:57 -0400
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <79199357-38dc-4a2a-6e67-e80235448b31@web.de>
Date: Sun, 1 Apr 2018 23:17:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] e1000e: Prevent MSI/MSI-X storms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Only signal MSI/MSI-X events on rising edges. So far we re-triggered the
interrupt sources even if the guest did no consumed the pending one,
easily causing interrupt storms.

Issue was observable with Linux 4.16 e1000e driver when MSI-X was used.
Vector 2 was causing interrupt storms after the driver activated the
device.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/net/e1000e_core.c | 10 ++++++++++
 hw/net/e1000e_core.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index c93c4661ed..ecf9b15555 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2123,6 +2123,13 @@ e1000e_send_msi(E1000ECore *core, bool msix)
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
@@ -2160,6 +2167,9 @@ e1000e_update_interrupt_state(E1000ECore *core)
     core->mac[ICS] = core->mac[ICR];
 
     interrupts_pending = (core->mac[IMS] & core->mac[ICR]) ? true : false;
+    if (!interrupts_pending) {
+        core->msi_causes_pending = 0;
+    }
 
     trace_e1000e_irq_pending_interrupts(core->mac[ICR] & core->mac[IMS],
                                         core->mac[ICR], core->mac[IMS]);
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 7d8ff41890..63a15510cc 100644
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
2.13.6
