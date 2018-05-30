Received: from eggs.gnu.org ([2001:4830:134:3::10]:43163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fNsd5-0005PW-UT
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fNsd4-0000hv-RS
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:22:31 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <CAFEAcA8H66jcoi2FXWPRpyoQ4OT955awzLEj+gMKTMctoYxqEQ@mail.gmail.com>
References: <20180529041946.9481-1-joel@jms.id.au>
	<CAFEAcA8H66jcoi2FXWPRpyoQ4OT955awzLEj+gMKTMctoYxqEQ@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 May 2018 13:52:08 +0930
Message-ID: <CACPK8Xcf8m+MfJjJWeqs5t1UkgfBaGr5T47N_0bmNqtR99VgkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3] aspeed_scu: Implement RNG
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On 30 May 2018 at 00:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 29 May 2018 at 05:19, Joel Stanley <joel@jms.id.au> wrote:
>> The ASPEED SoCs contain a single register that returns random data when
>> read. This models that register so that guests can use it.
>>
>> The random number data register has a corresponding control register,
>> however it returns data regardless of the state of the enabled bit, so
>> the model follows this behaviour.
>>
>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>> v2:
>>  - Remove call to qcrypto_random_init as this is done in main()
>> v3:
>>  - Add C=C3=A9dric's reviewed-by
>>  - Add a comment about why we don't check for the rng enable bit
>> ---
>>  hw/misc/aspeed_scu.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
>> index 5e6d5744eeca..96db052389cc 100644
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
> This will return an uninitialized value if qcrypto_random_bytes()
> fails.

Good catch.

> Does the guest use this value for cryptographic purposes?

The guest runs Linux, and Linux has a driver to expose this as a
hardware random number device.

As I said in the v2 thread, the aspeed model is for smoketesting of
firmware builds. I can't imagine a situation where it would make sense
to run a production BMC workload on qemu.

> In hw/misc/bcm2835_rng.c we opted to make qcrypto_random_bytes()
> failing be fatal (for reasons noted in the comment there),
> though that is a bit rough. exynos4210_rng() is more conveniently
> able to just never report to the guest that the PRNG is ready.

The hardware doesn't have the facility to indicate this to the guest.
If we want to be strict about handling the case where qcrypto has
failed, I will implement the same error handling as bcm2835_rng.
