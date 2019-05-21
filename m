Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50000C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFAC21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KpBFgTBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFAC21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47680 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSydX-0000xJ-29
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 02:52:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyI7-0006gE-Qa
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyI6-0000Bk-Fr
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:30:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hSyI5-0008FH-R7; Tue, 21 May 2019 02:30:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 457Qpl1dYDz9sPP; Tue, 21 May 2019 16:29:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558420175;
	bh=fqUWx+o0fahs3svnKmwnawbbhOdSX72WeDfqhKOGZrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KpBFgTBrsVUZ4DcTy/P3q600Cn8DmI1bD3wRc2uy715lmX4hU31rHZ0/JuD/nsV6V
	XEXIHRdJ6qvaJdIJNvXIG8td2lW437BrwxTNoGno1JpSVywffQQatlqmybktWKXyX4
	1n4UqmvQYHlTWC1QpPYij4mGjk8AXkb66agLPIjE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue, 21 May 2019 16:29:19 +1000
Message-Id: <20190521062924.6930-34-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521062924.6930-1-david@gibson.dropbear.id.au>
References: <20190521062924.6930-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 33/38] spapr: introduce routines to delete the
 KVM IRQ device
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
Cc: lvivier@redhat.com, gkurz@kaod.org, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

If a new interrupt mode is chosen by CAS, the machine generates a
reset to reconfigure. At this point, the connection with the previous
KVM device needs to be closed and a new connection needs to opened
with the KVM device operating the chosen interrupt mode.

New routines are introduced to destroy the XICS and the XIVE KVM
devices. They make use of a new KVM device ioctl which destroys the
device and also disconnects the IRQ presenters from the vCPUs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190513084245.25755-10-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c    | 56 +++++++++++++++++++++++++++++++++++++
 hw/intc/xics_kvm.c          | 51 +++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_xive.h |  1 +
 include/hw/ppc/xics_spapr.h |  1 +
 4 files changed, 109 insertions(+)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 3999e4b7ed..259cd1db95 100644
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
index 78a252e6df..1185846ff1 100644
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
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 04294b0ca2..0b5e972d52 100644
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
index 15a8dcff66..2476b540ed 100644
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
--=20
2.21.0


