Received: from eggs.gnu.org ([2001:4830:134:3::10]:38190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1eygQw-00072v-0C
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1eygQs-0005YV-2T
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:17:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1eygQr-0005YG-UM
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:17:45 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20180320173500.32065-1-vkuznets@redhat.com>
	<20180320173500.32065-3-vkuznets@redhat.com>
	<46c08ea1-27f7-e581-f93f-cf635950062f@redhat.com>
Date: Wed, 21 Mar 2018 17:17:38 +0100
In-Reply-To: <46c08ea1-27f7-e581-f93f-cf635950062f@redhat.com> (Paolo
	Bonzini's message of "Wed, 21 Mar 2018 16:33:33 +0100")
Message-ID: <87605p768t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, Roman Kagan <rkagan@virtuozzo.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 20/03/2018 18:35, Vitaly Kuznetsov wrote:
>> +        if (has_msr_hv_frequencies && env->tsc_khz) {
>>              env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
>>              env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
>>          }
>
> Since you have added cpu->hyperv_reenlightenment, I'd rather change this
> so that we don't make the "license to change guest ABI across migration"
> apply more.  We can exploit the fact that Windows doesn't even use the
> MSRs unless either invtsc or re-enlightenment is present.  Something
> like this:
>
>        if (has_msr_hv_frequencies && env->tsc_khz &&
> 	   (tsc_is_stable_and_known(env) ||
>             cpu->hyperv_reenlightenment))
>
> will make the MSRs visible in all useful cases, without having to add
> yet another knob.
>

Can be arranged, of course.

(What I'm worried about with all our hv_* knobs is that more of them we
have easier it is to assemble some frankenstien which won't look like
any existing Hyper-V version; we're probably not doing a very good job
tesing all possible hv_* combinations as people probably use 'all or
nothing'. In case we end up finding a bug in Windows with some weird
hv_* combination it's unlikely Microsoft will bother fixing at as it
doesn't reproduce on any existent Hyper-V version.

That said, it would be great to eventually have something like
'hv_ws2012r2' property making us look exactly the same real WS2012R2
looks like. Unfortunatelly, I'm unsure about a path to get there).

> (Don't worry, this backwards-compatibility stuff is the hardest part.
> I'm so happy that Eduardo is the one maintaining it :)).

I feel the pain :-) Thanks for the reviews!

-- 
  Vitaly
