Received: from eggs.gnu.org ([2001:4830:134:3::10]:51535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f0ybr-0001Ie-7C
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f0ybo-0008Qn-3e
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:06:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52398 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f0ybn-0008Pe-UL
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:06:32 -0400
Date: Wed, 28 Mar 2018 03:06:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180328030327-mutt-send-email-mst@kernel.org>
References: <1521211002-4529-1-git-send-email-wanpengli@tencent.com>
	<20180327224058-mutt-send-email-mst@kernel.org>
	<20180327213646.GE5046@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327213646.GE5046@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Tue, Mar 27, 2018 at 06:36:46PM -0300, Eduardo Habkost wrote:
> On Tue, Mar 27, 2018 at 10:42:56PM +0300, Michael S. Tsirkin wrote:
> > On Fri, Mar 16, 2018 at 07:36:42AM -0700, Wanpeng Li wrote:
> > > From: Wanpeng Li <wanpengli@tencent.com>
> > > 
> > > This patch adds support for KVM_CAP_X86_DISABLE_EXITS. Provides userspace with 
> > > per-VM capability(KVM_CAP_X86_DISABLE_EXITS) to not intercept MWAIT/HLT/PAUSE 
> > > in order that to improve latency in some workloads.
> > > 
> [...]
> > > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > > index d23fff1..95ed9eb 100644
> > > --- a/target/i386/kvm.c
> > > +++ b/target/i386/kvm.c
> > > @@ -999,6 +999,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > >          }
> > >      }
> > >  
> > > +    if (env->features[FEAT_KVM_HINTS] & KVM_HINTS_DEDICATED) {
> > > +        int disable_exits = kvm_check_extension(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS);
> > > +        if (disable_exits) {
> > > +            disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
> > > +                              KVM_X86_DISABLE_EXITS_HLT |
> > > +                              KVM_X86_DISABLE_EXITS_PAUSE);
> > > +        }
> > > +        if (kvm_vm_enable_cap(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS, 0, disable_exits)) {
> > > +            error_report("kvm: DISABLE EXITS not supported");
> > > +        }
> > > +    }
> > > +
> > >      qemu_add_vm_change_state_handler(cpu_update_state, env);
> > >  
> > >      c = cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
> > 
> > Why not a bit per capability?
> > I can see how someone might want to disable mwait exists
> > but not the rest of them.
> 
> kvm-hint-dedicated=on should be used only if the physical CPU is
> dedicated to the VCPU task.  Are there any advantages of getting
> vmexits for HLT and PAUSE if no other task is going to use the
> CPU?

No but there are advantages to using mwait even without a dedicated host
CPU (VCPUs can wake up each other without exiting to hypervisor).

Which is my point - there should be a separate flag to disable mwait
exiting only.

> -- 
> Eduardo
