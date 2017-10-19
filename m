Received: from eggs.gnu.org ([2001:4830:134:3::10]:53764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5DSv-0002ce-AH
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e5DSr-0006EL-B9
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:14:37 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:47899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e5DSr-0006Db-2t
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:14:33 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 27007143A58
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 18:14:31 +0200 (CEST)
References: <20171019151249.13663-1-clg@kaod.org>
	<20171019151249.13663-2-clg@kaod.org>
	<CAFEAcA-6gXF9skgYRTke5-0Ds_SLceAgX-Dz6WyyuiYJSz7afw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d885fed2-f8a4-6593-67ec-16522dc109d0@kaod.org>
Date: Thu, 19 Oct 2017 18:14:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-6gXF9skgYRTke5-0Ds_SLceAgX-Dz6WyyuiYJSz7afw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/8] aspeed: use a ROM memory region to
 catch invalid writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/19/2017 05:44 PM, Peter Maydell wrote:
> On 19 October 2017 at 16:12, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>> Some legacy firmwares access unimplemented addresses on the Aspeed SoC
>> (old U-Boot code using variables in the bss when it shouldn't do).
>> Let's use a ROM memory region to catch the invalid writes and support
>> new boards without using the 'ignore_memory_transaction_failures'
>> flag.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>
>>  Changes since v4 :
>>
>>  - use a ROM memory region
>=20
> Probably worth mentioning in the commit message that this
> is a migration compatibility break for these boards.

ah. Indeed :/=20

I tend to forget about migration for these emulated machines=20
but people are starting to use these Aspeed guests on large=20
Intel hosts as if they were real BMCs. And so being able to=20
change host is a valid requirement. I will add a comment.


>>  hw/arm/aspeed.c | 22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index ab895ad490af..d88a8b5120b6 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -166,6 +166,23 @@ static void aspeed_board_init_flashes(AspeedSMCSt=
ate *s, const char *flashtype,
>>      }
>>  }
>>
>> +/*
>> + * This is to track invalid writes done in the ROM by some legacy
>> + * firmwares
>> + */
>> +static void boot_rom_write(void *opaque, hwaddr offset, uint64_t valu=
e,
>> +                           unsigned size)
>> +{
>> +    qemu_log_mask(LOG_GUEST_ERROR,
>> +                  "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%u]\n",
>> +                  __func__, offset, value, size);
>> +}
>> +
>> +static const MemoryRegionOps boot_rom_ops =3D {
>> +    .write =3D boot_rom_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +};
>> +
>>  static void aspeed_board_init(MachineState *machine,
>>                                const AspeedBoardConfig *cfg)
>>  {
>> @@ -216,8 +233,9 @@ static void aspeed_board_init(MachineState *machin=
e,
>>           * SoC and 128MB for the AST2500 SoC, which is twickende as b=
ig as
>>           * needed by the flash modules of the Aspeed machines.
>>           */
>> -        memory_region_init_rom_nomigrate(boot_rom, OBJECT(bmc), "aspe=
ed.boot_rom",
>> -                               fl->size, &error_abort);
>> +        memory_region_init_rom_device(boot_rom, OBJECT(bmc), &boot_ro=
m_ops,
>> +                                      NULL, "aspeed.boot_rom", fl->si=
ze,
>> +                                      &error_abort);
>>          memory_region_add_subregion(get_system_memory(), FIRMWARE_ADD=
R,
>>                                      boot_rom);
>>          write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort)=
;
>> --
>=20
> Don't you want to create the ROM device even if there happens
> not to be any contents specified by the user? The thing is still
> there in the SoC even if it's empty...

Do you mean that we should create the boot ROM device even if there=20
is no file backend ? I think so yes. Let's do a v6 :)

Thanks,

C.
