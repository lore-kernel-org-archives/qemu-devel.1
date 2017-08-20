Received: from eggs.gnu.org ([2001:4830:134:3::10]:48090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@jedlik.phy.bme.hu>) id 1djYS0-0005I2-Si
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 18:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@jedlik.phy.bme.hu>) id 1djYRx-0002KP-Kq
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 18:12:08 -0400
Date: Mon, 21 Aug 2017 00:12:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <1f2ce36c-928b-0631-fdb0-0f413a7a5cb5@amsat.org>
Message-ID: <alpine.LMD.2.02.1708210002500.3635@jedlik.phy.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ac6a19d43a6d36ae6f7cab99a1ac25d2515339ad.1503249785.git.balaton@eik.bme.hu>
	<1f2ce36c-928b-0631-fdb0-0f413a7a5cb5@amsat.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Subject: Re: [Qemu-devel] [PATCH 13/15] ppc4xx: Add more PLB registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Sun, 20 Aug 2017, Philippe Mathieu-Daud=C3=A9 wrote:
> On 08/20/2017 02:23 PM, BALATON Zoltan wrote:
>> These registers are present in 440 SoCs (and maybe in others too) and
>> U-Boot accesses them when printing register info. We don't emulate
>> these but add them to avoid crashing when they are read or written.
>
> Your code isn't incorrect but it doesn't sound the right way to fix your=
=20
> problem. Your firmware shouldn't *crash* on unimplemented dcr.

The firmware shouldn't crash but it's just isn't written expecting missing=
=20
DCRs (and we aim to run the board's patched U-Boot version as it is=20
because it is needed by the OSes running on the board). QEMU makes it=20
crash by raising an exception for unknown DCRs, I think in=20
target/ppc/timebase_helper.c:150

> Looking at ppc_dcr_read() I see that *valp isn't updated on unimp dcrn, w=
hile=20
> the dcr_read_plb() callback you are using return 0 on unimp (with an "avo=
id=20
> gcc warning" misleading comment).
>
> What is the hardware behavior on implemented dcr? return 0? In that case =
this=20
> should be used in ppc_dcr_read(), also adding some=20
> qemu_log_mask(LOG_UNIMP,...) log entry there.

Of course the right way would be to emulate what these registers do on=20
hardware but I don't know what the hardware does and for a lot of DCRs the=
=20
firmware just writes some values to initialise the hadware which is not=20
needed on QEMU so we can just do read zero, ignore writes which we are=20
doing here. (That's what I was trying to say in the commit message too.)=20
Actually these registers aren't even used by the firmware, only included=20
in register dumps so this should be safe until we find something tries to=
=20
use it.

> Regards,
>
> Phil.
>
>>=20
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/ppc405_uc.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
>> index e621d0a..8e58065 100644
>> --- a/hw/ppc/ppc405_uc.c
>> +++ b/hw/ppc/ppc405_uc.c
>> @@ -105,9 +105,12 @@ ram_addr_t ppc405_set_bootinfo (CPUPPCState *env,=
=20
>> ppc4xx_bd_info_t *bd,
>>   /*********************************************************************=
********/
>>   /* Peripheral local bus arbitrer */
>>   enum {
>> -    PLB0_BESR =3D 0x084,
>> -    PLB0_BEAR =3D 0x086,
>> -    PLB0_ACR  =3D 0x087,
>> +    PLB3A0_ACR =3D 0x077,
>> +    PLB4A0_ACR =3D 0x081,
>> +    PLB0_BESR  =3D 0x084,
>> +    PLB0_BEAR  =3D 0x086,
>> +    PLB0_ACR   =3D 0x087,
>> +    PLB4A1_ACR =3D 0x089,
>>   };
>>     typedef struct ppc4xx_plb_t ppc4xx_plb_t;
>> @@ -179,9 +182,12 @@ void ppc4xx_plb_init(CPUPPCState *env)
>>       ppc4xx_plb_t *plb;
>>         plb =3D g_malloc0(sizeof(ppc4xx_plb_t));
>> +    ppc_dcr_register(env, PLB3A0_ACR, plb, &dcr_read_plb, &dcr_write_pl=
b);
>> +    ppc_dcr_register(env, PLB4A0_ACR, plb, &dcr_read_plb, &dcr_write_pl=
b);
>>       ppc_dcr_register(env, PLB0_ACR, plb, &dcr_read_plb, &dcr_write_plb=
);
>>       ppc_dcr_register(env, PLB0_BEAR, plb, &dcr_read_plb, &dcr_write_pl=
b);
>>       ppc_dcr_register(env, PLB0_BESR, plb, &dcr_read_plb, &dcr_write_pl=
b);
>> +    ppc_dcr_register(env, PLB4A1_ACR, plb, &dcr_read_plb, &dcr_write_pl=
b);
>>       qemu_register_reset(ppc4xx_plb_reset, plb);
>>   }
>>=20
>
>
