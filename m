Received: from eggs.gnu.org ([2001:4830:134:3::10]:34554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eizp3-0007p8-AQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eizp2-0008CO-4Y
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:45:53 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:39480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eizp1-0008C0-Uh
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:45:52 -0500
Received: by mail-oi0-x22d.google.com with SMTP id j188so880659oib.6
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 01:45:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b1112be1-c1bf-ee94-f786-84f248e223c5@amsat.org>
References: <20180205105720.14620-1-peter.maydell@linaro.org>
	<20180205105720.14620-6-peter.maydell@linaro.org>
	<b1112be1-c1bf-ee94-f786-84f248e223c5@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 09:45:30 +0000
Message-ID: <CAFEAcA9=ty0TyC87=SYduk773iE_tnZ2tJkSq8-BC5cVtQwwdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 5/8] hw/intc/armv7m_nvic:
 Implement cache ID registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 5 February 2018 at 23:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Hi Peter,
>
> On 02/05/2018 07:57 AM, Peter Maydell wrote:
>> M profile cores have a similar setup for cache ID registers
>> to A profile:
>>  * Cache Level ID Register (CLIDR) is a fixed value
>>  * Cache Type Register (CTR) is a fixed value
>>  * Cache Size ID Registers (CCSIDR) are a bank of registers;
>>    which one you see is selected by the Cache Size Selection
>>    Register (CSSELR)
>>
>> The only difference is that they're in the NVIC memory mapped
>> register space rather than being coprocessor registers.
>> Implement the M profile view of them.
>>
>> Since neither Cortex-M3 nor Cortex-M4 implement caches,
>> we don't need to update their init functions and can leave
>> the ctr/clidr/ccsidr[] fields in their ARMCPU structs at zero.
>> Newer cores (like the Cortex-M33) will want to be able to
>> set these ID registers to non-zero values, though.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> The CSSELR/CCSIDR parts are a bit under-motivated, because
>> the Cortex-M33 doesn't implement caches either and so they
>> are RAZ/WI for that as well as M3/M4, though I'd written all
>> the code before I realized that. This will be helpful if
>> we ever need a Cortex-M7 model, though (which does have
>> a couple of CSSIDR array entries).
>
> I wonder if it is easier/faster to add a check for the "Instruction not
> Data" bit and the level value is not 7 (not permitted) or simple comments=
.
>
>> ---
>>  target/arm/cpu.h      |  9 +++++++++
>>  hw/intc/armv7m_nvic.c | 13 +++++++++++++
>>  target/arm/machine.c  | 36 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 58 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index f21f68ec4a..99c7cb996f 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -453,6 +453,7 @@ typedef struct CPUARMState {
>>          uint32_t faultmask[M_REG_NUM_BANKS];
>>          uint32_t aircr; /* only holds r/w state if security extn implem=
ented */
>>          uint32_t secure; /* Is CPU in Secure state? (not guest visible)=
 */
>> +        uint32_t csselr[M_REG_NUM_BANKS];
>>      } v7m;
>>
>>      /* Information associated with an exception about to be taken:
>> @@ -2443,6 +2444,14 @@ static inline int arm_debug_target_el(CPUARMState=
 *env)
>>      }
>>  }
>>
>> +static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
>> +{
>> +    /* If all the CLIDR.Ctypem bits are 0 there are no caches, and
>> +     * CSSELR is RAZ/WI.
>> +     */
>> +    return (cpu->clidr & 0x001fffff) !=3D 0;
>> +}
>
> Suggestion to be consistent with other bitfields:
>
> /* V7M Cache Level ID (CLIDR) */
> FIELD(V7M_CLIDR, CTYPE, 0, 7 * 3)
>
> So we can use:
>
>     return (cpu->clidr & R_V7M_CLIDR_CTYPE_MASK) !=3D 0;
>
>> +
>>  static inline bool aa64_generate_debug_exceptions(CPUARMState *env)
>>  {
>>      if (arm_is_secure(env)) {
>> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
>> index eb49fd77c7..cc83c9e553 100644
>> --- a/hw/intc/armv7m_nvic.c
>> +++ b/hw/intc/armv7m_nvic.c
>> @@ -1025,6 +1025,14 @@ static uint32_t nvic_readl(NVICState *s, uint32_t=
 offset, MemTxAttrs attrs)
>>          return cpu->id_isar4;
>>      case 0xd74: /* ISAR5.  */
>>          return cpu->id_isar5;
>> +    case 0xd78: /* CLIDR */
>> +        return cpu->clidr;
>> +    case 0xd7c: /* CTR */
>> +        return cpu->ctr;
>> +    case 0xd80: /* CSSIDR */
>> +        return cpu->ccsidr[cpu->env.v7m.csselr[attrs.secure] & 0xf];
>
> /* V7M Cache Size Selection (CSSELR) */
> FIELD(V7M_CSSELR, LEVEL, 1, 3)

Yes, but the index into the csselr[] array is by both the level
field and the I/D bit: csselr[0] is L1 dcache, csselr[1] is
L1 icache, csselr[2] is L2 dcache, and so on.

I guess we could define some field constants.

thanks
-- PMM
