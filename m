Received: from eggs.gnu.org ([2001:4830:134:3::10]:55799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fRDQI-0002Df-9L
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fRDQD-0002ZH-Vn
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:11:06 -0400
Date: Fri, 8 Jun 2018 11:11:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180608085054.GS3344@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806081107200.22949@zero.eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<53f9d0b04374a3f4449af65ce01bd68dbe757ab5.1528291908.git.balaton@eik.bme.hu>
	<428ea537-a8d7-1c7c-7052-ea959797022d@amsat.org>
	<20180608085054.GS3344@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/8] ppc4xx_i2c: Clean up and improve
 error logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

On Fri, 8 Jun 2018, David Gibson wrote:
> On Wed, Jun 06, 2018 at 12:56:32PM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
>> On 06/06/2018 10:31 AM, BALATON Zoltan wrote:
>>> Make it more readable by converting register indexes to decimal
>>> (avoids lot of superfluous 0x0) and distinguish errors caused by
>>> accessing non-existent vs. unimplemented registers.
>>> No functional change.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>  hw/i2c/ppc4xx_i2c.c | 94 +++++++++++++++++++++++++++++--------------=
----------
>>>  1 file changed, 51 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
>>> index ab64d19..d1936db 100644
>>> --- a/hw/i2c/ppc4xx_i2c.c
>>> +++ b/hw/i2c/ppc4xx_i2c.c
>>> @@ -31,7 +31,7 @@
>>>  #include "hw/hw.h"
>>>  #include "hw/i2c/ppc4xx_i2c.h"
>>>
>>> -#define PPC4xx_I2C_MEM_SIZE 0x12
>>> +#define PPC4xx_I2C_MEM_SIZE 18
>>
>> This looks weird, it seems all memory range sizes are in hex in other
>> QEMU devices.
>
> [snip]
>>> @@ -263,32 +267,31 @@ static void ppc4xx_i2c_writeb(void *opaque, hwa=
ddr addr, uint64_t value,
>>>              }
>>>          }
>>>          break;
>>> -    case 0x07:
>>> -        i2c->mdcntl =3D value & 0xDF;
>>> +    case 7:
>>> +        i2c->mdcntl =3D value & 0xdf;
>>>          break;
>>> -    case 0x08:
>>> -        i2c->sts &=3D ~(value & 0x0A);
>>> +    case 8:
>>> +        i2c->sts &=3D ~(value & 0xa);
>>
>> 'value & 0x0a' implicitly denotes than 'value' is a 8-bit register.
>> Matter of taste...
>
> I tend to prefer the forms you suggest, Philippe, but not by enough to
> delay this otherwise good cleanup.  Especially since Balaton is taking
> on this long neglected area of the code.

I prefer code that does not have unneeded chars so it's easier to read,=20
that's why I've removed all 0x0 from this file which made it more=20
comprehensible. But I'll add the 0 back to this place in next respin as=20
you both seem to prefer that and since other bit masks are two digit too=20
it's also consistent that way.
