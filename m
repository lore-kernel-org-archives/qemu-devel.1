Received: from eggs.gnu.org ([2001:4830:134:3::10]:38440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ewrT0-0006MQ-K5
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ewrSx-00086X-Ck
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:40:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ewrSx-00086H-8P
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:40:23 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20180312151233.16565-1-vkuznets@redhat.com>
	<20180312151233.16565-3-vkuznets@redhat.com>
	<7d1afa27-9653-75dc-ebfe-8633b93f1ce6@redhat.com>
	<87efkk9i2j.fsf@vitty.brq.redhat.com>
	<cd71ecd6-7a3c-05e5-7854-d71763cbc4c2@redhat.com>
Date: Fri, 16 Mar 2018 16:40:06 +0100
In-Reply-To: <cd71ecd6-7a3c-05e5-7854-d71763cbc4c2@redhat.com> (Paolo
	Bonzini's message of "Fri, 16 Mar 2018 16:28:20 +0100")
Message-ID: <87605w9gh5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] i386/kvm: lower requirements for
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
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 16/03/2018 16:05, Vitaly Kuznetsov wrote:
>>>>  
>>>> -        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
>>>> +        if (has_msr_hv_frequencies && env->tsc_khz) {
>>> Should this be
>>>
>>> ((env->tsc_khz && has_msr_hv_reenlightenment) ||
>>>  tsc_is_stable_and_known(env))
>>>
>>> so that you don't regress on older kernels?
>>>
>> I don't actually see where the regression might come from: frequency
>> MSRs are supported regardless or reenlightenment/invtsc and there's
>> nothing wrong with exposing them but I may be missing something..
>
> On older kernel without re-enlightenment support, you don't want to
> expose the frequency MSRs unless invtsc is on, right?
>

Actually no, I think it's OK to expose frequency MSRs even when we don't
have invtsc and don't support re-enlightenment. Nested Hyper-V won't
pass stable TSC pages to its guests unless it sees either invtsc or
reenlightenment. So as long as we have something to put to these MSRs
(env->tsc_khz) I *think* we can expose them.

I may actually be missing the reason why Ladi put
tsc_is_stable_and_known() here. In case we're running Windows (and not
Hyper-V) as a guest KVM will update TSC page on migration. And genuine
Hyper-V also exposes these MSRs without exposing INVTSC flag by
default.

-- 
  Vitaly
