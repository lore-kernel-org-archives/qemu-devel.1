Received: from eggs.gnu.org ([2001:4830:134:3::10]:49655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNMou-0004Nc-11
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNMot-0002IE-83
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:56:51 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNMot-0002BY-3p
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:56:51 -0500
Received: by mail-ot1-x342.google.com with SMTP id u3so13888598ota.5
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 10:56:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <94e3624b-a2a3-7a1e-7dc7-6e43d8447f1e@linaro.org>
References: <20181029155339.15280-1-richard.henderson@linaro.org>
	<20181029155339.15280-2-richard.henderson@linaro.org>
	<CAFEAcA82DVtipZg7GVPJyUCKSUJUXzijRFzo6xRGmkYet0VuLA@mail.gmail.com>
	<94e3624b-a2a3-7a1e-7dc7-6e43d8447f1e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 18:56:14 +0000
Message-ID: <CAFEAcA8jD0bRzLUbATTSW+wEh90iv3eaA7=eQA2kQnT=T2hRbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/4] cputlb: Add tlb_set_asid_for_mmuidx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 November 2018 at 18:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 11/15/18 7:36 PM, Peter Maydell wrote:
>> On 29 October 2018 at 15:53, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> Although we can't do much with ASIDs except remember them, this
>>> will allow cleanups within target/ that should make things clearer.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

>>> +void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid, uint16_t idxmap,
>>> +                             uint16_t depmap)
>>> +{
>>> +    CPUArchState *env = cpu->env_ptr;
>>> +    uint16_t work, to_flush = 0;
>>
>> The other functions that work on the tlb defer their
>> actual operation to an async-work type function or
>> do a run-on-cpu if the passed-in CPU is not the current
>> CPU. Do we need to do that here too?
>
> I don't *think* so.  I would expect an ASID to be set in response to some
> cpu-local change, like setting TTBR0_EL1.  Something that cannot be done across
> cpus.  I could assert_cpu_is_self, if you like.

Yes, if the function expects to be called only for the
current CPU we should assert and document this.

> What I *should* be adding as well is cross-cpu asid-specific tlb flushing, a-la
> TLBI ASID.  That would need the run-on-cpu stuff.
>
>> So this will flush all the passed in indexes in idxmap
>> if any one of them was previously the wrong ASID. Is that
>> necessary, or could we just flush only the ones which
>> were wrong and not flush any that were already the correct ASID ?
>
> It probably wouldn't be necessary.  But I also sort of expect the set of
> indexes to always have the same ASID -- e.g. kernel vs user views of the same
> address space, e.g. S12NSE0 + S12NSE1.  I don't really know what to do when
> this presumed invariant is violated.

We should either document the invariant at the cputlb.c level
(and assert it, if not too tedious to do), or say that the cputlb
code doesn't care, and just only flush the indexes which have the
wrong ASID currently, I think.

thanks
-- PMM
