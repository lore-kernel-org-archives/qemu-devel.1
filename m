Received: from eggs.gnu.org ([209.51.188.92]:41567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1giwk3-0003hx-Fl
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1giwk2-0007P6-IR
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:33:03 -0500
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:34942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1giwk1-0007J5-Tb
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:33:02 -0500
Received: from player732.ha.ovh.net (unknown [10.109.143.249])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id AC10F10DED4
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:32:52 +0100 (CET)
References: <20190111125759.31577-1-clg@kaod.org>
	<CACPK8Xdp8hCYCqWrVQeRuK819-EmNCuWJwF1jGSJfy5RzMUsXg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8aafff96-e02c-a5a3-dc20-a15f21387479@kaod.org>
Date: Mon, 14 Jan 2019 08:32:42 +0100
MIME-Version: 1.0
In-Reply-To: <CACPK8Xdp8hCYCqWrVQeRuK819-EmNCuWJwF1jGSJfy5RzMUsXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ftgmac100: implement the new MDIO
 interface on Aspeed SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, Jason Wang <jasowang@redhat.com>

On 1/14/19 4:29 AM, Joel Stanley wrote:
> On Fri, 11 Jan 2019 at 23:58, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>
>> The PHY behind the MAC of an Aspeed SoC can be controlled using two
>> different MDC/MDIO interfaces. The same registers PHYCR (MAC60) and
>> PHYDATA (MAC64) are involved but they have a different layout.
>>
>> BIT31 of the Feature Register (MAC40) controls which MDC/MDIO
>> interface is active.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/net/ftgmac100.c | 80 +++++++++++++++++++++++++++++++++++++++------=
-
>>  1 file changed, 68 insertions(+), 12 deletions(-)
>=20
>> @@ -269,9 +281,9 @@ static void phy_reset(FTGMAC100State *s)
>>      s->phy_int =3D 0;
>>  }
>>
>> -static uint32_t do_phy_read(FTGMAC100State *s, int reg)
>> +static uint16_t do_phy_read(FTGMAC100State *s, uint8_t reg)
>>  {
>> -    uint32_t val;
>> +    uint16_t val;
>=20
> Unrelated?

It is. Check do_phy_new_ctl() passing a 'uint8_t reg'.=20

There is not much point of adding these small changes without the bigger=20
one adding the new MDC/MDIO interfaces. That's why I merged them all in=20
one single patch.

>> @@ -336,7 +348,7 @@ static uint32_t do_phy_read(FTGMAC100State *s, int=
 reg)
>>                         MII_BMCR_FD | MII_BMCR_CTST)
>>  #define MII_ANAR_MASK 0x2d7f
>>
>> -static void do_phy_write(FTGMAC100State *s, int reg, uint32_t val)
>> +static void do_phy_write(FTGMAC100State *s, uint8_t reg, uint16_t val=
)
>=20
> Also unrelated?
>>> @@ -711,14 +771,11 @@ static void ftgmac100_write(void *opaque, hwadd=
r addr,
>>          break;
>>
>>      case FTGMAC100_PHYCR:  /* PHY Device control */
>> -        reg =3D FTGMAC100_PHYCR_REG(value);
>>          s->phycr =3D value;
>> -        if (value & FTGMAC100_PHYCR_MIIWR) {
>> -            do_phy_write(s, reg, s->phydata & 0xffff);
>> -            s->phycr &=3D ~FTGMAC100_PHYCR_MIIWR;
>> +        if (s->revr & FTGMAC100_REVR_NEW_MDIO_INTERFACE) {
>> +            do_phy_new_ctl(s);
>>          } else {
>> -            s->phydata =3D do_phy_read(s, reg) << 16;
>> -            s->phycr &=3D ~FTGMAC100_PHYCR_MIIRD;
>> +            do_phy_ctl(s);
>=20
> I assume the guest code programs the correct phy mode so this will
> work fine. This change appears to keep the existing default of the old
> mode.

Yes. 0 is the default setting of 'Feature Register'

> Did you give this a go with both -kernel and a u-boot mtd image?

Yes.
=20
> Looks good to me. If you feel like splitting out the unrelated changes
> do that, but I'm not fussed either way.
>=20
> Reviewed-by: Joel Stanley <joel@jms.id.au>


Thanks,

C.


> Cheers,
>=20
> Joel
>=20
