Received: from eggs.gnu.org ([2001:4830:134:3::10]:56221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim7-0006ZR-Eu
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim6-0000NA-0W
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 19 Mar 2018 11:35:22 +1100
Message-Id: <20180319003524.28143-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180319003524.28143-1-david@gibson.dropbear.id.au>
References: <20180319003524.28143-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 6/8] hw/ppc/spapr: Allow "spapr-vlan" as NIC
 model name beside "ibmveth"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, lvivier@redhat.com, surajjs@au1.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

With the new "--nic" command line parameter option, the "old" way of
specifying a NIC model via the nd_table[] is becoming more prominent
again. But for the pseries "spapr-vlan" device, there is a confusing
discrepancy between the model name that is used for "--device" (i.e.
"spapr-vlan") and the model name that has to be used for "--net nic"
or the new "--nic" parameter (i.e. "ibmveth"). Since "spapr-vlan" is
the "real" name of the device, let's allow "spapr-vlan" to be used
as model name for the nd_table[] entries, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 032d03423f..fba76abee2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2607,10 +2607,11 @@ static void spapr_machine_init(MachineState *machine)
         NICInfo *nd = &nd_table[i];
 
         if (!nd->model) {
-            nd->model = g_strdup("ibmveth");
+            nd->model = g_strdup("spapr-vlan");
         }
 
-        if (strcmp(nd->model, "ibmveth") == 0) {
+        if (g_str_equal(nd->model, "spapr-vlan") ||
+            g_str_equal(nd->model, "ibmveth")) {
             spapr_vlan_create(spapr->vio_bus, nd);
         } else {
             pci_nic_init_nofail(&nd_table[i], phb->bus, nd->model, NULL);
-- 
2.14.3
