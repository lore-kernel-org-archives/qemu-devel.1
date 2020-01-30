Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51178C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F341206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyeeVjt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F341206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCb8-0000gh-6l
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTt-0005UT-EY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTr-0002vP-Gx
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50371)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTr-0002ud-9N
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:47 -0500
Received: by mail-wm1-x32d.google.com with SMTP id a5so4413202wmb.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=A81TgHlTRnZzsDa1BQNvoi2SngiMSAXN7zM53gp6FB8=;
 b=iyeeVjt1Dm9PWBU5eaoG33RIezUAXBTi6+5yjfBS3rbBJ/1UwXCXZ9ng8L3kCav5UY
 lleHi+WaCbJH9O2KBKTnSjSv5tCVZ1ErHS3FnefVqGfFyFQ8Zioy2/MTeWGzV4ySucpF
 SmN9OraPm0Ci1r3FhRt4wnJAwVJK+3Ed8deRBFvhqgWll/xzOaz9LwN7/94n7esvvdYV
 m8/mgLWIDbDV0b9BrmSiUTMDaIObUnbb1m+ExVqNPmDhU+iWE9/pOwYEjY2J4Qip1PNE
 gQH2+kaPhjN9j90DqJyo4yrBZhnV8ClDIMCod69juoQReVYZRziiXffsYFcCKI3lZj4d
 v1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A81TgHlTRnZzsDa1BQNvoi2SngiMSAXN7zM53gp6FB8=;
 b=kzbg+5ybIdEqZ52Qg51ODsMOpddg6h3DXB713HAhXuV/qehS22iWVlSNq9AUbyN/Lp
 Gu0nZg904WGIgi3kuEXLkzoWWlKegsq1AOsyWQTgzGNLwlO/vyOL3XpEwhKdV7HE8Kyj
 JZ2VFO23nP6rbWtDCXjVWJpEpMCoZipZE/Y1ivhNetkGhInfENGVPCLrBsQJIbVUljwS
 yU0lfiF8+Y9jKcoGdAz1qqZgwV4fvJWdjCJTrLcjTEhkkrqvmF9lo0kVH9ZCxEz7tosr
 R6+d0SLI8C7sFqWAQXfE7XbxhBJjzIFxJf29JMsC1tYb9+xdgg3Tf/emC4MKEgTC/xrZ
 m5Wg==
X-Gm-Message-State: APjAAAVLdqfnYt7g+1dAY6PYz+i1OedQraNEzDqRIigD+id0hELGaW1d
 DSeLRUJJh3+x9J8mhlaJnEp0ddgpD9Ecqg==
X-Google-Smtp-Source: APXvYqznvuUyI8DACptTpRPkxbvM4Mb7vF0yCBcGp6Vs8pp7JzSb0tSXt4Ph3RxyGIct1uQ96jfo8A==
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr6782165wmf.56.1580400945819; 
 Thu, 30 Jan 2020 08:15:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/26] add device_legacy_reset function to prepare for reset
 api change
Date: Thu, 30 Jan 2020 16:15:16 +0000
Message-Id: <20200130161533.8180-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Damien Hedde <damien.hedde@greensocs.com>

Provide a temporary device_legacy_reset function doing what
device_reset does to prepare for the transition with Resettable
API.

All occurrence of device_reset in the code tree are also replaced
by device_legacy_reset.

The new resettable API has different prototype and semantics
(resetting child buses as well as the specified device). Subsequent
commits will make the changeover for each call site individually; once
that is complete device_legacy_reset() will be removed.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200123132823.1117486-2-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/qdev-core.h   | 4 ++--
 hw/audio/intel-hda.c     | 2 +-
 hw/core/qdev.c           | 6 +++---
 hw/hyperv/hyperv.c       | 2 +-
 hw/i386/microvm.c        | 2 +-
 hw/i386/pc.c             | 2 +-
 hw/ide/microdrive.c      | 8 ++++----
 hw/intc/spapr_xive.c     | 2 +-
 hw/ppc/pnv_psi.c         | 4 ++--
 hw/ppc/spapr_pci.c       | 2 +-
 hw/ppc/spapr_vio.c       | 2 +-
 hw/s390x/s390-pci-inst.c | 2 +-
 hw/scsi/vmw_pvscsi.c     | 2 +-
 hw/sd/omap_mmc.c         | 2 +-
 hw/sd/pl181.c            | 2 +-
 15 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5da94f872a8..627d653dc16 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -432,11 +432,11 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
 void qdev_machine_init(void);
 
 /**
- * @device_reset
+ * device_legacy_reset:
  *
  * Reset a single device (by calling the reset method).
  */
