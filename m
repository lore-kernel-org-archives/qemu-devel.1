Received: from eggs.gnu.org ([2001:4830:134:3::10]:40147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9Cn-0002lH-Lm
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93X-0001Td-HU
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:43 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93W-0008Hx-9y
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:38 -0500
Received: by mail-wm1-x344.google.com with SMTP id p2-v6so13716619wmc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:07 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	l186-v6sm3223526wma.13.2018.11.06.13.38.04
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Nov 2018 13:38:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:37:46 +0100
Message-Id: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/17] Misc patches for QEMU 3.1 hard freeze (?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit fc3d1bad1edf08871275cf469a64e12dae4eba96:

  oslib-posix: Use MAP_STACK in qemu_alloc_stack() on OpenBSD (2018-11-06 10:52:23 +0000)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to a458774ad711bceabefbf01e8f0b91d86ec72e0c:

  util/qemu-thread-posix: Fix qemu_thread_atexit* for OSX (2018-11-06 21:35:06 +0100)

Vitaly's patch is a bit late; unfortunately I couldn't resend the pull
request yesterday because of a long weekend.  On the other hand this
meant I could include three more bugfix series, and also fix some nits
pointed out by Laszlo who just came back from his own vacation.

----------------------------------------------------------------
* icount fix (Clement)
* dumping fixes for non-volatile memory (Marc-André, myself)
* x86 emulation fix (Rudolf)
* recent Hyper-V CPUID flag (Vitaly)
* Q35 doc fix (Daniel)
* lsi fix (Prasad)
* SCSI block limits emulation fixes (myself)
* qemu_thread_atexit rework (Peter)
* ivshmem memory leak fix (Igor)

----------------------------------------------------------------
Clement Deschamps (1):
      icount: fix deadlock when all cpus are sleeping

Daniel P. Berrangé (1):
      i386: clarify that the Q35 machine type implements a P35 chipset

Igor Mammedov (1):
      ivshmem: fix memory backend leak

Marc-André Lureau (3):
      memory: learn about non-volatile memory region
      nvdimm: set non-volatile on the memory region
      memory-mapping: skip non-volatile memory regions in GuestPhysBlockList

Paolo Bonzini (6):
      MAINTAINERS: remove or downgrade myself to reviewer from some subsystems
      scripts/dump-guest-memory: Synchronize with guest_phys_blocks_region_add
      scsi-generic: keep VPD page list sorted
      scsi-generic: avoid out-of-bounds access to VPD page list
      scsi-generic: avoid invalid access to struct when emulating block limits
      scsi-generic: do not do VPD emulation for sense other than ILLEGAL_REQUEST

Peter Maydell (2):
      include/qemu/thread.h: Document qemu_thread_atexit* API
      util/qemu-thread-posix: Fix qemu_thread_atexit* for OSX

Prasad J Pandit (1):
      lsi53c895a: check message length value is valid

Rudolf Marek (1):
      target/i386: Clear RF on SYSCALL instruction

Vitaly Kuznetsov (1):
      x86: hv_evmcs CPU flag support

 MAINTAINERS                  | 13 +++----
 cpus.c                       |  8 ++++
 docs/devel/migration.rst     |  1 +
 hw/mem/nvdimm.c              |  1 +
 hw/misc/ivshmem.c            |  1 +
 hw/pci-host/q35.c            | 10 ++++-
 hw/scsi/Makefile.objs        |  2 +-
 hw/scsi/emulation.c          | 42 ++++++++++++++++++++
 hw/scsi/lsi53c895a.c         | 19 ++++++++-
 hw/scsi/scsi-disk.c          | 92 ++++++++++----------------------------------
 hw/scsi/scsi-generic.c       | 60 +++++++++++++++++++++--------
 include/exec/memory.h        | 25 ++++++++++++
 include/hw/pci/pci_ids.h     |  2 +-
 include/hw/scsi/emulation.h  | 16 ++++++++
 include/hw/scsi/scsi.h       |  1 -
 include/qemu/thread.h        | 22 +++++++++++
 memory.c                     | 45 +++++++++++++++++-----
 memory_mapping.c             |  3 +-
 scripts/dump-guest-memory.py |  4 +-
 target/i386/cpu.c            |  1 +
 target/i386/cpu.h            |  1 +
 target/i386/hyperv-proto.h   |  2 +
 target/i386/kvm.c            | 30 ++++++++++++++-
 target/i386/seg_helper.c     |  4 +-
 util/qemu-thread-posix.c     | 44 ++++++++++-----------
 25 files changed, 308 insertions(+), 141 deletions(-)
 create mode 100644 hw/scsi/emulation.c
 create mode 100644 include/hw/scsi/emulation.h
-- 
1.8.3.1
