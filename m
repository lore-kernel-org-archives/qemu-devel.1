Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B385C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB84C20830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB84C20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38728 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDo3n-0007FG-3e
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 06:32:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo1t-00062X-69
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo1r-0007H9-Vy
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2258 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo1o-0007Bx-GR; Tue, 09 Apr 2019 06:30:56 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 5C57B8640ACF8D4AC4B1;
	Tue,  9 Apr 2019 18:30:47 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
	DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server
	id 14.3.408.0; Tue, 9 Apr 2019 18:30:40 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
	<imammedo@redhat.com>
Date: Tue, 9 Apr 2019 11:29:27 +0100
Message-ID: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: [Qemu-devel] [PATCH v4 0/8] ARM virt: ACPI memory hotplug support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
	linuxarm@huawei.com, xuwei5@hisilicon.com,
	shannon.zhaosl@gmail.com, sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409102927.zdEqcHJqoDiGoizzm02Jdy2Q_5aIhK4rRldOpLDxjOg@z>

This series is an attempt to provide device memory hotplug support 
on ARM virt platform. This is based on Eric's recent works here[1]
and carries some of the pc-dimm related patches dropped from his
series.

The kernel support for arm64 memory hot add was added recently by
Robin and hence the guest kernel should be => 5.0-rc1.

NVDIM support is not included currently as we still have an unresolved
issue while hot adding NVDIMM[2]. However NVDIMM cold plug patches
can be included, but not done for now, for keeping it simple.

This makes use of GED device to sent hotplug ACPI events to the
Guest. GED code is based on Nemu. Thanks to the efforts of Samuel and
Sebastien to add the hardware-reduced support to Nemu using GED
device[3]. (Please shout if I got the author/signed-off wrong for
those patches or missed any names).

This is sanity tested on a HiSilicon ARM64 platform and appreciate
any further testing.

Thanks,
Shameer

[1] https://patchwork.kernel.org/cover/10837565/
[2] https://patchwork.kernel.org/cover/10783589/
[3] https://github.com/intel/nemu/blob/topic/virt-x86/hw/acpi/ged.c

v3 --> v4
Addressed comments from Igor and Eric,
-Renamed "virt-acpi" to "acpi-ged".
-Changed ged device parent to TYPE_DEVICE.
-Introduced DT memory node property "hotpluggable" to resolve device
 memory being treated as early boot memory issue(patch #7).
-Combined patches #3 and #9 from v3 into #3.

v2 --> v3

Addressed comments from Igor and Eric,
-Made virt acpi device platform independent and moved
 to hw/acpi/generic_event_device.c
-Moved ged specific code into hw/acpi/generic_event_device.c
-Introduced an opt-in feature "fdt" to resolve device-memory being
 treated as early boot memory.
-Dropped patch #1 from v2.

RFC --> v2

-Use GED device instead of GPIO for ACPI hotplug events.
-Removed NVDIMM support for now.
-Includes dropped patches from Eric's v9 series.

Eric Auger (1):
  hw/arm/virt: Add memory hotplug framework

Samuel Ortiz (2):
  hw/acpi: Do not create memory hotplug method when handler is not
    defined
  hw/acpi: Add ACPI Generic Event Device Support

Shameer Kolothum (5):
  hw/acpi: Make ACPI IO address space configurable
  hw/arm/virt: Enable device memory cold/hot plug with ACPI boot
  hw/arm/virt-acpi-build: Add PC-DIMM in SRAT
  hw/arm/boot: Add "hotpluggable" property to DT memory node
  hw/arm/boot: Expose the PC-DIMM nodes in the DT

 default-configs/arm-softmmu.mak        |   5 +
 hw/acpi/Kconfig                        |   4 +
 hw/acpi/Makefile.objs                  |   1 +
 hw/acpi/generic_event_device.c         | 311 +++++++++++++++++++++++++++++++++
 hw/acpi/memory_hotplug.c               |  35 ++--
 hw/arm/boot.c                          |  64 ++++++-
 hw/arm/virt-acpi-build.c               |  18 ++
 hw/arm/virt.c                          | 102 ++++++++++-
 hw/i386/acpi-build.c                   |   3 +-
 include/hw/acpi/generic_event_device.h | 121 +++++++++++++
 include/hw/acpi/memory_hotplug.h       |   9 +-
 include/hw/arm/virt.h                  |   4 +
 12 files changed, 654 insertions(+), 23 deletions(-)
 create mode 100644 hw/acpi/generic_event_device.c
 create mode 100644 include/hw/acpi/generic_event_device.h

-- 
2.7.4



