Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F14C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EF120700
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EF120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG3Lo-0004gg-Lw
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 11:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iG3Je-0003A6-QP
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iG3Jd-0006Jr-Go
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:46:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iG3JY-0006FQ-Pl; Thu, 03 Oct 2019 11:46:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E5F4793E5;
 Thu,  3 Oct 2019 15:46:47 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-64.ams2.redhat.com [10.36.117.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 642B219C6A;
 Thu,  3 Oct 2019 15:46:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v4 0/3] KVM/ARM: Fix >256 vcpus
Date: Thu,  3 Oct 2019 17:46:37 +0200
Message-Id: <20191003154640.22451-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 03 Oct 2019 15:46:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: yuzenghui@huawei.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 4.18, KVM/ARM exposes a KVM_MAX_VCPUS equal to 512. However it was
reported [1] that a VM with more than 256 vcpus cannot be launched. 5.4
fixes the situation with 2 patches:
- one upgrade of the KVM_IRQ_LINE API [2] supporting a vcpu id encoded
  on 12 bits,
- the reduction of KVM IO devices consumed by each GICv3 redistributor [3=
]

This series uses the new KVM_IRQ_LINE API and also checks the associated
capability (KVM_CAP_ARM_IRQ_LINE_LAYOUT_2) in machvirt.

Without the series, as soon as the -smp arguments exceeds 256, QEMU exits
with "kvm_set_irq: Invalid argument".

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.1.0-256fix-patch-v4

History:

v3 -> v4:
- headers update against v5.4-rc1
- moved to patch as the kernel dependencies are resolved in 5.4
- Added Richard and Drew's R-b

v2 -> v3:
- simplifications in kvm_arm_gic_set_irq
- Implement KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 check in kvm_arch_init

v1 -> v2:
- New layout set for kvm_arm_gic_set_irq and
  arm_cpu_kvm_set_irq through kvm_arm_set_irq
- Introduced kvm_arm_irq_line_layout_mismatch()

Eric Auger (3):
  linux headers: update against v5.4-rc1
  intc/arm_gic: Support IRQ injection for more than 256 vpus
  ARM: KVM: Check KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 for smp_cpus > 256

 hw/intc/arm_gic_kvm.c                         |   7 +-
 include/standard-headers/asm-x86/bootparam.h  |   2 +
 include/standard-headers/asm-x86/kvm_para.h   |   1 +
 include/standard-headers/linux/ethtool.h      |  24 +++
 include/standard-headers/linux/pci_regs.h     |  19 +-
 include/standard-headers/linux/virtio_fs.h    |  19 ++
 include/standard-headers/linux/virtio_ids.h   |   2 +
 include/standard-headers/linux/virtio_iommu.h | 165 ++++++++++++++++++
 include/standard-headers/linux/virtio_pmem.h  |   6 +-
 linux-headers/asm-arm/kvm.h                   |  16 +-
 linux-headers/asm-arm/unistd-common.h         |   2 +
 linux-headers/asm-arm64/kvm.h                 |  21 ++-
 linux-headers/asm-generic/mman-common.h       |  18 +-
 linux-headers/asm-generic/mman.h              |  10 +-
 linux-headers/asm-generic/unistd.h            |  10 +-
 linux-headers/asm-mips/mman.h                 |   3 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/mman.h              |   6 +-
 linux-headers/asm-powerpc/unistd_32.h         |   2 +
 linux-headers/asm-powerpc/unistd_64.h         |   2 +
 linux-headers/asm-s390/kvm.h                  |   6 +
 linux-headers/asm-s390/unistd_32.h            |   2 +
 linux-headers/asm-s390/unistd_64.h            |   2 +
 linux-headers/asm-x86/kvm.h                   |  28 ++-
 linux-headers/asm-x86/unistd.h                |   2 +-
 linux-headers/asm-x86/unistd_32.h             |   2 +
 linux-headers/asm-x86/unistd_64.h             |   2 +
 linux-headers/asm-x86/unistd_x32.h            |   2 +
 linux-headers/linux/kvm.h                     |  12 +-
 linux-headers/linux/psp-sev.h                 |   5 +-
 linux-headers/linux/vfio.h                    |  71 +++++---
 target/arm/cpu.c                              |  10 +-
 target/arm/kvm.c                              |  22 ++-
 target/arm/kvm_arm.h                          |   1 +
 36 files changed, 434 insertions(+), 71 deletions(-)
 create mode 100644 include/standard-headers/linux/virtio_fs.h
 create mode 100644 include/standard-headers/linux/virtio_iommu.h

--=20
2.20.1


