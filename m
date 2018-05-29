Received: from eggs.gnu.org ([2001:4830:134:3::10]:44772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fNW9Q-0008K5-Qb
	for qemu-devel@nongnu.org; Tue, 29 May 2018 00:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fNW9P-0001zS-Kn
	for qemu-devel@nongnu.org; Tue, 29 May 2018 00:22:24 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <45bcd928-b328-0a0b-a0a2-6b4c4f0b560e@amsat.org>
References: <20180528152225.7108-1-joel@jms.id.au>
	<45bcd928-b328-0a0b-a0a2-6b4c4f0b560e@amsat.org>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 29 May 2018 13:52:01 +0930
Message-ID: <CACPK8XfyPwPrFjMUBKLdYgF=0qNZKXi3KT5OvUnELsAO9W9siQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] aspeed_scu: Implement RNG register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On 29 May 2018 at 01:37, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Hi Joel,
>
> On 05/28/2018 12:22 PM, Joel Stanley wrote:
>> The ASPEED SoCs contain a single register that returns random data when
>> read. This models that register so that guests can use it.
>>
>> The random number data register has a corresponding control register,
>> data returns a different number regardless of the state of the enabled
>> bit, so the model follows this behaviour.
>
> I have been bugging C=C3=A9dric to check specs for the RNG_CTRL register =
and
> he sent me the v1 of this patch than I missed:
>
>     >>> may be we could test bit 1 of RNG_CTRL to check if it is enabled
> or not.
>     >>
>     >> The RNG is enabled by default, and I didn't find any software that
>     >> disables it, but it can't hurt to have that check.
>     >
>     > I did some testing on hardware, and the rng still outputs a differe=
nt
>     > number each time I ask for one regardless of the state of the enabl=
ed
>     > bit.
>     >
>     I confirm that the HW doesn't really care about the enabled bit.
>     Let's ignore it then ?
>
> Now your comment makes more sens, however I think it would be more
> useful to add it in aspeed_scu_read() to make it obvious.
>
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>> v2:
>>  - Remove call to qcrypto_random_init as this is done in main()
>> ---
>>  hw/misc/aspeed_scu.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
>> index 5e6d5744eeca..29e58527793b 100644
>> --- a/hw/misc/aspeed_scu.c
>> +++ b/hw/misc/aspeed_scu.c
>> @@ -16,6 +16,7 @@
>>  #include "qapi/visitor.h"
>>  #include "qemu/bitops.h"
>>  #include "qemu/log.h"
>> +#include "crypto/random.h"
>>  #include "trace.h"
>>
>>  #define TO_REG(offset) ((offset) >> 2)
>> @@ -154,6 +155,18 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_=
NR_REGS] =3D {
>>       [BMC_DEV_ID]      =3D 0x00002402U
>>  };
>>
>> +static uint32_t aspeed_scu_get_random(void)
>> +{
>> +    Error *err =3D NULL;
>> +    uint32_t num;
>> +
>> +    if (qcrypto_random_bytes((uint8_t *)&num, sizeof(num), &err)) {
>> +        error_report_err(err);
>> +    }
>> +
>> +    return num;
>> +}
>
> This function duplicates bcm2835_rng::get_random_bytes() except it
> doesn't exit(), is that on purpose?

Yes. It's not fatal to the emulation if we can't provide random data.
The aspeed model is used for smoketesting firmware builds and aiding
in firmware development, so strong cryptographic guarantees are not
essential.

> What about refactoring, inlining bcm2835_rng::get_random_bytes() in a
> new include/hw/misc/rng.h?
>
> (This can be later patch)
>
>> +
>>  static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned s=
ize)
>>  {
>>      AspeedSCUState *s =3D ASPEED_SCU(opaque);
>> @@ -167,6 +180,9 @@ static uint64_t aspeed_scu_read(void *opaque, hwaddr=
 offset, unsigned size)
>>      }
>>
>>      switch (reg) {
>
>        case RNG_CTRL:
>            /* The RNG_DATA returns a different number regardless of
>             * the state of the enabled bit in RNG_CTRL,
>             * so the model follows this behaviour.
>             */
>            break;
>
> With a comment:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks. I don't think it makes sense to do this for the read case, and
it was strange to find it in the write callback, so I instead added a
comment next to RNG_DATA.

Cheers,

Joel
