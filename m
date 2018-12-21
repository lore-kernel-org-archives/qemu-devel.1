Received: from eggs.gnu.org ([2001:4830:134:3::10]:59693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8o9-0005j3-K6
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8o6-0006t9-Df
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:36:53 -0500
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:54240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ga8o6-0006rg-2U
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:36:50 -0500
Received: from player772.ha.ovh.net (unknown [10.109.159.224])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id BAAF310A80C
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 01:36:48 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 21 Dec 2018 01:36:32 +0100
Message-ID: <154535259259.862554.5658306444032609904.stgit@bahia.lan>
In-Reply-To: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 06/15] spapr: enable PHB hotplug for default
 pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

The 'dr_phb_enabled' field of that class can be set as part of
machine-specific init code. It will be used to conditionally
enable creation of DRC objects and device-tree description to
facilitate hotplug of PHBs.

Since we can't migrate this state to older machine types,
default the option to true and disable it for older machine
types.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |    2 ++
 include/hw/ppc/spapr.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1f17b5d01f4f..621006eaa862 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4011,6 +4011,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_xics;
+    smc->dr_phb_enabled = true;
 }
 
 static const TypeInfo spapr_machine_info = {
@@ -4079,6 +4080,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
     smc->update_dt_enabled = false;
+    smc->dr_phb_enabled = false;
 }
 
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 36033b89d31a..e96deefa30de 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -104,6 +104,7 @@ struct sPAPRMachineClass {
     /*< public >*/
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
+    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     bool pre_2_10_has_unused_icps;
     bool legacy_irq_allocation;
