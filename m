Received: from eggs.gnu.org ([2001:4830:134:3::10]:59148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ce1xe-00052t-20
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ce1xa-0002xZ-6m
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:57:42 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ce1xa-0002xP-0C
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:57:38 -0500
Received: by mail-wr0-x243.google.com with SMTP id i10so31799419wrb.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 07:57:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170210095012.16039-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d1feeef5-0f3c-30e1-6a45-0e0c3fb618a2@redhat.com>
Date: Wed, 15 Feb 2017 16:57:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170210095012.16039-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu 0/7] KVM: race-free exit from KVM_RUN
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



On 10/02/2017 10:50, Paolo Bonzini wrote:
> The purpose of the KVM_SET_SIGNAL_MASK API is to let userspace "kick"
> a VCPU out of KVM_RUN through a POSIX signal.  A signal is attached
> to a dummy signal handler; by blocking the signal outside KVM_RUN and
> unblocking it inside, this possible race is closed:
> 
>           VCPU thread                     service thread
>    --------------------------------------------------------------
>         check flag
>                                           set flag
>                                           raise signal
>         (signal handler does nothing)
>         KVM_RUN
> 
> However, one issue with KVM_SET_SIGNAL_MASK is that it has to take
> tsk->sighand->siglock on every KVM_RUN.  This lock is often on a
> remote NUMA node, because it is on the node of a thread's creator.
> Taking this lock can be very expensive if there are many userspace
> exits (as is the case for SMP Windows VMs without Hyper-V reference
> time counter).
> 
> As an alternative, we can put the flag directly in kvm_run so that
> KVM can see it:
> 
>           VCPU thread                     service thread
>    --------------------------------------------------------------
>                                           raise signal
>         signal handler
>           set run->immediate_exit
>         KVM_RUN
>           check run->immediate_exit
> 
> This is what the last patch in this series does, together with
> the corresponding kernel API.  The first six patches are a long
> detour in the signal handling code, moving KVM-specific stuff
> from cpus.c to kvm-all.c so that we have a better hook point for
> KVM_CAP_IMMEDIATE_EXIT (patches 1-3, 6).
> 
> Because KVM_SET_SIGNAL_MASK is also unblocking SIGBUS so that
> BUS_MCEERR_AR actions can be delivered via sigwait, we also have
> to rewrite it (patch 4-5) to avoid sigwait, stowing the machine check
> exception as soon as KVM_RUN exits and process it outside the signal
> handler.
> 
> The seventh patch would of course be split between a linux-headers
> update and the rest.
> 
> Paolo
> 
> ps: As an aside, I finally figured out how to test machine check
> forwarding and I hope to write something about it.

This is needed to test these patches with the final version of the KVM part:

diff --git a/kvm-all.c b/kvm-all.c
index 083143f..c79833e 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1922,6 +1922,7 @@ static void kvm_eat_signals(CPUState *cpu)
     int r;
 
     if (kvm_immediate_exit) {
+        atomic_set(&cpu->kvm_run->immediate_exit, 0);
         return;
     }
 
Paolo
