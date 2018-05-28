Received: from eggs.gnu.org ([2001:4830:134:3::10]:41422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fNIke-0003uj-Lk
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fNIkd-0004jg-I1
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:03:56 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <9959794d-6d3b-b797-bfc8-b548d54378ad@kaod.org>
References: <20180528124621.22977-1-joel@jms.id.au>
	<9959794d-6d3b-b797-bfc8-b548d54378ad@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 28 May 2018 23:33:34 +0930
Message-ID: <CACPK8Xe5+-zVfoS-g2Te7YOuT5emT-i=JsNDrF52WLVzLERQcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] aspeed_scu: Implement RNG register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>

On 28 May 2018 at 23:17, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello Joel,
>
> On 05/28/2018 02:46 PM, Joel Stanley wrote:
>> The ASPEED SoCs contain a single register that returns random data when
>> read. This models that register so that guests can use it.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  hw/misc/aspeed_scu.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
>> index 5e6d5744eeca..8fa0cecf0fa1 100644
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
>> +    case RNG_DATA:
>> +        return aspeed_scu_get_random();
>
> may be we could test bit 1 of RNG_CTRL to check if it is enabled or not.

The RNG is enabled by default, and I didn't find any software that
disables it, but it can't hurt to have that check.

I'll send a v2 with that check.

>
>> +        break;
>>      case WAKEUP_EN:
>>          qemu_log_mask(LOG_GUEST_ERROR,
>>                        "%s: Read of write-only offset 0x%" HWADDR_PRIx "=
\n",
>> @@ -287,6 +303,9 @@ static void aspeed_scu_realize(DeviceState *dev, Err=
or **errp)
>>                            TYPE_ASPEED_SCU, SCU_IO_REGION_SIZE);
>>
>>      sysbus_init_mmio(sbd, &s->iomem);
>> +
>> +    if (qcrypto_random_init(errp))
>> +        return;
>>  }
>
> Isn't this routine called from main() already ?

It is indirectly called, yes. I'll remove this.

Cheers,

Joel
