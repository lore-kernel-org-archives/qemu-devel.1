Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D092CC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0112205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="kmHBw+RA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0112205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs79O-00078C-HH
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37717)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77A-000434-Ui
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs778-0004VJ-Po
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:04 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:47954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs771-0004OL-DH; Mon, 29 Jul 2019 10:58:55 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 4A48C96F58;
 Mon, 29 Jul 2019 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=521vOHuLiLvfDSa3Sksi2ob6UnVR8YJSCp06JwJLTaU=;
 b=kmHBw+RAtNw04UI4NzqBlSWif2mJ2QMNKrBVQZKZxdPEHd/GySRl7aY5fm1vY6m9ydge7a
 dRzNpQmu+YgACM4FNeF6JanIIzOwXS82UZ5CvBEnAHctqCrMXVdCejR2J7Dh0thkzEH0jn
 4YIoQoBYetixxxGmarYXVuwYMZUAEsE=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:24 +0200
Message-Id: <20190729145654.14644-4-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=521vOHuLiLvfDSa3Sksi2ob6UnVR8YJSCp06JwJLTaU=;
 b=DC7wLFAol4Z56yrwwN6gsbUsBTSlys015DoWHBzeQpo8egHJ+YxFrRo475mFTmBU4MMlnE
 sDRB9pWHmJatC7ZdGXstgDZ7FqAbB/To9jmIn0PUX3fACeXg/QNmrodsqJfJJmaebOk2r/
 udKyY5/ByWuK3FSu6IIcZPWs60n/QGY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412334; a=rsa-sha256; cv=none;
 b=HTG2kuyPhqAEMWaVoNttaIgRqR1zS5vOCQCktSSq93v9JT/4wg89Qca2EfKcP5wj33kMn4
 N2Kqzq6ThKwF8lgzTopUFBc9iSnKcgru1TF74wx2204dWXHtpyM6wsdwRQz1JuhmtV5k9t
 8EGt10x5LrCdB99J4BhSKUeGCA1Q+wA=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 03/33] Replace all call to device_reset by
 call to device_legacy_reset
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
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
index b78baac295..f133684b10 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1086,7 +1086,7 @@ static void intel_hda_reset(DeviceState *dev)
     QTAILQ_FOREACH(kid, &d->codecs.qbus.children, sibling) {
         DeviceState *qdev =3D kid->child;
         cdev =3D HDA_CODEC_DEVICE(qdev);
-        device_reset(DEVICE(cdev));
+        device_legacy_reset(DEVICE(cdev));
         d->state_sts |=3D (1 << cdev->cad);
     }
     intel_hda_update_irq(d);
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 6ebf31c310..cd9db3cb5c 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -140,7 +140,7 @@ void hyperv_synic_reset(CPUState *cs)
     SynICState *synic =3D get_synic(cs);
=20
     if (synic) {
-        device_reset(DEVICE(synic));
+        device_legacy_reset(DEVICE(synic));
     }
 }
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c437050..c0f20fe8aa 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2823,7 +2823,7 @@ static void pc_machine_reset(MachineState *machine)
         cpu =3D X86_CPU(cs);
=20
         if (cpu->apic_state) {
-            device_reset(cpu->apic_state);
+            device_legacy_reset(cpu->apic_state);
         }
     }
 }
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index 92ee6e0af8..fc346f5ad5 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -173,7 +173,7 @@ static void md_attr_write(PCMCIACardState *card, uint=
32_t at, uint8_t value)
     case 0x00:	/* Configuration Option Register */
         s->opt =3D value & 0xcf;
         if (value & OPT_SRESET) {
-            device_reset(DEVICE(s));
+            device_legacy_reset(DEVICE(s));
         }
         md_interrupt_update(s);
         break;
@@ -316,7 +316,7 @@ static void md_common_write(PCMCIACardState *card, ui=
nt32_t at, uint16_t value)
     case 0xe:	/* Device Control */
         s->ctrl =3D value;
         if (value & CTRL_SRST) {
-            device_reset(DEVICE(s));
+            device_legacy_reset(DEVICE(s));
         }
         md_interrupt_update(s);
         break;
@@ -541,7 +541,7 @@ static int dscm1xxxx_attach(PCMCIACardState *card)
     md->attr_base =3D pcc->cis[0x74] | (pcc->cis[0x76] << 8);
     md->io_base =3D 0x0;
=20
-    device_reset(DEVICE(md));
+    device_legacy_reset(DEVICE(md));
     md_interrupt_update(md);
=20
     return 0;
@@ -551,7 +551,7 @@ static int dscm1xxxx_detach(PCMCIACardState *card)
 {
     MicroDriveState *md =3D MICRODRIVE(card);
=20
-    device_reset(DEVICE(md));
+    device_legacy_reset(DEVICE(md));
     return 0;
 }
=20
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 3ae311d9ff..22e11ad10c 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1511,7 +1511,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
=20
-    device_reset(DEVICE(xive));
+    device_legacy_reset(DEVICE(xive));
=20
     if (kvm_irqchip_in_kernel()) {
         Error *local_err =3D NULL;
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index d7b6f5d75b..78eafa353a 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -703,7 +703,7 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwadd=
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
index 9003fe9010..3c6cf79a5e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2029,7 +2029,7 @@ static int spapr_phb_children_reset(Object *child, =
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
index 00235148be..93cda37c27 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -242,7 +242,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintpt=
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
index 14641df1c8..cda3fc96a0 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -835,7 +835,7 @@ pvscsi_on_cmd_reset_device(PVSCSIState *s)
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
index 81b406dbf0..15b4aaa67f 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -480,7 +480,7 @@ static void pl181_reset(DeviceState *d)
     /* Since we're still using the legacy SD API the card is not plugged
      * into any bus, and we must reset it manually.
      */
-    device_reset(DEVICE(s->card));
+    device_legacy_reset(DEVICE(s->card));
 }
=20
 static void pl181_init(Object *obj)
--=20
2.22.0


