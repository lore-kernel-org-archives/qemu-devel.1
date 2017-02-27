Received: from eggs.gnu.org ([2001:4830:134:3::10]:38459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMKp-0001rB-JN
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMKl-0007xj-LO
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:31 -0500
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:39657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMKl-0007xS-F1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:27 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6BEA39BE0A
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:31:26 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:22 +0100
Message-Id: <1488205773-30436-16-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 15/26] ppc/xics: move kernel_xics_fd out of
 KVMXICSState
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

The kernel ICP file descriptor is the only reason behind the
KVMXICSState class and it's in the way of more cleanups. Let's make it
a static for the moment and move forward.

If this is problem, we could use an attribute under the sPAPR machine
later on.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_kvm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 2d08c4071d3f..86ddf470e546 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -40,6 +40,8 @@
=20
 #include <sys/ioctl.h>
=20
+static int kernel_xics_fd =3D -1;
+
 typedef struct KVMXICSState {
     XICSState parent_obj;
=20
@@ -145,7 +147,6 @@ static const TypeInfo icp_kvm_info =3D {
  */
 static void ics_get_kvm_state(ICSState *ics)
 {
-    KVMXICSState *xicskvm =3D XICS_SPAPR_KVM(ics->xics);
     uint64_t state;
     struct kvm_device_attr attr =3D {
         .flags =3D 0,
@@ -160,7 +161,7 @@ static void ics_get_kvm_state(ICSState *ics)
=20
         attr.attr =3D i + ics->offset;
=20
-        ret =3D ioctl(xicskvm->kernel_xics_fd, KVM_GET_DEVICE_ATTR, &att=
r);
+        ret =3D ioctl(kernel_xics_fd, KVM_GET_DEVICE_ATTR, &attr);
         if (ret !=3D 0) {
             error_report("Unable to retrieve KVM interrupt controller st=
ate"
                     " for IRQ %d: %s", i + ics->offset, strerror(errno))=
;
@@ -204,7 +205,6 @@ static void ics_get_kvm_state(ICSState *ics)
=20
 static int ics_set_kvm_state(ICSState *ics, int version_id)
 {
-    KVMXICSState *xicskvm =3D XICS_SPAPR_KVM(ics->xics);
     uint64_t state;
     struct kvm_device_attr attr =3D {
         .flags =3D 0,
@@ -238,7 +238,7 @@ static int ics_set_kvm_state(ICSState *ics, int versi=
on_id)
             }
         }
=20
-        ret =3D ioctl(xicskvm->kernel_xics_fd, KVM_SET_DEVICE_ATTR, &att=
r);
+        ret =3D ioctl(kernel_xics_fd, KVM_SET_DEVICE_ATTR, &attr);
         if (ret !=3D 0) {
             error_report("Unable to restore KVM interrupt controller sta=
te"
                     " for IRQs %d: %s", i + ics->offset, strerror(errno)=
);
@@ -328,14 +328,13 @@ static void xics_kvm_cpu_setup(XICSState *xics, Pow=
erPCCPU *cpu)
 {
     CPUState *cs;
     ICPState *ss;
-    KVMXICSState *xicskvm =3D XICS_SPAPR_KVM(xics);
     int ret;
=20
     cs =3D CPU(cpu);
     ss =3D &xics->ss[cs->cpu_index];
=20
     assert(cs->cpu_index < xics->nr_servers);
-    if (xicskvm->kernel_xics_fd =3D=3D -1) {
+    if (kernel_xics_fd =3D=3D -1) {
         abort();
     }
=20
@@ -348,7 +347,7 @@ static void xics_kvm_cpu_setup(XICSState *xics, Power=
PCCPU *cpu)
         return;
     }
=20
-    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, xicskvm->kernel=
_xics_fd,
+    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,
                               kvm_arch_vcpu_id(cs));
     if (ret < 0) {
         error_report("Unable to connect CPU%ld to kernel XICS: %s",
@@ -369,7 +368,6 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineS=
tate *spapr,
=20
 static void xics_kvm_realize(DeviceState *dev, Error **errp)
 {
-    KVMXICSState *xicskvm =3D XICS_SPAPR_KVM(dev);
     int rc;
     struct kvm_create_device xics_create_device =3D {
         .type =3D KVM_DEV_TYPE_XICS,
@@ -418,7 +416,7 @@ static void xics_kvm_realize(DeviceState *dev, Error =
**errp)
         goto fail;
     }
=20
-    xicskvm->kernel_xics_fd =3D xics_create_device.fd;
+    kernel_xics_fd =3D xics_create_device.fd;
=20
     kvm_kernel_irqchip =3D true;
     kvm_msi_via_irqfd_allowed =3D true;
--=20
2.7.4
