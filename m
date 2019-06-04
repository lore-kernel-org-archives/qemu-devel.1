Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4BCC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9E523CA1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="EHffHrqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9E523CA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCLx-0005ll-72
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:32:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCFx-0000Zq-Df
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCFv-0003a4-7o
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:49 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hYCFr-0003TS-59; Tue, 04 Jun 2019 12:25:43 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.17.10.6])
	by beetle.greensocs.com (Postfix) with ESMTPSA id 9831296F5B;
	Tue,  4 Jun 2019 16:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1559665542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=YYxCAcFY2f8T7dY7vwkEpubeXgbDt8PO/wb4DbcDzk8=;
	b=EHffHrquEFGV8MLehGdJ56kI3+VIXA79OJVSDruYKa/2PKN+LbOKDqavaWQ5TW44/8EWze
	TF7C81ZmWXWJuBmX+Q5TQsYH+2K+EJ6T8e+bK/01tHvaLTL0vXeVXKRsyCRhfpljtqjRCy
	ILKkerL1QqWNIEefJ/hWT3YwlFzwevw=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 18:25:17 +0200
Message-Id: <20190604162526.10655-4-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604162526.10655-1-damien.hedde@greensocs.com>
References: <20190604162526.10655-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1559665542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=YYxCAcFY2f8T7dY7vwkEpubeXgbDt8PO/wb4DbcDzk8=;
	b=o0yfScJQteo+Al3vaVVlZXA0yuwmiRY8t46mdtMzXO1IyVoxVu+niL1v84LgMg8Hzf9ihL
	UB8luMrQ+Igk4Tz4PaSOX+iD1Ak4rpxCgWwz3cCvVvOjFwYhzLurk8JFWa9xYjY+Tb2BN8
	cQsFOUYSVH+aB7P+9FPbbEtB97zSaM0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1559665542; a=rsa-sha256; cv=none;
	b=iZJaKr1BlrXl88dJRnjqkz2RkJxS+odpVr41md+F5F/gWNyTxUV+uB/9L5tFFAlrqdlHug
	oGvtYjruhR1gEVTE2ZrjGq9/M2HYq6vze1wQrtAE3cOW/S5gM3vfD26THbvZhTe2qv8MAA
	oHAy3qzcQfPD1wTjYevFb34G6UZzqpA=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH v2 03/12] replace all occurences of
 device_reset by device_legacy_reset
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org,
	marc.burton@greensocs.com, alistair@alistair23.me,
	qemu-arm@nongnu.org, Damien Hedde <damien.hedde@greensocs.com>,
	marcandre.lureau@redhat.com, pbonzini@redhat.com,
	philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/audio/intel-hda.c     | 2 +-
 hw/hyperv/hyperv.c       | 2 +-
 hw/i386/pc.c             | 2 +-
 hw/ide/microdrive.c      | 8 ++++----
 hw/intc/spapr_xive.c     | 2 +-
 hw/ppc/pnv_psi.c         | 2 +-
 hw/ppc/spapr_pci.c       | 2 +-
 hw/ppc/spapr_vio.c       | 2 +-
 hw/s390x/s390-pci-inst.c | 2 +-
 hw/scsi/vmw_pvscsi.c     | 2 +-
 hw/sd/omap_mmc.c         | 2 +-
 hw/sd/pl181.c            | 2 +-
 12 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 33e333cc26..c674b9c0bb 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1085,7 +1085,7 @@ static void intel_hda_reset(DeviceState *dev)
     QTAILQ_FOREACH(kid, &d->codecs.qbus.children, sibling) {
         DeviceState *qdev =3D kid->child;
         cdev =3D HDA_CODEC_DEVICE(qdev);
-        device_reset(DEVICE(cdev));
+        device_legacy_reset(DEVICE(cdev));
         d->state_sts |=3D (1 << cdev->cad);
     }
     intel_hda_update_irq(d);
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 8758635227..ec57417a3d 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -139,7 +139,7 @@ void hyperv_synic_reset(CPUState *cs)
     SynICState *synic =3D get_synic(cs);
=20
     if (synic) {
-        device_reset(DEVICE(synic));
+        device_legacy_reset(DEVICE(synic));
     }
 }
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index edc240bcbf..c6d72c9a5d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2634,7 +2634,7 @@ static void pc_machine_reset(void)
         cpu =3D X86_CPU(cs);
