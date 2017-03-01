Received: from eggs.gnu.org ([2001:4830:134:3::10]:58042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cj3OG-0006gh-Cr
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cj3OC-00025S-Dz
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:29:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cj3OC-000250-4p
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:29:52 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85EAAC04B328
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 12:29:51 +0000 (UTC)
Received: from donizetti.mxp.redhat.com (dhcp-176-49.mxp.redhat.com
	[10.32.176.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 043FF2D655
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 12:29:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  1 Mar 2017 13:29:47 +0100
Message-Id: <20170301122950.3587-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v4 00/19] KVM and cpu-exec patches for 2.9 soft
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

The following changes since commit d992f2f1368ceb92e6bfd8efece174110f4236=
ff:

  Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170226' =
into staging (2017-02-26 22:40:23 +0000)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to b9a93b6cfddd348286cd8e44d7c4d964d9553a9f:

  vl: disable default cdrom when using explicitely scsi-hd (2017-02-28 11=
:51:12 +0100)

v3->v4: added two patches

        fixed #ifdef KVM_HAVE_MCE_INJECTION

v2->v3: replace SIGPOLL with SIGIO

        another missing #ifdef KVM_HAVE_MCE_INJECTION

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
* VFIO ram device fix (Yongji)
* scsi-hd vs. default CD-ROM (Herv=C3=A9)

----------------------------------------------------------------
Anton Nefedov (2):
      qapi: flatten GuestPanicInformation union
      qmp-events: fix GUEST_PANICKED description formatting

Herv=C3=A9 Poussineau (1):
      vl: disable default cdrom when using explicitely scsi-hd

Paolo Bonzini (15):
      cpu-exec: unify icount_decr and tcg_exit_req
      cpu-exec: remove unnecessary check of cpu->exit_request
      Merge branch 'refs/heads/icount-update' into HEAD
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

Yongji Xie (1):
      memory: Introduce DEVICE_HOST_ENDIAN for ram device

 cpu-exec.c                                         |  93 ++---
 cpus.c                                             | 102 +----
 include/exec/cpu-common.h                          |   6 +
 include/exec/gen-icount.h                          |  53 ++-
 include/qemu/compatfd.h                            |  42 ---
 include/qemu/osdep.h                               |  37 ++
 include/qom/cpu.h                                  |  15 +-
 include/standard-headers/asm-x86/hyperv.h          |   8 +
 include/standard-headers/linux/input-event-codes.h |   2 +-
 include/standard-headers/linux/pci_regs.h          |  25 ++
 include/standard-headers/linux/virtio_ids.h        |   1 +
 include/sysemu/kvm.h                               |  11 +-
 kvm-all.c                                          | 150 +++++++-
 kvm-stub.c                                         |  12 +-
 linux-headers/asm-arm/kvm.h                        |  15 +
 linux-headers/asm-arm/unistd-common.h              | 357 +++++++++++++++=
+++
 linux-headers/asm-arm/unistd-eabi.h                |   5 +
 linux-headers/asm-arm/unistd-oabi.h                |  17 +
 linux-headers/asm-arm/unistd.h                     | 419 +--------------=
------
 linux-headers/asm-arm64/kvm.h                      |  13 +
 linux-headers/asm-powerpc/kvm.h                    |  27 ++
 linux-headers/asm-powerpc/unistd.h                 |   1 +
 linux-headers/asm-x86/kvm_para.h                   |  13 +-
 linux-headers/linux/kvm.h                          |  24 +-
 linux-headers/linux/kvm_para.h                     |   2 +
 linux-headers/linux/userfaultfd.h                  |  67 +++-
 linux-headers/linux/vfio.h                         |  10 +
 memory.c                                           |   2 +-
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
 vl.c                                               |  13 +-
 46 files changed, 976 insertions(+), 813 deletions(-)
 delete mode 100644 include/qemu/compatfd.h
 create mode 100644 linux-headers/asm-arm/unistd-common.h
 create mode 100644 linux-headers/asm-arm/unistd-eabi.h
 create mode 100644 linux-headers/asm-arm/unistd-oabi.h
