Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85762C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9D32051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9D32051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtHr-00012A-Hu
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqlb-0000cO-EQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqlZ-00072R-Ij
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:54 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqlT-00045b-R1; Mon, 16 Mar 2020 10:30:47 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 342B6BFAA8;
 Mon, 16 Mar 2020 14:29:55 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 39/42] pci: allocate pci id for nvme
Date: Mon, 16 Mar 2020 07:29:25 -0700
Message-Id: <20200316142928.153431-40-its@irrelevant.dk>
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

The emulated nvme device (hw/block/nvme.c) is currently using an
internal Intel device id.

Prepare to change that by allocating a device id under the 1b36 (Red
Hat, Inc.) vendor id.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 MAINTAINERS            |  1 +
 docs/specs/nvme.txt    | 25 +++++++++++++++++++++++++
 docs/specs/pci-ids.txt |  1 +
 include/hw/pci/pci.h   |  1 +
 4 files changed, 28 insertions(+)
 create mode 100644 docs/specs/nvme.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 32867bc63670..fcffe790ef40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1698,6 +1698,7 @@ L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/nvme*
 F: tests/qtest/nvme-test.c
+F: docs/specs/nvme.txt
=20
 megasas
 M: Hannes Reinecke <hare@suse.com>
diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
new file mode 100644
index 000000000000..b51552cb5c3f
--- /dev/null
+++ b/docs/specs/nvme.txt
@@ -0,0 +1,25 @@
+NVM Express Controller
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The nvme device (-device nvme) emulates an NVM Express Controller.
+
+
+Reference Specifications
+------------------------
+
+The device currently implements most mandatory features of NVMe v1.3d, s=
ee
+
+  https://nvmexpress.org/resources/specifications/
+
+for the specification.
+
+
+Known issues
+------------
+
+* The device does not have any way of storing persistent state, so minor=
 parts
+  of the implementation is in violation of the specification:
+    - The accounting numbers in the SMART/Health are reset across power =
cycles
+
+* Interrupt Coalescing is not supported and is disabled by default in vo=
lation
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
=20
 All these devices are documented in docs/specs.
=20
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index da9057b8db97..92231885bc23 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -104,6 +104,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_XHCI        0x000d
 #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
 #define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
+#define PCI_DEVICE_ID_REDHAT_NVME        0x0010
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
=20
 #define FMT_PCIBUS                      PRIx64
--=20
2.25.1


