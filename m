Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22271C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3292064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3292064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkoj-0004f7-GH
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iCkBn-0002eX-D3
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iCkBl-0004Wb-C7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iCkBl-0004WT-4b
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:45:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 29B7518C37B;
 Tue, 24 Sep 2019 12:45:04 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87B0D60852;
 Tue, 24 Sep 2019 12:44:50 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/8] Introduce the microvm machine type
Date: Tue, 24 Sep 2019 14:44:25 +0200
Message-Id: <20190924124433.96810-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 24 Sep 2019 12:45:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Sergio Lopez <slp@redhat.com>, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, lersek@redhat.com, mtosatti@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Microvm is a machine type inspired by both NEMU and Firecracker, and
constructed after the machine model implemented by the latter.

It's main purpose is providing users a minimalist machine type free
from the burden of legacy compatibility, serving as a stepping stone
for future projects aiming at improving boot times, reducing the
attack surface and slimming down QEMU's footprint.

The microvm machine type supports the following devices:

 - ISA bus
 - i8259 PIC
 - LAPIC (implicit if using KVM)
 - IOAPIC (defaults to kernel_irqchip_split =3D true)
 - i8254 PIT
 - MC146818 RTC (optional)
 - kvmclock (if using KVM)
 - fw_cfg
 - One ISA serial port (optional)
 - Up to eight virtio-mmio devices (configured by the user)

It supports the following machine-specific options:

microvm.option-roms=3Dbool (Set off to disable loading option ROMs)
microvm.isa-serial=3Dbool (Set off to disable the instantiation an ISA se=
rial port)
microvm.rtc=3Dbool (Set off to disable the instantiation of an MC146818 R=
TC)
microvm.kernel-cmdline=3Dbool (Set off to disable adding virtio-mmio devi=
ces to the kernel cmdline)

By default, microvm uses qboot as its BIOS, to obtain better boot
times, but it's also compatible with SeaBIOS.

As no current FW is able to boot from a block device using virtio-mmio
as its transport, a microvm-based VM needs to be run using a host-side
kernel and, optionally, an initrd image.

This is an example of instantiating a microvm VM with a virtio-mmio
based console:

qemu-system-x86_64 -M microvm
 -enable-kvm -cpu host -m 512m -smp 2 \
 -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
 -nodefaults -no-user-config -nographic \
 -chardev stdio,id=3Dvirtiocon0,server \
 -device virtio-serial-device \
 -device virtconsole,chardev=3Dvirtiocon0 \
 -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
 -device virtio-blk-device,drive=3Dtest \
 -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
 -device virtio-net-device,netdev=3Dtap0

This is another example, this time using an ISA serial port, useful
for debugging purposes:

qemu-system-x86_64 -M microvm \
 -enable-kvm -cpu host -m 512m -smp 2 \
 -kernel vmlinux -append "earlyprintk=3DttyS0 console=3DttyS0 root=3D/dev=
/vda" \
 -nodefaults -no-user-config -nographic \
 -serial stdio \
 -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
 -device virtio-blk-device,drive=3Dtest \
 -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
 -device virtio-net-device,netdev=3Dtap0

Finally, in this example a microvm VM is instantiated without RTC,
without an ISA serial port and without loading the option ROMs,
obtaining the smallest configuration:

qemu-system-x86_64 -M microvm,rtc=3Doff,isa-serial=3Doff,option-roms=3Dof=
f \
 -enable-kvm -cpu host -m 512m -smp 2 \
 -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
 -nodefaults -no-user-config -nographic \
 -chardev stdio,id=3Dvirtiocon0,server \
 -device virtio-serial-device \
 -device virtconsole,chardev=3Dvirtiocon0 \
 -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
 -device virtio-blk-device,drive=3Dtest \
 -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
 -device virtio-net-device,netdev=3Dtap0

---

Changelog
v4:
 - This is a complete rewrite of the whole patchset, with a focus on
   reusing as much existing code as possible to ease the maintenance burd=
en
   and making the machine type as compatible as possible by default. As
   a result, the number of lines dedicated specifically to microvm is
   383 (code lines measured by "cloc") and, with the default
   configuration, it's now able to boot both PVH ELF images and
   bzImages with either SeaBIOS or qboot.

v3:
  - Add initrd support (thanks Stefano).

v2:
  - Drop "[PATCH 1/4] hw/i386: Factorize CPU routine".
  - Simplify machine definition (thanks Eduardo).
  - Remove use of unneeded NUMA-related callbacks (thanks Eduardo).
  - Add a patch to factorize PVH-related functions.
  - Replace use of Linux's Zero Page with PVH (thanks Maran and Paolo).
 =20
---
Sergio Lopez (8):
  hw/i386: Factorize PVH related functions
  hw/i386: Factorize e820 related functions
  hw/virtio: Factorize virtio-mmio headers
  hw/i386: split PCMachineState deriving X86MachineState from it
  fw_cfg: add "modify" functions for all types
  roms: add microvm-bios (qboot) as binary and git submodule
  docs/microvm.txt: document the new microvm machine type
  hw/i386: Introduce the microvm machine type

 .gitmodules                      |   3 +
 default-configs/i386-softmmu.mak |   1 +
 docs/microvm.txt                 |  78 +++
 hw/acpi/cpu_hotplug.c            |  10 +-
 hw/i386/Kconfig                  |   4 +
 hw/i386/Makefile.objs            |   4 +
 hw/i386/acpi-build.c             |  31 +-
 hw/i386/amd_iommu.c              |   4 +-
 hw/i386/e820.c                   |  99 ++++
 hw/i386/e820.h                   |  11 +
 hw/i386/intel_iommu.c            |   4 +-
 hw/i386/microvm.c                | 512 +++++++++++++++++
 hw/i386/pc.c                     | 960 +++----------------------------
 hw/i386/pc_piix.c                |  48 +-
 hw/i386/pc_q35.c                 |  38 +-
 hw/i386/pc_sysfw.c               |  60 +-
 hw/i386/pvh.c                    | 113 ++++
 hw/i386/pvh.h                    |  10 +
 hw/i386/x86.c                    | 788 +++++++++++++++++++++++++
 hw/intc/ioapic.c                 |   3 +-
 hw/nvram/fw_cfg.c                |  29 +
 hw/virtio/virtio-mmio.c          |  35 +-
 include/hw/i386/microvm.h        |  80 +++
 include/hw/i386/pc.h             |  40 +-
 include/hw/i386/x86.h            |  97 ++++
 include/hw/nvram/fw_cfg.h        |  42 ++
 include/hw/virtio/virtio-mmio.h  |  60 ++
 pc-bios/bios-microvm.bin         | Bin 0 -> 65536 bytes
 roms/Makefile                    |   6 +
 roms/qboot                       |   1 +
 target/i386/kvm.c                |   1 +
 31 files changed, 2102 insertions(+), 1070 deletions(-)
 create mode 100644 docs/microvm.txt
 create mode 100644 hw/i386/e820.c
 create mode 100644 hw/i386/e820.h
 create mode 100644 hw/i386/microvm.c
 create mode 100644 hw/i386/pvh.c
 create mode 100644 hw/i386/pvh.h
 create mode 100644 hw/i386/x86.c
 create mode 100644 include/hw/i386/microvm.h
 create mode 100644 include/hw/i386/x86.h
 create mode 100644 include/hw/virtio/virtio-mmio.h
 create mode 100755 pc-bios/bios-microvm.bin
 create mode 160000 roms/qboot

--=20
2.21.0


