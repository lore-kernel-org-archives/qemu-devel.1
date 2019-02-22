Received: from eggs.gnu.org ([209.51.188.92]:40644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxApN-0000qk-2b
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxAeV-0004Oz-0i
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxAeU-0003wv-9S
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:14:06 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1MDBuRx139482
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qtf667sx1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:13:40 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 22 Feb 2019 13:13:37 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 22 Feb 2019 14:13:19 +0100
In-Reply-To: <20190222131322.26079-1-clg@kaod.org>
References: <20190222131322.26079-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190222131322.26079-11-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/13] spapr: introduce routines to delete
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
 include/hw/ppc/xics_spapr.h |  1 +
 hw/intc/spapr_xive_kvm.c    | 60 +++++++++++++++++++++++++++++++++++++
 hw/intc/xics_kvm.c          | 56 ++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 22d70650b51f..a7c4c275a747 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -71,6 +71,7 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint32_t =
end_idx,
  * KVM XIVE device helpers
  */
 void kvmppc_xive_connect(sPAPRXive *xive, Error **errp);
+void kvmppc_xive_disconnect(sPAPRXive *xive, Error **errp);
 void kvmppc_xive_reset(sPAPRXive *xive, Error **errp);
 void kvmppc_xive_set_source_config(sPAPRXive *xive, uint32_t lisn, XiveE=
AS *eas,
                                    Error **errp);
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index b8d924baf437..bddf09821cb0 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -34,6 +34,7 @@
 void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
+int xics_kvm_disconnect(sPAPRMachineState *spapr, Error **errp);
 void xics_spapr_init(sPAPRMachineState *spapr);
=20
 #endif /* XICS_SPAPR_H */
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 119fd59fc9ae..e31035c90260 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -58,6 +58,16 @@ static void kvm_cpu_enable(CPUState *cs)
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
@@ -674,3 +684,53 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error **er=
rp)
     /* Map all regions */
     spapr_xive_map_mmio(xive);
 }
+
+void kvmppc_xive_disconnect(sPAPRXive *xive, Error **errp)
+{
+    XiveSource *xsrc;
+    struct kvm_destroy_device xive_destroy_device;
+    size_t esb_len;
+    int rc;
+
+    /* The KVM XIVE device is not in use */
+    if (!xive || xive->fd =3D=3D -1) {
+        return;
+    }
+
+    if (!kvmppc_has_cap_xive()) {
+        error_setg(errp, "IRQ_XIVE capability must be present for KVM");
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
+    xive_destroy_device.flags =3D 0;
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
index c6e1b630a404..373de3155f6b 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -51,6 +51,16 @@ typedef struct KVMEnabledICP {
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
@@ -360,3 +370,49 @@ fail:
     kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
     return -1;
 }
+
+int xics_kvm_disconnect(sPAPRMachineState *spapr, Error **errp)
+{
+    int rc;
+    struct kvm_destroy_device xics_destroy_device =3D {
+        .fd =3D kernel_xics_fd,
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
+    rc =3D kvm_vm_ioctl(kvm_state, KVM_DESTROY_DEVICE, &xics_destroy_dev=
ice);
+    if (rc < 0) {
+        error_setg_errno(errp, -rc, "Error on KVM_DESTROY_DEVICE for XIC=
S");
+    }
+    close(kernel_xics_fd);
+    kernel_xics_fd =3D -1;
+
+    spapr_rtas_unregister(RTAS_IBM_SET_XIVE);
+    spapr_rtas_unregister(RTAS_IBM_GET_XIVE);
+    spapr_rtas_unregister(RTAS_IBM_INT_OFF);
+    spapr_rtas_unregister(RTAS_IBM_INT_ON);
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
--=20
2.20.1
