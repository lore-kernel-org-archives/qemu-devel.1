Received: from eggs.gnu.org ([2001:4830:134:3::10]:45622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYu-00006X-2i
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYp-0004uw-O1
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:35 -0500
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:44267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgYf-0004i5-Us
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:24 -0500
Received: from player714.ha.ovh.net (unknown [10.109.160.251])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id A8568208117
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:26:11 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:49 +0100
Message-Id: <20181205232251.10446-36-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 35/37] spapr: introduce routines to delete
 the KVM IRQ device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

If a new interrupt mode is chosen by CAS, the machine generates a
reset to reconfigure. At this point, the connection with the previous
KVM device needs to be closed and a new connection needs to opened
with the KVM device operating the chosen interrupt mode.

New routines are introduced to destroy the XICS and the XIVE KVM
devices. They make use of a new KVM device ioctl which destroys the
device and also disconnects the IRQ presenters from the vCPUs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h |  1 +
 include/hw/ppc/xics.h       |  1 +
 hw/intc/spapr_xive_kvm.c    | 61 +++++++++++++++++++++++++++++++++++++
 hw/intc/xics_kvm.c          | 57 ++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 735e916d3844..250de7fdc943 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -71,6 +71,7 @@ void spapr_xive_enable_mmio(sPAPRXive *xive, bool enabl=
e);
  * KVM XIVE device helpers
  */
 void kvmppc_xive_connect(sPAPRXive *xive, Error **errp);
+void kvmppc_xive_disconnect(sPAPRXive *xive, Error **errp);
 void kvmppc_xive_synchronize_state(sPAPRXive *xive);
 int kvmppc_xive_pre_save(sPAPRXive *xive);
 int kvmppc_xive_post_load(sPAPRXive *xive, int version_id);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 14afda198cdb..f7e5f8f9b5d7 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -205,6 +205,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
 void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
+int xics_kvm_disconnect(sPAPRMachineState *spapr, Error **errp);
 void xics_spapr_init(sPAPRMachineState *spapr);
=20
 Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 04f997479e8f..dba3344831c6 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -57,6 +57,16 @@ static void kvm_cpu_enable(CPUState *cs)
     QLIST_INSERT_HEAD(&kvm_enabled_cpus, enabled_cpu, node);
 }
=20
+static void kvm_cpu_disable_all(void)
+{
+    KVMEnabledCPU *enabled_cpu, *next;
+
+    QLIST_FOREACH_SAFE(enabled_cpu, &kvm_enabled_cpus, node, next) {
+        QLIST_REMOVE(enabled_cpu, node);
+        g_free(enabled_cpu);
+    }
+}
+
 /*
  * XIVE Thread Interrupt Management context (KVM)
  */
@@ -743,3 +753,54 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **er=
rp)
     /* Map all regions */
     spapr_xive_map_mmio(xive);
 }
+
+void kvmppc_xive_disconnect(sPAPRXive *xive, Error **errp)
+{
+    XiveSource *xsrc;
+    struct kvm_create_device xive_destroy_device =3D { 0 };
+    size_t esb_len;
+    int rc;
+
+    if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
+        error_setg(errp,
+                   "IRQ_XIVE capability must be present for KVM XIVE dev=
ice");
+        return;
+    }
+
+    /* The KVM XIVE device is not in use */
+    if (!xive || xive->fd =3D=3D -1) {
+        return;
+    }
+
+    /* Clear the KVM mapping */
+    xsrc =3D &xive->source;
+    esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
+
+    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 0);
+    munmap(xsrc->esb_mmap, esb_len);
+
+    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 1);
+
+    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 2);
+    munmap(xive->tm_mmap, 4ull << TM_SHIFT);
+
+    /* Destroy the KVM device. This also clears the VCPU presenters */
+    xive_destroy_device.fd =3D xive->fd;
+    xive_destroy_device.type =3D KVM_DEV_TYPE_XIVE;
+    rc =3D kvm_vm_ioctl(kvm_state, KVM_DESTROY_DEVICE, &xive_destroy_dev=
ice);
+    if (rc < 0) {
+        error_setg_errno(errp, -rc, "Error on KVM_DESTROY_DEVICE for XIV=
E");
+    }
+    close(xive->fd);
+    xive->fd =3D -1;
+
+    kvm_kernel_irqchip =3D false;
+    kvm_msi_via_irqfd_allowed =3D false;
+    kvm_gsi_direct_mapping =3D false;
+
+    /* Clear the local list of presenter (hotplug) */
+    kvm_cpu_disable_all();
+
+    /* VM Change state handler is not needed anymore */
+    qemu_del_vm_change_state_handler(xive->change);
+}
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index de86e1d0b1ab..2a60ae71730b 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -50,6 +50,16 @@ typedef struct KVMEnabledICP {
 static QLIST_HEAD(, KVMEnabledICP)
     kvm_enabled_icps =3D QLIST_HEAD_INITIALIZER(&kvm_enabled_icps);
=20
+static void kvm_disable_icps(void)
+{
+    KVMEnabledICP *enabled_icp, *next;
+
+    QLIST_FOREACH_SAFE(enabled_icp, &kvm_enabled_icps, node, next) {
+        QLIST_REMOVE(enabled_icp, node);
+        g_free(enabled_icp);
+    }
+}
+
 /*
  * ICP-KVM
  */
@@ -456,6 +466,53 @@ fail:
     return -1;
 }
=20
+int xics_kvm_disconnect(sPAPRMachineState *spapr, Error **errp)
+{
+    int rc;
+    struct kvm_create_device xics_create_device =3D {
+        .fd =3D kernel_xics_fd,
+        .type =3D KVM_DEV_TYPE_XICS,
+        .flags =3D 0,
+    };
+
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return 0;
+    }
+
+    if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
+        error_setg(errp,
+                   "KVM and IRQ_XICS capability must be present for KVM =
XICS device");
+        return -1;
+    }
+
+    rc =3D kvm_vm_ioctl(kvm_state, KVM_DESTROY_DEVICE, &xics_create_devi=
ce);
+    if (rc < 0) {
+        error_setg_errno(errp, -rc, "Error on KVM_DESTROY_DEVICE for XIC=
S");
+    }
+    close(kernel_xics_fd);
+    kernel_xics_fd =3D -1;
+
+    spapr_rtas_register(RTAS_IBM_SET_XIVE, NULL, 0);
+    spapr_rtas_register(RTAS_IBM_GET_XIVE, NULL, 0);
+    spapr_rtas_register(RTAS_IBM_INT_OFF, NULL, 0);
+    spapr_rtas_register(RTAS_IBM_INT_ON, NULL, 0);
+
+    kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
+    kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
+    kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
+    kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
+
+    kvm_kernel_irqchip =3D false;
+    kvm_msi_via_irqfd_allowed =3D false;
+    kvm_gsi_direct_mapping =3D false;
+
+    /* Clear the presenter from the VCPUs */
+    kvm_disable_icps();
+
+    return rc;
+}
+
 static void xics_kvm_register_types(void)
 {
     type_register_static(&ics_kvm_info);
--=20
2.17.2
