Received: from eggs.gnu.org ([2001:4830:134:3::10]:60376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUT-0001Aj-Jt
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUP-0000ds-NV
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:17 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:45503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUP-0000dV-Cs
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:13 -0400
Received: by mail-wr0-x22d.google.com with SMTP id h2so15084533wre.12
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:13 -0700 (PDT)
Received: from 640k.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	i127sm187460wmf.33.2018.03.13.05.57.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Mar 2018 05:57:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:16 +0100
Message-Id: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/22] KVM patches for QEMU 2.12 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit fb5fff15881ba7a002924b967eb211c002897983:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180312-pull-request' into staging (2018-03-12 18:35:37 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream-sev

for you to fetch changes up to 297dabdd6b39ce1e2ed2e69b4b2afc024e07ad09:

  sev/i386: add sev_get_capabilities() (2018-03-13 12:04:04 +0100)

----------------------------------------------------------------
* Migrate MSR_SMI_COUNT (Liran)
* Update kernel headers (Gerd, myself)
* SEV support (Brijesh)

I have not tested non-x86 compilation, but I reordered the SEV patches
so that all non-x86-specific changes go first to catch any possible
issues (which weren't there anyway :)).

----------------------------------------------------------------
Brijesh Singh (20):
      machine: add memory-encryption option
      docs: add AMD Secure Encrypted Virtualization (SEV)
      kvm: add memory encryption context
      kvm: introduce memory encryption APIs
      target/i386: add Secure Encrypted Virtualization (SEV) object
      sev/i386: qmp: add query-sev command
      include: add psp-sev.h header file
      sev/i386: add command to initialize the memory encryption context
      sev/i386: register the guest memory range which may contain encrypted data
      sev/i386: add command to create launch memory encryption context
      sev/i386: add command to encrypt guest memory region
      target/i386: encrypt bios rom
      sev/i386: add support to LAUNCH_MEASURE command
      sev/i386: finalize the SEV guest launch flow
      sev/i386: add migration blocker
      cpu/i386: populate CPUID 0x8000_001F when SEV is active
      sev/i386: hmp: add 'info sev' command
      sev/i386: qmp: add query-sev-launch-measure command
      sev/i386: qmp: add query-sev-capabilities command
      sev/i386: add sev_get_capabilities()

Liran Alon (1):
      KVM: x86: Add support for save/load MSR_SMI_COUNT

Paolo Bonzini (1):
      update Linux headers to 4.16-rc5

 accel/Makefile.objs                                |   2 +-
 accel/kvm/Makefile.objs                            |   3 +-
 accel/kvm/kvm-all.c                                |  39 +
 accel/kvm/sev-stub.c                               |  26 +
 accel/stubs/kvm-stub.c                             |  10 +
 default-configs/i386-softmmu.mak                   |   1 +
 default-configs/x86_64-softmmu.mak                 |   1 +
 docs/amd-memory-encryption.txt                     | 109 +++
 hmp-commands-info.hx                               |  16 +
 hmp.h                                              |   1 +
 hw/core/machine.c                                  |  22 +
 hw/i386/pc_sysfw.c                                 |  13 +
 include/hw/boards.h                                |   1 +
 include/standard-headers/linux/input-event-codes.h |   1 +
 include/standard-headers/linux/input.h             |  11 +
 include/standard-headers/linux/pci_regs.h          |  30 +-
 include/standard-headers/linux/virtio_net.h        |  13 +
 include/standard-headers/linux/virtio_ring.h       |   2 +-
 include/standard-headers/rdma/vmw_pvrdma-abi.h     |  13 +-
 include/sysemu/kvm.h                               |  17 +
 include/sysemu/sev.h                               |  21 +
 linux-headers/asm-powerpc/kvm.h                    |   2 +
 linux-headers/asm-powerpc/unistd.h                 |   3 +
 linux-headers/asm-s390/unistd.h                    | 401 +---------
 linux-headers/asm-s390/unistd_32.h                 | 364 +++++++++
 linux-headers/asm-s390/unistd_64.h                 | 331 +++++++++
 linux-headers/asm-x86/kvm_para.h                   |   5 +
 linux-headers/linux/kvm.h                          |  92 +++
 linux-headers/linux/psci.h                         |   3 +
 linux-headers/linux/psp-sev.h                      | 142 ++++
 linux-headers/linux/vfio.h                         |  72 ++
 monitor.c                                          |  21 +
 qapi/misc.json                                     | 148 ++++
 qemu-options.hx                                    |  49 +-
 scripts/update-linux-headers.sh                    |   5 +-
 target/i386/Makefile.objs                          |   2 +
 target/i386/cpu.c                                  |  14 +
 target/i386/cpu.h                                  |   3 +
 target/i386/kvm.c                                  |  13 +
 target/i386/machine.c                              |  20 +
 target/i386/monitor.c                              |  66 ++
 target/i386/sev-stub.c                             |  51 ++
 target/i386/sev.c                                  | 811 +++++++++++++++++++++
 target/i386/sev_i386.h                             |  88 +++
 target/i386/trace-events                           |  10 +
 tests/qmp-test.c                                   |   5 +
 46 files changed, 2653 insertions(+), 420 deletions(-)
 create mode 100644 accel/kvm/sev-stub.c
 create mode 100644 docs/amd-memory-encryption.txt
 create mode 100644 include/sysemu/sev.h
 create mode 100644 linux-headers/asm-s390/unistd_32.h
 create mode 100644 linux-headers/asm-s390/unistd_64.h
 create mode 100644 linux-headers/linux/psp-sev.h
 create mode 100644 target/i386/sev-stub.c
 create mode 100644 target/i386/sev.c
 create mode 100644 target/i386/sev_i386.h
-- 
1.8.3.1
