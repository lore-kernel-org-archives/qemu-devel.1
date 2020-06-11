Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27725C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E344A2068E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9Qa4ryP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E344A2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjSWC-0003Xb-5e
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jjSV7-0002jR-Be
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:04:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47058
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jjSV5-0008Kk-7d
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591902269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T+XHqRfq/dnHuxLT0uNOfMIA48KTl7HDxnNUrv88rAk=;
 b=U9Qa4ryPp2AHcdt/XsB7TtACPqrljGtxXE/AoxmmGXi9jlaiBzI5dEG6W/I3WTLORTUWtn
 xWFCK42jkgdvrGkCVtCbneoAYaHuNBNrTjXBqzhwi6QPICeFtXSq5Jk1/w03AI+8df4Lu6
 sWOiYJrwBUSGpeFDlOlRIkMNmARfXDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-mvvPW5gmPv6bx9DWBVarlw-1; Thu, 11 Jun 2020 15:04:25 -0400
X-MC-Unique: mvvPW5gmPv6bx9DWBVarlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3DEA100CCE6;
 Thu, 11 Jun 2020 19:04:24 +0000 (UTC)
Received: from gimli.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FD1DC14BC;
 Thu, 11 Jun 2020 19:04:24 +0000 (UTC)
Subject: [PULL 1/2] hw/vfio: Add VMD Passthrough Quirk
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jun 2020 13:04:24 -0600
Message-ID: <159190226406.22110.14335554909961993542.stgit@gimli.home>
In-Reply-To: <159190218710.22110.16614504111613456036.stgit@gimli.home>
References: <159190218710.22110.16614504111613456036.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jon Derrick <jonathan.derrick@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Derrick <jonathan.derrick@intel.com>

The VMD endpoint provides a real PCIe domain to the guest, including
bridges and endpoints. Because the VMD domain is enumerated by the guest
kernel, the guest kernel will assign Guest Physical Addresses to the
downstream endpoint BARs and bridge windows.

When the guest kernel performs MMIO to VMD sub-devices, MMU will
translate from the guest address space to the physical address space.
Because the bridges have been programmed with guest addresses, the
bridges will reject the transaction containing physical addresses.

VMD device 28C0 natively assists passthrough by providing the Host
Physical Address in shadow registers accessible to the guest for bridge
window assignment. The shadow registers are valid if bit 1 is set in VMD
VMLOCK config register 0x70.

In order to support existing VMDs, this quirk provides the shadow
registers in a vendor-specific PCI capability to the vfio-passthrough
device for all VMD device ids which don't natively assist with
passthrough. The Linux VMD driver is updated to check for this new
vendor-specific capability.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |   84 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index f2155ddb1d78..a1e615c54e06 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1567,18 +1567,6 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
     return 0;
 }
 
-int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
-{
-    int ret;
-
-    ret = vfio_add_nv_gpudirect_cap(vdev, errp);
-    if (ret) {
-        return ret;
-    }
-
-    return 0;
-}
-
 static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
                                      const char *name,
                                      void *opaque, Error **errp)
@@ -1709,3 +1697,75 @@ free_exit:
 
     return ret;
 }
+
+/*
+ * The VMD endpoint provides a real PCIe domain to the guest and the guest
+ * kernel performs enumeration of the VMD sub-device domain. Guest transactions
+ * to VMD sub-devices go through MMU translation from guest addresses to
+ * physical addresses. When MMIO goes to an endpoint after being translated to
+ * physical addresses, the bridge rejects the transaction because the window
+ * has been programmed with guest addresses.
+ *
+ * VMD can use the Host Physical Address in order to correctly program the
+ * bridge windows in its PCIe domain. VMD device 28C0 has HPA shadow registers
+ * located at offset 0x2000 in MEMBAR2 (BAR 4). This quirk provides the HPA
+ * shadow registers in a vendor-specific capability register for devices
+ * without native support. The position of 0xE8-0xFF is in the reserved range
+ * of the VMD device capability space following the Power Management
+ * Capability.
+ */
+#define VMD_SHADOW_CAP_VER 1
+#define VMD_SHADOW_CAP_LEN 24
+static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
+{
+    uint8_t membar_phys[16];
+    int ret, pos = 0xE8;
+
+    if (!(vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x201D) ||
+          vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x467F) ||
+          vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x4C3D) ||
+          vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x9A0B))) {
+        return 0;
+    }
+
+    ret = pread(vdev->vbasedev.fd, membar_phys, 16,
+                vdev->config_offset + PCI_BASE_ADDRESS_2);
+    if (ret != 16) {
+        error_report("VMD %s cannot read MEMBARs (%d)",
+                     vdev->vbasedev.name, ret);
+        return -EFAULT;
+    }
+
+    ret = pci_add_capability(&vdev->pdev, PCI_CAP_ID_VNDR, pos,
+                             VMD_SHADOW_CAP_LEN, errp);
+    if (ret < 0) {
+        error_prepend(errp, "Failed to add VMD MEMBAR Shadow cap: ");
+        return ret;
+    }
+
+    memset(vdev->emulated_config_bits + pos, 0xFF, VMD_SHADOW_CAP_LEN);
+    pos += PCI_CAP_FLAGS;
+    pci_set_byte(vdev->pdev.config + pos++, VMD_SHADOW_CAP_LEN);
+    pci_set_byte(vdev->pdev.config + pos++, VMD_SHADOW_CAP_VER);
+    pci_set_long(vdev->pdev.config + pos, 0x53484457); /* SHDW */
+    memcpy(vdev->pdev.config + pos + 4, membar_phys, 16);
+
+    return 0;
+}
+
+int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
+{
+    int ret;
+
+    ret = vfio_add_nv_gpudirect_cap(vdev, errp);
+    if (ret) {
+        return ret;
+    }
+
+    ret = vfio_add_vmd_shadow_cap(vdev, errp);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}