-void device_reset(DeviceState *dev);
+void device_legacy_reset(DeviceState *dev);
 
 void device_class_set_props(DeviceClass *dc, Property *props);
 
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index e96a707ac50..1bcc3e5cf80 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1087,7 +1087,7 @@ static void intel_hda_reset(DeviceState *dev)
     QTAILQ_FOREACH(kid, &d->codecs.qbus.children, sibling) {
         DeviceState *qdev = kid->child;
         cdev = HDA_CODEC_DEVICE(qdev);
-        device_reset(DEVICE(cdev));
+        device_legacy_reset(DEVICE(cdev));
         d->state_sts |= (1 << cdev->cad);
     }
     intel_hda_update_irq(d);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 05c31df52d7..00230eecb77 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -298,7 +298,7 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
 
 static int qdev_reset_one(DeviceState *dev, void *opaque)
 {
-    device_reset(dev);
+    device_legacy_reset(dev);
 
     return 0;
 }
@@ -867,7 +867,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             }
         }
         if (dev->hotplugged) {
-            device_reset(dev);
+            device_legacy_reset(dev);
         }
         dev->pending_deleted_event = false;
 
@@ -1101,7 +1101,7 @@ void device_class_set_parent_unrealize(DeviceClass *dc,
     dc->unrealize = dev_unrealize;
 }
 
-void device_reset(DeviceState *dev)
+void device_legacy_reset(DeviceState *dev)
 {
     DeviceClass *klass = DEVICE_GET_CLASS(dev);
 
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index da8ce82725c..8ca3706f5b0 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -140,7 +140,7 @@ void hyperv_synic_reset(CPUState *cs)
     SynICState *synic = get_synic(cs);
 
     if (synic) {
-        device_reset(DEVICE(synic));
+        device_legacy_reset(DEVICE(synic));
     }
 }
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 827ce29e58f..d23485108d9 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -370,7 +370,7 @@ static void microvm_machine_reset(MachineState *machine)
         cpu = X86_CPU(cs);
 
         if (cpu->apic_state) {
-            device_reset(cpu->apic_state);
+            device_legacy_reset(cpu->apic_state);
         }
     }
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a6302a772d1..2ddce4230a8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1879,7 +1879,7 @@ static void pc_machine_reset(MachineState *machine)
         cpu = X86_CPU(cs);
 
         if (cpu->apic_state) {
-            device_reset(cpu->apic_state);
+            device_legacy_reset(cpu->apic_state);
         }
     }
 }
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index b0272ea14b3..6b30e36ed83 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -173,7 +173,7 @@ static void md_attr_write(PCMCIACardState *card, uint32_t at, uint8_t value)
     case 0x00:	/* Configuration Option Register */
         s->opt = value & 0xcf;
         if (value & OPT_SRESET) {
-            device_reset(DEVICE(s));
+            device_legacy_reset(DEVICE(s));
         }
         md_interrupt_update(s);
         break;
@@ -316,7 +316,7 @@ static void md_common_write(PCMCIACardState *card, uint32_t at, uint16_t value)
     case 0xe:	/* Device Control */
         s->ctrl = value;
         if (value & CTRL_SRST) {
-            device_reset(DEVICE(s));
+            device_legacy_reset(DEVICE(s));
         }
         md_interrupt_update(s);
         break;
