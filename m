Received: from eggs.gnu.org ([2001:4830:134:3::10]:53198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ezJgG-0001lG-G3
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ezJgD-0004sy-Oi
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:12:16 -0400
Received: from mail-ve1eur01hn0206.outbound.protection.outlook.com
	([104.47.1.206]:51646
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ezJgD-0004qw-2v
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:12:13 -0400
Date: Fri, 23 Mar 2018 13:11:53 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180323101152.GB28085@rkaganb.sw.ru>
References: <20180322131358.15096-1-vkuznets@redhat.com>
	<20180322131358.15096-3-vkuznets@redhat.com>
	<20180322190146.GA1396@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322190146.GA1396@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 22, 2018 at 04:01:46PM -0300, Eduardo Habkost wrote:
> On Thu, Mar 22, 2018 at 02:13:58PM +0100, Vitaly Kuznetsov wrote:
> > We can also expose Hyper-V frequency MSRs when reenlightenment feature is
> > enabled and TSC frequency is known, Hyper-V on KVM will provide stable TSC
> > page clocksources to its guests.
> > 
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> > - Expose frequency MSRs only when either INVTSC or Reenlightenment is
> >   provided [Paolo Bonzini]
> > ---
> >  target/i386/kvm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index 75f4e1d69e..2c3c19d690 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -651,7 +651,8 @@ static int hyperv_handle_properties(CPUState *cs)
> >          env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
> >          env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
> >  
> > -        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
> > +        if (has_msr_hv_frequencies && env->tsc_khz &&
> > +            (tsc_is_stable_and_known(env) || cpu->hyperv_reenlightenment)) {
> 
> Continuing the discussion we had in v3 about being possible to
> crash when migrating to a host running an older kernel:
> 
> This patch doesn't fix the issue, because it is still implicitly
> enabling hv-frequencies.
> 
> But I don't think this patch will make the situation any worse,
> because we don't have any KVM versions that support
> HV_X64_MSR_REENLIGHTENMENT_CONTROL but not
> HV_X64_MSR_TSC_FREQUENCY.
> 
> This means that we can safely make "hv-reenlightenment=on"
> automatically set "hv-frequencies=on", when we finally introduce
> a hv-frequencies property.

Do I get you right that there's no controversy about the need for
hv-frequencies?

> Roman, do you agree?

Well, this strictly depends on the answer to your next question, because
hv-reenlightenment is most certainly 2.13 material.

> The next question is: do we need to fix this and introduce a
> hv-frequencies property in 2.12, or can this wait for 2.13?

I'm tempted to stick hv-frequencies into 2.12 and retrospectively into
2.11-stable, to minimize the exposure to the problem but to keep the
effort and added complexity reasonable.  But I'm not sure this will be
ok from the compatibility policy standpoint.  So I'd appreciate an
advice on this.
[Should I better just post a patch doing that and continue this
discussion there?]

Thanks,
Roman.
