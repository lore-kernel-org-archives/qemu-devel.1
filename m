Received: from eggs.gnu.org ([2001:4830:134:3::10]:56745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cOlyl-0006J0-5f
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cOlyf-0000o7-BJ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:51:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cOlyf-0000nk-2u
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:51:41 -0500
Date: Wed, 4 Jan 2017 11:51:37 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170104135137.GI3315@thinpad.lan.raisama.net>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-3-git-send-email-ehabkost@redhat.com>
	<20170104114404.GA14961@amt.cnet>
	<20170104134017.GH3315@thinpad.lan.raisama.net>
	<20170104134534.GA21361@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170104134534.GA21361@amt.cnet>
Subject: Re: [Qemu-devel] [PATCH 2/4] kvm: Allow invtsc migration if tsc-khz
 is set explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>

On Wed, Jan 04, 2017 at 11:45:36AM -0200, Marcelo Tosatti wrote:
> On Wed, Jan 04, 2017 at 11:40:17AM -0200, Eduardo Habkost wrote:
> > On Wed, Jan 04, 2017 at 09:44:06AM -0200, Marcelo Tosatti wrote:
> > > On Tue, Dec 27, 2016 at 05:21:18PM -0200, Eduardo Habkost wrote:
> > > > We can safely allow a VM to be migrated with invtsc enabled if
> > > > tsc-khz is set explicitly, because QEMU already refuses to start
> > > > if it can't set the TSC frequency to the configured value.
> > > 
> > > On the source host, yes, but on the destination it does not.
> > > 
> > > SOURCE: -cpu kvm64,tsc-frequency=2660001000
> > > DESTINATION: -cpu kvm64
> > 
> > This is invalid usage. Management software is responsible for
> > keeping the same configuration on source and destination.
> 
> Fine. Just to confirm: you do not expect libvirt to 
> use
> 
>         -cpu XXX,tsc-frequency=ZZZZZ
> 
> On both source and destination, correct?

They can omit it, as long as it is omitted on both source and
destination.

If they do use tsc-frequency on the source, they must use it on
the destination as well. Just like they do for every device
option in QEMU.


> 
> > > Only prints:
> > > 
> > > qemu-system-x86_64: warning: TSC frequency mismatch between VM (2660001
> > > kHz) and host (2893428 kHz), and TSC scaling unavailable
> > > qemu-system-x86_64: warning: TSC frequency mismatch between VM (2660001
> > > kHz) and host (2893428 kHz), and TSC scaling unavailable
> > > 
> > > And allows migration.
> > > 
> > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > ---
> > > >  target/i386/kvm.c | 19 ++++++++++---------
> > > >  1 file changed, 10 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > > > index a26290f..6a51399 100644
> > > > --- a/target/i386/kvm.c
> > > > +++ b/target/i386/kvm.c
> > > > @@ -962,15 +962,16 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > > >          has_msr_mcg_ext_ctl = has_msr_feature_control = true;
> > > >      }
> > > >  
> > > > -    if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
> > > > -        invtsc_mig_blocker == NULL) {
> > > > -        /* for migration */
> > > > -        error_setg(&invtsc_mig_blocker,
> > > > -                   "State blocked by non-migratable CPU device"
> > > > -                   " (invtsc flag)");
> > > > -        migrate_add_blocker(invtsc_mig_blocker);
> > > > -        /* for savevm */
> > > > -        vmstate_x86_cpu.unmigratable = 1;
> > > > +    if (!env->user_tsc_khz) {
> > > > +        if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
> > > > +            invtsc_mig_blocker == NULL) {
> > > > +            /* for migration */
> > > > +            error_setg(&invtsc_mig_blocker,
> > > > +                       "State blocked by non-migratable CPU device"
> > > > +                       " (invtsc flag)");
> > > > +            migrate_add_blocker(invtsc_mig_blocker);
> > > > +            /* for savevm */
> > > > +            vmstate_x86_cpu.unmigratable = 1;
> > > >      }
> > > >  
> > > >      cpuid_data.cpuid.padding = 0;
> > > > -- 
> > > > 2.7.4
> > 
> > -- 
> > Eduardo
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Eduardo
