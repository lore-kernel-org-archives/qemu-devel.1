Received: from eggs.gnu.org ([2001:4830:134:3::10]:43234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTezk-0000dk-Ta
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTezi-0002d1-JX
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fTezi-0002ci-ER
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:46 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Jun 2018 11:01:22 +0800
Message-Id: <1529031683-27458-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1529031683-27458-1-git-send-email-jasowang@redhat.com>
References: <1529031683-27458-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] e1000e: Do not auto-clear ICR bits which
 aren't set in EIAC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

The spec does not justify clearing of any E1000_ICR_OTHER_CAUSES when
E1000_ICR_OTHER is set in EIAC. In fact, removing this code fixes the
issue the Linux driver runs into since 4aea7a5c5e94 ("e1000e: Avoid
receiver overrun interrupt bursts") and was worked around by
745d0bd3af99 ("e1000e: Remove Other from EIAC").

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index c93c466..9504891 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2022,10 +2022,6 @@ e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
 
     effective_eiac = core->mac[EIAC] & cause;
 
-    if (effective_eiac == E1000_ICR_OTHER) {
-        effective_eiac |= E1000_ICR_OTHER_CAUSES;
-    }
-
     core->mac[ICR] &= ~effective_eiac;
 
     if (!(core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
-- 
2.7.4
