Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE207C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33F8208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33F8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIZXX-0002A2-Fy
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 10:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iIZVw-0000ev-UZ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iIZVq-0000z7-Li
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:34:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iIZVo-0000wG-Kx
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:33:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A9743069609;
 Thu, 10 Oct 2019 14:33:50 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F16D60BF7;
 Thu, 10 Oct 2019 14:33:36 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/15] Introduce the microvm machine type
Date: Thu, 10 Oct 2019 16:31:10 +0200
Message-Id: <20191010143125.67246-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 10 Oct 2019 14:33:50 +0000 (UTC)
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 lersek@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Microvm is a machine type inspired by Firecracker and constructed
after the its machine model.

It's a minimalist machine type without PCI nor ACPI support, designed
for short-lived guests. Microvm also establishes a baseline for
benchmarking and optimizing both QEMU and guest operating systems,
since it is optimized for both boot time and footprint.

---

Changelog
v8:
 - Split "[PATCH v7 03/12] hw/i386/pc: fix code style issues on
   functions that will be moved out" into four different patches
   (Philippe Mathieu-Daud=C3=A9)

v7:
 - Fix code style issues on already present code touched by this patch
   series (Michael S. Tsirkin, Philippe Mathieu-Daud=C3=A9)
 - Add new files to MAINTAINERS (Michael S. Tsirkin, Philippe
   Mathieu-Daud=C3=A9)
 - Allow starting a microvm machine without a kernel image, fixing
   "qom-test" (Michael S. Tsirkin)
 - Change "bios-microvm.bin" mode to 0644 (Stefano Garzarella)
 - Remove unneeded "hw/i386/pc.h" include from x86.c (Stefano
   Garzarella)

v6:
 - Some style fixes (Philippe Mathieu-Daud=C3=A9)
 - Fix a documentation bug stating that LAPIC was in userspace (Paolo
   Bonzini)
 - Update Xen HVM code after X86MachineState introduction (Philippe
   Mathieu-Daud=C3=A9)
 - Rename header guard from QEMU_VIRTIO_MMIO_H to HW_VIRTIO_MMIO_H
   (Philippe Mathieu-Daud=C3=A9)

v5:
 - Drop unneeded "[PATCH v4 2/8] hw/i386: Factorize e820 related
   functions" (Philippe Mathieu-Daud=C3=A9)
 - Drop unneeded "[PATCH v4 1/8] hw/i386: Factorize PVH related
   functions" (Stefano Garzarella)
 - Split X86MachineState introduction into smaller patches (Philippe
   Mathieu-Daud=C3=A9)
 - Change option-roms to x-option-roms and kernel-cmdline to
   auto-kernel-cmdline (Paolo Bonzini)
 - Make i8259 PIT and i8254 PIC optional (Paolo Bonzini)
 - Some fixes to the documentation (Paolo Bonzini)
 - Switch documentation format from txt to rst (Peter Maydell)
 - Move NMI interface to X86_MACHINE (Philippe Mathieu-Daud=C3=A9, Paolo
   Bonzini)

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

---

Sergio Lopez (15):
  hw/virtio: Factorize virtio-mmio headers
  hw/i386/pc: rename functions shared with non-PC machines
  hw/i386/pc: fix code style issues on functions that will be moved out
  hw/i386/pc: replace use of strtol with qemu_strtol in x86_load_linux()
  hw/i386/pc: avoid an assignment in if condition in x86_load_linux()
  hw/i386/pc: remove commented out code from x86_load_linux()
  hw/i386/pc: move shared x86 functions to x86.c and export them
  hw/i386: split PCMachineState deriving X86MachineState from it
  hw/i386: make x86.c independent from PCMachineState
  fw_cfg: add "modify" functions for all types
  hw/intc/apic: reject pic ints if isa_pic =3D=3D NULL
  roms: add microvm-bios (qboot) as binary and git submodule
  docs/microvm.rst: document the new microvm machine type
  hw/i386: Introduce the microvm machine type
  MAINTAINERS: add microvm related files

 docs/microvm.rst                 |  98 ++++
 default-configs/i386-softmmu.mak |   1 +
 include/hw/i386/microvm.h        |  83 ++++
 include/hw/i386/pc.h             |  28 +-
 include/hw/i386/x86.h            |  96 ++++
 include/hw/nvram/fw_cfg.h        |  42 ++
 include/hw/virtio/virtio-mmio.h  |  73 +++
 hw/acpi/cpu_hotplug.c            |  10 +-
 hw/i386/acpi-build.c             |  29 +-
 hw/i386/amd_iommu.c              |   3 +-
 hw/i386/intel_iommu.c            |   3 +-
 hw/i386/microvm.c                | 572 ++++++++++++++++++++++
 hw/i386/pc.c                     | 781 +++---------------------------
 hw/i386/pc_piix.c                |  46 +-
 hw/i386/pc_q35.c                 |  38 +-
 hw/i386/pc_sysfw.c               |  60 +--
 hw/i386/x86.c                    | 795 +++++++++++++++++++++++++++++++
 hw/i386/xen/xen-hvm.c            |  28 +-
 hw/intc/apic.c                   |   2 +-
 hw/intc/ioapic.c                 |   2 +-
 hw/nvram/fw_cfg.c                |  29 ++
 hw/virtio/virtio-mmio.c          |  48 +-
 .gitmodules                      |   3 +
 MAINTAINERS                      |  10 +
 hw/i386/Kconfig                  |   4 +
 hw/i386/Makefile.objs            |   2 +
 pc-bios/bios-microvm.bin         | Bin 0 -> 65536 bytes
 roms/Makefile                    |   6 +
 roms/qboot                       |   1 +
 29 files changed, 1982 insertions(+), 911 deletions(-)
 create mode 100644 docs/microvm.rst
 create mode 100644 include/hw/i386/microvm.h
 create mode 100644 include/hw/i386/x86.h
 create mode 100644 include/hw/virtio/virtio-mmio.h
 create mode 100644 hw/i386/microvm.c
 create mode 100644 hw/i386/x86.c
 create mode 100644 pc-bios/bios-microvm.bin
 create mode 160000 roms/qboot

--=20
2.21.0


