Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB04C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2602C20775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRRgL/yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2602C20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joliY-0000Xk-Bp
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jole4-0002Wd-V8
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:31:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21845
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jole3-0003NN-4S
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593167502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QR/HakmSlchkW8rUsYtzabgqq8Ooc2VYeCjnvOodyD0=;
 b=SRRgL/ypEElCrDFN5OEuW0hzlkvgvczZsDBVSjbtGQ3dPQxzSTRIcFuovxET/sjm5VOheF
 A6rxyrDyOlkJ0+DLi/nkh7RRTy+x8xlY6CGWZ1R1uzXJ5HvYCoiBGvgJxwqxxQktymDYVv
 +JhQSpdwUpDvmYvwykoJCd4v9RcwvOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-zMWRtc4GMnOfaMwHVydwxg-1; Fri, 26 Jun 2020 06:31:38 -0400
X-MC-Unique: zMWRtc4GMnOfaMwHVydwxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A9C010059A0;
 Fri, 26 Jun 2020 10:31:37 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA85A610F3;
 Fri, 26 Jun 2020 10:31:34 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, pbonzini@redhat.com, jean-philippe@linaro.org,
 bbhushan2@marvell.com, peterx@redhat.com
Subject: [PATCH v6 5/5] hw/arm/virt: Let the virtio-iommu bypass MSIs
Date: Fri, 26 Jun 2020 12:30:57 +0200
Message-Id: <20200626103057.11263-6-eric.auger@redhat.com>
In-Reply-To: <20200626103057.11263-1-eric.auger@redhat.com>
References: <20200626103057.11263-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment the virtio-iommu translates MSI transactions.
This behavior is inherited from ARM SMMU. The virt machine
code knows where the guest MSI doorbells are so we can easily
declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
setting the guest will not map MSIs through the IOMMU and those
transactions will be simply bypassed.

Depending on which MSI controller is in use (ITS or GICV2M),
we declare either:
- the ITS interrupt translation space (ITS_base + 0x10000),
  containing the GITS_TRANSLATOR or
- The GICV2M single frame, containing the MSI_SETSP_NS register.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v5 -> v6:
- do not hardcode doorbell base and size
- removed Jean's R-b

v3 -> v4:
- use ':' as separators

v2 -> v3:
- Add a new value to VirtMSIControllerType

v1 -> v2:
- Test which MSI controller is instantiated
- If GICV2M is in use, declare its doorbell as an MSI doorbell too
---
 include/hw/arm/virt.h |  7 +++++++
 hw/arm/virt.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 31878ddc72..a18b6b397b 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -96,6 +96,12 @@ typedef enum VirtIOMMUType {
     VIRT_IOMMU_VIRTIO,
 } VirtIOMMUType;
 
+typedef enum VirtMSIControllerType {
+    VIRT_MSI_CTRL_NONE,
+    VIRT_MSI_CTRL_GICV2M,
+    VIRT_MSI_CTRL_ITS,
+} VirtMSIControllerType;
+
 typedef enum VirtGICType {
     VIRT_GIC_VERSION_MAX,
     VIRT_GIC_VERSION_HOST,
@@ -136,6 +142,7 @@ typedef struct {
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
+    VirtMSIControllerType msi_controller;
     uint16_t virtio_iommu_bdf;
     struct arm_boot_info bootinfo;
     MemMapEntry *memmap;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 402c362c14..5ba62d6568 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -602,6 +602,7 @@ static void create_its(VirtMachineState *vms)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
 
     fdt_add_its_gic_node(vms);
+    vms->msi_controller = VIRT_MSI_CTRL_ITS;
 }
 
 static void create_v2m(VirtMachineState *vms)
@@ -622,6 +623,7 @@ static void create_v2m(VirtMachineState *vms)
     }
 
     fdt_add_v2m_gic_node(vms);
+    vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
 }
 
 static void create_gic(VirtMachineState *vms)
@@ -2149,8 +2151,36 @@ out:
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_memory_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        hwaddr db_start = 0, db_end = 0;
+        char *resv_prop_str;
+
+        switch (vms->msi_controller) {
+        case VIRT_MSI_CTRL_NONE:
+            return;
+        case VIRT_MSI_CTRL_ITS:
+            /* GITS_TRANSLATER page */
+            db_start = base_memmap[VIRT_GIC_ITS].base + 0x10000;
+            db_end = base_memmap[VIRT_GIC_ITS].base +
+                     base_memmap[VIRT_GIC_ITS].size - 1;
+            break;
+        case VIRT_MSI_CTRL_GICV2M:
+            /* MSI_SETSPI_NS page */
+            db_start = base_memmap[VIRT_GIC_V2M].base;
+            db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
+            break;
+        }
+        resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
+                                        db_start, db_end,
+                                        VIRTIO_IOMMU_RESV_MEM_T_MSI);
+
+        qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
+        qdev_prop_set_string(dev, "reserved-regions[0]", resv_prop_str);
+        g_free(resv_prop_str);
     }
 }
 
-- 
2.20.1


