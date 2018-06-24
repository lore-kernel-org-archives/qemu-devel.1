Received: from eggs.gnu.org ([2001:4830:134:3::10]:39750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fXBlL-00034r-GL
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 16:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fXBlI-0002o7-A6
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 16:37:31 -0400
Date: Sun, 24 Jun 2018 22:37:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <51f8a2ca-0b35-dd1b-33a5-1fca51ef7a9c@kaod.org>
Message-ID: <alpine.BSF.2.21.1806242200550.67254@zero.eik.bme.hu>
References: <cover.1529839203.git.balaton@eik.bme.hu>
	<61b9cf7d09f0f12a86f036b828665c3fc91c3ce9.1529839203.git.balaton@eik.bme.hu>
	<51f8a2ca-0b35-dd1b-33a5-1fca51ef7a9c@kaod.org>
MIME-Version: 1.0
Content-ID: <alpine.BSF.2.21.1806242211190.67254@zero.eik.bme.hu>
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 1/4] ppc4xx_i2c: Rewrite to
 model hardware more closely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Hello,

On Sun, 24 Jun 2018, C=E9dric Le Goater wrote:
> On 06/24/2018 01:20 PM, BALATON Zoltan wrote:
>> Rewrite to make it closer to how real device works so that guest OS
>> drivers can access I2C devices. Previously this was only a hack to
>> allow U-Boot to get past accessing SPD EEPROMs but to support other
>> I2C devices and allow guests to access them we need to model real
>> device more properly.
>
> ppc4xx support was dropped from u-boot but there is some work being don=
e
> to re-add at least ppc-460x. These models should be of interest to emul=
ate
> BMC like boards and, in some near future, they could even run OpenBMC.
>
> I understand that you are adding extended status support, multi transfe=
r
> support, better interrupt support. Having some comments on the bit
> definitions and register names would help a lot.
>
> Is there a public datasheet for the I2C controller of the Sam460ex boar=
d ?
> and a simple boot image we could use to test ?

I don't have the manual of this SoC but some of the devices including thi=
s=20
i2c controller is similar to the 440EP for which there's a manual online.=
=20
That's the best reference I know of even if not always applicable for=20
460ex.

