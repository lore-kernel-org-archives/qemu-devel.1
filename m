Received: from eggs.gnu.org ([208.118.235.92]:49071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzFdJ-0002Dw-7b
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzFZV-0006n9-Oy
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:21:21 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:56728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fzFZS-0006k9-RM
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:21:15 -0400
Received: from player796.ha.ovh.net (unknown [10.109.160.40])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 87C3A17B8D5
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 08:21:03 +0200 (CEST)
References: <20180831103816.13479-1-clg@kaod.org>
	<20180831103816.13479-7-clg@kaod.org>
	<c9bc4c3d-c7cc-389c-12e7-3255383543c1@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e607ad6a-29bc-97d9-b224-f91bccb2dccd@kaod.org>
Date: Mon, 10 Sep 2018 08:20:52 +0200
MIME-Version: 1.0
In-Reply-To: <c9bc4c3d-c7cc-389c-12e7-3255383543c1@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/11] aspeed/smc: fix default read value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>

On 09/08/2018 01:06 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi C=C3=A9dric,
>=20
> On 8/31/18 7:38 AM, C=C3=A9dric Le Goater wrote:
>> 0xFFFFFFFF should be returned for non implemented registers.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ssi/aspeed_smc.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>> index 1270842dcf0c..6045ca11b969 100644
>> --- a/hw/ssi/aspeed_smc.c
>> +++ b/hw/ssi/aspeed_smc.c
>> @@ -665,12 +665,12 @@ static uint64_t aspeed_smc_read(void *opaque, hw=
addr addr, unsigned int size)
>>          addr =3D=3D s->r_ce_ctrl ||
>>          addr =3D=3D R_INTR_CTRL ||
>>          (addr >=3D R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_s=
laves) ||
>> -        (addr >=3D s->r_ctrl0 && addr < s->r_ctrl0 + s->num_cs)) {
>> +        (addr >=3D s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_sla=
ves)) {
>
> This change seems unrelated to this commit.

The controller should have one control register for each flash device
if there is no CS available.

The problem is that s->num_cs is a QEMU software concept representing=20
the number of flash devices handled by a board where as 'ctrl->max_slaves=
'=20
is a HW limit representing the maximum number of flash devices a=20
controller can handle.

Thanks,

C.
=20
>>          return s->regs[addr];
>>      } else {
>>          qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PR=
Ix "\n",
>>                        __func__, addr);
>> -        return 0;
>> +        return -1;
>>      }
>>  }
>> =20
>>
