Received: from eggs.gnu.org ([2001:4830:134:3::10]:35640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKge-0004a2-2u
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKga-0000RO-VY
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:45:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKga-0000RF-MX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:45:52 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA97461B92
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 12:45:52 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-118.ams2.redhat.com
	[10.36.117.118])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1RCjpdt028718
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:45:52 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:34 +0100
Message-Id: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 00/17] KVM and cpu-exec patches for 2.9 soft
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

The following changes since commit d992f2f1368ceb92e6bfd8efece174110f4236ff:

  Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170226' into staging (2017-02-26 22:40:23 +0000)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f601681feff62113b526d4ad491af4a03aca825a:

  qmp-events: fix GUEST_PANICKED description formatting (2017-02-27 13:31:25 +0100)

v1->v2: add missing #ifdef KVM_HAVE_MCE_INJECTION

        rebase over MTTCG pull request.  -icount is currently broken but
        I'd like to preserve bisectability, so this pull request brings
        in the icount patches through a merge commit.

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

 cpu-exec.c                                         |  91 ++---
 cpus.c                                             | 102 +----
 include/exec/gen-icount.h                          |  53 ++-
 include/qemu/compatfd.h                            |  42 ---
 include/qemu/osdep.h                               |  35 ++
 include/qom/cpu.h                                  |  15 +-
 include/standard-headers/asm-x86/hyperv.h          |   8 +
 include/standard-headers/linux/input-event-codes.h |   2 +-
 include/standard-headers/linux/pci_regs.h          |  25 ++
 include/standard-headers/linux/virtio_ids.h        |   1 +
 include/sysemu/kvm.h                               |  11 +-
 kvm-all.c                                          | 150 +++++++-
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
 os-win32.c                                         |   7 +
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
 45 files changed, 972 insertions(+), 811 deletions(-)
 delete mode 100644 include/qemu/compatfd.h
 create mode 100644 linux-headers/asm-arm/unistd-common.h
 create mode 100644 linux-headers/asm-arm/unistd-eabi.h
 create mode 100644 linux-headers/asm-arm/unistd-oabi.h

-- 
2.9.3
