Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64175C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CD7207C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBTIFDeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CD7207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKlQ-0006uJ-SN
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKVg-0000Os-Tg
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKVc-0005cL-22
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604264607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=URlrK8N3AZ5b6bLprZUIx3eH4LlhG+CiVkUjGJOZI2s=;
 b=OBTIFDeW1sXfyxJY9mxm2AZjZHkkUUvsyT1BS64JGj+TwRTXrQS8HCMsqa4mnunE0z46LN
 1/HAHIYxBWUhg3vxNVLy2rpBOdklEM1pxXPeqS7/a1awiIXZ28S9lc0AD2cYgcQKud9azK
 HCm3LdhdQOCXYluIjUlpuCowH/TVHd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-9Z2n3O98NDSR8-GMGkAkFw-1; Sun, 01 Nov 2020 16:03:23 -0500
X-MC-Unique: 9Z2n3O98NDSR8-GMGkAkFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 472DB57056;
 Sun,  1 Nov 2020 21:03:22 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E036A6EF77;
 Sun,  1 Nov 2020 21:03:18 +0000 (UTC)
Subject: [PULL v3 30/32] s390x/pci: get zPCI function info from host
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 01 Nov 2020 14:03:18 -0700
Message-ID: <160426459862.24886.16608217565679464370.stgit@gimli.home>
In-Reply-To: <160426371498.24886.12193840637250368669.stgit@gimli.home>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 15:46:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Matthew Rosato <mjrosato@linux.ibm.com>

We use the capability chains of the VFIO_DEVICE_GET_INFO ioctl to retrieve
the CLP information that the kernel exports.

To be compatible with previous kernel versions we fall back on previous
predefined values, same as the emulation values, when the ioctl is found
to not support capability chains. If individual CLP capabilities are not
found, we fall back on default values for only those capabilities missing
from the chain.

This patch is based on work previously done by Pierre Morel.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[aw: non-Linux build fixes]
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/s390x/s390-pci-bus.c          |    9 +-
 hw/s390x/s390-pci-vfio.c         |  180 ++++++++++++++++++++++++++++++++++++++
 hw/s390x/trace-events            |    5 +
 include/hw/s390x/s390-pci-bus.h  |    1 
 include/hw/s390x/s390-pci-clp.h  |   12 ++-
 include/hw/s390x/s390-pci-vfio.h |    2 
 6 files changed, 202 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 072b56e45ee5..48a3be802f8e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -738,7 +738,7 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     object_unref(OBJECT(iommu));
 }
 
-static S390PCIGroup *s390_group_create(int id)
+S390PCIGroup *s390_group_create(int id)
 {
     S390PCIGroup *group;
     S390pciState *s = s390_get_phb();
@@ -783,7 +783,7 @@ static void set_pbdev_info(S390PCIBusDevice *pbdev)
     pbdev->zpci_fn.sdma = ZPCI_SDMA_ADDR;
     pbdev->zpci_fn.edma = ZPCI_EDMA_ADDR;
     pbdev->zpci_fn.pchid = 0;
-    pbdev->zpci_fn.ug = ZPCI_DEFAULT_FN_GRP;
+    pbdev->zpci_fn.pfgid = ZPCI_DEFAULT_FN_GRP;
     pbdev->zpci_fn.fid = pbdev->fid;
     pbdev->zpci_fn.uid = pbdev->uid;
     pbdev->pci_group = s390_group_find(ZPCI_DEFAULT_FN_GRP);
@@ -863,7 +863,8 @@ static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
     name = g_strdup_printf("msix-s390-%04x", pbdev->uid);
     memory_region_init_io(&pbdev->msix_notify_mr, OBJECT(pbdev),
                           &s390_msi_ctrl_ops, pbdev, name, PAGE_SIZE);
-    memory_region_add_subregion(&pbdev->iommu->mr, ZPCI_MSI_ADDR,
+    memory_region_add_subregion(&pbdev->iommu->mr,
+                                pbdev->pci_group->zpci_group.msia,
                                 &pbdev->msix_notify_mr);
     g_free(name);
 
@@ -1016,6 +1017,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
             pbdev->fh |= FH_SHM_VFIO;
             pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
+            /* Fill in CLP information passed via the vfio region */
+            s390_pci_get_clp_info(pbdev);
         } else {
             pbdev->fh |= FH_SHM_EMUL;
         }
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 0621fa386ced..d5c78063b5bc 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -10,9 +10,13 @@
  */
 
 #include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include <linux/vfio_zdev.h>
 
 #include "qemu/osdep.h"
+#include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
+#include "hw/s390x/s390-pci-clp.h"
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/vfio/pci.h"
 #include "hw/vfio/vfio-common.h"
@@ -94,3 +98,179 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
         QTAILQ_REMOVE(&s->zpci_dma_limit, cnt, link);
     }
 }
