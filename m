Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F42AC7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69078206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69078206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b5F-0000xh-Hz
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2w-0004I4-E6
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2u-0000V7-KO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2714 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2q-0000Gg-FE; Mon, 17 Feb 2020 02:42:20 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 081D9DFADD86BAE88059;
 Mon, 17 Feb 2020 15:42:10 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:03 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 00/16] Implement Microvm for aarch64 architecture
Date: Mon, 17 Feb 2020 02:51:12 -0500
Message-ID: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
X-Originating-IP: [10.175.124.177]
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
Cc: zhang.zhanghailiang@huawei.com, slp@redhat.com,
 Xu Yandong <xuyandong2@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement Microvm for aarch64 architecture

This series attempts to implement microvm for aarch64
architecture.

Just like how Sergio Lopez does for implementing microvm
for x86 architecture. We remove parts of emulate devices which
are not needed in microvm, compared with normal VM,
We only keep PL011 (UART), PL031 (RTC) and virtio-mmio
devices for microvm of aarch64.

We compared the boot time between virt VM and microvm With the
follow command lines:
For microvm:
qemu-system-aarch64 \
    -cpu host \
    -smp 1,sockets=3D1,cores=3D1,threads=3D1 \
    -m 1024M \
    -machine microvm,accel=3Dkvm,gic-version=3D3 \
    -kernel vmlinux.bin \
    -drive id=3Dtest,file=3Dubuntu-rootfs.img,format=3Draw,if=3Dnone \
    -device virtio-blk-device,drive=3Dtest \
    -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
    -device virtio-net-device,netdev=3Dtap0 \
    -append "root=3D/dev/vda rw printk.time=3Dy" \
    -nographic
Normal VM=EF=BC=9AOnly changed the machine type to 'virt'
qemu-system-aarch64 \
    -cpu host \
    -smp 1,sockets=3D1,cores=3D1,threads=3D1 \
    -m 1024M \
    -machine virt,accel=3Dkvm,gic-version=3D3 \
    -kernel vmlinux.bin \
    -drive id=3Dtest,file=3Dubuntu-rootfs.img,format=3Draw,if=3Dnone \
    -device virtio-blk-device,drive=3Dtest \
    -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
    -device virtio-net-device,netdev=3Dtap0 \
    -append "root=3D/dev/vda rw printk.time=3Dy" \
    -nographic

This is the test results:
1. Boot time
1) boot time after dropped caches(echo 3 > /proc/sys/vm/drop_caches)
normal virt Machine: 204 ms
microvm Machine: 132 ms

2) boot time with caches
normal virt Machine: 168 ms
microvm Machine: 71 ms

2. MMIO regions
normal virt Machine:
address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-0000000003ffffff (prio 0, romd): virt.flash0
    0000000004000000-0000000007ffffff (prio 0, romd): virt.flash1
    0000000008000000-000000000800ffff (prio 0, i/o): gicv3_dist
    0000000008080000-000000000809ffff (prio 0, i/o): gicv3_its
      0000000008080000-000000000808ffff (prio 0, i/o): control
      0000000008090000-000000000809ffff (prio 0, i/o): translation
    00000000080a0000-00000000080bffff (prio 0, i/o): gicv3_redist_region[=
0]
    0000000009000000-0000000009000fff (prio 0, i/o): pl011
    0000000009010000-0000000009010fff (prio 0, i/o): pl031
    0000000009020000-0000000009020007 (prio 0, i/o): fwcfg.data
    0000000009020008-0000000009020009 (prio 0, i/o): fwcfg.ctl
    0000000009020010-0000000009020017 (prio 0, i/o): fwcfg.dma
    0000000009030000-0000000009030fff (prio 0, i/o): pl061
    000000000a000000-000000000a0001ff (prio 0, i/o): virtio-mmio
 	... skipped 30 virtio-mmio region
    000000000a003e00-000000000a003fff (prio 0, i/o): virtio-mmio
    000000000c000000-000000000dffffff (prio 0, i/o): platform bus
    0000000010000000-000000003efeffff (prio 0, i/o): alias pcie-mmio @gpe=
x_mmio 0000000010000000-000000003efeffff
    000000003eff0000-000000003effffff (prio 0, i/o): gpex_ioport
      000000003eff1000-000000003eff101f (prio 1, i/o): virtio-pci
    0000000040000000-000000007fffffff (prio 0, ram): mach-virt.ram
    0000004010000000-000000401fffffff (prio 0, i/o): alias pcie-ecam @pci=
e-mmcfg-mmio 0000000000000000-000000000fffffff
    0000008000000000-000000ffffffffff (prio 0, i/o): alias pcie-mmio-high=
 @gpex_mmio 0000008000000000-000000ffffffffff

microvm Machine:
address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
  0000000008000000-000000000800ffff (prio 0, i/o): gicv3_dist
    00000000080a0000-00000000080bffff (prio 0, i/o): gicv3_redist_region[=
0]
    0000000009000000-0000000009000fff (prio 0, i/o): pl011
    0000000009010000-0000000009010fff (prio 0, i/o): pl031
    000000000a000000-000000000a0001ff (prio 0, i/o): virtio-mmio
	... skipped 30 virtio-mmio region
    000000000a003e00-000000000a003fff (prio 0, i/o): virtio-mmio
    0000000040000000-000000007fffffff (prio 0, ram): mach-virt.ram

Please review this series.

Thinks,
Xu Yandong.

Xu Yandong (16):
  hw/arm/arm: Introduce ArmMachineState and ArmMachineClass
  hw/arm: move shared fdt member to ArmMachine
  hw/arm: move shared memmap member to ArmMachine
  hw/arm: move shared irqmap member to ArmMachine
  hw/arm: move shared smp_cpus member to ArmMachine
  hw/arm/virt: split MSI related codes from create_gic
  hw/arm/virt: split virt extension related codes from create_gic
  hw/arm/virt: split secure extension related codes from create_gic
  hw/arm: move shared gic member to ArmMachine
  hw/arm: split create_gic function
  hw/arm: move shared psci_enable and claim_edge_triggered_timers member
    to ArmMachine
  hw/arm: move shared devices related functions to arm.c and export them
  hw/arm: move shared fdt related functions to arm.c and export them
  hw/arm: move shared bootinfo member to ArmMachine
  hw/arm: move shared cpu related functions to arm.c and export them
  hw/arm: Introduce the microvm machine type

 default-configs/aarch64-softmmu.mak |    2 +
 hw/arm/Kconfig                      |    7 +
 hw/arm/Makefile.objs                |    3 +-
 hw/arm/arm.c                        |  687 +++++++++++++++++
 hw/arm/microvm.c                    |  303 ++++++++
 hw/arm/virt-acpi-build.c            |   48 +-
 hw/arm/virt.c                       | 1079 +++++++--------------------
 include/hw/arm/arm.h                |  152 ++++
 include/hw/arm/microvm.h            |   40 +
 include/hw/arm/virt.h               |   86 +--
 10 files changed, 1505 insertions(+), 902 deletions(-)
 create mode 100644 hw/arm/arm.c
 create mode 100644 hw/arm/microvm.c
 create mode 100644 include/hw/arm/arm.h
 create mode 100644 include/hw/arm/microvm.h

--=20
2.18.1


