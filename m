Received: from eggs.gnu.org ([2001:4830:134:3::10]:48011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eyh3d-0000YA-6R
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eyh3a-0006C1-4H
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:57:49 -0400
Received: from mail-ve1eur02hn0326.outbound.protection.outlook.com
	([2a01:111:f400:fe06::326]:55629
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eyh3Z-0006Ae-Ne
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:57:46 -0400
Date: Wed, 21 Mar 2018 19:57:29 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180321165729.GH14983@rkaganb.sw.ru>
References: <20180320173500.32065-1-vkuznets@redhat.com>
	<20180320173500.32065-3-vkuznets@redhat.com>
	<20180321121001.GD14983@rkaganb.sw.ru>
	<87bmfh7eip.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmfh7eip.fsf@vitty.brq.redhat.com>
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
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On Wed, Mar 21, 2018 at 02:18:54PM +0100, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> 
> > On Tue, Mar 20, 2018 at 06:35:00PM +0100, Vitaly Kuznetsov wrote:
> >> Requiring tsc_is_stable_and_known() is too restrictive: even without INVTCS
> >> nested Hyper-V-on-KVM enables TSC pages for its guests e.g. when
> >> Reenlightenment MSRs are present. Presence of frequency MSRs doesn't mean
> >> these frequencies are stable, it just means they're available for reading.
> >> 
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> ---
> >>  target/i386/kvm.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> >> index 7d9f9ca0b1..74fc3d3b2c 100644
> >> --- a/target/i386/kvm.c
> >> +++ b/target/i386/kvm.c
> >> @@ -651,7 +651,7 @@ static int hyperv_handle_properties(CPUState *cs)
> >>          env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
> >>          env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
> >>  
> >> -        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
> >> +        if (has_msr_hv_frequencies && env->tsc_khz) {
> >>              env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
> >>              env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
> >>          }
> >
> > I suggest that we add a corresponding cpu property here, too.  The guest
> > may legitimately rely on these msrs when it sees the support in CPUID,
> > and migrating from a kernel with the feature supported (4.14+) to an
> > older one will make it crash.
> >
> 
> This can be arranged, but what happens to people who use these features
> today? Assuming they also passed 'invtsc' they have stable TSC page
> clocksource already (when Hyper-V role is enabled) but when we start
> requesting a new 'hv_frequency' cpu property they'll suddenly lose what
> they have...

I see two cases here:

1) people start a new VM, and discover that their old configuration is
   not enough for this feature to work.

   They need to reconfigure and restart the VM.  This costs them some
   time investigating and restarting, but not data.

2) people migrate from a QEMU without ->hv_frequency, to a new one with
   ->hv_frequency=off (assuming on both ends KVM supports the frequency
   MSRs).

   With the current implementation in KVM, this will only result in the
   feature bits disappearing from the respective CPUID leaf, but the
   MSRs themselves will continue working as they used to.  So the guest
   either won't notice or will check the CPUID and adjust.


Am I missing anything?

Roman.
