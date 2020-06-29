Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B79EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64153206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64153206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq1gc-0002qE-NQ
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 17:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1jq1dg-0007Kk-31
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 17:48:32 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1jq1dc-000855-De
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 17:48:31 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 2D919BF783
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 21:48:27 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] pci: allocate pci id for nvme
Date: Mon, 29 Jun 2020 23:48:24 +0200
Message-Id: <20200629214825.1283673-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629214825.1283673-1-its@irrelevant.dk>
References: <20200629214825.1283673-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 14:26:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Klaus Jensen <k.jensen@samsung.com>

The emulated nvme device (hw/block/nvme.c) is currently using an
internal Intel device id.

Prepare to change that by allocating a device id under the 1b36 (Red
Hat, Inc.) vendor id.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 MAINTAINERS            |  1 +
 docs/specs/nvme.txt    | 23 +++++++++++++++++++++++
 docs/specs/pci-ids.txt |  1 +
 include/hw/pci/pci.h   |  1 +
 4 files changed, 26 insertions(+)
 create mode 100644 docs/specs/nvme.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b1d..7d190ae364e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1796,6 +1796,7 @@ L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/nvme*
 F: tests/qtest/nvme-test.c
+F: docs/specs/nvme.txt
 
 megasas
 M: Hannes Reinecke <hare@suse.com>
diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
new file mode 100644
index 000000000000..56d393884e7a
--- /dev/null
+++ b/docs/specs/nvme.txt
@@ -0,0 +1,23 @@
+NVM Express Controller
+======================
+
+The nvme device (-device nvme) emulates an NVM Express Controller.
+
+
+Reference Specifications
+------------------------
+
+The device currently implements most mandatory features of NVMe v1.3d, see
+
+  https://nvmexpress.org/resources/specifications/
+
+for the specification.
+
+
+Known issues
+------------
+
+* The accounting numbers in the SMART/Health are reset across power cycles
+
+* Interrupt Coalescing is not supported and is disabled by default in volation
+  of the specification.
diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
index 4d53e5c7d9d5..abbdbca6be38 100644
--- a/docs/specs/pci-ids.txt
+++ b/docs/specs/pci-ids.txt
@@ -63,6 +63,7 @@ PCI devices (other than virtio):
 1b36:000b  PCIe Expander Bridge (-device pxb-pcie)
 1b36:000d  PCI xhci usb host adapter
 1b36:000f  mdpy (mdev sample device), linux/samples/vfio-mdev/mdpy.c
+1b36:0010  PCIe NVMe device (-device nvme)
 
 All these devices are documented in docs/specs.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 2347dc36bfb5..7e565ba03262 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -104,6 +104,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_XHCI        0x000d
 #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
 #define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
+#define PCI_DEVICE_ID_REDHAT_NVME        0x0010
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.27.0


