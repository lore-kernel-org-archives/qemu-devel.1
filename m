Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8622C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 16:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF437215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 16:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF437215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGQ5j-0004yZ-D6
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 12:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPuT-0006L7-L2
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPuS-0000Xx-Id
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:54:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44540 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPuO-0000Mn-93; Fri, 04 Oct 2019 11:54:20 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D0FF42812587D8540905;
 Fri,  4 Oct 2019 23:54:07 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 4 Oct 2019 23:54:00 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH 0/5] ARM virt: Add NVDIMM support
Date: Fri, 4 Oct 2019 16:52:57 +0100
Message-ID: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, lersek@redhat.com, linuxarm@huawei.com,
 xuwei5@hisilicon.com, shannon.zhaosl@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds NVDIMM support to arm/virt platform.
This has a dependency on [0] and make use of the GED
device for NVDIMM hotplug events. The series reuses
some of=C2=A0the=C2=A0patches posted by Eric in his earlier
attempt here[1].

Patch 1/5 is a fix to the Guest reboot issue on NVDIMM
hot add case described here[2].

I have done basic sanity testing of NVDIMM deviecs with
both ACPI and DT Guest boot. Further testing is always
welcome.

Please let me know your feedback.

Thanks,
Shameer

[0] https://patchwork.kernel.org/cover/11150345/
[1] https://patchwork.kernel.org/cover/10830777/
[2] https://patchwork.kernel.org/patch/11154757/

Eric Auger (1):
  hw/arm/boot: Expose the pmem nodes in the DT

Kwangwoo Lee (2):
  nvdimm: Use configurable ACPI IO base and size
  hw/arm/virt: Add nvdimm hot-plug infrastructure

Shameer Kolothum (2):
  hw/arm: Align ACPI blob len to PAGE size
  hw/arm/virt: Add nvdimm hotplug support

 docs/specs/acpi_hw_reduced_hotplug.rst |  1 +
 hw/acpi/generic_event_device.c         | 13 ++++++++
 hw/acpi/nvdimm.c                       | 32 ++++++++++++------
 hw/arm/Kconfig                         |  1 +
 hw/arm/boot.c                          | 45 ++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c               | 20 ++++++++++++
 hw/arm/virt.c                          | 42 ++++++++++++++++++++----
 hw/i386/acpi-build.c                   |  6 ++++
 hw/i386/acpi-build.h                   |  3 ++
 hw/i386/pc_piix.c                      |  2 ++
 hw/i386/pc_q35.c                       |  2 ++
 hw/mem/Kconfig                         |  2 +-
 include/hw/acpi/generic_event_device.h |  1 +
 include/hw/arm/virt.h                  |  1 +
 include/hw/mem/nvdimm.h                |  3 ++
 15 files changed, 157 insertions(+), 17 deletions(-)

--=20
2.17.1



