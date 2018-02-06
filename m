Received: from eggs.gnu.org ([2001:4830:134:3::10]:44642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j7-0005k0-6t
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ix-0008ET-GI
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34968
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ix-0008Da-9W
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:11 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEJAG056257
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:10 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fygjbwd3n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:08 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:08 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:15:07 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-47-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 46/54] spapr: fix device tree properties when
 using compatibility mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Commit 51f84465dd98 changed the compatility mode setting logic:
- machine reset only sets compatibility mode for the boot CPU
- compatibility mode is set for other CPUs when they are put online
  by the guest with the "start-cpu" RTAS call

This causes a regression for machines started with max-compat-cpu:
the device tree nodes related to secondary CPU cores contain wrong
"cpu-version" and "ibm,pa-features" values, as shown below.

Guest started on a POWER8 host with:
     -smp cores=2 -machine pseries,max-cpu-compat=compat7

                        ibm,pa-features = [18 00 f6 3f c7 c0 80 f0 80 00
 00 00 00 00 00 00 00 00 80 00 80 00 80 00 00 00];
                        cpu-version = <0x4d0200>;

                               ^^^
                        second CPU core

                        ibm,pa-features = <0x600f63f 0xc70080c0>;
                        cpu-version = <0xf000003>;

                               ^^^
                          boot CPU core

The second core is advertised in raw POWER8 mode. This happens because
CAS assumes all CPUs to have the same compatibility mode. Since the
boot CPU already has the requested compatibility mode, the CAS code
does not set it for the secondary one, and exposes the bogus device
tree properties in in the CAS response to the guest.

A similar situation is observed when hot-plugging a CPU core. The
related device tree properties are generated and exposed to guest
with the "ibm,configure-connector" RTAS before "start-cpu" is called.
The CPU core is advertised to the guest in raw mode as well.

It both cases, it boils down to the fact that "start-cpu" happens too
late. This can be fixed globally by propagating the compatibility mode
of the boot CPU to the other CPUs during reset.  For this to work, the
compatibility mode of the boot CPU must be set before the machine code
actually resets all CPUs.

It is not needed to set the compatibility mode in "start-cpu" anymore,
so the code is dropped.

Fixes: 51f84465dd98
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 9012a53f067a78022947e18050b145c34a3dc599)
 Conflicts:
	hw/ppc/spapr_cpu_core.c
	hw/ppc/spapr_rtas.c
* drop context dep on d6322252b32
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c          | 18 +++++++++---------
 hw/ppc/spapr_cpu_core.c |  7 +++++++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 34905731e1..6ab39a0e61 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1458,6 +1458,15 @@ static void ppc_spapr_reset(void)
         spapr_setup_hpt_and_vrma(spapr);
     }
 
+    /* if this reset wasn't generated by CAS, we should reset our
+     * negotiated options and start from scratch */
+    if (!spapr->cas_reboot) {
+        spapr_ovec_cleanup(spapr->ov5_cas);
+        spapr->ov5_cas = spapr_ovec_new();
+
+        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fatal);
+    }
+
     qemu_devices_reset();
 
     /* DRC reset may cause a device to be unplugged. This will cause troubles
@@ -1478,15 +1487,6 @@ static void ppc_spapr_reset(void)
     rtas_addr = rtas_limit - RTAS_MAX_SIZE;
     fdt_addr = rtas_addr - FDT_MAX_SIZE;
 
-    /* if this reset wasn't generated by CAS, we should reset our
-     * negotiated options and start from scratch */
-    if (!spapr->cas_reboot) {
-        spapr_ovec_cleanup(spapr->ov5_cas);
-        spapr->ov5_cas = spapr_ovec_new();
-
-        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
-    }
-
     fdt = spapr_build_fdt(spapr, rtas_addr, spapr->rtas_size);
 
     spapr_load_rtas(spapr, fdt, rtas_addr);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3a4c174012..e8b0ffb1b1 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -35,6 +35,13 @@ static void spapr_cpu_reset(void *opaque)
     cs->halted = 1;
 
     env->spr[SPR_HIOR] = 0;
+
+    /* Set compatibility mode to match the boot CPU, which was either set
+     * by the machine reset code or by CAS. This should never fail.
+     */
+    if (cs != first_cpu) {
+        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort);
+    }
 }
 
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
-- 
2.11.0
