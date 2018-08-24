Received: from eggs.gnu.org ([2001:4830:134:3::10]:54812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ft9Ua-0007U2-UL
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ft9Ua-0003DJ-1j
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:39:00 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ft9UZ-0003Cp-Qy
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:38:59 -0400
Received: by mail-oi0-x241.google.com with SMTP id z185-v6so14088722oia.5
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 03:38:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <26a33eec-3ed5-f05d-7c36-5b46eeba9612@huawei.com>
References: <1535039100-11248-1-git-send-email-gengdongjiu@huawei.com>
	<1535039100-11248-2-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA9DJ_GMkq1fGUjXJDu9GUM0cd6Pjm1HsXpm5rQ5n78Zew@mail.gmail.com>
	<26a33eec-3ed5-f05d-7c36-5b46eeba9612@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 11:38:38 +0100
Message-ID: <CAFEAcA8e77FvPCEKGb0eNoWf_NnQqoyMz3P_-=hJCC-PW3+2vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 2/2] target: arm: Add support for VCPU
 event states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Linuxarm <linuxarm@huawei.com>

On 24 August 2018 at 11:28, gengdongjiu <gengdongjiu@huawei.com> wrote:
> On 2018/8/24 0:52, Peter Maydell wrote:
>> On 23 August 2018 at 16:45, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>>> +static int kvm_put_vcpu_events(ARMCPU *cpu)
>>> +{
>>> +    CPUARMState *env = &cpu->env;
>>> +    struct kvm_vcpu_events events = {};
>>> +
>>> +    if (!kvm_has_vcpu_events()) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    memset(&events, 0, sizeof(events));
>>> +    events.exception.serror_pending = env->serror.pending;
>>> +
>>> +    if (have_inject_serror_esr) {
>>> +        events.exception.serror_has_esr = env->serror.has_esr;
>>> +        events.exception.serror_esr = env->serror.esr;
>>> +    }
>>
>> I realised that the effect of this condition is that
>> if we migrate a VM from a machine which supports specifying the
>> SError ESR to one which does not, and at the point of migration
>> there is a pending SError with an ESR value, then we will
>> silently drop the specified ESR value. The other alternative
>> would be to fail the migration (by dropping the if() check,
>> and letting the host kernel fail the ioctl if that meant that
>> we asked it to set an SError ESR it couldn't manage.)
>>
>> I guess that's OK? It's all hypothetical currently since
>> we don't support migration between different host CPU types.
>
> Peter,
>    there are two status needed to migrate, one is serror_pending, another is SError ESR value.
>
> If A migrates to B, A can set an SError ESR, but B does not support to set.
> when A is pending a SError and need to migrate to B, I think it should support to migrate the serror_pending status without the ESR value(the ESR value is 0).
> That is to say,  if A is pending a SError, when migrate to B, B should also pend a SError.
>
> or do you think we should refused this migration?

I don't know, that's why I asked. If we have a pending
SError with an ESR, and we end up on a destination machine
where we can pend the SError but not the ESR, does that
make sense (ie will the guest still be able to usefully
continue), or have we thrown away information that the
guest requires to be able to usefully use the SError ?
Presumably the ESR is important, or we could just never
bother to set it when pending SErrors.

thanks
-- PMM
