Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D753FC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91867206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euoNpR0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91867206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCREp-0003wx-NB
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxq-0000lz-DD
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxo-0005Ie-Rs
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:42 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:35242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxo-0005IR-K8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id m3so7127477wmi.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LW+uhVLtDVUYFrSt24tGGyA8LHnhD06A1jm/O2Dydpk=;
 b=euoNpR0zJ0xaOGfQPCASYBml2PVfr0s3neeidYkZzOs9iQycoiqyi9JxKT+QIEjds/
 ENPGz2w18J0t0/VcDvUD2/WgVcuyOmFXjvLAWw9YXDRYJHg3AmgLKc8EUQb5z0obBdpA
 XoEvC8YhU9ymOkgRcVSvMGBQeKiau7A70E9L0vXzmb3Y9NUALr+movcDgKCDEsaTsbHV
 8+YoJy2QwoVHWS0bc/ytahcQi8k41xUzZ/rmg3OlXERcguFE0Lz9a/lstjVjRyf1RLP5
 qoMnMLVhxjejPWr0/xGtZzEtAZxuW67Q9Pxwoh7omXa8+s8QomH6L1WyC7zfZU89NsLf
 ngzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LW+uhVLtDVUYFrSt24tGGyA8LHnhD06A1jm/O2Dydpk=;
 b=KXnzPE+fQXNSpTjVcaAkXwCcead187WAYNAu0aq/yD8IuvLfE99dc/gct+CtZk3gOS
 xc4dR19G/0MHoNiC6JjuCFN6utIee8dQR79WMf0lGJeKECrWR8KwjQDfy8zspVsQHqb3
 KjPdMi4cyeWg4K4cQKaUlz9NpOSEXSNmB13kXqTqZfqQdPKrTRQRSOFtMnKP75eT887g
 4wO2oviyv6qh/HMqE/Wb6WrEgctqP1H6Wi5dFi/ge4Ypl2gCzji2X3SJx89Ad5eySwn8
 WxOCw/r+h23YEFHTQhuqjEDPBcAt6CF7HDRW04alAZvA38UeiG5NQ8K+Or9KxgfOqECv
 OqzA==
X-Gm-Message-State: ANhLgQ0ouO0vjuOHJcjeKzvqJ27MlGeDtxQr3Ev7OU4gGhPhyKyEn2/d
 2rs7LewWvAzDh7CfhSXYJhZ4uROd0+vz7Q==
X-Google-Smtp-Source: ADFU+vvik/FlM3IXtJ9k3iyLgKslKazyKDJDOtUq4OGNS1saa/KpDx9nX+yvnQpagX7K0wTqvQcRpg==
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr5401096wmk.97.1584031539304; 
 Thu, 12 Mar 2020 09:45:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/36] hw/arm/virt: Introduce VirtGICType enum type
Date: Thu, 12 Mar 2020 16:44:54 +0000
Message-Id: <20200312164459.25924-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

From: Eric Auger <eric.auger@redhat.com>

We plan to introduce yet another value for the gic version (nosel).
As we already use exotic values such as 0 and -1, let's introduce
a dedicated enum type and let vms->gic_version take this
type.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200311131618.7187-3-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h | 11 +++++++++--
 hw/arm/virt.c         | 30 +++++++++++++++---------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 02f500cb8e2..c0827cacdf3 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -95,6 +95,13 @@ typedef enum VirtIOMMUType {
     VIRT_IOMMU_VIRTIO,
 } VirtIOMMUType;
 
+typedef enum VirtGICType {
+    VIRT_GIC_VERSION_MAX,
+    VIRT_GIC_VERSION_HOST,
+    VIRT_GIC_VERSION_2,
+    VIRT_GIC_VERSION_3,
+} VirtGICType;
+
 typedef struct MemMapEntry {
     hwaddr base;
     hwaddr size;
@@ -123,7 +130,7 @@ typedef struct {
     bool highmem_ecam;
     bool its;
     bool virt;
-    int32_t gic_version;
+    VirtGICType gic_version;
     VirtIOMMUType iommu;
     uint16_t virtio_iommu_bdf;
     struct arm_boot_info bootinfo;
@@ -162,7 +169,7 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
     uint32_t redist0_capacity =
                 vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
 
-    assert(vms->gic_version == 3);
+    assert(vms->gic_version == VIRT_GIC_VERSION_3);
 
     return vms->smp_cpus > redist0_capacity ? 2 : 1;
 }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7c38c6c7f91..4ed1f0cb2e5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -299,7 +299,7 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
         irqflags = GIC_FDT_IRQ_FLAGS_EDGE_LO_HI;
     }
 
