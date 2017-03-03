Received: from eggs.gnu.org ([2001:4830:134:3::10]:59400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq6H-0003v3-P9
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cjq6E-0002Pg-Ku
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:37 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cjq6E-0002PZ-EL
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:30:34 -0500
Received: by mail-wr0-x234.google.com with SMTP id u48so77253128wrc.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:30:34 -0800 (PST)
Received: from 640k.lan (94-36-245-171.adsl-ull.clienti.tiscali.it.
	[94.36.245.171]) by smtp.gmail.com with ESMTPSA id
	k195sm3667527wmd.7.2017.03.03.08.30.32 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 Mar 2017 08:30:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Mar 2017 17:30:26 +0100
Message-Id: <1488558630-21522-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v5 00/21] Misc patches for QEMU soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 508e038a5d725f2aa729f58a1f5209b9be4227de:

  dtc: Revert unintentional submodule downgrade from commit 077dd74239a99 (2017-03-03 12:48:42 +0000)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f6eb0b319e4bad3d01d74d71e3a6cf40f0ede720:

  iscsi: fix missing unlock (2017-03-03 16:41:20 +0100)

v4->v5: 4.11 kernel header already merged
	added two more patches at the end

----------------------------------------------------------------
* kernel header update (requested by David and Vijay)
* GuestPanicInformation fixups (Anton)
* record/replay icount fixes (Pavel)
* cpu-exec cleanup, unification of icount_decr with tcg_exit_req (me)
* KVM_CAP_IMMEDIATE_EXIT support (me)
* vmxcap update (me)
* iscsi locking fix (me)
* VFIO ram device fix (Yongji)
* scsi-hd vs. default CD-ROM (Hervé)
* SMI migration fix (Dave)
* spice-char segfault (Li Qiang)
* improved "info mtree -f" (me)

----------------------------------------------------------------
Anton Nefedov (2):
      qapi: flatten GuestPanicInformation union
      qmp-events: fix GUEST_PANICKED description formatting

Dr. David Alan Gilbert (1):
      x86: Work around SMI migration breakages

Hervé Poussineau (1):
      vl: disable default cdrom when using explicitely scsi-hd

Li Qiang (1):
      spice-char: fix segfault in char_spice_finalize

Paolo Bonzini (15):
      cpu-exec: unify icount_decr and tcg_exit_req
      cpu-exec: remove unnecessary check of cpu->exit_request
      Merge branch 'icount-update' into HEAD
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
      memory: show region offset and ROM/RAM type in "info mtree -f"
      iscsi: fix missing unlock

Pavel Dovgalyuk (1):
      replay: check icount in cpu exec loop

Yongji Xie (1):
      memory: Introduce DEVICE_HOST_ENDIAN for ram device

 block/iscsi.c             |   4 ++
 cpu-exec.c                |  93 +++++++++++++---------------
 cpus.c                    | 102 +++++--------------------------
 include/exec/cpu-common.h |   6 ++
 include/exec/gen-icount.h |  53 ++++++++--------
 include/hw/i386/pc.h      |   4 ++
 include/qemu/compatfd.h   |  42 -------------
 include/qemu/osdep.h      |  37 ++++++++++++
 include/qom/cpu.h         |  15 +++--
 include/sysemu/kvm.h      |  11 ++--
 kvm-all.c                 | 150 ++++++++++++++++++++++++++++++++++++++++++----
 kvm-stub.c                |  12 ++--
 memory.c                  |  27 ++++++---
 qapi-schema.json          |  12 ++++
 qapi/event.json           |   4 +-
 qom/cpu.c                 |   2 +-
 scripts/kvm/vmxcap        |  23 ++++---
 spice-qemu-char.c         |   5 +-
 target/arm/kvm.c          |  10 ----
 target/i386/cpu.c         |  17 +++---
 target/i386/cpu.h         |   3 +
 target/i386/kvm.c         |  88 +++++++++------------------
 target/mips/kvm.c         |  12 ----
 target/ppc/kvm.c          |  10 ----
 target/s390x/kvm.c        |  10 ----
 tcg/tcg.h                 |   1 -
 translate-all.c           |   2 +-
 translate-common.c        |  13 ++--
 util/compatfd.c           |   1 -
 util/main-loop.c          |   5 +-
 util/oslib-posix.c        |  33 ++++++++++
 vl.c                      |  13 ++--
 32 files changed, 428 insertions(+), 392 deletions(-)
 delete mode 100644 include/qemu/compatfd.h
---
