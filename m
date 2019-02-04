Received: from eggs.gnu.org ([209.51.188.92]:42402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqgbN-0005xO-W8
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqgbM-0006SN-Qx
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:56:05 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqgbM-0006Rn-Jg
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:56:04 -0500
Received: by mail-ot1-x344.google.com with SMTP id a11so498666otr.10
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 07:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20190128173940.25813-1-alex.bennee@linaro.org>
	<20190128173940.25813-3-alex.bennee@linaro.org>
	<CAFEAcA9fD_bju_+QM3D+088rKJffQ66HBPYUB-cDknKmPikhaQ@mail.gmail.com>
	<87munb4lgv.fsf@zen.linaroharston>
In-Reply-To: <87munb4lgv.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 15:55:52 +0000
Message-ID: <CAFEAcA__N6kPPzems0DS0oLLvqp0VoBjdbB6vvRNywQi8uw0nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/4] target/arm: expose CPUID registers
 to userspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 4 Feb 2019 at 15:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > This doesn't seem right -- I think ID_AA64DFR0_EL1 should be exposed
> > as zero, not whatever the underlying register value is.
>
> Under a kernel I'm seeing numbers reported so I don't think it's totally
> squashed:
>
>   id_aa64dfr0_el1     : 0x0000000000000006
>   id_aa64dfr1_el1     : 0x0000000000000000
>
> Confusingly the kernel does:
>
> static const struct arm64_ftr_bits ftr_id_aa64dfr0[] =3D {
>         ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 36, 28, 0),
>         ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64=
DFR0_PMSVER_SHIFT, 4, 0),
>         ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR=
0_CTX_CMPS_SHIFT, 4, 0),
>         ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR=
0_WRPS_SHIFT, 4, 0),
>         ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR=
0_BRPS_SHIFT, 4, 0),
>         /*
>          * We can instantiate multiple PMU instances with different level=
s
>          * of support.
>          */
>         S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64DFR=
0_PMUVER_SHIFT, 4, 0),
>         ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64DFR0_TRA=
CEVER_SHIFT, 4, 0),
>         ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64DFR0_DEB=
UGVER_SHIFT, 4, 0x6),
>         ARM64_FTR_END,
> };
>
> So I'm not sure if that is intentional as the line:
>
>   ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64DFR0_DEBUGVER_=
SHIFT, 4, 0x6)
>
> implies the DEBUGVER is hidden but actually 0x6?

I think this is because the field in the register is architecturally
defined to have a restricted set of permitted values, of which 0 is
not one. (6 means "ARMv8 debug architecture" so is the effective minimum.)

> > More generally, this ifdeffing of "maybe mask the values" doesn't
> > seem very future-proof. If we add something to one of the cpu-id_*
> > values, that should be masked out to zero by default for linux-user,
> > not defaulting to passed through.
>
> Do you mean setting cpu->id_foo during cpu_init? I wasn't sure if that
> might interact badly with the recent changes to base our features off
> what's actually set in them.

No, I meant having something where we either:
 (a) have a separate set of cpreg structs for the userspace visible version=
s,
or (b) have some code which modifies the cpreg structs in v8_idregs[] (it's
not const) before handing it to define_arm_cp_regs().
(b) sounds better to me -- the ideal here I think would be something where =
we:
 * mark all the regs in the space the kernel covers as PL0U_R with a bit
   of code rather than by changing all the cpreg structs
 * default them to "no bits of the real value are exposed, all bits 0"
 * have a hopefully short list of overrides, probably defined in a special
   purpose array with entries like
 { /* ID_AA64DFR0_EL1 */, .crm =3D 5, .opc2 =3D 0, .passbits =3D 0x0,
.fixedbits =3D 0x6 },
Or we could match the override entries with cpreg values by register name,
which would let you say
 { "ID_AA64DFR0_EL1", .passbits =3D 0x0, .fixedbits =3D 0x6 },
and avoid having to repeat the encoding values, which might be neater.

thanks
-- PMM