-    if (vms->gic_version == 2) {
+    if (vms->gic_version == VIRT_GIC_VERSION_2) {
         irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
                              (1 << vms->smp_cpus) - 1);
@@ -440,7 +440,7 @@ static void fdt_add_gic_node(VirtMachineState *vms)
     qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 0x2);
     qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 0x2);
     qemu_fdt_setprop(vms->fdt, nodename, "ranges", NULL, 0);
-    if (vms->gic_version == 3) {
+    if (vms->gic_version == VIRT_GIC_VERSION_3) {
         int nb_redist_regions = virt_gicv3_redist_region_count(vms);
 
         qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
@@ -519,7 +519,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
         }
     }
 
-    if (vms->gic_version == 2) {
+    if (vms->gic_version == VIRT_GIC_VERSION_2) {
         irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
                              (1 << vms->smp_cpus) - 1);
@@ -1470,7 +1470,7 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
          * purposes are to make TCG consistent (with 64-bit KVM hosts)
          * and to improve SGI efficiency.
          */
-        if (vms->gic_version == 3) {
+        if (vms->gic_version == VIRT_GIC_VERSION_3) {
             clustersz = GICV3_TARGETLIST_BITS;
         } else {
             clustersz = GIC_TARGETLIST_BITS;
@@ -1561,15 +1561,15 @@ static void machvirt_init(MachineState *machine)
     /* We can probe only here because during property set
      * KVM is not available yet
      */
-    if (vms->gic_version <= 0) {
-        /* "host" or "max" */
+    if (vms->gic_version == VIRT_GIC_VERSION_HOST ||
+        vms->gic_version == VIRT_GIC_VERSION_MAX) {
         if (!kvm_enabled()) {
-            if (vms->gic_version == 0) {
+            if (vms->gic_version == VIRT_GIC_VERSION_HOST) {
                 error_report("gic-version=host requires KVM");
                 exit(1);
             } else {
                 /* "max": currently means 3 for TCG */
-                vms->gic_version = 3;
+                vms->gic_version = VIRT_GIC_VERSION_3;
             }
         } else {
             vms->gic_version = kvm_arm_vgic_probe();
@@ -1628,7 +1628,7 @@ static void machvirt_init(MachineState *machine)
     /* The maximum number of CPUs depends on the GIC version, or on how
      * many redistributors we can fit into the memory map.
      */
-    if (vms->gic_version == 3) {
+    if (vms->gic_version == VIRT_GIC_VERSION_3) {
         virt_max_cpus =
             vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
         virt_max_cpus +=
@@ -1856,7 +1856,7 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
 static char *virt_get_gic_version(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
-    const char *val = vms->gic_version == 3 ? "3" : "2";
+    const char *val = vms->gic_version == VIRT_GIC_VERSION_3 ? "3" : "2";
 
     return g_strdup(val);
 }
@@ -1866,13 +1866,13 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
     if (!strcmp(value, "3")) {
-        vms->gic_version = 3;
+        vms->gic_version = VIRT_GIC_VERSION_3;
     } else if (!strcmp(value, "2")) {
-        vms->gic_version = 2;
+        vms->gic_version = VIRT_GIC_VERSION_2;
     } else if (!strcmp(value, "host")) {
-        vms->gic_version = 0; /* Will probe later */
+        vms->gic_version = VIRT_GIC_VERSION_HOST; /* Will probe later */
     } else if (!strcmp(value, "max")) {
-        vms->gic_version = -1; /* Will probe later */
+        vms->gic_version = VIRT_GIC_VERSION_MAX; /* Will probe later */
     } else {
         error_setg(errp, "Invalid gic-version value");
         error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
@@ -2141,7 +2141,7 @@ static void virt_instance_init(Object *obj)
                                     "physical address space above 32 bits",
                                     NULL);
     /* Default GIC type is v2 */
-    vms->gic_version = 2;
+    vms->gic_version = VIRT_GIC_VERSION_2;
     object_property_add_str(obj, "gic-version", virt_get_gic_version,
                         virt_set_gic_version, NULL);
     object_property_set_description(obj, "gic-version",
-- 
2.20.1


