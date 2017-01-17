Received: from eggs.gnu.org ([2001:4830:134:3::10]:40901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTOlh-0003R6-6I
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTOld-00027m-V3
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:05:25 -0500
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:36396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cTOld-00027d-OX
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:05:21 -0500
Received: from player760.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id D42156D179
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 09:05:19 +0100 (CET)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-3-git-send-email-clg@kaod.org>
	<a4062932-5906-eff0-8931-9da7c1123ddb@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <021feed5-b87e-c3ff-0030-12b3c018d7ed@kaod.org>
Date: Tue, 17 Jan 2017 09:05:12 +0100
MIME-Version: 1.0
In-Reply-To: <a4062932-5906-eff0-8931-9da7c1123ddb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/11] aspeed/smc: remove call to
 aspeed_smc_update_cs() in reset function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcin Krzeminski <marcin.krzeminski@nokia.com>

On 01/16/2017 06:23 PM, mar.krzeminski wrote:
> W dniu 09.01.2017 o 17:24, C=C3=A9dric Le Goater pisze:
>> Instead, we can simply set the irq level when unselecting the slave
>> devices. This change prepares ground for a subsequent cleanup of the
>> aspeed_smc_update_cs() routine which uselessly loops on all slaves to
>> update their status.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ssi/aspeed_smc.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>> index 8a7217d4df6c..205c0abfae98 100644
>> --- a/hw/ssi/aspeed_smc.c
>> +++ b/hw/ssi/aspeed_smc.c
>> @@ -424,6 +424,7 @@ static void aspeed_smc_reset(DeviceState *d)
>>      /* Unselect all slaves */
>>      for (i =3D 0; i < s->num_cs; ++i) {
>>          s->regs[s->r_ctrl0 + i] |=3D CTRL_CE_STOP_ACTIVE;
>> +        qemu_set_irq(s->cs_lines[i], true);
> Does SMC support only flash chips with CS active LOW?

yes. This is the case.

Thanks,


C.=20

> If yes:
> Acked-by: Marcin Krzemi=C5=84ski <mar.krzeminski@gmail.com>
>>      }
>> =20
>>      /* setup default segment register values for all */
>> @@ -431,8 +432,6 @@ static void aspeed_smc_reset(DeviceState *d)
>>          s->regs[R_SEG_ADDR0 + i] =3D
>>              aspeed_smc_segment_to_reg(&s->ctrl->segments[i]);
>>      }
>> -
>> -    aspeed_smc_update_cs(s);
>>  }
>> =20
>>  static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned i=
nt size)
>=20
