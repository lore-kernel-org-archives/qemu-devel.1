Received: from eggs.gnu.org ([2001:4830:134:3::10]:48375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dpViD-0000MV-2k
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dpVi8-0003NZ-W0
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:29:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dpVi8-0003NE-Na
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:29:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v868TG7K143724
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 04:29:23 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ct76an5wu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 04:29:22 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 18:29:20 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed,  6 Sep 2017 13:57:48 +0530
Message-Id: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

When the user does not provide the cpu topology, e.g. "-smp 4", machine fails to
initialize 4 cpus. Compute the chip per cores depending on the number of chips
and smt threads.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 hw/ppc/pnv.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9724719..3fbaafb 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -642,7 +642,7 @@ static void ppc_powernv_init(MachineState *machine)
     MemoryRegion *ram;
     char *fw_filename;
     long fw_size;
-    int i;
+    int i, cores_per_chip;
     char *chip_typename;
     PCIBus *pbus;
     bool has_gfx = false;
@@ -710,6 +710,22 @@ static void ppc_powernv_init(MachineState *machine)
     }
 
     pnv->chips = g_new0(PnvChip *, pnv->num_chips);
+
+    /* If user has specified number of cores, use it. Otherwise, compute it. */
+    if (smp_cores != 1) {
+        cores_per_chip = smp_cores;
+    } else {
+        cores_per_chip = smp_cpus / (smp_threads * pnv->num_chips);
+    }
+
+    if (smp_cpus != (smp_threads * pnv->num_chips * cores_per_chip)) {
+        error_report("cpu topology not balanced: "
+                     "chips (%u) * cores (%u) * threads (%u) != "
+                     "number of cpus (%u)",
+                     pnv->num_chips, cores_per_chip, smp_threads, smp_cpus);
+        exit(1);
+    }
+
     for (i = 0; i < pnv->num_chips; i++) {
         char chip_name[32];
         Object *chip = object_new(chip_typename);
@@ -728,7 +744,7 @@ static void ppc_powernv_init(MachineState *machine)
         object_property_add_child(OBJECT(pnv), chip_name, chip, &error_fatal);
         object_property_set_int(chip, PNV_CHIP_HWID(i), "chip-id",
                                 &error_fatal);
-        object_property_set_int(chip, smp_cores, "nr-cores", &error_fatal);
+        object_property_set_int(chip, cores_per_chip, "nr-cores", &error_fatal);
         object_property_set_int(chip, 1, "num-phbs", &error_fatal);
         object_property_set_bool(chip, true, "realized", &error_fatal);
     }
-- 
2.9.3
