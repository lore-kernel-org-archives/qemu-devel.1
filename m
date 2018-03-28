Received: from eggs.gnu.org ([2001:4830:134:3::10]:35093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1BlY-0003F7-MJ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1BlU-00056M-MO
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:09:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1BlU-000552-G8
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:09:24 -0400
Date: Wed, 28 Mar 2018 11:09:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180328140913.GF5046@localhost.localdomain>
References: <20180322131358.15096-1-vkuznets@redhat.com>
	<20180322131358.15096-3-vkuznets@redhat.com>
	<20180322184933.GI3417@localhost.localdomain>
	<87a7uy6eaq.fsf@vitty.brq.redhat.com>
	<20180326142547.GC2401@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326142547.GC2401@rkaganb.sw.ru>
Subject: Re: [Qemu-devel] [PATCH v4 2/2] i386/kvm: expose Hyper-V frequency
 MSRs with reenlightenment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>

On Mon, Mar 26, 2018 at 05:25:47PM +0300, Roman Kagan wrote:
> On Fri, Mar 23, 2018 at 03:45:49PM +0100, Vitaly Kuznetsov wrote:
> > Eduardo Habkost <ehabkost@redhat.com> writes:
> > 
> > > On Thu, Mar 22, 2018 at 02:13:58PM +0100, Vitaly Kuznetsov wrote:
> > >> We can also expose Hyper-V frequency MSRs when reenlightenment feature is
> > >> enabled and TSC frequency is known, Hyper-V on KVM will provide stable TSC
> > >> page clocksources to its guests.
> > >> 
> > >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > >> ---
> > >> - Expose frequency MSRs only when either INVTSC or Reenlightenment is
> > >>   provided [Paolo Bonzini]
> > >> ---
> > >>  target/i386/kvm.c | 3 ++-
> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >> 
> > >> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > >> index 75f4e1d69e..2c3c19d690 100644
> > >> --- a/target/i386/kvm.c
> > >> +++ b/target/i386/kvm.c
> > >> @@ -651,7 +651,8 @@ static int hyperv_handle_properties(CPUState *cs)
> > >>          env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
> > >>          env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
> > >>  
> > >> -        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
> > >> +        if (has_msr_hv_frequencies && env->tsc_khz &&
> > >
> > > Why is the check for env->tsc_khz necessary?
> > >
> > > Are there known circumstances where HV_X64_MSR_TSC_FREQUENCY will be supported
> > > by KVM but ioctl(KVM_GET_TSC_KHZ) will return 0, or this is just for extra
> > > safety?
> > >
> > 
> > Yes,
> > 
> > I didn't experiment with passing '0' to Windows but in general it
> > doesn't sound like a good idea. 
> 
> AFAICS the value of ->tsc_khz that QEMU pushes into KVM is the one that
> it first obtains from KVM via ioctl(KVM_GET_TSC_KHZ), or receives in the
> migration stream (obtained in a similar way on the source VM).  So for
> all relevant configurations this check seems indeed redundant, and I
> went ahead and dropped it in the patch I posted.  Did I miss any case
> where it is not?

That's my impression as well.

-- 
Eduardo
