Received: from eggs.gnu.org ([2001:4830:134:3::10]:60651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exwlF-0007UI-Oj
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exwlE-0001Q0-R8
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:31:45 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exwlE-0001Pf-LR
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:31:44 -0400
Received: by mail-oi0-x244.google.com with SMTP id q71so4382359oic.6
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 08:31:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319152426.GB24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-15-git-send-email-alindsay@codeaurora.org>
	<9af89876-bf5d-4696-a430-664fcd5a02fa@amsat.org>
	<20180319152426.GB24561@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 15:31:21 +0000
Message-ID: <CAFEAcA_1gVEziptLMoEm-noVM7EZqP=KLg1uyaLfAd+7PToHdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/22] target/arm: Make PMOVSCLR 64 bits
 wide
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, QEMU Developers <qemu-devel@nongnu.org>, Digant Desai <digantd@codeaurora.org>

On 19 March 2018 at 15:24, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> Phil,
>
> On Mar 19 00:14, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Aaron,
>>
>> On 03/16/2018 09:31 PM, Aaron Lindsay wrote:
>> > This is a bug fix to ensure 64-bit reads of this register don't read
>> > adjacent data.
>> >
>> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
>> > ---
>> >  target/arm/cpu.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> > index 9c3b5ef..fb2f983 100644
>> > --- a/target/arm/cpu.h
>> > +++ b/target/arm/cpu.h
>> > @@ -367,7 +367,7 @@ typedef struct CPUARMState {
>> >          uint32_t c9_data;
>> >          uint64_t c9_pmcr; /* performance monitor control register */
>> >          uint64_t c9_pmcnten; /* perf monitor counter enables */
>> > -        uint32_t c9_pmovsr; /* perf monitor overflow status */
>> > +        uint64_t c9_pmovsr; /* perf monitor overflow status */
>>
>> This doesn't look correct, since this reg is 32b.
>>
>> I *think* the correct fix is in ARMCPRegInfo v7_cp_reginfo[]:
>>
>>     { .name =3D "PMOVSR", ...
>> -     ..., .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pmovsr),
>> +     ..., .fieldoffset =3D offsetoflow32(CPUARMState, cp15.c9_pmovsr),
>>       .accessfn =3D pmreg_access,
>>       .writefn =3D pmovsr_write,
>>       .raw_writefn =3D raw_write },
>
> Nearly all of these PMU registers are 32 bits wide, but most of them are
> implemented as 64-bit registers (PMCR, PMCNTEN*, PMSELR, PMINTEN* are a
> few examples I see in this patch's context). My understanding is that
> AArch64 register accesses are handled as 64 bits, even if the register
> itself isn't that wide (though I haven't personally verified this).

Correct. Technically there's no such thing as a 32-bit wide AArch64
system register -- that is just a shorthand in the Arm ARM for
"64-bit wide with the top 32-bits being RES0".

thanks
-- PMM
