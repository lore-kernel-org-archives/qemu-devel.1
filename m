Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F81C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC8E2146F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC8E2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53644 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6ui-0003Gw-Iv
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:06:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6oC-0006kh-Oc
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQ6Yw-0004D8-Kw
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:44:00 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:35599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hQ6Yw-0004CS-FQ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:43:58 -0400
Received: from player778.ha.ovh.net (unknown [10.108.57.18])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id B558F129AEB
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:43:56 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player778.ha.ovh.net (Postfix) with ESMTPSA id 50F5E59C3FDB;
	Mon, 13 May 2019 08:43:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 13 May 2019 10:42:40 +0200
Message-Id: <20190513084245.25755-10-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513084245.25755-1-clg@kaod.org>
References: <20190513084245.25755-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3336041424952462310
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.63.100
Subject: [Qemu-devel] [PATCH v4 09/14] spapr: introduce routines to delete
 the KVM IRQ device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a new interrupt mode is chosen by CAS, the machine generates a
reset to reconfigure. At this point, the connection with the previous
KVM device needs to be closed and a new connection needs to opened
with the KVM device operating the chosen interrupt mode.

New routines are introduced to destroy the XICS and the XIVE KVM
devices. They make use of a new KVM device ioctl which destroys the
device and also disconnects the IRQ presenters from the vCPUs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

 Changes since v3:

 - removed KVM_DESTROY_DEVICE control. KVM device is destroyed when
   the fd is closed.

 include/hw/ppc/spapr_xive.h |  1 +
 include/hw/ppc/xics_spapr.h |  1 +
 hw/intc/spapr_xive_kvm.c    | 56 +++++++++++++++++++++++++++++++++++++
 hw/intc/xics_kvm.c          | 51 +++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 04294b0ca266..0b5e972d52c8 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -71,6 +71,7 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint32_t =
end_idx,
  * KVM XIVE device helpers
  */
 void kvmppc_xive_connect(SpaprXive *xive, Error **errp);
+void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp);
 void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
 void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveE=
AS *eas,
                                    Error **errp);
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 15a8dcff66fc..2476b540edfa 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -34,6 +34,7 @@
 void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
 int xics_kvm_init(SpaprMachineState *spapr, Error **errp);
+void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
 void xics_spapr_init(SpaprMachineState *spapr);
=20
 #endif /* XICS_SPAPR_H */
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 3999e4b7edfb..259cd1db9582 100644
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
@@ -709,3 +719,49 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **er=
rp)
     /* Map all regions */
     spapr_xive_map_mmio(xive);
 }
+
+void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
+{
+    XiveSource *xsrc;
+    size_t esb_len;
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
+    /*
+     * When the KVM device fd is closed, the KVM device is destroyed
+     * and removed from the list of devices of the VM. The VCPU
+     * presenters are also detached from the device.
+     */
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
index 78a252e6dfd4..1185846ff183 100644
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
@@ -360,3 +370,44 @@ fail:
     kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
     return -1;
 }
+
+void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp)
+{
+    /* The KVM XICS device is not in use */
+    if (kernel_xics_fd =3D=3D -1) {
+        return;
+    }
+
+    if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XI=
CS)) {
+        error_setg(errp,
+                   "KVM and IRQ_XICS capability must be present for KVM =
XICS device");
+        return;
+    }
+
+    /*
+     * Only on P9 using the XICS-on XIVE KVM device:
+     *
+     * When the KVM device fd is closed, the device is destroyed and
+     * removed from the list of devices of the VM. The VCPU presenters
+     * are also detached from the device.
+     */
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
+}
--=20
2.20.1