@@ -541,7 +541,7 @@ static int dscm1xxxx_attach(PCMCIACardState *card)
     md->attr_base = pcc->cis[0x74] | (pcc->cis[0x76] << 8);
     md->io_base = 0x0;
 
-    device_reset(DEVICE(md));
+    device_legacy_reset(DEVICE(md));
     md_interrupt_update(md);
 
     return 0;
@@ -551,7 +551,7 @@ static int dscm1xxxx_detach(PCMCIACardState *card)
 {
     MicroDriveState *md = MICRODRIVE(card);
 
-    device_reset(DEVICE(md));
+    device_legacy_reset(DEVICE(md));
     return 0;
 }
 
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 024b8ce2852..20c8155557d 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1766,7 +1766,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
-    device_reset(DEVICE(xive));
+    device_legacy_reset(DEVICE(xive));
 
     if (kvm_irqchip_in_kernel()) {
         Error *local_err = NULL;
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 6baf9503a1c..c34a49b000f 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -466,7 +466,7 @@ static void pnv_psi_reset(DeviceState *dev)
 
 static void pnv_psi_reset_handler(void *dev)
 {
-    device_reset(DEVICE(dev));
+    device_legacy_reset(DEVICE(dev));
 }
 
 static void pnv_psi_realize(DeviceState *dev, Error **errp)
@@ -715,7 +715,7 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
         break;
     case PSIHB9_INTERRUPT_CONTROL:
         if (val & PSIHB9_IRQ_RESET) {
-            device_reset(DEVICE(&psi9->source));
+            device_legacy_reset(DEVICE(&psi9->source));
         }
         psi->regs[reg] = val;
         break;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index e82bfc5ca7c..709a52780dd 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2014,7 +2014,7 @@ static int spapr_phb_children_reset(Object *child, void *opaque)
     DeviceState *dev = (DeviceState *) object_dynamic_cast(child, TYPE_DEVICE);
 
     if (dev) {
-        device_reset(dev);
+        device_legacy_reset(dev);
     }
 
     return 0;
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 554de9930dc..f14944e9007 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -304,7 +304,7 @@ int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *crq)
 static void spapr_vio_quiesce_one(SpaprVioDevice *dev)
 {
     if (dev->tcet) {
-        device_reset(DEVICE(dev->tcet));
+        device_legacy_reset(DEVICE(dev->tcet));
     }
     free_crq(dev);
 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 92c7e45df5f..2f7a7d7bd1b 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -243,7 +243,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
                 stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FHOP);
                 goto out;
             }
-            device_reset(DEVICE(pbdev));
+            device_legacy_reset(DEVICE(pbdev));
             pbdev->fh &= ~FH_MASK_ENABLE;
             pbdev->state = ZPCI_FS_DISABLED;
             stl_p(&ressetpci->fh, pbdev->fh);
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 8f1aaf9c874..e4ee2e66435 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -838,7 +838,7 @@ pvscsi_on_cmd_reset_device(PVSCSIState *s)
 
     if (sdev != NULL) {
         s->resetting++;
-        device_reset(&sdev->qdev);
+        device_legacy_reset(&sdev->qdev);
         s->resetting--;
         return PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
     }
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index c6e516b6113..4088a8a80bc 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -318,7 +318,7 @@ void omap_mmc_reset(struct omap_mmc_s *host)
      * into any bus, and we must reset it manually. When omap_mmc is
      * QOMified this must move into the QOM reset function.
      */
-    device_reset(DEVICE(host->card));
+    device_legacy_reset(DEVICE(host->card));
 }
 
 static uint64_t omap_mmc_read(void *opaque, hwaddr offset,
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 8033fe455d8..2b3776a6a0f 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -482,7 +482,7 @@ static void pl181_reset(DeviceState *d)
     /* Since we're still using the legacy SD API the card is not plugged
      * into any bus, and we must reset it manually.
      */
-    device_reset(DEVICE(s->card));
+    device_legacy_reset(DEVICE(s->card));
 }
 
 static void pl181_init(Object *obj)
-- 
2.20.1


