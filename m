Received: from eggs.gnu.org ([2001:4830:134:3::10]:46678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdzjN-00015B-0Q
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdzjK-0006pv-Pk
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:34:49 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdzjJ-0006pF-Uo
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:34:46 -0500
Received: by mail-wm0-x232.google.com with SMTP id r141so40731187wmg.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 05:34:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87mvdnvcxx.fsf@linaro.org>
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-4-git-send-email-peter.maydell@linaro.org>
	<87mvdnvcxx.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Feb 2017 13:34:23 +0000
Message-ID: <CAFEAcA-PFJp_9=NOCFqiQp=xF6Y-TnmE3bfU3zDa6xH7nK2Zfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] armv7m: Rewrite NVIC to not use any
 GIC code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>

On 15 February 2017 at 12:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> From: Michael Davidsaver <mdavidsaver@gmail.com>
>>
>> Despite some superficial similarities of register layout, the
>> M-profile NVIC is really very different from the A-profile GIC.
>> Our current attempt to reuse the GIC code means that we have
>> significant bugs in our NVIC.
>>
>> Implement the NVIC as an entirely separate device, to give
>> us somewhere we can get the behaviour correct.
>>
>> This initial commit does not attempt to implement exception
>> priority escalation, since the GIC-based code didn't either.
>> It does fix a few bugs in passing:
>>  * ICSR.RETTOBASE polarity was wrong and didn't account for
>>    internal exceptions
>>  * ICSR.VECTPENDING was 16 too high if the pending exception
>>    was for an external interrupt
>>  * UsageFault, BusFault and MemFault were not disabled on reset
>>    as they are supposed to be
>>
>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>> [PMM: reworked, various bugs and stylistic cleanups]
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/intc/armv7m_nvic.c | 721 ++++++++++++++++++++++++++++++++++++++++---=
-------
>>  hw/intc/trace-events  |  15 ++
>>  2 files changed, 592 insertions(+), 144 deletions(-)
>>
>> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
>> index ce22001..e319077 100644
>> --- a/hw/intc/armv7m_nvic.c
>> +++ b/hw/intc/armv7m_nvic.c
>> @@ -17,48 +17,79 @@
>>  #include "hw/sysbus.h"
>>  #include "qemu/timer.h"
>>  #include "hw/arm/arm.h"
>> +#include "target/arm/cpu.h"
>>  #include "exec/address-spaces.h"
>> -#include "gic_internal.h"
>>  #include "qemu/log.h"
>> +#include "trace.h"
>> +
>> +/* IRQ number counting:
>> + *
>> + * the num-irq property counts the number of external IRQ lines
>> + *
>> + * NVICState::num_irq counts the total number of exceptions
>> + * (external IRQs, the 15 internal exceptions including reset,
>> + * and one for the unused exception number 0).
>> + *
>> + * NVIC_MAX_IRQ is the highest permitted number of external IRQ lines.
>> + *
>> + * NVIC_MAX_VECTORS is the highest permitted number of exceptions.
>> + *
>> + * Iterating through all exceptions should typically be done with
>> + * for (i =3D 1; i < s->num_irq; i++) to avoid the unused slot 0.
>> + *
>> + * The external qemu_irq lines are the NVIC's external IRQ lines,
>> + * so line 0 is exception 16.
>> + */
>> +#define NVIC_FIRST_IRQ 16
>> +#define NVIC_MAX_VECTORS 512
>> +#define NVIC_MAX_IRQ (NVIC_MAX_VECTORS - NVIC_FIRST_IRQ)
>> +
>> +/* Effective running priority of the CPU when no exception is active
>> + * (higher than the highest possible priority value)
>> + */
>> +#define NVIC_NOEXC_PRIO 0x100
>> +
>> +typedef struct VecInfo {
>> +    int16_t prio; /* priorities can range from -3 to 255 */
>> +    uint8_t enabled;
>> +    uint8_t pending;
>> +    uint8_t active;
>> +    uint8_t level; /* exceptions <=3D15 never set level */
>> +} VecInfo;
>>
>>  typedef struct NVICState {
>> -    GICState gic;
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +    /*< public >*/
>> +
>>      ARMCPU *cpu;
>>
>> +    VecInfo vectors[NVIC_MAX_VECTORS];
>>      uint32_t prigroup;
>>
>> +    /* vectpending and exception_prio are both cached state that can
>> +     * be recalculated from the vectors[] array and the prigroup field.
>> +     */
>> +    unsigned int vectpending; /* highest prio pending enabled exception=
 */
>> +    int exception_prio; /* group prio of the highest prio active except=
ion */
>> +
>
> nit: the field comments could be more neatly rolled into the block
> comment above them.

I prefer this way. The block comment is describing the properties
of a category of the fields. The per-line comments are describing
the semantics of the fields defined on the lines they're on.

>> +static int nvic_pending_prio(NVICState *s)
>> +{
>> +    /* return the priority of the current pending interrupt,
>> +     * or NVIC_NOEXC_PRIO if no interrupt is pending
>> +     */
>> +    return s->vectpending ? s->vectors[s->vectpending].prio : NVIC_NOEX=
C_PRIO;
>> +}
>> +
>> +/* Return the value of the ISCR RETTOBASE bit:
>> + * 1 if there is exactly one active exception
>> + * 0 if there is more than one active exception
>> + * UNKNOWN if there are no active exceptions (we choose 0)
>> + */
>
> This doesn't match what the ARMv7M ARM says (for Handler mode):
>
>   0 There is an active exception other than the exception shown by IPSR.
>   1 There is no active exception other than any exception shown by IPSR.

They're only different if the guest code has managed
to deactivate the IPSR exception without leaving the
exception handler. This is bogus guest code and will cause
an exception-return-integrity-check to fail when the guest
exits the handler. It's also pretty hard to do: the only
method is to clear the SHCSR bits for those few exceptions
which report their active state there.

Otherwise "no active exceptions" =3D> not in handler mode;
"more than 1 active exception" =3D> IPSR exception and another;
"exactly one active exception" =3D> the IPSR exception

I would be unsurprised to find that the documentation of the
RETTOBASE bit was just phrased in a way that forgot about
the possible effect of the deactivated-your-own-exception
corner case. I'll investigate a bit more what's going on
here and whether eg the v8M ARM ARM nails down the behaviour
more precisely, though.

>> +static bool nvic_rettobase(NVICState *s)
>> +{
>> +    int irq, nhand =3D 0;
>> +
>> +    for (irq =3D ARMV7M_EXCP_RESET; irq < s->num_irq; irq++) {
>> +        if (s->vectors[irq].active) {
>
> I would expect && !what the ISPR is reporting. However looking at the
> code it doesn't look like we ever report an exception in the IPSR
> (assuming HELPER(v7m_mrs) is the right one).

See xpsr_read() in target/arm/cpu.h -- we report
v7m.exception in the IPSR bits.

>> +            nhand++;
>> +            if (nhand =3D=3D 2) {
>> +                break;
>> +            }
>> +        }
>> +    }
>> +
>> +    return nhand =3D=3D 1;
>> +}
>> +
>> +/* Return the value of the ISCR ISRPENDING bit:
>> + * 1 if an external interrupt is pending
>> + * 0 if no external interrupt is pending
>> + */
>> +static bool nvic_isrpending(NVICState *s)
>> +{
>> +    int irq;
>> +
>> +    /* We can shortcut if the highest priority pending interrupt
>> +     * happens to be external or if there is nothing pending.
>> +     */
>> +    if (s->vectpending > NVIC_FIRST_IRQ) {
>> +        return true;
>> +    }
>> +    if (s->vectpending =3D=3D 0) {
>> +        return false;
>> +    }
>> +
>> +    for (irq =3D NVIC_FIRST_IRQ; irq < s->num_irq; irq++) {
>
> Should NVIC_FIRST_IRQ be renamed to NVIC_FIRST_EXTERNAL_IRQ?

The internal ones aren't IRQs, they're exceptions.
The terminology is a bit confusing, though.

>> +        if (s->vectors[irq].pending) {
>> +            return true;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>> +/* Return a mask word which clears the subpriority bits from
>> + * a priority value for an M-profile exception, leaving only
>> + * the group priority.
>> + */
>> +static inline uint32_t nvic_gprio_mask(NVICState *s)
>> +{
>> +    return ~0U << (s->prigroup + 1);
>
> I wonder if it is worth adding MAKE_32BIT_MASK to bitops.h?

MAKE_64BIT_MASK would work here too. This is the same way
arm_gicv3_cpuif.c writes it, though.

>> +/* caller must call nvic_irq_update() after this */
>> +static void set_prio(NVICState *s, unsigned irq, uint8_t prio)
>> +{
>> +    assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios *=
/
>> +    assert(irq < s->num_irq);
>> +
>> +    s->vectors[irq].prio =3D prio;
>
> So this means the negative priorities are hardwired parts of the NVIC
> for NMI/RESET? Maybe we should make that clearer in the comment for
> VecInfo.

Sure. (Yes, the priorities for NMI and HardFault are architecturally
hardwired. I suspect that in hardware they are not in fact represented
as negative numbers :-))

>>  /* Make pending IRQ active.  */
>>  int armv7m_nvic_acknowledge_irq(void *opaque)
>>  {
>>      NVICState *s =3D (NVICState *)opaque;
>> -    uint32_t irq;
>> -
>> -    irq =3D gic_acknowledge_irq(&s->gic, 0, MEMTXATTRS_UNSPECIFIED);
>> -    if (irq =3D=3D 1023)
>> -        hw_error("Interrupt but no vector\n");
>> -    if (irq >=3D 32)
>> -        irq -=3D 16;
>> -    return irq;
>> +    CPUARMState *env =3D &s->cpu->env;
>> +    const int pending =3D s->vectpending;
>> +    const int running =3D nvic_exec_prio(s);
>> +    int pendgroupprio;
>> +    VecInfo *vec;
>> +
>> +    assert(pending > ARMV7M_EXCP_RESET && pending < s->num_irq);
>> +
>> +    vec =3D &s->vectors[pending];
>> +
>> +    assert(vec->enabled);
>> +    assert(vec->pending);
>> +
>> +    pendgroupprio =3D vec->prio & nvic_gprio_mask(s);
>> +    assert(pendgroupprio < running);
>
> I'm all for asserts to declare what the API is expecting. These are
> starting to look like being unsure of the nvic being in the correct
> state. Are they left over from debugging?

They're mostly left over from Michael's code where I didn't
see any reason to specifically delete them. For this particular
assert the situation is quite complicated -- we know the
pending priority must be such that we can take this
exception, but that is only true because the code
in target/arm is required to only try to acknowledge
(take) the exception if the priority permits it,
which in turn is the result of a combination of the
conditions that the NVIC applies to decide whether to
assert the interrupt line and the conditions applied
in arm_v7m_cpu_exec_interrupt() to decide whether to
call the CPU do_interrupt hook. That's quite a lot of
moving parts which need to all agree, which I think makes
an assert() justified.

>> @@ -428,28 +713,81 @@ static uint64_t nvic_sysreg_read(void *opaque, hwa=
ddr addr,
>>  {
>>      NVICState *s =3D (NVICState *)opaque;
>>      uint32_t offset =3D addr;
>> -    int i;
>> +    unsigned i, end;
>>      uint32_t val;
>>
>>      switch (offset) {
>> +    /* reads of set and clear both return the status */
>> +    case 0x100 ... 0x13f: /* NVIC Set enable */
>> +        offset +=3D 0x80;
>> +        /* fall through */
>> +    case 0x180 ... 0x1bf: /* NVIC Clear enable */
>> +        val =3D 0;
>> +        offset =3D offset - 0x180 + NVIC_FIRST_IRQ; /* vector # */
>
> Can we not calculate a vector index rather than abusing the meaning of
> offset while switching on it?

Yeah, we could. (This is just a case where I thought "I could
rewrite the code Michael did initially, but it doesn't quite
reach my threshold for doing that just because it's not the
way I'd have written it.".)


>> +    /* include space for internal exception vectors */
>> +    s->num_irq +=3D NVIC_FIRST_IRQ;
>> +
>> +    /* The NVIC and system controller register area starts at 0xe000e00=
0
>> +     * and looks like this:
>
> s/system controller register area/System Control Space (SCS)/ to make it
> easier to find in the ARM ARM.

OK.

thanks
-- PMM
