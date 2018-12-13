Received: from eggs.gnu.org ([2001:4830:134:3::10]:36023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXSOS-0004Q4-Tz
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXSOP-0007Wo-0Y
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:16 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXSOO-0007Vq-MN
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:12 -0500
Received: by mail-wr1-x441.google.com with SMTP id t27so2315060wra.6
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 06:55:12 -0800 (PST)
References: <20181213115503.24188-1-alex.bennee@linaro.org>
	<20181213115503.24188-2-alex.bennee@linaro.org>
	<CAKv+Gu_C78f-a1MdsdXHi6u_gyhRh3djbzM3_vZ3K=AtWzqXGg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAKv+Gu_C78f-a1MdsdXHi6u_gyhRh3djbzM3_vZ3K=AtWzqXGg@mail.gmail.com>
Date: Thu, 13 Dec 2018 14:55:10 +0000
Message-ID: <87mup91nox.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Mark Rutland <mark.rutland@arm.com>, omair.javaid@linaro.org, Peter Maydell <peter.maydell@linaro.org>


Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:

> Hi Alex,
>
> Thanks again for looking into this.
>
> On Thu, 13 Dec 2018 at 12:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
<snip>
>
>>
>>  int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoin=
t *bp)
>>  {
>> +    CPUARMState *env =3D &ARM_CPU(cs)->env;
>> +    int el =3D arm_current_el(env);
>> +    bool is_aa64 =3D arm_el_is_aa64(env, el);
>> +    const uint32_t *bpi =3D is_aa64 ? &brk_insn : &bkpt_insn;
>> +
>>      if (have_guest_debug) {
>>          if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn,=
 4, 0) ||
>> -            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)=
) {
>> +            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)bpi, 4, 1)) {
>
> Should we be dealing with endianness here?
>
<snip>

I don't think so - everything eventually ends up (ld|st)n_p which deals
with the endianness details.

--
Alex Benn=C3=A9e
