Received: from eggs.gnu.org ([2001:4830:134:3::10]:38141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXZQO-0000g6-VF
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXZQK-0008Ic-Qx
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:25:44 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXZQJ-0007kx-US
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:25:40 -0500
Received: by mail-ot1-x343.google.com with SMTP id k98so3553579otk.3
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:25:28 -0800 (PST)
References: <20181213115503.24188-1-alex.bennee@linaro.org>
	<20181213115503.24188-2-alex.bennee@linaro.org>
	<CAKv+Gu_C78f-a1MdsdXHi6u_gyhRh3djbzM3_vZ3K=AtWzqXGg@mail.gmail.com>
	<87mup91nox.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a78b697f-4bb8-f54e-28a9-34ecf6a40f29@linaro.org>
Date: Thu, 13 Dec 2018 16:25:24 -0600
MIME-Version: 1.0
In-Reply-To: <87mup91nox.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target/arm: kvm64 make guest debug
 AA32 break point aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, omair.javaid@linaro.org

On 12/13/18 8:55 AM, Alex Bennée wrote:
> 
> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
> 
>> Hi Alex,
>>
>> Thanks again for looking into this.
>>
>> On Thu, 13 Dec 2018 at 12:55, Alex Bennée <alex.bennee@linaro.org> wrote:
> <snip>
>>
>>>
>>>  int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>>>  {
>>> +    CPUARMState *env = &ARM_CPU(cs)->env;
>>> +    int el = arm_current_el(env);
>>> +    bool is_aa64 = arm_el_is_aa64(env, el);
>>> +    const uint32_t *bpi = is_aa64 ? &brk_insn : &bkpt_insn;
>>> +
>>>      if (have_guest_debug) {
>>>          if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
>>> -            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
>>> +            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)bpi, 4, 1)) {
>>
>> Should we be dealing with endianness here?
>>
> <snip>
> 
> I don't think so - everything eventually ends up (ld|st)n_p which deals
> with the endianness details.

I think Ard is right.  You need to consider dynamic endianness with

    bswap_code(arm_sctlr_b(env))


r~
r~
