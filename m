Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BEBC2BC11
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B6320658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVGdX+yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B6320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjqZ-0005ve-Lf
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjoK-0000yC-EM
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:01:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33731
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjoI-0004Ke-2n
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599595302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVOFLhGS1ayfqgVDrW1HUrqH3Kic36OYN3ARbCi2xqQ=;
 b=MVGdX+yuF3jMBa7blopbfgpZDYhJ2+HOWejPcYNmZu9Oi3p3/ZjsaSm/Si5hp6FR8q6ODN
 +Sd3lIkrXI/4cqTM0DN2U3jnmgrHtHXjjMJ4Hmp9+AoDTpM291io/JkDYofII4l2TjCOKb
 uxG61nasAATm6KLlGdMf6U2Rjq9BrPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-y-qVivsaPLy8cFXPgOlTGQ-1; Tue, 08 Sep 2020 16:01:39 -0400
X-MC-Unique: y-qVivsaPLy8cFXPgOlTGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC76E1005E67;
 Tue,  8 Sep 2020 20:01:38 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B234560C17;
 Tue,  8 Sep 2020 20:01:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 11/34] Use DECLARE_*CHECKER* when possible (--force mode)
Date: Tue,  8 Sep 2020 16:01:00 -0400
Message-Id: <20200908200123.3402311-12-ehabkost@redhat.com>
In-Reply-To: <20200908200123.3402311-1-ehabkost@redhat.com>
References: <20200908200123.3402311-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Separate run of the TypeCheckMacro converter using the --force
flag, for the cases where typedefs weren't found in the same
header nor in typedefs.h.

Generated initially using:

 $ ./scripts/codeconverter/converter.py --force -i \
   --pattern=TypeCheckMacro $(git grep -l '' -- '*.[ch]')

Then each case was manually reviewed, and a comment was added
indicating what's unusual about those type checking
macros/functions.  Despite not following the usual pattern, the
changes in this patch were found to be safe.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200831210740.126168-15-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/intc/arm_gic.h       | 9 +++------
 include/hw/intc/arm_gicv3.h     | 8 +++-----
 include/hw/ppc/xics_spapr.h     | 4 +++-
 include/hw/virtio/virtio-mmio.h | 9 +++------
 hw/intc/apic.c                  | 5 +++--
 hw/intc/arm_gic_kvm.c           | 9 +++------
 hw/intc/arm_gicv3_its_kvm.c     | 8 +++-----
 hw/intc/arm_gicv3_kvm.c         | 9 +++------
 hw/sd/allwinner-sdhost.c        | 5 +++--
 hw/sd/bcm2835_sdhost.c          | 5 +++--
 hw/sd/pxa2xx_mmci.c             | 4 +++-
 hw/sd/sdhci.c                   | 4 +++-
 12 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index 704ef2b751..116ccbb5a9 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -74,12 +74,9 @@
 
 #define TYPE_ARM_GIC "arm_gic"
 typedef struct ARMGICClass ARMGICClass;
