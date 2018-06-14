Received: from eggs.gnu.org ([2001:4830:134:3::10]:36589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTNSq-0001m2-0n
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTNSl-0004rm-0i
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:18:39 -0400
Date: Thu, 14 Jun 2018 10:18:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180614011449.GR30690@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806141007300.19899@zero.eik.bme.hu>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<16139dc707e8de2b79bcdb2b0fcb4749216f2e86.1528935420.git.balaton@eik.bme.hu>
	<20180614011449.GR30690@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/9] ppc4xx_i2c: Remove unimplemented
 sdata and intr registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

On Thu, 14 Jun 2018, David Gibson wrote:
> On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> But.. they are implemented.  Albeit as an entirely software controlled
> register.

They were implemented only in that they could be written and read but did=
=20
not implement any of the functionality they have in real hardware so in=20
that sense they were not really implemented.

> I'm guessing that's not what they're supposed to do, which is why
> you're removing them, but that needs to be explained in the commit
> message.

Maybe adding this explanation:

We dont emulate slave mode so related registers are not needed. [lh]sadr=20
are only retained to avoid too many warnings and simplify debugging but=20
sdata is not even correct because device has a 4 byte FIFO instead so=20
just remove this unimplemented register for now.

The intr register is also not implemented correctly, it is for diagnostic=
s=20
and normally not even visible on device without explicitly enabling it. A=
s=20
no guests are known to need this remove it as well.

Regards,
BALATON Zoltan

> As a general rule cases where a one line commit message is acceptable
> are *very* rare.
>
>> ---
>>  hw/i2c/ppc4xx_i2c.c         | 16 +---------------
>>  include/hw/i2c/ppc4xx_i2c.h |  4 +---
>>  2 files changed, 2 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
>> index d1936db..4e0aaae 100644
>> --- a/hw/i2c/ppc4xx_i2c.c
>> +++ b/hw/i2c/ppc4xx_i2c.c
>> @@ -3,7 +3,7 @@
>>   *
>>   * Copyright (c) 2007 Jocelyn Mayer
>>   * Copyright (c) 2012 Fran=E7ois Revol
>> - * Copyright (c) 2016 BALATON Zoltan
>> + * Copyright (c) 2016-2018 BALATON Zoltan
>>   *
>>   * Permission is hereby granted, free of charge, to any person obtain=
ing a copy
>>   * of this software and associated documentation files (the "Software=
"), to deal
>> @@ -63,7 +63,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>>      i2c->mdcntl =3D 0;
>>      i2c->sts =3D 0;
>>      i2c->extsts =3D 0x8f;
>> -    i2c->sdata =3D 0;
>>      i2c->lsadr =3D 0;
>>      i2c->hsadr =3D 0;
>>      i2c->clkdiv =3D 0;
>> @@ -71,7 +70,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>>      i2c->xfrcnt =3D 0;
>>      i2c->xtcntlss =3D 0;
>>      i2c->directcntl =3D 0xf;
>> -    i2c->intr =3D 0;
>>  }
>>
>>  static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
>> @@ -139,9 +137,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwa=
ddr addr, unsigned int size)
>>                            TYPE_PPC4xx_I2C, __func__);
>>          }
>>          break;
>> -    case 2:
>> -        ret =3D i2c->sdata;
>> -        break;
>>      case 4:
>>          ret =3D i2c->lmadr;
>>          break;
>> @@ -181,9 +176,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwa=
ddr addr, unsigned int size)
>>      case 16:
>>          ret =3D i2c->directcntl;
>>          break;
>> -    case 17:
>> -        ret =3D i2c->intr;
>> -        break;
>>      default:
>>          if (addr < PPC4xx_I2C_MEM_SIZE) {
>>              qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
>> @@ -229,9 +221,6 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr=
 addr, uint64_t value,
>>              }
>>          }
>>          break;
>> -    case 2:
>> -        i2c->sdata =3D value;
>> -        break;
>>      case 4:
>>          i2c->lmadr =3D value;
>>          if (i2c_bus_busy(i2c->bus)) {
>> @@ -302,9 +291,6 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr=
 addr, uint64_t value,
>>      case 16:
>>          i2c->directcntl =3D value & 0x7;
>>          break;
>> -    case 17:
>> -        i2c->intr =3D value;
>> -        break;
>>      default:
>>          if (addr < PPC4xx_I2C_MEM_SIZE) {
>>              qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
>> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
>> index 3c60307..e4b6ded 100644
>> --- a/include/hw/i2c/ppc4xx_i2c.h
>> +++ b/include/hw/i2c/ppc4xx_i2c.h
>> @@ -3,7 +3,7 @@
>>   *
>>   * Copyright (c) 2007 Jocelyn Mayer
>>   * Copyright (c) 2012 Fran=E7ois Revol
>> - * Copyright (c) 2016 BALATON Zoltan
>> + * Copyright (c) 2016-2018 BALATON Zoltan
>>   *
>>   * Permission is hereby granted, free of charge, to any person obtain=
ing a copy
>>   * of this software and associated documentation files (the "Software=
"), to deal
>> @@ -49,7 +49,6 @@ typedef struct PPC4xxI2CState {
>>      uint8_t mdcntl;
>>      uint8_t sts;
>>      uint8_t extsts;
>> -    uint8_t sdata;
>>      uint8_t lsadr;
>>      uint8_t hsadr;
>>      uint8_t clkdiv;
>> @@ -57,7 +56,6 @@ typedef struct PPC4xxI2CState {
>>      uint8_t xfrcnt;
>>      uint8_t xtcntlss;
>>      uint8_t directcntl;
>> -    uint8_t intr;
>>  } PPC4xxI2CState;
>>
>>  #endif /* PPC4XX_I2C_H */
>
>
