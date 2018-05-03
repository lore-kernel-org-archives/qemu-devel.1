Received: from eggs.gnu.org ([2001:4830:134:3::10]:37688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fELbC-0001hD-EL
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fELb9-0000Qr-LL
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:17:10 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:42650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fELb9-0000PX-4o
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:17:07 -0400
Received: from player688.ha.ovh.net (unknown [10.109.105.117])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id BAC3A14ABB
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 23:17:05 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 03 May 2018 23:16:59 +0200
Message-ID: <152538221936.223014.5693034615440530856.stgit@bahia.lan>
In-Reply-To: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
References: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/3] spapr: don't advertise radix GTSE if
 max-compat-cpu < power9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

On a POWER9 host, if a guest runs in pre POWER9 compat mode, it necessarily
uses the hash MMU mode. In this case, we shouldn't advertise radix GTSE in
the ibm,arch-vec-5-platform-support DT property as the current code does.
The first reason is that it doesn't make sense, and the second one is that
causes the CAS-negotiated options subsection to be migrated. This breaks
backward migration to QEMU 2.7 and older versions on POWER8 hosts:

qemu-system-ppc64: error while loading state for instance 0x0 of device
 'spapr'
qemu-system-ppc64: load of migration failed: No such file or directory

This patch hence initialize CPUs a bit earlier so that we can check the
requested compat mode, and don't set OV5_MMU_RADIX_GTSE for power8 and
older.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index eb9d087d1a60..154bf9d548c4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2517,6 +2517,7 @@ static void spapr_machine_init(MachineState *machine)
     long load_limit, fw_size;
     char *filename;
     Error *resize_hpt_err = NULL;
+    PowerPCCPU *first_ppc_cpu;
 
     msi_nonbroken = true;
 
@@ -2609,11 +2610,6 @@ static void spapr_machine_init(MachineState *machine)
     }
 
     spapr_ovec_set(spapr->ov5, OV5_FORM1_AFFINITY);
-    if (!kvm_enabled() || kvmppc_has_cap_mmu_radix()) {
-        /* KVM and TCG always allow GTSE with radix... */
-        spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX_GTSE);
-    }
-    /* ... but not with hash (currently). */
 
     /* advertise support for dedicated HP event source to guests */
     if (spapr->use_hotplug_event_source) {
@@ -2631,6 +2627,15 @@ static void spapr_machine_init(MachineState *machine)
     /* init CPUs */
     spapr_init_cpus(spapr);
 
+    first_ppc_cpu = POWERPC_CPU(first_cpu);
+    if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
+        ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
+                         spapr->max_compat_pvr)) {
+        /* KVM and TCG always allow GTSE with radix... */
+        spapr_ovec_set(spapr->ov5, OV5_MMU_RADIX_GTSE);
+    }
+    /* ... but not with hash (currently). */
+
     if (kvm_enabled()) {
         /* Enable H_LOGICAL_CI_* so SLOF can talk to in-kernel devices */
         kvmppc_enable_logical_ci_hcalls();
