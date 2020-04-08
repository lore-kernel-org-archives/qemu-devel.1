Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB404C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 13:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951BD206F7
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 13:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951BD206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMAN4-0007LV-OC
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 09:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1jMAI7-0008VQ-1r
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1jMAI5-00058D-Mu
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3733 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1jMAI5-00054i-B4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id CE5E38C204DE5671C2A8;
 Wed,  8 Apr 2020 20:58:39 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Apr 2020 20:58:31 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <lersek@redhat.com>
Subject: [PATCH v6 0/8] pci_expander_brdige:acpi:Support pxb-pcie for ARM
Date: Wed, 8 Apr 2020 20:58:08 +0800
Message-ID: <20200408125816.955-1-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: berrange@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, miaoyubo@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: miaoyubo <miaoyubo@huawei.com>

Changes with v5
v5->v6: stat crs_range_insert in aml_build.h

Changes with v4
v4->v5: Not using specific resources for PXB.
Instead, the resources for pxb are composed of the bar space of the
pci-bridge/pcie-root-port behined it and the config space of devices
behind it.

Only if the bios(uefi for arm) support multiple roots,
configure space of devices behind pxbs could be obtained.
The uefi work is updated for discussion by the following link:
https://edk2.groups.io/g/devel/message/56901?p=3D,,,20,0,0,0::Created,,ad=
d+extra+roots+for+Arm,20,2,0,72723351=20
[PATCH] ArmVirtPkg/FdtPciHostBridgeLib: add extra roots for Arm.

Currently pxb-pcie is not supported by arm,
the reason for it is pxb-pcie is not described in DSDT table
and only one main host bridge is described in acpi tables,
which means it is not impossible to present different io numas
for different devices.

This series of patches make arm to support PXB-PCIE.

Users can configure pxb-pcie with certain numa, Example command
is:

   -device pxb-pcie,id=3Dpci.7,bus_nr=3D128,numa_node=3D0,bus=3Dpcie.0,ad=
dr=3D0x9

miaoyubo (8):
  acpi: Extract two APIs from acpi_dsdt_add_pci
  fw_cfg: Write the extra roots into the fw_cfg
  acpi: Extract crs build form acpi_build.c
  acpi: Refactor the source of host bridge and build tables for pxb
  acpi: Align the size to 128k
  unit-test: The files changed.
  unit-test: Add testcase for pxb
  unit-test: Add the binary file and clear diff.h

 hw/acpi/aml-build.c            | 275 +++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c       | 251 ++++++++++++++++++++++-------
 hw/arm/virt.c                  |  23 +++
 hw/i386/acpi-build.c           | 285 ---------------------------------
 include/hw/acpi/aml-build.h    |  25 +++
 tests/data/acpi/virt/DSDT.pxb  | Bin 0 -> 7802 bytes
 tests/qtest/bios-tables-test.c |  58 ++++++-
 7 files changed, 566 insertions(+), 351 deletions(-)
 create mode 100644 tests/data/acpi/virt/DSDT.pxb

--=20
2.19.1