-#define ARM_GIC(obj) \
-     OBJECT_CHECK(GICState, (obj), TYPE_ARM_GIC)
-#define ARM_GIC_CLASS(klass) \
-     OBJECT_CLASS_CHECK(ARMGICClass, (klass), TYPE_ARM_GIC)
-#define ARM_GIC_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(ARMGICClass, (obj), TYPE_ARM_GIC)
+/* This is reusing the GICState typedef from TYPE_ARM_GIC_COMMON */
+DECLARE_OBJ_CHECKERS(GICState, ARMGICClass,
+                     ARM_GIC, TYPE_ARM_GIC)
 
 struct ARMGICClass {
     /*< private >*/
diff --git a/include/hw/intc/arm_gicv3.h b/include/hw/intc/arm_gicv3.h
index 58e9131a33..a81a6ae7ec 100644
--- a/include/hw/intc/arm_gicv3.h
+++ b/include/hw/intc/arm_gicv3.h
@@ -17,11 +17,9 @@
 
 #define TYPE_ARM_GICV3 "arm-gicv3"
 typedef struct ARMGICv3Class ARMGICv3Class;
-#define ARM_GICV3(obj) OBJECT_CHECK(GICv3State, (obj), TYPE_ARM_GICV3)
-#define ARM_GICV3_CLASS(klass) \
-     OBJECT_CLASS_CHECK(ARMGICv3Class, (klass), TYPE_ARM_GICV3)
-#define ARM_GICV3_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(ARMGICv3Class, (obj), TYPE_ARM_GICV3)
+/* This is reusing the GICState typedef from TYPE_ARM_GICV3_COMMON */
+DECLARE_OBJ_CHECKERS(GICv3State, ARMGICv3Class,
+                     ARM_GICV3, TYPE_ARM_GICV3)
 
 struct ARMGICv3Class {
     /*< private >*/
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 09e428de4e..0b8182e40b 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -31,7 +31,9 @@
 #include "qom/object.h"
 
 #define TYPE_ICS_SPAPR "ics-spapr"
-#define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
+/* This is reusing the ICSState typedef from TYPE_ICS */
+DECLARE_INSTANCE_CHECKER(ICSState, ICS_SPAPR,
+                         TYPE_ICS_SPAPR)
 
 int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_servers,
                      Error **errp);
diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
index dca651fd14..6a1c2c20d4 100644
--- a/include/hw/virtio/virtio-mmio.h
+++ b/include/hw/virtio/virtio-mmio.h
@@ -28,12 +28,9 @@
 /* QOM macros */
 /* virtio-mmio-bus */
 #define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
-#define VIRTIO_MMIO_BUS(obj) \
-        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
-#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
-#define VIRTIO_MMIO_BUS_CLASS(klass) \
-        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS)
+/* This is reusing the VirtioBusState typedef from TYPE_VIRTIO_BUS */
+DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,
+                     VIRTIO_MMIO_BUS, TYPE_VIRTIO_MMIO_BUS)
 
 /* virtio-mmio */
 #define TYPE_VIRTIO_MMIO "virtio-mmio"
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index e055bb3af2..b6a05e5439 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -40,8 +40,9 @@
 static APICCommonState *local_apics[MAX_APICS + 1];
 
 #define TYPE_APIC "apic"
-#define APIC(obj) \
-    OBJECT_CHECK(APICCommonState, (obj), TYPE_APIC)
+/*This is reusing the APICCommonState typedef from APIC_COMMON */
+DECLARE_INSTANCE_CHECKER(APICCommonState, APIC,
+                         TYPE_APIC)
 
 static void apic_set_irq(APICCommonState *s, int vector_num, int trigger_mode);
 static void apic_update_irq(APICCommonState *s);
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 6e5a2b8fe0..9494185cf4 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -33,12 +33,9 @@
 
 #define TYPE_KVM_ARM_GIC "kvm-arm-gic"
 typedef struct KVMARMGICClass KVMARMGICClass;
