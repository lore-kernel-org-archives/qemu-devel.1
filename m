Received: from eggs.gnu.org ([2001:4830:134:3::10]:57266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXNmu-0004Y9-Pc
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXNmr-0006MI-Fz
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:27:56 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:53888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fXNmr-0006LU-4M
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:27:53 -0400
Received: from player760.ha.ovh.net (unknown [10.109.105.47])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 7D7B1197F2
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 11:27:51 +0200 (CEST)
References: <cover.1529839203.git.balaton@eik.bme.hu>
	<61b9cf7d09f0f12a86f036b828665c3fc91c3ce9.1529839203.git.balaton@eik.bme.hu>
	<51f8a2ca-0b35-dd1b-33a5-1fca51ef7a9c@kaod.org>
	<alpine.BSF.2.21.1806242200550.67254@zero.eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e407d067-bf23-4281-fc56-496cdbda35c4@kaod.org>
Date: Mon, 25 Jun 2018 11:27:41 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806242200550.67254@zero.eik.bme.hu>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
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
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06/24/2018 10:37 PM, BALATON Zoltan wrote:
> Hello,
>=20
> On Sun, 24 Jun 2018, C=E9dric Le Goater wrote:
>> On 06/24/2018 01:20 PM, BALATON Zoltan wrote:
>>> Rewrite to make it closer to how real device works so that guest OS
>>> drivers can access I2C devices. Previously this was only a hack to
>>> allow U-Boot to get past accessing SPD EEPROMs but to support other
>>> I2C devices and allow guests to access them we need to model real
>>> device more properly.
>>
>> ppc4xx support was dropped from u-boot but there is some work being do=
ne
>> to re-add at least ppc-460x. These models should be of interest to emu=
late
>> BMC like boards and, in some near future, they could even run OpenBMC.
>>
>> I understand that you are adding extended status support, multi transf=
er
>> support, better interrupt support. Having some comments on the bit
>> definitions and register names would help a lot.
>>
>> Is there a public datasheet for the I2C controller of the Sam460ex boa=
rd ?
>> and a simple boot image we could use to test ?
>=20
> I don't have the manual of this SoC but some of the devices including t=
his i2c controller is similar to the 440EP for which there's a manual onl=
ine. That's the best reference I know of even if not always applicable fo=
r 460ex.

I could not find one. Can you provide an URL ? I would to take a look=20
at the register and bit definitions of the I2C controller of the SoC.

Thanks,

C.=20
=20
>=20
>> Some comments below,
>>
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> =A0hw/i2c/ppc4xx_i2c.c=A0=A0=A0=A0=A0=A0=A0=A0 | 222 ++++++++++++++++=
+++++-----------------------
>>> =A0include/hw/i2c/ppc4xx_i2c.h |=A0=A0 3 +-
>>> =A02 files changed, 110 insertions(+), 115 deletions(-)
>>>
>>> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
>>> index fca80d6..3ebce17 100644
>>> --- a/hw/i2c/ppc4xx_i2c.c
>>> +++ b/hw/i2c/ppc4xx_i2c.c
>>> @@ -38,13 +38,26 @@
>>> =A0#define IIC_CNTL_READ=A0=A0=A0=A0=A0=A0 (1 << 1)
>>> =A0#define IIC_CNTL_CHT=A0=A0=A0=A0=A0=A0=A0 (1 << 2)
>>> =A0#define IIC_CNTL_RPST=A0=A0=A0=A0=A0=A0 (1 << 3)
>>> +#define IIC_CNTL_AMD=A0=A0=A0=A0=A0=A0=A0 (1 << 6)
>>> +#define IIC_CNTL_HMT=A0=A0=A0=A0=A0=A0=A0 (1 << 7)
>>> +
>>> +#define IIC_MDCNTL_EINT=A0=A0=A0=A0 (1 << 2)
>>> +#define IIC_MDCNTL_ESM=A0=A0=A0=A0=A0 (1 << 3)
>>> +#define IIC_MDCNTL_FMDB=A0=A0=A0=A0 (1 << 6)
>>>
>>> =A0#define IIC_STS_PT=A0=A0=A0=A0=A0=A0=A0=A0=A0 (1 << 0)
>>> +#define IIC_STS_IRQA=A0=A0=A0=A0=A0=A0=A0 (1 << 1)
>>> =A0#define IIC_STS_ERR=A0=A0=A0=A0=A0=A0=A0=A0 (1 << 2)
>>> +#define IIC_STS_MDBF=A0=A0=A0=A0=A0=A0=A0 (1 << 4)
>>> =A0#define IIC_STS_MDBS=A0=A0=A0=A0=A0=A0=A0 (1 << 5)
>>>
>>> =A0#define IIC_EXTSTS_XFRA=A0=A0=A0=A0 (1 << 0)
>>>
>>> +#define IIC_INTRMSK_EIMTC=A0=A0 (1 << 0)
>>> +#define IIC_INTRMSK_EITA=A0=A0=A0 (1 << 1)
>>> +#define IIC_INTRMSK_EIIC=A0=A0=A0 (1 << 2)
>>> +#define IIC_INTRMSK_EIHE=A0=A0=A0 (1 << 3)
>>> +
>>> =A0#define IIC_XTCNTLSS_SRST=A0=A0 (1 << 0)
>>>
>>> =A0#define IIC_DIRECTCNTL_SDAC (1 << 3)
>>> @@ -56,21 +69,13 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>>> =A0{
>>> =A0=A0=A0=A0 PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
>>>
>>> -=A0=A0=A0 /* FIXME: Should also reset bus?
>>> -=A0=A0=A0=A0 *if (s->address !=3D ADDR_RESET) {
>>> -=A0=A0=A0=A0 *=A0=A0=A0 i2c_end_transfer(s->bus);
>>> -=A0=A0=A0=A0 *}
>>> -=A0=A0=A0=A0 */> -
>>> -=A0=A0=A0 i2c->mdata =3D 0;
>>> -=A0=A0=A0 i2c->lmadr =3D 0;
>>> -=A0=A0=A0 i2c->hmadr =3D 0;
>>> +=A0=A0=A0 i2c->mdidx =3D -1;
>>> +=A0=A0=A0 memset(i2c->mdata, 0, ARRAY_SIZE(i2c->mdata));
>>> +=A0=A0=A0 /* [hl][ms]addr are not affected by reset */
>>> =A0=A0=A0=A0 i2c->cntl =3D 0;
>>> =A0=A0=A0=A0 i2c->mdcntl =3D 0;
>>> =A0=A0=A0=A0 i2c->sts =3D 0;
>>> -=A0=A0=A0 i2c->extsts =3D 0x8f;
>>> -=A0=A0=A0 i2c->lsadr =3D 0;
>>> -=A0=A0=A0 i2c->hsadr =3D 0;
>>> +=A0=A0=A0 i2c->extsts =3D (1 << 6);
>>
>> #define=A0=A0 EXTSTS_BCS_FREE=A0 0x40 ?
>=20
> I guess this could be defined but I did not bother as this is not fully=
 emulated. If you think it's worth to add it without the other states I c=
an do in next version.
>=20
>>> =A0=A0=A0=A0 i2c->clkdiv =3D 0;
>>> =A0=A0=A0=A0 i2c->intrmsk =3D 0;
>>> =A0=A0=A0=A0 i2c->xfrcnt =3D 0;
>>> @@ -78,69 +83,29 @@ static void ppc4xx_i2c_reset(DeviceState *s)
>>> =A0=A0=A0=A0 i2c->directcntl =3D 0xf;
>>> =A0}
>>>
>>> -static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
>>> -{
>>> -=A0=A0=A0 return true;
>>> -}
>>> -
>>> =A0static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsign=
ed int size)
>>> =A0{
>>> =A0=A0=A0=A0 PPC4xxI2CState *i2c =3D PPC4xx_I2C(opaque);
>>> =A0=A0=A0=A0 uint64_t ret;
>>> +=A0=A0=A0 int i;
>>>
>>> =A0=A0=A0=A0 switch (addr) {
>>> =A0=A0=A0=A0 case 0:
>>> -=A0=A0=A0=A0=A0=A0=A0 ret =3D i2c->mdata;
>>> -=A0=A0=A0=A0=A0=A0=A0 if (ppc4xx_i2c_is_master(i2c)) {
>>> +=A0=A0=A0=A0=A0=A0=A0 if (i2c->mdidx < 0) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D 0xff;
>>> -
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!(i2c->sts & IIC_STS_MDBS)) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_log_mask(LOG_GUES=
T_ERROR, "[%s]%s: Trying to read "
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 "without starting transfer\n",
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 TYPE_PPC4xx_I2C, __func__);
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int pending =3D (i2c->=
cntl >> 4) & 3;
>>> -
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* get the next byte *=
/
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int byte =3D i2c_recv(=
i2c->bus);
>>> -
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (byte < 0) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_log_m=
ask(LOG_GUEST_ERROR, "[%s]%s: read failed "
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "for device 0x%02x\n", TYPE_PPC4xx_I2C,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __func__, i2c->lmadr);
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D 0x=
ff;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D by=
te;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Raise i=
nterrupt if enabled */
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*ppc4xx_i=
2c_raise_interrupt(i2c)*/;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> -
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!pending) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=
=3D ~IIC_STS_MDBS;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*i2c_end_=
transfer(i2c->bus);*/
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*} else if (i2c->cntl=
 & (IIC_CNTL_RPST | IIC_CNTL_CHT)) {*/
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (pending) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* current=
 smbus implementation doesn't like
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 m=
ultibyte xfer repeated start */
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c_end_tr=
ansfer(i2c->bus);
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i2c_st=
art_transfer(i2c->bus, i2c->lmadr >> 1, 1)) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 /* if non zero is returned, the adress is not valid */
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 i2c->sts &=3D ~IIC_STS_PT;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 i2c->sts |=3D IIC_STS_ERR;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 i2c->extsts |=3D IIC_EXTSTS_XFRA;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 /*i2c->sts |=3D IIC_STS_PT;*/
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 i2c->sts |=3D IIC_STS_MDBS;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 i2c->sts &=3D ~IIC_STS_ERR;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 i2c->extsts =3D 0;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pending--;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->cntl =3D (i2c->cn=
tl & 0xcf) | (pending << 4);
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> -=A0=A0=A0=A0=A0=A0=A0 } else {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_log_mask(LOG_UNIMP, "[%s]%s: =
slave mode not implemented\n",
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 TYPE_PPC4xx_I2C, __func__);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D i2c->mdata[0];
>>> +=A0=A0=A0=A0=A0=A0=A0 if (i2c->mdidx =3D=3D 3) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=3D ~IIC_STS_MDBF;
>>> +=A0=A0=A0=A0=A0=A0=A0 } else if (i2c->mdidx =3D=3D 0) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=3D ~IIC_STS_MDBS;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < i2c->mdidx; i++) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->mdata[i] =3D i2c->mdata[i + 1=
];
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0 if (i2c->mdidx >=3D 0) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->mdidx--;
>>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0 case 4:
>>> @@ -160,6 +125,7 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hw=
addr addr, unsigned int size)
>>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0 case 9:
>>> =A0=A0=A0=A0=A0=A0=A0=A0 ret =3D i2c->extsts;
>>> +=A0=A0=A0=A0=A0=A0=A0 ret |=3D !!i2c_bus_busy(i2c->bus) << 4;
>>
>> Don't we have a bit definition for this ?
>=20
> No, like I said above not all states in extsts are emulated, just the b=
its needed for the guests I've tested, because I don't know how real hard=
ware works. So extsts is mostly a placeholder if it ever needs to be emul=
ated more closely at which points appropriate defines could also be added=
.
>=20
>>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0 case 10:
>>> =A0=A0=A0=A0=A0=A0=A0=A0 ret =3D i2c->lsadr;
>>> @@ -203,70 +169,98 @@ static void ppc4xx_i2c_writeb(void *opaque, hwa=
ddr addr, uint64_t value,
>>>
>>> =A0=A0=A0=A0 switch (addr) {
>>> =A0=A0=A0=A0 case 0:
>>> -=A0=A0=A0=A0=A0=A0=A0 i2c->mdata =3D value;
>>> -=A0=A0=A0=A0=A0=A0=A0 if (!i2c_bus_busy(i2c->bus)) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* assume we start a write transfe=
r */
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i2c_start_transfer(i2c->bus, i=
2c->lmadr >> 1, 0)) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* if non zero is retu=
rned, the adress is not valid */
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=3D ~IIC_STS=
_PT;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts |=3D IIC_STS_=
ERR;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->extsts |=3D IIC_E=
XTSTS_XFRA;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts |=3D IIC_STS_=
PT;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=3D ~IIC_STS=
_ERR;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->extsts =3D 0;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0 if (i2c->mdidx >=3D 3) {
>>
>> can mdidx go above 3 ?
>=20
> No, it shouldn't, the > is just to make sure no buffer overrun is possi=
ble.
>=20
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>>> -=A0=A0=A0=A0=A0=A0=A0 if (i2c_bus_busy(i2c->bus)) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i2c_send(i2c->bus, i2c->mdata)=
) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* if the target retur=
n non zero then end the transfer */
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=3D ~IIC_STS=
_PT;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts |=3D IIC_STS_=
ERR;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->extsts |=3D IIC_E=
XTSTS_XFRA;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c_end_transfer(i2c->=
bus);
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0 i2c->mdata[++i2c->mdidx] =3D value;
>>> +=A0=A0=A0=A0=A0=A0=A0 if (i2c->mdidx =3D=3D 3) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts |=3D IIC_STS_MDBF;
>>
>> MDBF sounds like a 'M ... Data Buffer Full' status
>=20
> Master Data Buffer Full
>=20
>>> +=A0=A0=A0=A0=A0=A0=A0 } else if (i2c->mdidx =3D=3D 0) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts |=3D IIC_STS_MDBS;
>>
>> what about MDBS ?
>=20
> Master Data Buffer Status, shows if buffer has data or not.
>=20
>>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0 case 4:
>>> =A0=A0=A0=A0=A0=A0=A0=A0 i2c->lmadr =3D value;
>>> -=A0=A0=A0=A0=A0=A0=A0 if (i2c_bus_busy(i2c->bus)) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c_end_transfer(i2c->bus);
>>> -=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0 case 5:
>>> =A0=A0=A0=A0=A0=A0=A0=A0 i2c->hmadr =3D value;
>>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0 case 6:
>>> -=A0=A0=A0=A0=A0=A0=A0 i2c->cntl =3D value;
>>> -=A0=A0=A0=A0=A0=A0=A0 if (i2c->cntl & IIC_CNTL_PT) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i2c->cntl & IIC_CNTL_READ) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i2c_bus_busy(i2c->=
bus)) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* end pre=
vious transfer */
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=
=3D ~IIC_STS_PT;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c_end_tr=
ansfer(i2c->bus);
>>> +=A0=A0=A0=A0=A0=A0=A0 i2c->cntl =3D value & 0xfe;
>>> +=A0=A0=A0=A0=A0=A0=A0 if (value & IIC_CNTL_AMD) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_log_mask(LOG_UNIMP, "%s: only=
 7 bit addresses supported\n",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 __func__);
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0 if (value & IIC_CNTL_HMT && i2c_bus_busy(i2c->=
bus)) {
>>
>> That's an abort ? correct ?
>=20
> HMT: Halt Master Transfer, issue stop to halt master transfer.
>=20
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c_end_transfer(i2c->bus);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i2c->mdcntl & IIC_MDCNTL_EINT =
&&
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->intrmsk & IIC_INT=
RMSK_EIHE) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts |=
=3D IIC_STS_IRQA;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_irq_r=
aise(i2c->irq);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0 } else if (value & IIC_CNTL_PT) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int recv =3D (value & IIC_CNTL_REA=
D) >> 1;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int tct =3D value >> 4 & 3;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int i;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (recv && (i2c->lmadr >> 1) >=3D=
 0x50 && (i2c->lmadr >> 1) < 0x58) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* smbus emulation doe=