> Some comments below,
>
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/i2c/ppc4xx_i2c.c         | 222 +++++++++++++++++++++--------------=
---------
>>  include/hw/i2c/ppc4xx_i2c.h |   3 +-
>>  2 files changed, 110 insertions(+), 115 deletions(-)
>>
>> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
>> index fca80d6..3ebce17 100644
>> --- a/hw/i2c/ppc4xx_i2c.c
>> +++ b/hw/i2c/ppc4xx_i2c.c
>> @@ -38,13 +38,26 @@
>>  #define IIC_CNTL_READ       (1 << 1)
>>  #define IIC_CNTL_CHT        (1 << 2)
>>  #define IIC_CNTL_RPST       (1 << 3)
>> +#define IIC_CNTL_AMD        (1 << 6)
>> +#define IIC_CNTL_HMT        (1 << 7)
>> +
>> +#define IIC_MDCNTL_EINT     (1 << 2)
>> +#define IIC_MDCNTL_ESM      (1 << 3)
>> +#define IIC_MDCNTL_FMDB     (1 << 6)
>>
>>  #define IIC_STS_PT          (1 << 0)
>> +#define IIC_STS_IRQA        (1 << 1)
>>  #define IIC_STS_ERR         (1 << 2)
>> +#define IIC_STS_MDBF        (1 << 4)
>>  #define IIC_STS_MDBS        (1 << 5)
>>
>>  #define IIC_EXTSTS_XFRA     (1 << 0)
>>
>> +#define IIC_INTRMSK_EIMTC   (1 << 0)
>> +#define IIC_INTRMSK_EITA    (1 << 1)
>> +#define IIC_INTRMSK_EIIC    (1 << 2)
>> +#define IIC_INTRMSK_EIHE    (1 << 3)
>> +
>>  #define IIC_XTCNTLSS_SRST   (1 << 0)
>>
>>  #define IIC_DIRECTCNTL_SDAC (1 << 3)
>> @@ -56,21 +69,13 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>>  {
>>      PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
>>
>> -    /* FIXME: Should also reset bus?
>> -     *if (s->address !=3D ADDR_RESET) {
>> -     *    i2c_end_transfer(s->bus);
>> -     *}
>> -     */> -
>> -    i2c->mdata =3D 0;
>> -    i2c->lmadr =3D 0;
>> -    i2c->hmadr =3D 0;
>> +    i2c->mdidx =3D -1;
>> +    memset(i2c->mdata, 0, ARRAY_SIZE(i2c->mdata));
>> +    /* [hl][ms]addr are not affected by reset */
>>      i2c->cntl =3D 0;
>>      i2c->mdcntl =3D 0;
>>      i2c->sts =3D 0;
>> -    i2c->extsts =3D 0x8f;
>> -    i2c->lsadr =3D 0;
>> -    i2c->hsadr =3D 0;
>> +    i2c->extsts =3D (1 << 6);
>
> #define   EXTSTS_BCS_FREE  0x40 ?

I guess this could be defined but I did not bother as this is not fully=20
emulated. If you think it's worth to add it without the other states I ca=
n=20
do in next version.

>>      i2c->clkdiv =3D 0;
>>      i2c->intrmsk =3D 0;
>>      i2c->xfrcnt =3D 0;
>> @@ -78,69 +83,29 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>>      i2c->directcntl =3D 0xf;
>>  }
>>
>> -static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
>> -{
>> -    return true;
>> -}
>> -
>>  static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned =
int size)
>>  {
>>      PPC4xxI2CState *i2c =3D PPC4xx_I2C(opaque);
>>      uint64_t ret;
>> +    int i;
>>
>>      switch (addr) {
>>      case 0:
>> -        ret =3D i2c->mdata;
>> -        if (ppc4xx_i2c_is_master(i2c)) {
>> +        if (i2c->mdidx < 0) {
>>              ret =3D 0xff;
>> -
>> -            if (!(i2c->sts & IIC_STS_MDBS)) {
>> -                qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Trying to rea=
d "
>> -                              "without starting transfer\n",
>> -                              TYPE_PPC4xx_I2C, __func__);
>> -            } else {
>> -                int pending =3D (i2c->cntl >> 4) & 3;
>> -
>> -                /* get the next byte */
>> -                int byte =3D i2c_recv(i2c->bus);
>> -
>> -                if (byte < 0) {
>> -                    qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: read fail=
ed "
>> -                                  "for device 0x%02x\n", TYPE_PPC4xx_=
I2C,
>> -                                  __func__, i2c->lmadr);
>> -                    ret =3D 0xff;
>> -                } else {
>> -                    ret =3D byte;
>> -                    /* Raise interrupt if enabled */
>> -                    /*ppc4xx_i2c_raise_interrupt(i2c)*/;
>> -                }
>> -
>> -                if (!pending) {
>> -                    i2c->sts &=3D ~IIC_STS_MDBS;
>> -                    /*i2c_end_transfer(i2c->bus);*/
>> -                /*} else if (i2c->cntl & (IIC_CNTL_RPST | IIC_CNTL_CH=
T)) {*/
>> -                } else if (pending) {
>> -                    /* current smbus implementation doesn't like
>> -                       multibyte xfer repeated start */
>> -                    i2c_end_transfer(i2c->bus);
>> -                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1,=
 1)) {
>> -                        /* if non zero is returned, the adress is not=
 valid */
>> -                        i2c->sts &=3D ~IIC_STS_PT;
>> -                        i2c->sts |=3D IIC_STS_ERR;
>> -                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
>> -                    } else {
>> -                        /*i2c->sts |=3D IIC_STS_PT;*/
>> -                        i2c->sts |=3D IIC_STS_MDBS;
>> -                        i2c->sts &=3D ~IIC_STS_ERR;
>> -                        i2c->extsts =3D 0;
>> -                    }
>> -                }
>> -                pending--;
>> -                i2c->cntl =3D (i2c->cntl & 0xcf) | (pending << 4);
>> -            }
>> -        } else {
>> -            qemu_log_mask(LOG_UNIMP, "[%s]%s: slave mode not implemen=
ted\n",
>> -                          TYPE_PPC4xx_I2C, __func__);
>> +            break;
>> +        }
>> +        ret =3D i2c->mdata[0];
>> +        if (i2c->mdidx =3D=3D 3) {
>> +            i2c->sts &=3D ~IIC_STS_MDBF;
>> +        } else if (i2c->mdidx =3D=3D 0) {
>> +            i2c->sts &=3D ~IIC_STS_MDBS;
>> +        }
>> +        for (i =3D 0; i < i2c->mdidx; i++) {
>> +            i2c->mdata[i] =3D i2c->mdata[i + 1];
>> +        }
>> +        if (i2c->mdidx >=3D 0) {
>> +            i2c->mdidx--;
>>          }
>>          break;
>>      case 4:
>> @@ -160,6 +125,7 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwa=
ddr addr, unsigned int size)
>>          break;
>>      case 9:
>>          ret =3D i2c->extsts;
>> +        ret |=3D !!i2c_bus_busy(i2c->bus) << 4;
>
> Don't we have a bit definition for this ?