=20
         if (cpu->apic_state) {
-            device_reset(cpu->apic_state);
+            device_legacy_reset(cpu->apic_state);
         }
     }
 }
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index 34bb98dce8..b1350eb54f 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -171,7 +171,7 @@ static void md_attr_write(PCMCIACardState *card, uint=
32_t at, uint8_t value)
     case 0x00:	/* Configuration Option Register */
         s->opt =3D value & 0xcf;
         if (value & OPT_SRESET) {
-            device_reset(DEVICE(s));
+            device_legacy_reset(DEVICE(s));
         }
         md_interrupt_update(s);
         break;
@@ -314,7 +314,7 @@ static void md_common_write(PCMCIACardState *card, ui=
nt32_t at, uint16_t value)
     case 0xe:	/* Device Control */
         s->ctrl =3D value;
         if (value & CTRL_SRST) {
-            device_reset(DEVICE(s));
+            device_legacy_reset(DEVICE(s));
         }
         md_interrupt_update(s);
         break;
@@ -539,7 +539,7 @@ static int dscm1xxxx_attach(PCMCIACardState *card)
     md->attr_base =3D pcc->cis[0x74] | (pcc->cis[0x76] << 8);
     md->io_base =3D 0x0;
=20
-    device_reset(DEVICE(md));
+    device_legacy_reset(DEVICE(md));
     md_interrupt_update(md);
=20
     return 0;
@@ -549,7 +549,7 @@ static int dscm1xxxx_detach(PCMCIACardState *card)
 {
     MicroDriveState *md =3D MICRODRIVE(card);
=20
-    device_reset(DEVICE(md));
+    device_legacy_reset(DEVICE(md));
     return 0;
 }
=20
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 62e0ef8fa5..bea4582f33 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1528,7 +1528,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
=20
-    device_reset(DEVICE(xive));
+    device_legacy_reset(DEVICE(xive));
=20
     if (kvm_irqchip_in_kernel()) {
         Error *local_err =3D NULL;
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5345c8389e..d79c8c62be 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -702,7 +702,7 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwadd=
r addr,
         break;
     case PSIHB9_INTERRUPT_CONTROL:
         if (val & PSIHB9_IRQ_RESET) {
-            device_reset(DEVICE(&psi9->source));
+            device_legacy_reset(DEVICE(&psi9->source));
         }
         psi->regs[reg] =3D val;
         break;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 97961b0128..d89290ac28 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1858,7 +1858,7 @@ static int spapr_phb_children_reset(Object *child, =
void *opaque)
     DeviceState *dev =3D (DeviceState *) object_dynamic_cast(child, TYPE=
_DEVICE);
=20
     if (dev) {
-        device_reset(dev);
+        device_legacy_reset(dev);
     }
=20
     return 0;
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 583c13deda..5a0b5cc35c 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -306,7 +306,7 @@ int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *=
crq)
 static void spapr_vio_quiesce_one(SpaprVioDevice *dev)
 {
     if (dev->tcet) {
-        device_reset(DEVICE(dev->tcet));
+        device_legacy_reset(DEVICE(dev->tcet));
     }
     free_crq(dev);
 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index be2896232d..d532597566 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -243,7 +243,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintpt=
r_t ra)
                 stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FHOP);
                 goto out;
             }
-            device_reset(DEVICE(pbdev));
+            device_legacy_reset(DEVICE(pbdev));
             pbdev->fh &=3D ~FH_MASK_ENABLE;
             pbdev->state =3D ZPCI_FS_DISABLED;
             stl_p(&ressetpci->fh, pbdev->fh);
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 584b4be07e..7ad3d05b9b 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -834,7 +834,7 @@ pvscsi_on_cmd_reset_device(PVSCSIState *s)
=20
     if (sdev !=3D NULL) {
         s->resetting++;
-        device_reset(&sdev->qdev);
+        device_legacy_reset(&sdev->qdev);
         s->resetting--;
         return PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
     }
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index d0c98ca021..24a1edc149 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -317,7 +317,7 @@ void omap_mmc_reset(struct omap_mmc_s *host)
      * into any bus, and we must reset it manually. When omap_mmc is
      * QOMified this must move into the QOM reset function.
      */
-    device_reset(DEVICE(host->card));
+    device_legacy_reset(DEVICE(host->card));
 }
=20
 static uint64_t omap_mmc_read(void *opaque, hwaddr offset,
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 3ad7e925c5..03f859ec33 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -479,7 +479,7 @@ static void pl181_reset(DeviceState *d)
     /* Since we're still using the legacy SD API the card is not plugged
      * into any bus, and we must reset it manually.
      */
-    device_reset(DEVICE(s->card));
+    device_legacy_reset(DEVICE(s->card));
 }
=20
 static void pl181_init(Object *obj)
--=20
2.21.0


