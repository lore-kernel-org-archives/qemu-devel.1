Received: from eggs.gnu.org ([2001:4830:134:3::10]:33333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eyzpc-0007vR-QX
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eyzpX-0007zz-P3
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:00:36 -0400
Received: from mail-he1eur01hn0313.outbound.protection.outlook.com
	([2a01:111:f400:fe1e::313]:19328
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eyzpW-0007yp-Hj
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:00:31 -0400
Date: Thu, 22 Mar 2018 16:00:14 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180322130013.GB4500@rkaganb.sw.ru>
References: <20180320173500.32065-1-vkuznets@redhat.com>
	<20180320173500.32065-3-vkuznets@redhat.com>
	<20180321121001.GD14983@rkaganb.sw.ru>
	<87bmfh7eip.fsf@vitty.brq.redhat.com>
	<20180321165729.GH14983@rkaganb.sw.ru>
	<20180321201924.GE3417@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321201924.GE3417@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] i386/kvm: lower requirements for
 Hyper-V frequency MSRs exposure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On Wed, Mar 21, 2018 at 05:19:24PM -0300, Eduardo Habkost wrote:
> On Wed, Mar 21, 2018 at 07:57:29PM +0300, Roman Kagan wrote:
> > On Wed, Mar 21, 2018 at 02:18:54PM +0100, Vitaly Kuznetsov wrote:
> > > Roman Kagan <rkagan@virtuozzo.com> writes:
> > > 
> > > > On Tue, Mar 20, 2018 at 06:35:00PM +0100, Vitaly Kuznetsov wrote:
> > > >> Requiring tsc_is_stable_and_known() is too restrictive: even without INVTCS
> > > >> nested Hyper-V-on-KVM enables TSC pages for its guests e.g. when
> > > >> Reenlightenment MSRs are present. Presence of frequency MSRs doesn't mean
> > > >> these frequencies are stable, it just means they're available for reading.
> > > >> 
> > > >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > >> ---
> > > >>  target/i386/kvm.c | 2 +-
> > > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >> 
> > > >> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > > >> index 7d9f9ca0b1..74fc3d3b2c 100644
> > > >> --- a/target/i386/kvm.c
> > > >> +++ b/target/i386/kvm.c
> > > >> @@ -651,7 +651,7 @@ static int hyperv_handle_properties(CPUState *cs)
> > > >>          env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
> > > >>          env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
> > > >>  
> > > >> -        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
> > > >> +        if (has_msr_hv_frequencies && env->tsc_khz) {
> > > >>              env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
> > > >>              env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
> > > >>          }
> > > >
> > > > I suggest that we add a corresponding cpu property here, too.  The guest
> > > > may legitimately rely on these msrs when it sees the support in CPUID,
> > > > and migrating from a kernel with the feature supported (4.14+) to an
> > > > older one will make it crash.
> > > >
> > > 
> > > This can be arranged, but what happens to people who use these features
> > > today? Assuming they also passed 'invtsc' they have stable TSC page
> > > clocksource already (when Hyper-V role is enabled) but when we start
> > > requesting a new 'hv_frequency' cpu property they'll suddenly lose what
> > > they have...
> > 
> > I see two cases here:
> > 
> > 1) people start a new VM, and discover that their old configuration is
> >    not enough for this feature to work.
> > 
> >    They need to reconfigure and restart the VM.  This costs them some
> >    time investigating and restarting, but not data.
> 
> If we keep machine-type compatibility, people will need to do
> that only if they change the machine-type (or use the "pc" or
> "q35" aliases).  If they copy the old configuration, it will keep
> working.

The problem is that the feature is not fixed by the machine-type, due to
the forgotten property: it only depends on the KVM version.  So, once
(if) we add the property and make the feature deterministic, we'll lose
compatibility one way or another.

Or are you suggesting that for pre-2.12 machine types we leave the
property at "decided by your KVM" state?

> 
> machine-type compatibility also makes the following case a bit
> safer:
> 
> > 
> > 2) people migrate from a QEMU without ->hv_frequency, to a new one with
> >    ->hv_frequency=off (assuming on both ends KVM supports the frequency
> >    MSRs).
> > 
> >    With the current implementation in KVM, this will only result in the
> >    feature bits disappearing from the respective CPUID leaf, but the
> >    MSRs themselves will continue working as they used to.  So the guest
> >    either won't notice or will check the CPUID and adjust.
> 
> If we keep machine-type compatibility, the CPUID bit won't
> disappear for the guest while the MSRs keep working.
> 
> 
> Whichever solution we choose, we can still have guests crashing
> if migrating a pc-2.11 machine from a 4.14+ host kernel to a host
> with an older kernel.  But I don't think there's a way out of
> this, except requiring an explicit "hv-frequencies" CPU option on
> newer machine-types.

What's wrong with requiring it, as we do for all other hv_* properties?

Roman.