No, like I said above not all states in extsts are emulated, just the bit=
s=20
needed for the guests I've tested, because I don't know how real hardware=
=20
works. So extsts is mostly a placeholder if it ever needs to be emulated=20
more closely at which points appropriate defines could also be added.

>>          break;
>>      case 10:
>>          ret =3D i2c->lsadr;
>> @@ -203,70 +169,98 @@ static void ppc4xx_i2c_writeb(void *opaque, hwad=
dr addr, uint64_t value,
>>
>>      switch (addr) {
>>      case 0:
>> -        i2c->mdata =3D value;
>> -        if (!i2c_bus_busy(i2c->bus)) {
>> -            /* assume we start a write transfer */
>> -            if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 0)) {
>> -                /* if non zero is returned, the adress is not valid *=
/
>> -                i2c->sts &=3D ~IIC_STS_PT;
>> -                i2c->sts |=3D IIC_STS_ERR;
>> -                i2c->extsts |=3D IIC_EXTSTS_XFRA;
>> -            } else {
>> -                i2c->sts |=3D IIC_STS_PT;
>> -                i2c->sts &=3D ~IIC_STS_ERR;
>> -                i2c->extsts =3D 0;
>> -            }
>> +        if (i2c->mdidx >=3D 3) {
>
> can mdidx go above 3 ?

No, it shouldn't, the > is just to make sure no buffer overrun is=20
possible.

>> +            break;
>>          }
>> -        if (i2c_bus_busy(i2c->bus)) {
>> -            if (i2c_send(i2c->bus, i2c->mdata)) {
>> -                /* if the target return non zero then end the transfe=
r */
>> -                i2c->sts &=3D ~IIC_STS_PT;
>> -                i2c->sts |=3D IIC_STS_ERR;
>> -                i2c->extsts |=3D IIC_EXTSTS_XFRA;
>> -                i2c_end_transfer(i2c->bus);
>> -            }
>> +        i2c->mdata[++i2c->mdidx] =3D value;
>> +        if (i2c->mdidx =3D=3D 3) {
>> +            i2c->sts |=3D IIC_STS_MDBF;
>
> MDBF sounds like a 'M ... Data Buffer Full' status

Master Data Buffer Full

>> +        } else if (i2c->mdidx =3D=3D 0) {
>> +            i2c->sts |=3D IIC_STS_MDBS;
>
> what about MDBS ?

Master Data Buffer Status, shows if buffer has data or not.

>>          }
>>          break;
>>      case 4:
>>          i2c->lmadr =3D value;
>> -        if (i2c_bus_busy(i2c->bus)) {
>> -            i2c_end_transfer(i2c->bus);
>> -        }
>>          break;
>>      case 5:
>>          i2c->hmadr =3D value;
>>          break;
>>      case 6:
>> -        i2c->cntl =3D value;
>> -        if (i2c->cntl & IIC_CNTL_PT) {
>> -            if (i2c->cntl & IIC_CNTL_READ) {
>> -                if (i2c_bus_busy(i2c->bus)) {
>> -                    /* end previous transfer */
>> -                    i2c->sts &=3D ~IIC_STS_PT;
>> -                    i2c_end_transfer(i2c->bus);
>> +        i2c->cntl =3D value & 0xfe;
>> +        if (value & IIC_CNTL_AMD) {
>> +            qemu_log_mask(LOG_UNIMP, "%s: only 7 bit addresses suppor=
ted\n",
>> +                          __func__);
>> +        }
>> +        if (value & IIC_CNTL_HMT && i2c_bus_busy(i2c->bus)) {
>
> That's an abort ? correct ?

HMT: Halt Master Transfer, issue stop to halt master transfer.

>> +            i2c_end_transfer(i2c->bus);
>> +            if (i2c->mdcntl & IIC_MDCNTL_EINT &&
>> +                i2c->intrmsk & IIC_INTRMSK_EIHE) {
>> +                    i2c->sts |=3D IIC_STS_IRQA;
>> +                    qemu_irq_raise(i2c->irq);
>> +            }
>> +        } else if (value & IIC_CNTL_PT) {
>> +            int recv =3D (value & IIC_CNTL_READ) >> 1;
>> +            int tct =3D value >> 4 & 3;
>> +            int i;
>> +
>> +            if (recv && (i2c->lmadr >> 1) >=3D 0x50 && (i2c->lmadr >>=
 1) < 0x58) {
>> +                /* smbus emulation does not like multi byte reads w/o=
 restart */
>> +                value |=3D IIC_CNTL_RPST;
>> +            }
>> +
>> +            for (i =3D 0; i <=3D tct; i++) {
>
> ok. i is used for mdata, but the tct definition should not exceed 3

TCT: Transfer Count, mdata FIFO is 4 bytes so max index is 3, TCT has 2=20
bits so it should also not be higher than 3.

>> +                if (!i2c_bus_busy(i2c->bus)) {
>> +                    i2c->extsts =3D (1 << 6);
>
> please add a definition for this bit.

See above, this basically resets extsts to initial value which may not=20
match what real hardware does but enough for tested guests.

>> +                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1,=
 recv)) {
>> +                        i2c->sts |=3D IIC_STS_ERR;
>> +                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
>> +                        break;
>> +                    } else {
>> +                        i2c->sts &=3D ~IIC_STS_ERR;
>> +                    }
>> +                }
>
> do we need to start the transfer in the loop ? The device address
> does not change if I am correct. We would not need to test sts against
> IIC_STS_ERR.

I have no idea. This works with all guests I tested, that's U-Boot, AROS,=
=20
AmigaOS, Linux. Don't know if it matches what real hardware does though.=20
But there are some modes where repeated start is used so I think this=20
needs to be within the loop to allow that.

>> +                if (!(i2c->sts & IIC_STS_ERR) &&
>> +                    i2c_send_recv(i2c->bus, &i2c->mdata[i], !recv)) {
>> +                        i2c->sts |=3D IIC_STS_ERR;
>> +                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
>> +                        break;
>>                  }
>> -                if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1))=
 {
>> -                    /* if non zero is returned, the adress is not val=
id */
>> -                    i2c->sts &=3D ~IIC_STS_PT;
>> -                    i2c->sts |=3D IIC_STS_ERR;
>> -                    i2c->extsts |=3D IIC_EXTSTS_XFRA;
>> -                } else {
>> -                    /*i2c->sts |=3D IIC_STS_PT;*/
>> -                    i2c->sts |=3D IIC_STS_MDBS;
>> -                    i2c->sts &=3D ~IIC_STS_ERR;
>> -                    i2c->extsts =3D 0;
>> +                if (value & IIC_CNTL_RPST || !(value & IIC_CNTL_CHT))=
 {
>> +                    i2c_end_transfer(i2c->bus);
>>                  }
>> -            } else {
>> -                /* we actually already did the write transfer... */
>> -                i2c->sts &=3D ~IIC_STS_PT;
>> +            }
>
> That's the end of the loop I suppose ?
>
>> +            i2c->xfrcnt =3D i;
>
> what is that xfrcnt field/reg for ?

Transfer count, number of bytes transmitted.

>> +            i2c->mdidx =3D i - 1;
>> +            if (recv && i2c->mdidx >=3D 0) {
>> +                i2c->sts |=3D IIC_STS_MDBS;
>> +            }
>> +            if (recv && i2c->mdidx =3D=3D 3) {
>> +                i2c->sts |=3D IIC_STS_MDBF;
>> +            }
>> +            if (i && i2c->mdcntl & IIC_MDCNTL_EINT &&
>> +                i2c->intrmsk & IIC_INTRMSK_EIMTC) {
>> +                i2c->sts |=3D IIC_STS_IRQA;
>> +                qemu_irq_raise(i2c->irq);
>>              }
>>          }
>>          break;
>>      case 7:
>
> So that seems to be 'control' register of the  I2C controller.

Yes.

>> -        i2c->mdcntl =3D value & 0xdf;
>> +        i2c->mdcntl =3D value & 0x3d;
>
> Could we use a mask built from the bits instead of raw hex value ?

Probably, I don't remember the details any more.

>> +        if (value & IIC_MDCNTL_ESM) {
>> +            qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\=
n",
>> +                          __func__);
>> +        }
>> +        if (value & IIC_MDCNTL_FMDB) {
>
> that's a flush ?

FMDB: Flush Master Data Buffer

All these names are in the documentation, you should consult that instead=
=20
of using this emulation as documentation which it's not just approximate=20
emulation of hardware to satisfy guests.

Do we need a new version with more constants added or is this acceptable=20
now?

Thanks you,
BALATON Zoltan

>> +            i2c->mdidx =3D -1;
>> +            memset(i2c->mdata, 0, ARRAY_SIZE(i2c->mdata));
>> +            i2c->sts &=3D ~(IIC_STS_MDBF | IIC_STS_MDBS);
>> +        }
>>          break;
>>      case 8:
>> -        i2c->sts &=3D ~(value & 0xa);
>> +        i2c->sts &=3D ~(value & 0x0a);
>
> ditto for the mask.
>
> Thanks,
>
> C.
>
>> +        if (value & IIC_STS_IRQA && i2c->mdcntl & IIC_MDCNTL_EINT) {
>> +            qemu_irq_lower(i2c->irq);
>> +        }
>>          break;
>>      case 9:
>>          i2c->extsts &=3D ~(value & 0x8f);
>> @@ -287,12 +281,12 @@ static void ppc4xx_i2c_writeb(void *opaque, hwad=
dr addr, uint64_t value,
>>          i2c->xfrcnt =3D value & 0x77;
>>          break;
>>      case 15:
>> +        i2c->xtcntlss &=3D ~(value & 0xf0);
>>          if (value & IIC_XTCNTLSS_SRST) {
>>              /* Is it actually a full reset? U-Boot sets some regs bef=
ore */
>>              ppc4xx_i2c_reset(DEVICE(i2c));
>>              break;
>>          }
>> -        i2c->xtcntlss =3D value;
>>          break;
>>      case 16:
>>          i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECT=
CNTL_SCLC);
>> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
>> index ea6c8e1..0891a9c 100644
>> --- a/include/hw/i2c/ppc4xx_i2c.h
>> +++ b/include/hw/i2c/ppc4xx_i2c.h
>> @@ -46,7 +46,8 @@ typedef struct PPC4xxI2CState {
>>      qemu_irq irq;
>>      MemoryRegion iomem;
>>      bitbang_i2c_interface *bitbang;
>> -    uint8_t mdata;
>> +    int mdidx;
>> +    uint8_t mdata[4];
>>      uint8_t lmadr;
>>      uint8_t hmadr;
>>      uint8_t cntl;
>>
>
>
>
