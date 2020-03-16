Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6644FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363E12051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363E12051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtCv-0006fx-AX
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqlg-0000fF-Dg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqle-0007O2-Ku
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:31:00 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqlT-00045L-SW; Mon, 16 Mar 2020 10:30:48 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id A7024BFAA9;
 Mon, 16 Mar 2020 14:29:55 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 40/42] nvme: change controller pci id
Date: Mon, 16 Mar 2020 07:29:26 -0700
Message-Id: <20200316142928.153431-41-its@irrelevant.dk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316142928.153431-1-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

There are two reasons for changing this:

  1. The nvme device currently uses an internal Intel device id.

  2. Since commits "nvme: fix write zeroes offset and count" and "nvme:
     support multiple namespaces" the controller device no longer has
     the quirks that the Linux kernel think it has.

     As the quirks are applied based on pci vendor and device id, change
     them to get rid of the quirks.

To keep backward compatibility, add a new 'x-use-intel-id' parameter to
the nvme device to force use of the Intel vendor and device id. This is
off by default but add a compat property to set this for machines 4.2
and older.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c   | 13 +++++++++----
 hw/block/nvme.h   |  4 +++-
 hw/core/machine.c |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 88a0499d0fe0..f176d859a85e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2493,8 +2493,15 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *=
pci_dev)
=20
     pci_conf[PCI_INTERRUPT_PIN] =3D 1;
     pci_config_set_prog_interface(pci_conf, 0x2);
-    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
-    pci_config_set_device_id(pci_conf, 0x5845);
+
+    if (n->params.use_intel_id) {
+        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
+        pci_config_set_device_id(pci_conf, 0x5846);
+    } else {
+        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
+        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
+    }
+
     pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(pci_dev, 0x80);
=20
@@ -2669,8 +2676,6 @@ static void nvme_class_init(ObjectClass *oc, void *=
data)
     pc->realize =3D nvme_realize;
     pc->exit =3D nvme_exit;
     pc->class_id =3D PCI_CLASS_STORAGE_EXPRESS;
-    pc->vendor_id =3D PCI_VENDOR_ID_INTEL;
-    pc->device_id =3D 0x5845;
     pc->revision =3D 2;
=20
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index c66f6cd8413a..70df17e6f893 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -13,7 +13,8 @@
     DEFINE_PROP_UINT32("max_ioqpairs", _state, _props.max_ioqpairs, 64),=
 \
     DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3), \
     DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, =
64), \
-    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7)
+    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7), \
+    DEFINE_PROP_BOOL("x-use-intel-id", _state, _props.use_intel_id, fals=
e)
=20
 typedef struct NvmeParams {
     char     *serial;
@@ -23,6 +24,7 @@ typedef struct NvmeParams {
     uint8_t  aerl;
     uint32_t aer_max_queued;
     uint8_t  mdts;
+    bool     use_intel_id;
 } NvmeParams;
=20
 typedef struct NvmeAsyncEvent {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9e8c06036faf..fe7dbca0b9a2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] =3D {
     { "usb-redir", "suppress-remote-wake", "off" },
     { "qxl", "revision", "4" },
     { "qxl-vga", "revision", "4" },
+    { "nvme", "x-use-intel-id", "on"},
 };
 const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
=20
--=20
2.25.1