-#define KVM_ARM_GIC(obj) \
-     OBJECT_CHECK(GICState, (obj), TYPE_KVM_ARM_GIC)
-#define KVM_ARM_GIC_CLASS(klass) \
-     OBJECT_CLASS_CHECK(KVMARMGICClass, (klass), TYPE_KVM_ARM_GIC)
-#define KVM_ARM_GIC_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(KVMARMGICClass, (obj), TYPE_KVM_ARM_GIC)
+/* This is reusing the GICState typedef from ARM_GIC_COMMON */
+DECLARE_OBJ_CHECKERS(GICState, KVMARMGICClass,
+                     KVM_ARM_GIC, TYPE_KVM_ARM_GIC)
 
 struct KVMARMGICClass {
     ARMGICCommonClass parent_class;
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 631adc34b6..4ee9875ecc 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -31,11 +31,9 @@
 
 #define TYPE_KVM_ARM_ITS "arm-its-kvm"
 typedef struct KVMARMITSClass KVMARMITSClass;
-#define KVM_ARM_ITS(obj) OBJECT_CHECK(GICv3ITSState, (obj), TYPE_KVM_ARM_ITS)
-#define KVM_ARM_ITS_CLASS(klass) \
-     OBJECT_CLASS_CHECK(KVMARMITSClass, (klass), TYPE_KVM_ARM_ITS)
-#define KVM_ARM_ITS_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(KVMARMITSClass, (obj), TYPE_KVM_ARM_ITS)
+/* This is reusing the GICv3ITSState typedef from ARM_GICV3_ITS_COMMON */
+DECLARE_OBJ_CHECKERS(GICv3ITSState, KVMARMITSClass,
+                     KVM_ARM_ITS, TYPE_KVM_ARM_ITS)
 
 struct KVMARMITSClass {
     GICv3ITSCommonClass parent_class;
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 5733936334..187eb054e0 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -43,12 +43,9 @@
 
 #define TYPE_KVM_ARM_GICV3 "kvm-arm-gicv3"
 typedef struct KVMARMGICv3Class KVMARMGICv3Class;
-#define KVM_ARM_GICV3(obj) \
-     OBJECT_CHECK(GICv3State, (obj), TYPE_KVM_ARM_GICV3)
-#define KVM_ARM_GICV3_CLASS(klass) \
-     OBJECT_CLASS_CHECK(KVMARMGICv3Class, (klass), TYPE_KVM_ARM_GICV3)
-#define KVM_ARM_GICV3_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(KVMARMGICv3Class, (obj), TYPE_KVM_ARM_GICV3)
+/* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON */
+DECLARE_OBJ_CHECKERS(GICv3State, KVMARMGICv3Class,
+                     KVM_ARM_GICV3, TYPE_KVM_ARM_GICV3)
 
 #define   KVM_DEV_ARM_VGIC_SYSREG(op0, op1, crn, crm, op2)         \
                              (ARM64_SYS_REG_SHIFT_MASK(op0, OP0) | \
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index e0cc5847f3..bea6d97ef8 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -32,8 +32,9 @@
 #include "qom/object.h"
 
 #define TYPE_AW_SDHOST_BUS "allwinner-sdhost-bus"
-#define AW_SDHOST_BUS(obj) \
-    OBJECT_CHECK(SDBus, (obj), TYPE_AW_SDHOST_BUS)
+/* This is reusing the SDBus typedef from SD_BUS */
+DECLARE_INSTANCE_CHECKER(SDBus, AW_SDHOST_BUS,
+                         TYPE_AW_SDHOST_BUS)
 
 /* SD Host register offsets */
 enum {
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 743abccbae..50f5fdb88b 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -22,8 +22,9 @@
 #include "qom/object.h"
 
 #define TYPE_BCM2835_SDHOST_BUS "bcm2835-sdhost-bus"
-#define BCM2835_SDHOST_BUS(obj) \
-    OBJECT_CHECK(SDBus, (obj), TYPE_BCM2835_SDHOST_BUS)
+/* This is reusing the SDBus typedef from SD_BUS */
+DECLARE_INSTANCE_CHECKER(SDBus, BCM2835_SDHOST_BUS,
+                         TYPE_BCM2835_SDHOST_BUS)
 
 #define SDCMD  0x00 /* Command to SD card              - 16 R/W */
 #define SDARG  0x04 /* Argument to SD card             - 32 R/W */
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 757a6a3c63..3dd2fc7a83 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -24,7 +24,9 @@
 #include "qom/object.h"
 
 #define TYPE_PXA2XX_MMCI_BUS "pxa2xx-mmci-bus"
-#define PXA2XX_MMCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_PXA2XX_MMCI_BUS)
+/* This is reusing the SDBus typedef from SD_BUS */
+DECLARE_INSTANCE_CHECKER(SDBus, PXA2XX_MMCI_BUS,
+                         TYPE_PXA2XX_MMCI_BUS)
 
 struct PXA2xxMMCIState {
     SysBusDevice parent_obj;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 63772bfab6..6900213083 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -40,7 +40,9 @@
 #include "qom/object.h"
 
 #define TYPE_SDHCI_BUS "sdhci-bus"
-#define SDHCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_SDHCI_BUS)
+/* This is reusing the SDBus typedef from SD_BUS */
+DECLARE_INSTANCE_CHECKER(SDBus, SDHCI_BUS,
+                         TYPE_SDHCI_BUS)
 
 #define MASKED_WRITE(reg, mask, val)  (reg = (reg & (mask)) | (val))
 
-- 
2.26.2