+
+static void s390_pci_read_base(S390PCIBusDevice *pbdev,
+                               struct vfio_device_info *info)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_device_info_cap_zpci_base *cap;
+    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+
+    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
+
+    /* If capability not provided, just leave the defaults in place */
+    if (hdr == NULL) {
+        trace_s390_pci_clp_cap(vpci->vbasedev.name,
+                               VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
+        return;
+    }
+    cap = (void *) hdr;
+
+    pbdev->zpci_fn.sdma = cap->start_dma;
+    pbdev->zpci_fn.edma = cap->end_dma;
+    pbdev->zpci_fn.pchid = cap->pchid;
+    pbdev->zpci_fn.vfn = cap->vfn;
+    pbdev->zpci_fn.pfgid = cap->gid;
+    /* The following values remain 0 until we support other FMB formats */
+    pbdev->zpci_fn.fmbl = 0;
+    pbdev->zpci_fn.pft = 0;
+}
+
+static void s390_pci_read_group(S390PCIBusDevice *pbdev,
+                                struct vfio_device_info *info)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_device_info_cap_zpci_group *cap;
+    ClpRspQueryPciGrp *resgrp;
+    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+
+    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_GROUP);
+
+    /* If capability not provided, just use the default group */
+    if (hdr == NULL) {
+        trace_s390_pci_clp_cap(vpci->vbasedev.name,
+                               VFIO_DEVICE_INFO_CAP_ZPCI_GROUP);
+        pbdev->zpci_fn.pfgid = ZPCI_DEFAULT_FN_GRP;
+        pbdev->pci_group = s390_group_find(ZPCI_DEFAULT_FN_GRP);
+        return;
+    }
+    cap = (void *) hdr;
+
+    /* See if the PCI group is already defined, create if not */
+    pbdev->pci_group = s390_group_find(pbdev->zpci_fn.pfgid);
+
+    if (!pbdev->pci_group) {
+        pbdev->pci_group = s390_group_create(pbdev->zpci_fn.pfgid);
+
+        resgrp = &pbdev->pci_group->zpci_group;
+        if (cap->flags & VFIO_DEVICE_INFO_ZPCI_FLAG_REFRESH) {
+            resgrp->fr = 1;
+        }
+        stq_p(&resgrp->dasm, cap->dasm);
+        stq_p(&resgrp->msia, cap->msi_addr);
+        stw_p(&resgrp->mui, cap->mui);
+        stw_p(&resgrp->i, cap->noi);
+        stw_p(&resgrp->maxstbl, cap->maxstbl);
+        stb_p(&resgrp->version, cap->version);
+    }
+}
+
+static void s390_pci_read_util(S390PCIBusDevice *pbdev,
+                               struct vfio_device_info *info)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_device_info_cap_zpci_util *cap;
+    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+
+    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_UTIL);
+
+    /* If capability not provided, just leave the defaults in place */
+    if (hdr == NULL) {
+        trace_s390_pci_clp_cap(vpci->vbasedev.name,
+                               VFIO_DEVICE_INFO_CAP_ZPCI_UTIL);
+        return;
+    }
+    cap = (void *) hdr;
+
+    if (cap->size > CLP_UTIL_STR_LEN) {
+        trace_s390_pci_clp_cap_size(vpci->vbasedev.name, cap->size,
+                                    VFIO_DEVICE_INFO_CAP_ZPCI_UTIL);
+        return;
+    }
+
+    pbdev->zpci_fn.flags |= CLP_RSP_QPCI_MASK_UTIL;
+    memcpy(pbdev->zpci_fn.util_str, cap->util_str, CLP_UTIL_STR_LEN);
+}
+
+static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
+                               struct vfio_device_info *info)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_device_info_cap_zpci_pfip *cap;
+    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+
+    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_PFIP);
+
+    /* If capability not provided, just leave the defaults in place */
+    if (hdr == NULL) {
+        trace_s390_pci_clp_cap(vpci->vbasedev.name,
+                               VFIO_DEVICE_INFO_CAP_ZPCI_PFIP);
+        return;
+    }
+    cap = (void *) hdr;
+
+    if (cap->size > CLP_PFIP_NR_SEGMENTS) {
+        trace_s390_pci_clp_cap_size(vpci->vbasedev.name, cap->size,
+                                    VFIO_DEVICE_INFO_CAP_ZPCI_PFIP);
+        return;
+    }
+
+    memcpy(pbdev->zpci_fn.pfip, cap->pfip, CLP_PFIP_NR_SEGMENTS);
+}
+
+/*
+ * This function will issue the VFIO_DEVICE_GET_INFO ioctl and look for
+ * capabilities that contain information about CLP features provided by the
+ * underlying host.
+ * On entry, defaults have already been placed into the guest CLP response
+ * buffers.  On exit, defaults will have been overwritten for any CLP features
+ * found in the capability chain; defaults will remain for any CLP features not
+ * found in the chain.
+ */
+void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
+{
+    g_autofree struct vfio_device_info *info;
+    VFIOPCIDevice *vfio_pci;
+    uint32_t argsz;
+    int fd;
+
+    argsz = sizeof(*info);
+    info = g_malloc0(argsz);
+
+    vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    fd = vfio_pci->vbasedev.fd;
+
+    /*
+     * If the specified argsz is not large enough to contain all capabilities
+     * it will be updated upon return from the ioctl.  Retry until we have
+     * a big enough buffer to hold the entire capability chain.  On error,
+     * just exit and rely on CLP defaults.
+     */
+retry:
+    info->argsz = argsz;
+
+    if (ioctl(fd, VFIO_DEVICE_GET_INFO, info)) {
+        trace_s390_pci_clp_dev_info(vfio_pci->vbasedev.name);
+        return;
+    }
+
+    if (info->argsz > argsz) {
+        argsz = info->argsz;
+        info = g_realloc(info, argsz);
+        goto retry;
+    }
+
+    /*
+     * Find the CLP features provided and fill in the guest CLP responses.
+     * Always call s390_pci_read_base first as information from this could
+     * determine which function group is used in s390_pci_read_group.
+     * For any feature not found, the default values will remain in the CLP
+     * response.
+     */
+    s390_pci_read_base(pbdev, info);
+    s390_pci_read_group(pbdev, info);
+    s390_pci_read_util(pbdev, info);
+    s390_pci_read_pfip(pbdev, info);
+
+    return;
+}
diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
index 0dc5b818c471..8156693749d7 100644
--- a/hw/s390x/trace-events
+++ b/hw/s390x/trace-events
@@ -14,3 +14,8 @@ css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode 0x%x on isc 0
 virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command 0x%x"
 virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, const char *devno_mode) "VIRTIO-CCW: add subchannel %x.%x.%04x, devno 0x%04x (%s)"
 virtio_ccw_set_ind(uint64_t ind_loc, uint8_t ind_old, uint8_t ind_new) "VIRTIO-CCW: indicator at %" PRIu64 ": 0x%x->0x%x"
