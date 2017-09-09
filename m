Received: from eggs.gnu.org ([2001:4830:134:3::10]:51077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqhL8-0007v5-LK
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqhL4-0006Hd-5u
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:34 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:41248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dqhL3-0006FX-VJ
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 11:06:30 -0400
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 8F0BC751FF
	for <qemu-devel@nongnu.org>; Sat,  9 Sep 2017 17:06:28 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Sat, 09 Sep 2017 17:06:25 +0200
Message-ID: <150496958584.9654.9736122740323515191.stgit@bahia>
In-Reply-To: <150496954641.9654.1998704077006846521.stgit@bahia>
References: <150496954641.9654.1998704077006846521.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 4/5] spapr_pci: use the common _FDT() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

All other users in hw/ppc already consider an error when building
the FDT to be fatal, even on hotplug paths. There's no valid reason
for spapr_pci to behave differently. So let's used the common _FDT()
helper which terminates QEMU when libfdt fails.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 6da73fe6bc29..abb9f05e7b75 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -40,7 +40,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qapi/qmp/qerror.h"
-
+#include "hw/ppc/fdt.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_ids.h"
@@ -61,14 +61,6 @@
 #define RTAS_TYPE_MSI           1
 #define RTAS_TYPE_MSIX          2
 
-#define _FDT(exp) \
-    do { \
-        int ret = (exp);                                           \
-        if (ret < 0) {                                             \
-            return ret;                                            \
-        }                                                          \
-    } while (0)
-
 sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState *spapr, uint64_t buid)
 {
     sPAPRPHBState *sphb;
