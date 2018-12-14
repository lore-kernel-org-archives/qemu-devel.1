Received: from eggs.gnu.org ([2001:4830:134:3::10]:54594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1gXqWP-0004Uu-QJ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1gXqWO-0004w6-Ta
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:41:05 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:36919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1gXqWO-0004t1-Eo
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:41:04 -0500
Received: by mail-it1-x144.google.com with SMTP id b5so10220344iti.2
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 08:41:03 -0800 (PST)
MIME-Version: 1.0
References: <20181213115503.24188-1-alex.bennee@linaro.org>
	<20181213115503.24188-2-alex.bennee@linaro.org>
	<CAKv+Gu_C78f-a1MdsdXHi6u_gyhRh3djbzM3_vZ3K=AtWzqXGg@mail.gmail.com>
	<87mup91nox.fsf@linaro.org>
	<a78b697f-4bb8-f54e-28a9-34ecf6a40f29@linaro.org>
	<87ftv013dr.fsf@linaro.org>
In-Reply-To: <87ftv013dr.fsf@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 14 Dec 2018 17:40:51 +0100
Message-ID: <CAKv+Gu-2tfeNXmjPcbXPRaByFhq3fFGkvL-YAthP=X=nCpEpLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Omair Javaid <omair.javaid@linaro.org>

On Fri, 14 Dec 2018 at 17:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > On 12/13/18 8:55 AM, Alex Benn=C3=A9e wrote:
> >>
> >> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
> >>
> >>> Hi Alex,
> >>>
> >>> Thanks again for looking into this.
> >>>
> >>> On Thu, 13 Dec 2018 at 12:55, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
> >> <snip>
> >>>
> >>>>
> >>>>  int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_break=
point *bp)
> >>>>  {
> >>>> +    CPUARMState *env =3D &ARM_CPU(cs)->env;
> >>>> +    int el =3D arm_current_el(env);
> >>>> +    bool is_aa64 =3D arm_el_is_aa64(env, el);
> >>>> +    const uint32_t *bpi =3D is_aa64 ? &brk_insn : &bkpt_insn;
> >>>> +
> >>>>      if (have_guest_debug) {
> >>>>          if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_i=
nsn, 4, 0) ||
> >>>> -            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4=
, 1)) {
> >>>> +            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)bpi, 4, 1)) =
{
> >>>
> >>> Should we be dealing with endianness here?
> >>>
> >> <snip>
> >>
> >> I don't think so - everything eventually ends up (ld|st)n_p which deal=
s
> >> with the endianness details.
> >
> > I think Ard is right.  You need to consider dynamic endianness with
> >
> >     bswap_code(arm_sctlr_b(env))
>
> *sigh* I guess. It of course still a heuristic that can break because we
> don't know if the system will have switched mode by the time it gets to
> the breakpoint.
>

Actually, I was referring to the QEMU/host side. Instruction encodings
are always little endian in ARMv7 and v8 (which is all KVM cares about
in any case), but I guess it is [theoretically?] possible that we are
running a BE QEMU?