+
+# s390-pci-vfio.c
+s390_pci_clp_cap(const char *id, uint32_t cap) "PCI: %s: missing expected CLP capability %u"
+s390_pci_clp_cap_size(const char *id, uint32_t size, uint32_t cap) "PCI: %s: bad size (%u) for CLP capability %u"
+s390_pci_clp_dev_info(const char *id) "PCI: %s: cannot read vfio device info"
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index fe36f163abd4..49ae9f03d310 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -322,6 +322,7 @@ typedef struct S390PCIGroup {
     int id;
     QTAILQ_ENTRY(S390PCIGroup) link;
 } S390PCIGroup;
+S390PCIGroup *s390_group_create(int id);
 S390PCIGroup *s390_group_find(int id);
 
 struct S390PCIBusDevice {
diff --git a/include/hw/s390x/s390-pci-clp.h b/include/hw/s390x/s390-pci-clp.h
index 3708acd173c6..ea2b1378cd5a 100644
--- a/include/hw/s390x/s390-pci-clp.h
+++ b/include/hw/s390x/s390-pci-clp.h
@@ -79,6 +79,7 @@ typedef struct ClpFhListEntry {
 #define CLP_SET_DISABLE_PCI_FN 1 /* Yes, 1 disables it */
 
 #define CLP_UTIL_STR_LEN 64
+#define CLP_PFIP_NR_SEGMENTS 4
 
 #define CLP_MASK_FMT 0xf0000000
 
@@ -120,14 +121,17 @@ typedef struct ClpRspQueryPci {
     uint32_t fmt;
     uint64_t reserved1;
     uint16_t vfn; /* virtual fn number */
-#define CLP_RSP_QPCI_MASK_UTIL  0x100
-#define CLP_RSP_QPCI_MASK_PFGID 0xff
-    uint16_t ug;
+#define CLP_RSP_QPCI_MASK_UTIL  0x01
+    uint8_t flags;
+    uint8_t pfgid;
     uint32_t fid; /* pci function id */
     uint8_t bar_size[PCI_BAR_COUNT];
     uint16_t pchid;
     uint32_t bar[PCI_BAR_COUNT];
-    uint64_t reserved2;
+    uint8_t pfip[CLP_PFIP_NR_SEGMENTS];
+    uint16_t reserved2;
+    uint8_t fmbl;
+    uint8_t pft;
     uint64_t sdma; /* start dma as */
     uint64_t edma; /* end dma as */
     uint32_t reserved3[11];
diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index 539bcf04eb5b..c7984905b3b7 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -19,6 +19,7 @@ bool s390_pci_update_dma_avail(int fd, unsigned int *avail);
 S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
                                           S390PCIBusDevice *pbdev);
 void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
+void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
 #else
 static inline bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
 {
@@ -31,6 +32,7 @@ static inline S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 }
 static inline void s390_pci_end_dma_count(S390pciState *s,
                                           S390PCIDMACount *cnt) { }
+static inline void s390_pci_get_clp_info(S390PCIBusDevice *pbdev) { }
 #endif
 
 #endif


