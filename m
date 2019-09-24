Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED9BC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FE820673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FE820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnRz-0000xu-La
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iCmf4-0001A4-BA
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iCmf2-0006i4-S7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:23:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2243 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iCmez-0006fv-P1; Tue, 24 Sep 2019 11:23:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4C7D13C505E55FB75118;
 Tue, 24 Sep 2019 23:23:22 +0800 (CST)
Received: from linux-Bxxcye.huawei.com (10.175.104.222) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Sep 2019 23:23:13 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 00/12] Add SDEI support for arm64
Date: Tue, 24 Sep 2019 23:21:39 +0800
Message-ID: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.222]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 James Morse <james.morse@arm.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As promised, this is the first RFC patch set for arm64 SDEI support.
Key points:
- We propose to only support kvm enabled arm64 virtual machines, for
  non-kvm VMs can emulate EL3 and have Trusted Firmware run on it,
  which has a builtin SDEI dispatcher.
- New kvm capability KVM_CAP_FORWARD_HYPERCALL is added to probe if
  kvm supports forwarding hypercalls, and the capability should be
  enabled explicitly. PSCI can be set as exception for backward
  compatibility.
- We make the dispatcher as a logical device, to save the states
  during migration or save/restore operation; only one instance is
  allowed in one VM.
- We use qemu_irq as the bridge for other qemu modules to switch from
  irq injection to SDEI event trigger after VM binds the interrupt to
  SDEI event. We use qemu_irq_intercept_in() to override qemu_irq
  handler with SDEI event trigger, and a new interface
  qemu_irq_remove_intercept() is added to restore the handler to
  default one (i.e. ARM GIC).

More details are in the commit message of each patch.

Basic tests are done by emulating a watchdog timer and triggering SDEI
event in every 10s.

As this is the first rough RFC, please focus on the interfaces and
framework first. We can refine the code for several rounds after the
big things have been determined.

Please give your comments and suggestions.

Thanks,
HG

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>

Heyi Guo (12):
  linux-headers: import arm_sdei.h
  arm/sdei: add virtual device framework
  arm/sdei: add support to handle SDEI requests from guest
  arm/sdei: add system reset callback
  arm/sdei: add support to trigger event by GIC interrupt ID
  core/irq: add qemu_irq_remove_intercept interface
  arm/sdei: override qemu_irq handler when binding interrupt
  arm/sdei: add support to register interrupt bind notifier
  linux-headers/kvm.h: add capability to forward hypercall
  arm/sdei: check KVM cap and enable SDEI
  arm/kvm: handle guest exit of hypercall
  virt/acpi: add SDEI table if SDEI is enabled

 hw/arm/virt-acpi-build.c       |   16 +
 hw/core/irq.c                  |   11 +
 include/hw/acpi/acpi-defs.h    |    5 +
 include/hw/irq.h               |    8 +-
 linux-headers/linux/arm_sdei.h |   73 ++
 linux-headers/linux/kvm.h      |    3 +
 target/arm/Makefile.objs       |    1 +
 target/arm/kvm.c               |   17 +
 target/arm/sdei.c              | 1518 ++++++++++++++++++++++++++++++++++++++++
 target/arm/sdei.h              |   60 ++
 target/arm/sdei_int.h          |  109 +++
 11 files changed, 1819 insertions(+), 2 deletions(-)
 create mode 100644 linux-headers/linux/arm_sdei.h
 create mode 100644 target/arm/sdei.c
 create mode 100644 target/arm/sdei.h
 create mode 100644 target/arm/sdei_int.h

-- 
1.8.3.1


