Received: from eggs.gnu.org ([2001:4830:134:3::10]:40524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxK-0002aB-4o
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxG-0001Wx-KE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 17 Jul 2017 16:56:01 +1000
Message-Id: <20170717065621.4688-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170717065621.4688-1-david@gibson.dropbear.id.au>
References: <20170717065621.4688-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/21] spapr: Remove unnecessary instance_size
 specifications from DRC subtypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sjitindarsingh@gmail.com, David Gibson <david@gibson.dropbear.id.au>

All the DRC subtypes explicitly list instance_size in TypeInfo (all as
sizeof(sPAPRDRConnector).  This isn't necessary, since if it's not listed
it will be derived from the parent type.

Worse, this is dangerous, because if a subtype is changed in future to
have a larger structure, then subtypes of that subtype also need to have
instance_size changed, or it will lead to hard to track memory corruption
bugs.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index f34355dad1..7f71c77015 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -653,7 +653,6 @@ static const TypeInfo spapr_dr_connector_info = {
 static const TypeInfo spapr_drc_physical_info = {
     .name          = TYPE_SPAPR_DRC_PHYSICAL,
     .parent        = TYPE_SPAPR_DR_CONNECTOR,
-    .instance_size = sizeof(sPAPRDRConnector),
     .class_init    = spapr_drc_physical_class_init,
     .abstract      = true,
 };
@@ -661,7 +660,6 @@ static const TypeInfo spapr_drc_physical_info = {
 static const TypeInfo spapr_drc_logical_info = {
     .name          = TYPE_SPAPR_DRC_LOGICAL,
     .parent        = TYPE_SPAPR_DR_CONNECTOR,
-    .instance_size = sizeof(sPAPRDRConnector),
     .class_init    = spapr_drc_logical_class_init,
     .abstract      = true,
 };
@@ -669,21 +667,18 @@ static const TypeInfo spapr_drc_logical_info = {
 static const TypeInfo spapr_drc_cpu_info = {
     .name          = TYPE_SPAPR_DRC_CPU,
     .parent        = TYPE_SPAPR_DRC_LOGICAL,
-    .instance_size = sizeof(sPAPRDRConnector),
     .class_init    = spapr_drc_cpu_class_init,
 };
 
 static const TypeInfo spapr_drc_pci_info = {
     .name          = TYPE_SPAPR_DRC_PCI,
     .parent        = TYPE_SPAPR_DRC_PHYSICAL,
-    .instance_size = sizeof(sPAPRDRConnector),
     .class_init    = spapr_drc_pci_class_init,
 };
 
 static const TypeInfo spapr_drc_lmb_info = {
     .name          = TYPE_SPAPR_DRC_LMB,
     .parent        = TYPE_SPAPR_DRC_LOGICAL,
-    .instance_size = sizeof(sPAPRDRConnector),
     .class_init    = spapr_drc_lmb_class_init,
 };
 
-- 
2.13.3
