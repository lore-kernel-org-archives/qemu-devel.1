Received: from eggs.gnu.org ([2001:4830:134:3::10]:37596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D2-0007H9-8U
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5Cx-00074U-N5
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5Cx-00074I-Ev
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:03 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77DF881127
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:23:02 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-19.ams2.redhat.com
	[10.36.116.19])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id uBMFN1xD027210
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 10:23:01 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:35 +0100
Message-Id: <20161222152300.32395-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/25] First round of misc patches for QEMU 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit d1e8e8ecc3d2a1a72504912d671f1cbbac1b06=
e5:

  Merge remote-tracking branch 'remotes/huth/tags/target-dirs-20161220' i=
nto staging (2016-12-21 21:11:48 +0000)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 6c7c3c21f95dd9af8a0691c0dd29b07247984122:

  x86: implement la57 paging mode (2016-12-22 16:01:04 +0100)

----------------------------------------------------------------
* core support for MemoryRegionCache from myself
* rules.mak speedup and cleanups from myself and Marc-Adnr=C3=A9
* multiboot command line fix from Vlad
* SCSI fixes from myself
* small qemu-timer speedup from myself
* x86 debugging improvements from Doug
* configurable Q35 devices from  Chao
* x86 5-level paging support from Kirill
* x86 SHA_NI support for KVM from Yi Sun
* improved kvmclock migration logic from Marcelo
* bugfixes and doc fixes from others

----------------------------------------------------------------
Chao Peng (3):
      pc: make smbus configurable
      pc: make sata configurable
      pc: make pit configurable

Doug Evans (2):
      x86: Fix x86_64 'g' packet response to gdb from 32-bit mode.
      target-i386: Fix eflags.TF/#DB handling of syscall/sysret insns

Kirill A. Shutemov (1):
      x86: implement la57 paging mode

Li Qiang (1):
      watchdog: 6300esb: add exit function

Marc-Andr=C3=A9 Lureau (1):
      build-sys: remove libtool left-over

Marcelo Tosatti (2):
      kvm: sync linux headers
      kvmclock: reduce kvmclock difference on migration

Paolo Bonzini (9):
      exec: optimize remaining address_space_* cases
      exec: introduce memory_ldst.inc.c
      exec: introduce address_space_extend_translation
      exec: introduce MemoryRegionCache
      rules.mak: speedup save-vars load-vars
      rules.mak: add more rules to avoid chaining
      virtio-scsi: introduce virtio_scsi_acquire/release
      qemu-timer: check active_timers outside lock/event
      scsi-disk: fix VERIFY for scsi-block

Vlad Lungu (1):
      multiboot: copy the cmdline verbatim, unescape module strings

Yaowei Bai (3):
      timer: fix misleading comment in timer.h
      main-loop: update comment for qemu_mutex_lock/unlock_iothread
      block: drop remaining legacy aio functions in comment

Yi Sun (1):
      target-i386: Add Intel SHA_NI instruction support.

Ziyue Yang (1):
      hw/block/pflash_cfi*.c: fix confusing assert fail message

 .gitignore                                |   4 -
 Makefile                                  |   9 +-
 Makefile.objs                             |   1 -
 Makefile.target                           |   1 +
 configure                                 |   2 -
 exec.c                                    | 687 ++++--------------------=
-----
 hw/block/pflash_cfi01.c                   |  13 +
 hw/block/pflash_cfi02.c                   |  13 +
 hw/i386/kvm/clock.c                       | 142 +++++-
 hw/i386/multiboot.c                       |  20 +-
 hw/i386/pc.c                              |  68 ++-
 hw/i386/pc_piix.c                         |   2 +-
 hw/i386/pc_q35.c                          |  39 +-
 hw/scsi/scsi-disk.c                       |   9 +-
 hw/scsi/virtio-scsi.c                     |  27 +-
 hw/watchdog/wdt_i6300esb.c                |   9 +
 include/block/aio.h                       |   4 +-
 include/exec/cpu-all.h                    |  23 +
 include/exec/cpu-common.h                 |  15 -
 include/exec/memory.h                     | 166 +++++++
 include/hw/i386/pc.h                      |  12 +
 include/qemu/main-loop.h                  |   4 +-
 include/qemu/timer.h                      |   2 +-
 include/qemu/typedefs.h                   |   1 +
 include/standard-headers/linux/input.h    |   1 +
 include/standard-headers/linux/pci_regs.h |  15 +-
 linux-headers/asm-arm/kvm.h               |   7 +
 linux-headers/asm-x86/unistd_32.h         |   3 +
 linux-headers/asm-x86/unistd_64.h         |   3 +
 linux-headers/asm-x86/unistd_x32.h        |   3 +
 linux-headers/linux/kvm.h                 |   7 +
 memory_ldst.inc.c                         | 709 ++++++++++++++++++++++++=
++++++
 qemu-timer.c                              |  20 +-
 rules.mak                                 |  26 +-
 target/i386/arch_memory_mapping.c         |  42 +-
 target/i386/bpt_helper.c                  |   7 +
 target/i386/cpu.c                         |  18 +-
 target/i386/cpu.h                         |   3 +
 target/i386/gdbstub.c                     |  52 ++-
 target/i386/helper.c                      |  54 ++-
 target/i386/helper.h                      |   1 +
 target/i386/kvm.c                         |   7 +
 target/i386/kvm_i386.h                    |   1 +
 target/i386/monitor.c                     | 234 +++++++---
 target/i386/translate.c                   |  29 +-
 45 files changed, 1722 insertions(+), 793 deletions(-)
 create mode 100644 memory_ldst.inc.c
--=20
2.9.3
