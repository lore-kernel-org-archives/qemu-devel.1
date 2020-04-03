Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3518CC2BA17
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D59A2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D59A2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJRz-0005cB-3t
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jKJQT-0003NG-Pu
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jKJQS-0001sO-Q6
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:19:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50348 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jKJQQ-0001kE-7H; Fri, 03 Apr 2020 06:19:46 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5DAAF1C7CDC4ED513491;
 Fri,  3 Apr 2020 18:19:39 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.24.31) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 3 Apr 2020 18:19:28 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH for-5.0 v2 0/3] acpi: Fixes for inconsistency in ACPI MR size
 during migration
Date: Fri, 3 Apr 2020 11:18:24 +0100
Message-ID: <20200403101827.30664-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.24.31]
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
 mst@redhat.com, dgilbert@redhat.com, xuwei5@hisilicon.com, linuxarm@huawei.com,
 shannon.zhaosl@gmail.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is to fix few issues discovered while adding NVDIMM hot-add
support to arm/virt. These were previously part of [1] and since
the fixes are generic in nature and might be an issue in x86 as
well, they are being treated separately now.

1. https://patchwork.kernel.org/patch/11432371/

v1 --> V2
 - patch #2, Addressed comments from Dave and MST

Updates from [1]:
 -Added R-by and A-by tags.
 -Edited commit log for patch#2
 -Updated patch#3 as per David's comment

David Hildenbrand (1):
  exec: Fix for qemu_ram_resize() callback

Shameer Kolothum (2):
  acpi: Use macro for table-loader file name
  fw_cfg: Migrate ACPI table mr sizes separately

 exec.c                      | 16 ++++++-
 hw/arm/virt-acpi-build.c    |  2 +-
 hw/core/machine.c           |  1 +
 hw/i386/acpi-build.c        |  2 +-
 hw/nvram/fw_cfg.c           | 91 ++++++++++++++++++++++++++++++++++++-
 include/hw/acpi/aml-build.h |  1 +
 include/hw/nvram/fw_cfg.h   |  6 +++
 7 files changed, 114 insertions(+), 5 deletions(-)

-- 
2.17.1



