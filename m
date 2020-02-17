Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7956CC761A3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED2120836
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED2120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3eRS-0000gE-CW
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j3eQD-0008H5-7y
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j3eQC-0001Tr-9L
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:18:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59848 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j3eQB-0001N5-VK
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:18:40 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 4E970FCF0F16A20FE997;
 Mon, 17 Feb 2020 19:18:32 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Feb 2020 19:18:24 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>
Subject: [RFC v2 0/1] pci_expander_brdige:acpi:Support pxb-pcie for ARM
Date: Mon, 17 Feb 2020 19:18:17 +0800
Message-ID: <20200217111818.766-1-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: imammedo@redhat.com, miaoyubo@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: miaoyubo <miaoyubo@huawei.com>

Currently pxb-pcie is not supported by arm and only one
main host bridge is described in acpi tables, which means
it is not impossible to present different io numas for different
devices. This series of patches make arm to support PXB-PCIE.

Users can configure pxb-pcie with certain numa, Example command
is:

   -device pxb-pcie,id=3Dpci.7,bus_nr=3D128,numa_node=3D0,bus=3Dpcie.0,ad=
dr=3D0x9

Since devices could not be plugged into pxb-pcie directly,pcie-root-port
or pci-bridge should be defined and plugged on pxb-pcie, then the device
could be plugged onto the pcie-root-port or pci-bridge.=20

With the patches,io numa could be presented to the guest by define a pxb-=
pcie
with the numa and plug the device on it.

miaoyubo (1):
  arm: acpi: pci-expender-bus: Make arm to support PXB-PCIE

 hw/arm/virt-acpi-build.c | 240 +++++++++++++++++++++++++++++----------
 hw/pci-host/gpex.c       |   4 +
 include/hw/arm/virt.h    |   1 +
 3 files changed, 184 insertions(+), 61 deletions(-)

--=20
2.19.1



