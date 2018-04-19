Received: from eggs.gnu.org ([2001:4830:134:3::10]:58544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xZ-0001gw-2T
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xV-0001HZ-5g
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:45 -0400
Received: from 9.mo7.mail-out.ovh.net ([46.105.60.248]:34541)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98xU-0001GR-Rf
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:41 -0400
Received: from player792.ha.ovh.net (unknown [10.109.108.85])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 61D6BA2969
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:46:39 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:26 +0200
Message-Id: <20180419124331.3915-31-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 30/35] spapr/xive,
 xics: reset KVM at machine reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The interrupt controller KVM device needs to be destroyed and then
recreated accordingly with the interrupt mode negociated at CAS time.
A new KVM_DESTROY_DEVICE is required for this purpose along with the
necessary support in Linux/KVM.

This won't work without the vpcus being first disconnected from the
KVM device.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_kvm.c    | 39 +++++++++++++++++++++++++++++++++++++++
 hw/intc/xics_kvm.c          | 38 ++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr.c              | 38 +++++++++++++++++++++++++++-----------
 hw/ppc/spapr_rtas.c         |  2 --
 include/hw/ppc/spapr_xive.h |  1 +
 include/hw/ppc/xics.h       |  1 +
 linux-headers/linux/kvm.h   |  2 ++
 7 files changed, 108 insertions(+), 13 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index e3851991653e..be7c9d1fe0aa 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -614,3 +614,42 @@ void xive_kvm_init(sPAPRXive *xive, Error **errp)
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
 }
+
+int xive_kvm_fini(sPAPRXive *xive, Error **errp)
+{
+    int rc;
+    XiveSource *xsrc =3D &xive->source;;
+    struct kvm_create_device xive_destroy_device =3D {
+        .fd =3D kernel_xive_fd,
+        .type =3D KVM_DEV_TYPE_XIVE,
+        .flags =3D 0,
+    };
+
+    if (kernel_xive_fd =3D=3D -1) {
+        return 0;
+    }
+
+    if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
+        error_setg(errp,
+                   "KVM and IRQ_XIVE capability must be present for KVM =
XIVE device");
+        return -1;
+    }
+
+    munmap(xsrc->esb_mmap, (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
+    munmap(xive->tm_mmap_user, 1ull << TM_SHIFT);
+    munmap(xive->tm_mmap_os, 1ull << TM_SHIFT);
+
+    rc =3D kvm_vm_ioctl(kvm_state, KVM_DESTROY_DEVICE, &xive_destroy_dev=
ice);
+    if (rc < 0) {
+        error_setg_errno(errp, -rc, "Error on KVM_DESTROY_DEVICE for XIV=
E");
+    }
+    close(xive->fd);
+    xive->fd =3D -1;
+
+    kernel_xive_fd =3D -1;
+    kvm_kernel_irqchip =3D false;
+    kvm_msi_via_irqfd_allowed =3D false;
+    kvm_gsi_direct_mapping =3D false;
+
+    return 0;
+}
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 62ea4ea150f2..0a1b0a703451 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -518,6 +518,44 @@ fail:
     return -1;
 }
=20
+int xics_kvm_fini(sPAPRMachineState *spapr, Error **errp)
+{
+    int rc;
+    struct kvm_create_device xics_create_device =3D {
+        .fd =3D kernel_xics_fd,
+        .type =3D KVM_DEV_TYPE_XICS,
+        .flags =3D 0,
+    };
+
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
+    kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
+    kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
+    kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
+    kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
+
+    kvm_kernel_irqchip =3D false;
+    kvm_msi_via_irqfd_allowed =3D false;
+    kvm_gsi_direct_mapping =3D false;
+
+    return rc;
+}
+
 static void xics_kvm_register_types(void)
 {
     type_register_static(&ics_kvm_info);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c98ceeed9d6f..dea636f9befe 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1048,9 +1048,8 @@ static void spapr_dt_ov5_platform_support(sPAPRMach=
ineState *spapr, void *fdt,
         } else {
             val[3] =3D 0x00; /* Hash */
         }
-        /* TODO: when under KVM, only advertise XIVE but not both mode *=
/
         if (spapr->xive_exploitation && kvmppc_has_cap_xive()) {
-            val[1] =3D 0x40; /* OV5_XIVE_EXPLOIT */
+            val[1] =3D 0x80; /* OV5_XIVE_BOTH */
         }
     } else {
         if (spapr->xive_exploitation) {
@@ -1536,6 +1535,7 @@ static int spapr_reset_drcs(Object *child, void *op=
aque)
 /* Setup XIVE exploitation or legacy mode as required by CAS */
 static void spapr_reset_interrupt(sPAPRMachineState *spapr, Error **errp=
)
 {
+    MachineState *machine =3D MACHINE(spapr);
     Error *local_err =3D NULL;
     const char *intc_type;
=20
@@ -1551,13 +1551,38 @@ static void spapr_reset_interrupt(sPAPRMachineSta=
te *spapr, Error **errp)
         return;
     }
=20
+    /* Destroy KVM device */
+    if (kvm_enabled()) {
+        xics_kvm_fini(spapr, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+        xive_kvm_fini(spapr->xive, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
     if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+            xive_kvm_init(spapr->xive, &local_err);
+        }
         spapr_xive_mmio_map(spapr->xive);
         intc_type =3D spapr->nvt_type;
     } else {
+        if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
+            xics_kvm_init(spapr, &local_err);
+        }
         intc_type =3D spapr->icp_type;
     }
=20
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     spapr_cpu_core_set_icp(intc_type, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2583,15 +2608,6 @@ static void spapr_machine_init(MachineState *machi=
ne)
         /* XIVE uses the full range of IRQ numbers. */
         xive_system_init(machine, XICS_IRQ_BASE + XICS_IRQS_SPAPR,
                          &error_fatal);
-
-        /* TODO: initialize KVM for XIVE or for XICS but not for both */
-        if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
-            xive_kvm_init(spapr->xive, &error_fatal);
-        }
-    } else {
-        if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
-            xics_kvm_init(spapr, &error_fatal);
-        }
     }
=20
     /* Set up containers for ibm,client-architecture-support negotiated =
options
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 0ec5fa4cfe43..9a3d42486e50 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -404,8 +404,6 @@ void spapr_rtas_register(int token, const char *name,=
 spapr_rtas_fn fn)
=20
     token -=3D RTAS_TOKEN_BASE;
=20
-    assert(!rtas_table[token].name);
-
     rtas_table[token].name =3D name;
     rtas_table[token].fn =3D fn;
 }
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 75b790cc9730..1a28ab0de46d 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -88,5 +88,6 @@ void spapr_dt_xive(sPAPRMachineState *spapr, int nr_ser=
vers, void *fdt,
     OBJECT_CHECK(XiveNVT, (obj), TYPE_XIVE_NVT_KVM)
=20
 void xive_kvm_init(sPAPRXive *xive, Error **errp);
+int xive_kvm_fini(sPAPRXive *xive, Error **errp);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 6cebff47a7d4..dc2b1bf7ac44 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -204,6 +204,7 @@ void icp_resend(ICPState *ss);
=20
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
+int xics_kvm_fini(sPAPRMachineState *spapr, Error **errp);
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
 void xics_spapr_init(sPAPRMachineState *spapr);
=20
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 2c20d34f194b..8864b855c08b 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1279,6 +1279,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
=20
+#define KVM_DESTROY_DEVICE	  _IOWR(KVMIO,  0xf0, struct kvm_create_devic=
e)
+
 /*
  * ioctls for vcpu fds
  */
--=20
2.13.6
