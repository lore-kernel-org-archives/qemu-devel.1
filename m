Received: from eggs.gnu.org ([2001:4830:134:3::10]:58572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da4BC-0004sy-3w
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da4B9-0004pO-0g
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:03:34 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:40106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da4B8-0004oH-Qr
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:03:30 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 8B5E9116654
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:03:29 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:03:21 +0200
Message-ID: <150100580191.27487.17612552307249886496.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 25/26] spapr_pci: drop abusive sanity
 check when migrating the LSI table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

The guest can allocate blocks of IRQs when calling the ibm,change-msi
RTAS call. This has an impact on the IRQ numbers returned by subsequent
calls to spapr_ics_alloc_block().

It doesn't cause any problem right now because PHB are cold plugged and
the LSI table have the same numbers at the destination and the source.

But this won't be the case anymore when we support PHB hotplug. In this
case the IRQ numbers in the LSI table are state that we should migrate.

This patch hence changes the destination to always accept the LSI table
from the migration stream, like it is already done for MSIs. No effort
is made to preserve the current behavior of failing migration when LSI
numbers are different with older machine types, for simplicity.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 58406a1b7e93..157867af8178 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1887,8 +1887,7 @@ static const VMStateDescription vmstate_spapr_pci_lsi = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32_EQUAL(irq, struct spapr_pci_lsi, NULL),
-
+        VMSTATE_UINT32(irq, struct spapr_pci_lsi),
         VMSTATE_END_OF_LIST()
     },
 };
