Received: from eggs.gnu.org ([2001:4830:134:3::10]:36242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrE-0007rD-8j
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrA-0002Ec-24
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:40 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chJr9-0002EY-Oj
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:35 -0500
Received: by mail-wm0-x22e.google.com with SMTP id v77so19969780wmv.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:40:35 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56]) by smtp.gmail.com with ESMTPSA id
	s26sm8814533wra.66.2017.02.24.09.40.32 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 Feb 2017 09:40:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Feb 2017 18:40:13 +0100
Message-Id: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 00/17] KVM and cpu-exec patches for 2.9 soft
 freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit a1cf5fac2b929ffa2abd1285401f2535ff8c6fea:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-block-2017-02-21' into staging (2017-02-21 13:58:50 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f9e640f9a1a7185591985e10a557f11fbe783b87:

  qmp-events: fix GUEST_PANICKED description formatting (2017-02-24 16:19:44 +0100)

----------------------------------------------------------------
* kernel header update (requested by David and Vijay)
* GuestPanicInformation fixups (Anton)
* record/replay icount fixes (Pavel)
* cpu-exec cleanup, unification of icount_decr with tcg_exit_req (me)
* KVM_CAP_IMMEDIATE_EXIT support (me)
* vmxcap update (me)

----------------------------------------------------------------
Anton Nefedov (2):
      qapi: flatten GuestPanicInformation union
      qmp-events: fix GUEST_PANICKED description formatting

Paolo Bonzini (14):
      cpu-exec: unify icount_decr and tcg_exit_req
      cpu-exec: remove unnecessary check of cpu->exit_request
      update-linux-headers: update for 4.11
      update Linux headers to 4.11
      cpus: remove ugly cast on sigbus_handler
      KVM: x86: cleanup SIGBUS handlers
      cpus: reorganize signal handling code
      KVM: remove kvm_arch_on_sigbus
      KVM: do not use sigtimedwait to catch SIGBUS
      KVM: move SIG_IPI handling to kvm-all.c
      kvm: use atomic_read/atomic_set to access cpu->exit_request
      KVM: use KVM_CAP_IMMEDIATE_EXIT
      vmxcap: port to Python 3
      vmxcap: update for September 2016 SDM

Pavel Dovgalyuk (1):
      replay: check icount in cpu exec loop

 cpu-exec.c                                         |  83 ++--
 cpus.c                                             | 102 +----
 include/exec/gen-icount.h                          |  53 ++-
 include/qemu/compatfd.h                            |  42 ---
 include/qemu/osdep.h                               |  37 ++
 include/qom/cpu.h                                  |  15 +-
 include/standard-headers/asm-x86/hyperv.h          |   8 +
 include/standard-headers/linux/input-event-codes.h |   2 +-
 include/standard-headers/linux/pci_regs.h          |  25 ++
 include/standard-headers/linux/virtio_ids.h        |   1 +
 include/sysemu/kvm.h                               |  11 +-
 kvm-all.c                                          | 146 ++++++-
 kvm-stub.c                                         |  12 +-
 linux-headers/asm-arm/kvm.h                        |  15 +
 linux-headers/asm-arm/unistd-common.h              | 357 ++++++++++++++++++
 linux-headers/asm-arm/unistd-eabi.h                |   5 +
 linux-headers/asm-arm/unistd-oabi.h                |  17 +
 linux-headers/asm-arm/unistd.h                     | 419 +--------------------
 linux-headers/asm-arm64/kvm.h                      |  13 +
 linux-headers/asm-powerpc/kvm.h                    |  27 ++
 linux-headers/asm-powerpc/unistd.h                 |   1 +
 linux-headers/asm-x86/kvm_para.h                   |  13 +-
 linux-headers/linux/kvm.h                          |  24 +-
 linux-headers/linux/kvm_para.h                     |   2 +
 linux-headers/linux/userfaultfd.h                  |  67 +++-
 linux-headers/linux/vfio.h                         |  10 +
 qapi-schema.json                                   |  12 +
 qapi/event.json                                    |   4 +-
 qom/cpu.c                                          |   2 +-
 scripts/kvm/vmxcap                                 |  23 +-
 scripts/update-linux-headers.sh                    |  13 +-
 target/arm/kvm.c                                   |  10 -
 target/i386/cpu.c                                  |  15 +-
 target/i386/kvm.c                                  |  81 ++--
 target/mips/kvm.c                                  |  12 -
 target/ppc/kvm.c                                   |  10 -
 target/s390x/kvm.c                                 |  10 -
 tcg/tcg.h                                          |   1 -
 translate-all.c                                    |   2 +-
 translate-common.c                                 |  13 +-
 util/compatfd.c                                    |   1 -
 util/main-loop.c                                   |   5 +-
 util/oslib-posix.c                                 |  33 ++
 vl.c                                               |  12 +-
 44 files changed, 960 insertions(+), 806 deletions(-)
 delete mode 100644 include/qemu/compatfd.h
 create mode 100644 linux-headers/asm-arm/unistd-common.h
 create mode 100644 linux-headers/asm-arm/unistd-eabi.h
 create mode 100644 linux-headers/asm-arm/unistd-oabi.h
-- 
1.8.3.1
