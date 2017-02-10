Received: from eggs.gnu.org ([2001:4830:134:3::10]:33625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cc7qN-0000KY-Ol
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cc7qK-0005Ml-IA
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:50:19 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cc7qK-0005Ly-Co
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:50:16 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so6538873wmv.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 01:50:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 Feb 2017 10:50:05 +0100
Message-Id: <20170210095012.16039-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH qemu 0/7] KVM: race-free exit from KVM_RUN
 without POSIX signals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org

The purpose of the KVM_SET_SIGNAL_MASK API is to let userspace "kick"
a VCPU out of KVM_RUN through a POSIX signal.  A signal is attached
to a dummy signal handler; by blocking the signal outside KVM_RUN and
unblocking it inside, this possible race is closed:

          VCPU thread                     service thread
   --------------------------------------------------------------
        check flag
                                          set flag
                                          raise signal
        (signal handler does nothing)
        KVM_RUN

However, one issue with KVM_SET_SIGNAL_MASK is that it has to take
tsk->sighand->siglock on every KVM_RUN.  This lock is often on a
remote NUMA node, because it is on the node of a thread's creator.
Taking this lock can be very expensive if there are many userspace
exits (as is the case for SMP Windows VMs without Hyper-V reference
time counter).

As an alternative, we can put the flag directly in kvm_run so that
KVM can see it:

          VCPU thread                     service thread
   --------------------------------------------------------------
                                          raise signal
        signal handler
          set run->immediate_exit
        KVM_RUN
          check run->immediate_exit

This is what the last patch in this series does, together with
the corresponding kernel API.  The first six patches are a long
detour in the signal handling code, moving KVM-specific stuff
from cpus.c to kvm-all.c so that we have a better hook point for
KVM_CAP_IMMEDIATE_EXIT (patches 1-3, 6).

Because KVM_SET_SIGNAL_MASK is also unblocking SIGBUS so that
BUS_MCEERR_AR actions can be delivered via sigwait, we also have
to rewrite it (patch 4-5) to avoid sigwait, stowing the machine check
exception as soon as KVM_RUN exits and process it outside the signal
handler.

The seventh patch would of course be split between a linux-headers
update and the rest.

Paolo

ps: As an aside, I finally figured out how to test machine check
forwarding and I hope to write something about it.

Paolo Bonzini (7):
  cpus: remove ugly cast on sigbus_handler
  KVM: x86: cleanup SIGBUS handlers
  cpus: reorganize signal handling code
  KVM: remove kvm_arch_on_sigbus
  KVM: do not use sigtimedwait to catch SIGBUS
  KVM: move SIG_IPI handling to kvm-all.c
  KVM: use KVM_CAP_IMMEDIATE_EXIT

 cpus.c                    | 102 ++++++------------------------------
 include/qemu/compatfd.h   |  42 ---------------
 include/qemu/osdep.h      |  35 +++++++++++++
 include/sysemu/kvm.h      |  11 ++--
 kvm-all.c                 | 130 +++++++++++++++++++++++++++++++++++++++++++---
 kvm-stub.c                |  12 ++---
 linux-headers/linux/kvm.h |   4 +-
 main-loop.c               |   5 +-
 os-win32.c                |   7 +++
 target/arm/kvm.c          |  10 ----
 target/i386/kvm.c         |  81 ++++++++---------------------
 target/mips/kvm.c         |  12 -----
 target/ppc/kvm.c          |  10 ----
 target/s390x/kvm.c        |  10 ----
 util/compatfd.c           |   1 -
 util/oslib-posix.c        |  33 ++++++++++++
 16 files changed, 249 insertions(+), 256 deletions(-)
 delete mode 100644 include/qemu/compatfd.h

-- 
1.8.3.1
