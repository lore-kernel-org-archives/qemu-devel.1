Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31596C49EAA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B8B20717
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B8B20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRuyC-0002ug-GV
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iRusy-00052f-1k
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iRusw-0007nA-Dw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:12:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2189 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iRuss-0007et-V5; Tue, 05 Nov 2019 04:12:19 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3B6A5595E2CDC4A9135E;
 Tue,  5 Nov 2019 17:12:08 +0800 (CST)
Received: from linux-OtBuvb.huawei.com (10.175.104.212) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 17:12:01 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v2 00/14] Add SDEI support for arm64
Date: Tue, 5 Nov 2019 17:10:42 +0800
Message-ID: <20191105091056.9541-1-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Cornelia Huck <cohuck@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SDEI is for ARM "Software Delegated Exception Interface". AS ARM64 doesn'=
t have
native non-maskable interrupt (NMI), we rely on higher privileged (larger
exception level) software to change the execution flow of lower privilege=
d
(smaller exception level) software when certain events occur, to emulate =
NMI
mechanism, and SDEI is the standard interfaces between the two levels of
privileged software. It is based on SMC/HVC calls.

The higher privileged software implements an SDEI dispatcher to handle SD=
EI
related SMC/HVC calls and trigger SDEI events; the lower privileged softw=
are
implements an SDEI client to request SDEI services and handle SDEI events=
.

Core interfaces provided by SDEI include:

1. interrupt bind: client can request to bind an interrupt to an SDEI eve=
nt, so
the interrupt will be a non-maskable event and the event number will be r=
eturned
to the caller. Only PPI and SPI can be bound to SDEI events.

2. register: client can request to register a handler to an SDEI event, s=
o
dispatcher will change PC of lower privileged software to this handler wh=
en
certain event occurs.

3. complete: client notifies dispatcher that it has completed the event
handling, so dispatcher will restore the context of guest when it is
interrupted.=20

In virtualization situation, guest OS is the lower privileged software an=
d
hypervisor is the higher one.

KVM is supposed to pass SMC/HVC calls to qemu, and qemu will emulate an S=
DEI
dispatcher to serve the SDEI requests and trigger the events. If an inter=
rupt is
requested to be bound to an event, qemu should not inject the interrupt t=
o guest
any more; instead, it should save the context of VCPU and change the PC t=
o event
handler which is registered by guest, and then return to guest.

To make the conversion of interrupt to SDEI event transparent to other mo=
dules
in qemu, we used qemu_irq and qemu_irq_intercept_in() to override the def=
ault
irq handler with SDEI event trigger. I saw qemu_irq_intercept_in() should=
 be
only used in qemu MST, but it seemed fit to override interrupt injection =
with
event trigger after guest requests to bind interrupt to SDEI event.=20

This patchset is trying to implement the whole SDEI framework in qemu wit=
h KVM
enabled, including all SDEI v1.0 interfaces, as well as event trigger con=
duit
from other qemu devices after interrupt binding.=20

Key points:
- We propose to only support kvm enabled arm64 virtual machines, for
  non-kvm VMs can emulate EL3 and have Trusted Firmware run on it,
  which has a builtin SDEI dispatcher.
- New kvm capability KVM_CAP_FORWARD_HYPERCALL is added to probe if
  kvm supports forwarding hypercalls, and the capability should be
  enabled explicitly.
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

Please focus on the interfaces and framework first. We can refine the cod=
e for
several rounds after the big things have been determined.

Any comment or suggestion is welcome.

Thanks,

HG

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>

v2:
- Import import linux/arm_sdei.h to standard-headers
- Drop SDEI table definition and add comments
- Some bugfix and code refinement

Heyi Guo (14):
  update-linux-headers.sh: import linux/arm_sdei.h to standard-headers
  standard-headers: import arm_sdei.h
  arm/sdei: add virtual device framework
  arm: add CONFIG_SDEI build flag
  arm/sdei: add support to handle SDEI requests from guest
  arm/sdei: add system reset callback
  arm/sdei: add support to trigger event by GIC interrupt ID
  core/irq: add qemu_irq_remove_intercept interface
  arm/sdei: override qemu_irq handler when binding interrupt
  arm/sdei: add support to register interrupt bind notifier
  linux-headers/kvm.h: add capability to forward hypercall
  arm/sdei: add stub to fix build failure when SDEI is not enabled
  arm/kvm: handle guest exit of hypercall
  virt/acpi: add SDEI table if SDEI is enabled

 default-configs/arm-softmmu.mak           |    1 +
 hw/arm/Kconfig                            |    4 +
 hw/arm/virt-acpi-build.c                  |   26 +
 hw/core/irq.c                             |   11 +
 include/hw/irq.h                          |    8 +-
 include/standard-headers/linux/arm_sdei.h |   73 +
 linux-headers/linux/kvm.h                 |    1 +
 scripts/update-linux-headers.sh           |    1 +
 target/arm/Makefile.objs                  |    4 +
 target/arm/kvm.c                          |   17 +
 target/arm/sdei-stub.c                    |   49 +
 target/arm/sdei.c                         | 1576 +++++++++++++++++++++
 target/arm/sdei.h                         |   60 +
 target/arm/sdei_int.h                     |  121 ++
 14 files changed, 1950 insertions(+), 2 deletions(-)
 create mode 100644 include/standard-headers/linux/arm_sdei.h
 create mode 100644 target/arm/sdei-stub.c
 create mode 100644 target/arm/sdei.c
 create mode 100644 target/arm/sdei.h
 create mode 100644 target/arm/sdei_int.h

--=20
2.19.1


