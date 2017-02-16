Received: from eggs.gnu.org ([2001:4830:134:3::10]:40063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMSB-0003FE-JZ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMS7-0006H1-5m
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:50:35 -0500
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:60593)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMS6-0006GJ-VD
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:50:31 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id AA86F241C0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:50:29 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:44 +0100
Message-Id: <1487252865-12064-22-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 21/22] ppc/xics: export the XICS init
 routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

There is nothing left related to the XICS object in the realize
functions of the KVMXICSState and XICSState class. So adapt the
interfaces to call these routines directly from the sPAPR machine init
sequence.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_kvm.c    | 13 +++----------
 hw/intc/xics_spapr.c  | 11 ++---------
 hw/ppc/spapr.c        |  4 +++-
 include/hw/ppc/xics.h |  5 +++++
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 7c1809873c29..4ea34ea6dac5 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -363,7 +363,7 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineS=
tate *spapr,
                  __func__);
 }
=20
-static void xics_kvm_realize(DeviceState *dev, Error **errp)
+int xics_kvm_init(sPAPRMachineState *spapr, Error **errp)
 {
     int rc;
     struct kvm_create_device xics_create_device =3D {
@@ -419,27 +419,20 @@ static void xics_kvm_realize(DeviceState *dev, Erro=
r **errp)
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
=20
-    return;
+    return rc;
=20
 fail:
     kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
     kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
     kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
     kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
-}
-
-static void xics_kvm_class_init(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(oc);
-
-    dc->realize =3D xics_kvm_realize;
+    return -1;
 }
=20
 static const TypeInfo xics_spapr_kvm_info =3D {
     .name          =3D TYPE_XICS_SPAPR_KVM,
     .parent        =3D TYPE_XICS_COMMON,
     .instance_size =3D sizeof(KVMXICSState),
-    .class_init    =3D xics_kvm_class_init,
 };
=20
 static void xics_kvm_register_types(void)
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index cb6325ee64fd..5c1ddee1e8e9 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -240,7 +240,7 @@ static void rtas_int_on(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-static void xics_spapr_realize(DeviceState *dev, Error **errp)
+int xics_spapr_init(sPAPRMachineState *spapr, Error **errp)
 {
     /* Registration of global state belongs into realize */
     spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive=
);
@@ -254,13 +254,7 @@ static void xics_spapr_realize(DeviceState *dev, Err=
or **errp)
     spapr_register_hypercall(H_XIRR_X, h_xirr_x);
     spapr_register_hypercall(H_EOI, h_eoi);
     spapr_register_hypercall(H_IPOLL, h_ipoll);
-}
-
-static void xics_spapr_class_init(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(oc);
-
-    dc->realize =3D xics_spapr_realize;
+    return 0;
 }
=20
 static const TypeInfo xics_spapr_info =3D {
@@ -268,7 +262,6 @@ static const TypeInfo xics_spapr_info =3D {
     .parent        =3D TYPE_XICS_COMMON,
     .instance_size =3D sizeof(XICSState),
     .class_size =3D sizeof(XICSStateClass),
-    .class_init    =3D xics_spapr_class_init,
 };
=20
 #define ICS_IRQ_FREE(ics, srcno)   \
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 059408a81b8a..2f1b45200813 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -156,7 +156,8 @@ static XICSState *xics_system_init(MachineState *mach=
ine,
     if (kvm_enabled()) {
         Error *err =3D NULL;
=20
-        if (machine_kernel_irqchip_allowed(machine)) {
+        if (machine_kernel_irqchip_allowed(machine) &&
+            !xics_kvm_init(SPAPR_MACHINE(machine), errp)) {
             xics =3D try_create_xics(SPAPR_MACHINE(machine),
                                    TYPE_XICS_SPAPR_KVM, TYPE_ICS_KVM,
                                    TYPE_KVM_ICP, nr_servers, nr_irqs, &e=
rr);
@@ -170,6 +171,7 @@ static XICSState *xics_system_init(MachineState *mach=
ine,
     }
=20
     if (!xics) {
+        xics_spapr_init(SPAPR_MACHINE(machine), errp);
         xics =3D try_create_xics(SPAPR_MACHINE(machine),
                                TYPE_XICS_SPAPR, TYPE_ICS_SIMPLE,
                                TYPE_ICP, nr_servers, nr_irqs, errp);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 20c792fccfc3..bfbc59ad2a05 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -219,4 +219,9 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool =
lsi);
 void ics_resend(ICSState *ics);
 void icp_resend(XICSInterface *xi, ICPState *ss);
=20
+typedef struct sPAPRMachineState sPAPRMachineState;
+
+int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
+int xics_spapr_init(sPAPRMachineState *spapr, Error **errp);
+
 #endif /* XICS_H */
--=20
2.7.4
