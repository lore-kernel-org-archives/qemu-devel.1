Received: from eggs.gnu.org ([2001:4830:134:3::10]:39482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fqIsm-0003aR-Az
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fqIsh-0003iX-6H
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:04:12 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:43387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fqIsg-0003hy-WF
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:04:07 -0400
Received: from player730.ha.ovh.net (unknown [10.109.159.7])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id BA6F8CF36D
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 16:04:05 +0200 (CEST)
References: <20180807075757.7242-1-joel@jms.id.au>
	<20180807075757.7242-7-joel@jms.id.au>
	<CAFEAcA8eUOzyHgF6YEBo80xQLzdnaVeZMYRiPPJWFBNv7dhZTQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ec225f94-6bcc-cb88-0421-7e464fca0033@kaod.org>
Date: Thu, 16 Aug 2018 16:03:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8eUOzyHgF6YEBo80xQLzdnaVeZMYRiPPJWFBNv7dhZTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] aspeed: add a max_ram_size property to
 the memory controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 08/16/2018 02:48 PM, Peter Maydell wrote:
> On 7 August 2018 at 08:57, Joel Stanley <joel@jms.id.au> wrote:
>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> This will be used to construct a memory region beyond the RAM region
>> to let firmwares scan the address space with load/store to guess how
>> much RAM the SoC has.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  hw/arm/aspeed.c               | 31 +++++++++++++++++++++++++++++++
>>  hw/arm/aspeed_soc.c           |  2 ++
>>  hw/misc/aspeed_sdmc.c         |  3 +++
>>  include/hw/misc/aspeed_sdmc.h |  1 +
>>  4 files changed, 37 insertions(+)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index bb9d33848d3f..e078269266bc 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -31,6 +31,7 @@ static struct arm_boot_info aspeed_board_binfo =3D {
>>  typedef struct AspeedBoardState {
>>      AspeedSoCState soc;
>>      MemoryRegion ram;
>> +    MemoryRegion max_ram;
>>  } AspeedBoardState;
>>
>>  typedef struct AspeedBoardConfig {
>> @@ -127,6 +128,27 @@ static const AspeedBoardConfig aspeed_boards[] =3D=
 {
>>      },
>>  };
>>
>> +/*
>> + * The max ram region is for firmwares that scan the address space
>> + * with load/store to guess how much RAM the SoC has.
>> + */
>> +static uint64_t max_ram_read(void *opaque, hwaddr offset, unsigned si=
ze)
>> +{
>> +    return 0;
>> +}
>> +
>> +static void max_ram_write(void *opaque, hwaddr offset, uint64_t value=
,
>> +                           unsigned size)
>> +{
>> +    /* Disacard writes */
>> +}
>> +
>> +static const MemoryRegionOps max_ram_ops =3D {
>> +    .read =3D max_ram_read,
>> +    .write =3D max_ram_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +};
>> +
>>  #define FIRMWARE_ADDR 0x0
>>
>>  static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_=
size,
>> @@ -187,6 +209,7 @@ static void aspeed_board_init(MachineState *machin=
e,
>>      AspeedBoardState *bmc;
>>      AspeedSoCClass *sc;
>>      DriveInfo *drive0 =3D drive_get(IF_MTD, 0, 0);
>> +    ram_addr_t max_ram_size;
>>
>>      bmc =3D g_new0(AspeedBoardState, 1);
>>      object_initialize(&bmc->soc, (sizeof(bmc->soc)), cfg->soc_name);
>> @@ -226,6 +249,14 @@ static void aspeed_board_init(MachineState *machi=
ne,
>>      object_property_add_const_link(OBJECT(&bmc->soc), "ram", OBJECT(&=
bmc->ram),
>>                                     &error_abort);
>>
>> +    max_ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "max=
-ram-size",
>> +                                            &error_abort);
>> +    memory_region_init_io(&bmc->max_ram, NULL, &max_ram_ops, NULL,
>> +                          "max_ram", max_ram_size  - ram_size);
>> +    memory_region_add_subregion(get_system_memory(),
>> +                                sc->info->sdram_base + ram_size,
>> +                                &bmc->max_ram);
>=20
> I'm surprised that you need the IO ops, ie that it doesn't work
> just to define an empty container region with memory_region_init().

Initially, there was some logging in the IO ops, which was a nice to have=
.
But that was dropped in this patch. No a big issue I think.

Thanks,

C.=20
=20
