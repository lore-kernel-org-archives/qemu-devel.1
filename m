Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26803C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9836720736
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9836720736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC57r-00005w-6g
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC553-0001sl-03
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC550-0003cr-O4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:23:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35152 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC54x-0003RL-KI; Wed, 11 Mar 2020 13:23:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 85C7376D7FBABC6B84C4;
 Thu, 12 Mar 2020 01:23:24 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 01:23:14 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH v3 00/10] ARM virt: Add NVDIMM support
Date: Wed, 11 Mar 2020 17:20:04 +0000
Message-ID: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, david@redhat.com,
 mst@redhat.com, linuxarm@huawei.com, xuwei5@hisilicon.com,
 shannon.zhaosl@gmail.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds NVDIMM support to arm/virt platform.
The series reuses some of the patches posted by Eric
in his earlier attempt here[1].

This also include few fixes to qemu in general which were
discovered while adding nvdimm support to arm/virt.

Patch #2 addresses the issue[2] that, during migration, the 
source and destination might end up with an inconsistency
in acpi table memory region sizes.

Patch #3 is to fix the qemu_ram_resize() callback issue[2].

Patch #4 is another fix to the nvdimm aml issue discussed
here[3].

I have done a basic sanity testing of NVDIMM devices
with Guest booting with ACPI. Further testing is always
welcome.

Please let me know your feedback.

Thanks,
Shameer

[1] https://patchwork.kernel.org/cover/10830777/
[2] https://patchwork.kernel.org/patch/11339591/
[3] https://patchwork.kernel.org/cover/11174959/

v2 --> v3
 - Added patch #1 and # 2 to fix the inconsistency in acpi
   table memory region sizes during migration. Thanks to
   David H.
 - The fix for qemu_ram_resize() callback was modified to
   the one in patch #3. Again thanks to David H.
 - Addressed comments from MST and Eric on tests added.
 - Addressed comments from Igor/MST on Integer size in patch #4
 - Added Eric's R-by to patch #7.

v1 --> v2
 -Reworked patch #1 and now fix is inside qemu_ram_resize().
 -Added patch #2 to fix the nvdim aml issue.
 -Dropped support to DT cold plug.
 -Updated test_acpi_virt_tcg_memhp() with pc-dimm and nvdimms(patch #7)

David Hildenbrand (1):
  exec: Fix for qemu_ram_resize() callback

Kwangwoo Lee (2):
  nvdimm: Use configurable ACPI IO base and size
  hw/arm/virt: Add nvdimm hot-plug infrastructure

Shameer Kolothum (7):
  acpi: Use macro for table-loader file name
  fw_cfg: Migrate ACPI table mr sizes separately
  hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM output buffer length
  hw/arm/virt: Add nvdimm hotplug support
  tests: Update ACPI tables list for upcoming arm/virt test changes
  tests/bios-tables-test: Update arm/virt memhp test
  tests/acpi: add expected tables for bios-tables-test

 docs/specs/acpi_hw_reduced_hotplug.rst |   1 +
 exec.c                                 |  14 +++-
 hw/acpi/generic_event_device.c         |  15 ++++-
 hw/acpi/nvdimm.c                       |  72 +++++++++++++++++----
 hw/arm/Kconfig                         |   1 +
 hw/arm/virt-acpi-build.c               |   8 ++-
 hw/arm/virt.c                          |  35 ++++++++--
 hw/core/machine.c                      |   1 +
 hw/i386/acpi-build.c                   |   8 ++-
 hw/i386/acpi-build.h                   |   3 +
 hw/i386/pc_piix.c                      |   2 +
 hw/i386/pc_q35.c                       |   2 +
 hw/mem/Kconfig                         |   2 +-
 hw/nvram/fw_cfg.c                      |  86 ++++++++++++++++++++++++-
 include/hw/acpi/aml-build.h            |   1 +
 include/hw/acpi/generic_event_device.h |   1 +
 include/hw/arm/virt.h                  |   1 +
 include/hw/mem/nvdimm.h                |   3 +
 include/hw/nvram/fw_cfg.h              |   6 ++
 tests/data/acpi/pc/SSDT.dimmpxm        | Bin 685 -> 734 bytes
 tests/data/acpi/q35/SSDT.dimmpxm       | Bin 685 -> 734 bytes
 tests/data/acpi/virt/DSDT.memhp        | Bin 6644 -> 6668 bytes
 tests/data/acpi/virt/NFIT.memhp        | Bin 0 -> 224 bytes
 tests/data/acpi/virt/SSDT.memhp        | Bin 0 -> 736 bytes
 tests/qtest/bios-tables-test.c         |   9 ++-
 25 files changed, 244 insertions(+), 27 deletions(-)
 create mode 100644 tests/data/acpi/virt/NFIT.memhp
 create mode 100644 tests/data/acpi/virt/SSDT.memhp

-- 
2.17.1



