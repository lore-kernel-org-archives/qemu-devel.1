Received: from eggs.gnu.org ([2001:4830:134:3::10]:47988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f2kMS-0001OE-9G
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f2kMP-00061Y-Rq
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:18:00 -0400
Received: from mout.web.de ([212.227.15.14]:42831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1f2kMP-00060y-GW
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:17:57 -0400
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <267f42a5-b7ce-379e-ffd1-f2611393d2ff@web.de>
Date: Sun, 1 Apr 2018 23:17:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] e1000e: Do not auto-clear ICR bits which
 aren't set in EIAC
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

The spec does not justify clearing of any E1000_ICR_OTHER_CAUSES when
E1000_ICR_OTHER is set in EIAC. In fact, removing this code fixes the
issue the Linux driver runs into since 4aea7a5c5e94 ("e1000e: Avoid
receiver overrun interrupt bursts") and was worked around by
745d0bd3af99 ("e1000e: Remove Other from EIAC").

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This resolves the issue I reported on February 18 ("e1000e: MSI-X
problem with recent Linux drivers").

 hw/net/e1000e_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index ecf9b15555..d38f025c0f 100644
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
2.13.6