s not like multi byte reads w/o restart */
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 value |=3D IIC_CNTL_RP=
ST;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i <=3D tct; i++) {
>>
>> ok. i is used for mdata, but the tct definition should not exceed 3
>=20
> TCT: Transfer Count, mdata FIFO is 4 bytes so max index is 3, TCT has 2=
 bits so it should also not be higher than 3.
>=20
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!i2c_bus_busy(i2c-=
>bus)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->extst=
s =3D (1 << 6);
>>
>> please add a definition for this bit.
>=20
> See above, this basically resets extsts to initial value which may not =
match what real hardware does but enough for tested guests.
>=20
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i2c_st=
art_transfer(i2c->bus, i2c->lmadr >> 1, recv)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 i2c->sts |=3D IIC_STS_ERR;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 i2c->extsts |=3D IIC_EXTSTS_XFRA;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 break;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 i2c->sts &=3D ~IIC_STS_ERR;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>
>> do we need to start the transfer in the loop ? The device address
>> does not change if I am correct. We would not need to test sts against
>> IIC_STS_ERR.
>=20
> I have no idea. This works with all guests I tested, that's U-Boot, ARO=
S, AmigaOS, Linux. Don't know if it matches what real hardware does thoug=
h. But there are some modes where repeated start is used so I think this =
needs to be within the loop to allow that.
>=20
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!(i2c->sts & IIC_S=
TS_ERR) &&
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c_send_r=
ecv(i2c->bus, &i2c->mdata[i], !recv)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 i2c->sts |=3D IIC_STS_ERR;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 i2c->extsts |=3D IIC_EXTSTS_XFRA;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 break;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i2c_start_transfer=
(i2c->bus, i2c->lmadr >> 1, 1)) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* if non =
zero is returned, the adress is not valid */
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=
=3D ~IIC_STS_PT;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts |=
=3D IIC_STS_ERR;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->extst=
s |=3D IIC_EXTSTS_XFRA;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*i2c->sts=
 |=3D IIC_STS_PT;*/
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts |=
=3D IIC_STS_MDBS;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=
=3D ~IIC_STS_ERR;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->extst=
s =3D 0;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (value & IIC_CNTL_R=
PST || !(value & IIC_CNTL_CHT)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c_end_tr=
ansfer(i2c->bus);
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* we actually already=
 did the write transfer... */
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=3D ~IIC_STS=
_PT;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>
>> That's the end of the loop I suppose ?
>>
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->xfrcnt =3D i;
>>
>> what is that xfrcnt field/reg for ?
>=20
> Transfer count, number of bytes transmitted.
>=20
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->mdidx =3D i - 1;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (recv && i2c->mdidx >=3D 0) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts |=3D IIC_STS_=
MDBS;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (recv && i2c->mdidx =3D=3D 3) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts |=3D IIC_STS_=
MDBF;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i && i2c->mdcntl & IIC_MDCNTL_=
EINT &&
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->intrmsk & IIC_INT=
RMSK_EIMTC) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts |=3D IIC_STS_=
IRQA;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_irq_raise(i2c->ir=
q);
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0 case 7:
>>
>> So that seems to be 'control' register of the=A0 I2C controller.
>=20
> Yes.
>=20
>>> -=A0=A0=A0=A0=A0=A0=A0 i2c->mdcntl =3D value & 0xdf;
>>> +=A0=A0=A0=A0=A0=A0=A0 i2c->mdcntl =3D value & 0x3d;
>>
>> Could we use a mask built from the bits instead of raw hex value ?
>=20
> Probably, I don't remember the details any more.
>=20
>>> +=A0=A0=A0=A0=A0=A0=A0 if (value & IIC_MDCNTL_ESM) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_log_mask(LOG_UNIMP, "%s: slav=
e mode not implemented\n",
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 __func__);
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0 if (value & IIC_MDCNTL_FMDB) {
>>
>> that's a flush ?
>=20
> FMDB: Flush Master Data Buffer
>=20
> All these names are in the documentation, you should consult that inste=
ad of using this emulation as documentation which it's not just approxima=
te emulation of hardware to satisfy guests.
>=20
> Do we need a new version with more constants added or is this acceptabl=
e now?
>=20
> Thanks you,
> BALATON Zoltan
>=20
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->mdidx =3D -1;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memset(i2c->mdata, 0, ARRAY_SIZE(i=
2c->mdata));
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=3D ~(IIC_STS_MDBF | IIC=
_STS_MDBS);
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0 case 8:
>>> -=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=3D ~(value & 0xa);
>>> +=A0=A0=A0=A0=A0=A0=A0 i2c->sts &=3D ~(value & 0x0a);
>>
>> ditto for the mask.
>>
>> Thanks,
>>
>> C.
>>
>>> +=A0=A0=A0=A0=A0=A0=A0 if (value & IIC_STS_IRQA && i2c->mdcntl & IIC_=
MDCNTL_EINT) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_irq_lower(i2c->irq);
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0 case 9:
>>> =A0=A0=A0=A0=A0=A0=A0=A0 i2c->extsts &=3D ~(value & 0x8f);
>>> @@ -287,12 +281,12 @@ static void ppc4xx_i2c_writeb(void *opaque, hwa=
ddr addr, uint64_t value,
>>> =A0=A0=A0=A0=A0=A0=A0=A0 i2c->xfrcnt =3D value & 0x77;
>>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0 case 15:
>>> +=A0=A0=A0=A0=A0=A0=A0 i2c->xtcntlss &=3D ~(value & 0xf0);
>>> =A0=A0=A0=A0=A0=A0=A0=A0 if (value & IIC_XTCNTLSS_SRST) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Is it actually a full reset? =
U-Boot sets some regs before */
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ppc4xx_i2c_reset(DEVICE(i2c));
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>>> -=A0=A0=A0=A0=A0=A0=A0 i2c->xtcntlss =3D value;
>>> =A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0 case 16:
>>> =A0=A0=A0=A0=A0=A0=A0=A0 i2c->directcntl =3D value & (IIC_DIRECTCNTL_=
SDAC & IIC_DIRECTCNTL_SCLC);
>>> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.=
h
>>> index ea6c8e1..0891a9c 100644
>>> --- a/include/hw/i2c/ppc4xx_i2c.h
>>> +++ b/include/hw/i2c/ppc4xx_i2c.h
>>> @@ -46,7 +46,8 @@ typedef struct PPC4xxI2CState {
>>> =A0=A0=A0=A0 qemu_irq irq;
>>> =A0=A0=A0=A0 MemoryRegion iomem;
>>> =A0=A0=A0=A0 bitbang_i2c_interface *bitbang;
>>> -=A0=A0=A0 uint8_t mdata;
>>> +=A0=A0=A0 int mdidx;
>>> +=A0=A0=A0 uint8_t mdata[4];
>>> =A0=A0=A0=A0 uint8_t lmadr;
>>> =A0=A0=A0=A0 uint8_t hmadr;
>>> =A0=A0=A0=A0 uint8_t cntl;
>>>
>>
>>
>>
