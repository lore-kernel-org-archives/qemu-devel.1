Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E5C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA2324679
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA2324679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVjo-00045s-Aq
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1isVi2-0002GW-Ol
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1isVi1-0007gp-IL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:47:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46894 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1isVhw-0007Uh-UA; Fri, 17 Jan 2020 12:46:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7FA3720316FEC9BDA05E;
 Sat, 18 Jan 2020 01:46:46 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 18 Jan 2020 01:46:38 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH v2 0/7] ARM virt: Add NVDIMM support
Date: Fri, 17 Jan 2020 17:45:15 +0000
Message-ID: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds NVDIMM support to arm/virt platform.
The series reuses some of the patches posted by Eric
in his earlier attempt here[1].

Patch #1 is a fix to the Guest reboot issue on NVDIMM
hot add case described here[2] and patch #2 is another
fix to the nvdimm aml issue discussed here[3].

I have done a basic sanity testing of NVDIMM deviecs
with Guest booting with both ACPI and DT. Further testing
is always welcome.

Please let me know your feedback.

Thanks,
Shameer

[1] https://patchwork.kernel.org/cover/10830777/
[2] https://patchwork.kernel.org/patch/11154757/
[3] https://patchwork.kernel.org/cover/11174959/

v1 --> v2
 -Reworked patch #1 and now fix is inside qemu_ram_resize().
 -Added patch #2 to fix the nvdim aml issue.
 -Dropped support to DT cold plug.
 -Updated test_acpi_virt_tcg_memhp() with pc-dimm and nvdimms(patch #7)

Kwangwoo Lee (2):
  nvdimm: Use configurable ACPI IO base and size
  hw/arm/virt: Add nvdimm hot-plug infrastructure

Shameer Kolothum (5):
  exec: Fix for qemu_ram_resize() callback
  hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM output  buffer  length
  hw/arm/virt: Add nvdimm hotplug support
  tests: Update ACPI tables list for upcoming arm/virt test changes
  tests/bios-tables-test: Update arm/virt memhp test

 docs/specs/acpi_hw_reduced_hotplug.rst      |  1 +
 exec.c                                      | 36 +++++++----
 hw/acpi/generic_event_device.c              | 13 ++++
 hw/acpi/nvdimm.c                            | 68 +++++++++++++++++----
 hw/arm/Kconfig                              |  1 +
 hw/arm/virt-acpi-build.c                    |  6 ++
 hw/arm/virt.c                               | 35 +++++++++--
 hw/i386/acpi-build.c                        |  6 ++
 hw/i386/acpi-build.h                        |  3 +
 hw/i386/pc_piix.c                           |  2 +
 hw/i386/pc_q35.c                            |  2 +
 hw/mem/Kconfig                              |  2 +-
 include/exec/ram_addr.h                     |  5 +-
 include/hw/acpi/generic_event_device.h      |  1 +
 include/hw/arm/virt.h                       |  1 +
 include/hw/mem/nvdimm.h                     |  3 +
 tests/data/acpi/virt/NFIT.memhp             |  0
 tests/data/acpi/virt/SSDT.memhp             |  0
 tests/qtest/bios-tables-test-allowed-diff.h |  5 ++
 tests/qtest/bios-tables-test.c              |  9 ++-
 20 files changed, 163 insertions(+), 36 deletions(-)
 create mode 100644 tests/data/acpi/virt/NFIT.memhp
 create mode 100644 tests/data/acpi/virt/SSDT.memhp

-- 
2.17.1



