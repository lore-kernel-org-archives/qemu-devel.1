Received: from eggs.gnu.org ([2001:4830:134:3::10]:57297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da49J-00039e-Q3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da49G-0002lJ-NF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:37 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:54552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da49G-0002jz-GE
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:34 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2727A1165D3
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:01:33 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:01:25 +0200
Message-ID: <150100568549.27487.11903027800624299907.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 16/26] spapr: enable PHB hotplug for
 pseries-2.11
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

From: Michael Roth <mdroth@linux.vnet.ibm.com>

The 'dr_phb_enabled' field of that class can be set as
part of machine-specific init code, and is then propagated
to sPAPREnvironment to conditionally enable creation of DRC
objects and device-tree description to facilitate hotplug
of PHBs.

Since we can't migrate this state to older machine types,
default the option to true and disable it for older machine
types.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
Changes since RFC:
- rebased against ppc-for-2.10
- updated changelog and title
- set default to true and disable for 2.10 and older
---
 hw/ppc/spapr.c         |    6 ++++++
 include/hw/ppc/spapr.h |    3 +++
 2 files changed, 9 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 277daa4f9645..8dc505343c0f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2382,6 +2382,8 @@ static void ppc_spapr_init(MachineState *machine)
     /* We always have at least the nvram device on VIO */
     spapr_create_nvram(spapr);
 
+    spapr->dr_phb_enabled = smc->dr_phb_enabled;
+
     /* Set up PCI */
     spapr_pci_rtas_init();
 
@@ -3482,6 +3484,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
      * in which LMBs are represented and hot-added
      */
     mc->numa_mem_align_shift = 28;
+    smc->dr_phb_enabled = true;
 }
 
 static const TypeInfo spapr_machine_info = {
@@ -3558,8 +3561,11 @@ static void spapr_machine_2_10_instance_options(MachineState *machine)
 
 static void spapr_machine_2_10_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_2_11_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
+    smc->dr_phb_enabled = false;
 }
 
 DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2a303a705c17..8004d9c2ab2c 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -59,6 +59,7 @@ struct sPAPRMachineClass {
 
     /*< public >*/
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
+    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     const char *tcg_default_cpu; /* which (TCG) CPU to simulate by default */
     bool pre_2_10_has_unused_icps;
@@ -122,6 +123,8 @@ struct sPAPRMachineState {
      * occurs during the unplug process. */
     QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
 
+    bool dr_phb_enabled; /* hotplug / dynamic-reconfiguration of PHBs */
+
     /*< public >*/
     char *kvm_type;
     MemoryHotplugState hotplug_memory;
