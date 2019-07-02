Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBBEC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AAC216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gwLAPqW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AAC216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCKX-00075e-0u
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58709)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzB-0005Gn-S1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzA-0003CR-CC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:49 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41831 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBz9-0002yz-Ma; Tue, 02 Jul 2019 02:09:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMl3Hdzz9sPw; Tue,  2 Jul 2019 16:09:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047747;
 bh=WE+XZ+26HGNIoIBJq5Wk8U+KSmTzN3ZWD4Y6XtP1yy4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gwLAPqW/HcUY3d3F3oyV0I1JPOj2tMQOnmuAm8DEhDkJHkOKNPW1+SfbsNwPspp3H
 E4QIBscDLTLjWRw5aDfd4RErThjbkzIzW9+C2Wu9JvQyFLMwPeZ8mdyLdHlAHxq33U
 /Q/jzhLjpp/kIHxFYiKb4FWcGUD6Kw25+0JSYKic=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:51 +1000
Message-Id: <20190702060857.3926-44-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 43/49] spapr/xive: rework the mapping the KVM
 memory regions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Today, the interrupt device is fully initialized at reset when the CAS
negotiation process has completed. Depending on the KVM capabilities,
the SpaprXive memory regions (ESB, TIMA) are initialized with a host
MMIO backend or a QEMU emulated backend. This results in a complex
initialization sequence partially done at realize and later at reset,
and some memory region leaks.

To simplify this sequence and to remove of the late initialization of
the emulated device which is required to be done only once, we
introduce new memory regions specific for KVM. These regions are
mapped as overlaps on top of the emulated device to make use of the
host MMIOs. Also provide proper cleanups of these regions when the
XIVE KVM device is destroyed to fix the leaks.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190614165920.12670-2-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        | 38 ++++++++++---------------------------
 hw/intc/spapr_xive_kvm.c    | 21 +++++++++++---------
 hw/ppc/spapr_irq.c          |  1 -
 include/hw/ppc/spapr_xive.h |  2 +-
 include/hw/ppc/xive.h       |  1 +
 5 files changed, 24 insertions(+), 39 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 58c2e5d890..3ae311d9ff 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -194,13 +194,6 @@ void spapr_xive_pic_print_info(SpaprXive *xive, Moni=
tor *mon)
     }
 }
=20
-void spapr_xive_map_mmio(SpaprXive *xive)
-{
-    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->vc_base);
-    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->end_base);
-    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
-}
-
 void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable)
 {
     memory_region_set_enabled(&xive->source.esb_mmio, enable);
@@ -305,6 +298,7 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, local_err);
         return;
     }
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
=20
     /*
      * Initialize the END ESB source
@@ -318,6 +312,7 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, local_err);
         return;
     }
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
=20
     /* Set the mapping address of the END ESB pages after the source ESB=
s */
     xive->end_base =3D xive->vc_base + (1ull << xsrc->esb_shift) * xsrc-=
>nr_irqs;
@@ -333,31 +328,18 @@ static void spapr_xive_realize(DeviceState *dev, Er=
ror **errp)
=20
     qemu_register_reset(spapr_xive_reset, dev);
=20
-    /* Define all XIVE MMIO regions on SysBus */
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
-}
-
-void spapr_xive_init(SpaprXive *xive, Error **errp)
-{
-    XiveSource *xsrc =3D &xive->source;
-
-    /*
-     * The emulated XIVE device can only be initialized once. If the
-     * ESB memory region has been already mapped, it means we have been
-     * through there.
-     */
-    if (memory_region_is_mapped(&xsrc->esb_mmio)) {
-        return;
-    }
-
     /* TIMA initialization */
     memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
                           "xive.tima", 4ull << TM_SHIFT);
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
=20
-    /* Map all regions */
-    spapr_xive_map_mmio(xive);
+    /*
+     * Map all regions. These will be enabled or disabled at reset and
+     * can also be overridden by KVM memory regions if active
+     */
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->vc_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->end_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
 }
=20
 static int spapr_xive_get_eas(XiveRouter *xrtr, uint8_t eas_blk,
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index b48f135838..5559f8bce5 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -728,8 +728,10 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **er=
rp)
         return;
     }
=20
-    memory_region_init_ram_device_ptr(&xsrc->esb_mmio, OBJECT(xsrc),
+    memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc),
                                       "xive.esb", esb_len, xsrc->esb_mma=
p);
+    memory_region_add_subregion_overlap(&xsrc->esb_mmio, 0,
+                                        &xsrc->esb_mmio_kvm, 1);
=20
     /*
      * 2. END ESB pages (No KVM support yet)
@@ -744,8 +746,10 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **er=
rp)
         error_propagate(errp, local_err);
         return;
     }
-    memory_region_init_ram_device_ptr(&xive->tm_mmio, OBJECT(xive),
+    memory_region_init_ram_device_ptr(&xive->tm_mmio_kvm, OBJECT(xive),
                                       "xive.tima", tima_len, xive->tm_mm=
ap);
+    memory_region_add_subregion_overlap(&xive->tm_mmio, 0,
+                                        &xive->tm_mmio_kvm, 1);
=20
     xive->change =3D qemu_add_vm_change_state_handler(
         kvmppc_xive_change_state_handler, xive);
@@ -771,9 +775,6 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **err=
p)
     kvm_kernel_irqchip =3D true;
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
-
-    /* Map all regions */
-    spapr_xive_map_mmio(xive);
 }
=20
 void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
@@ -795,13 +796,15 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error =
**errp)
     xsrc =3D &xive->source;
     esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
=20
-    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 0);
+    memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm);
+    object_unparent(OBJECT(&xsrc->esb_mmio_kvm));
     munmap(xsrc->esb_mmap, esb_len);
+    xsrc->esb_mmap =3D NULL;
=20
-    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 1);
-
-    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 2);
+    memory_region_del_subregion(&xive->tm_mmio, &xive->tm_mmio_kvm);
+    object_unparent(OBJECT(&xive->tm_mmio_kvm));
     munmap(xive->tm_mmap, 4ull << TM_SHIFT);
+    xive->tm_mmap =3D NULL;
=20
     /*
      * When the KVM device fd is closed, the KVM device is destroyed
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index b2b01e850d..02bc5e8c3d 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -413,7 +413,6 @@ static const char *spapr_irq_get_nodename_xive(SpaprM=
achineState *spapr)
=20
 static void spapr_irq_init_emu_xive(SpaprMachineState *spapr, Error **er=
rp)
 {
-    spapr_xive_init(spapr->xive, errp);
 }
=20
 static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **er=
rp)
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index b26befcf6b..7197144265 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -42,6 +42,7 @@ typedef struct SpaprXive {
     /* KVM support */
     int           fd;
     void          *tm_mmap;
+    MemoryRegion  tm_mmio_kvm;
     VMChangeStateEntry *change;
 } SpaprXive;
=20
@@ -66,7 +67,6 @@ void spapr_xive_map_mmio(SpaprXive *xive);
=20
 int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
                              uint32_t *out_server, uint8_t *out_prio);
-void spapr_xive_init(SpaprXive *xive, Error **errp);
=20
 /*
  * KVM XIVE device helpers
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index a6ee7e831d..55c53c7417 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -197,6 +197,7 @@ typedef struct XiveSource {
=20
     /* KVM support */
     void            *esb_mmap;
+    MemoryRegion    esb_mmio_kvm;
=20
     XiveNotifier    *xive;
 } XiveSource;
--=20
2.21.0


