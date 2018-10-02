Received: from eggs.gnu.org ([2001:4830:134:3::10]:45627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mv2-0003qG-Vi
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Muy-00073i-O8
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:04 -0400
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:43930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7Muy-00071c-Ga
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:00 -0400
Received: from player687.ha.ovh.net (unknown [10.109.146.163])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id C616734D28
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 17:48:52 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20180921161939.822-1-clg@kaod.org>
	<20180921161939.822-9-clg@kaod.org>
	<CAFEAcA8W0ixkfje4NSx-+kdw4rNh44JgNTu2OhDD_p91nHK7hw@mail.gmail.com>
Message-ID: <f18e92fa-7b49-04b6-0adb-4f1a84668168@kaod.org>
Date: Tue, 2 Oct 2018 17:48:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8W0ixkfje4NSx-+kdw4rNh44JgNTu2OhDD_p91nHK7hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/11] aspeed/smc: add support for DMAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/2/18 12:56 PM, Peter Maydell wrote:
> On 21 September 2018 at 17:19, C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
>> The FMC controller on the Aspeed SoCs support DMA to access the flash
>> modules. It can operate in a normal mode, to copy to or from the flash
>> module mapping window, or in a checksum calculation mode, to evaluate
>> the best clock settings for reads.
>>
>> The model introduces a custom address space for DMAs populated with
>> the required regions : an alias region on the AHB window for the flash
>> devices and another alias on the SDRAM.
>>
>> Our primary need is to support the checksum calculation mode and the
>> model only implements synchronous DMA accesses. Something to improve
>> in the future.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
>=20
>> +static void aspeed_smc_dma_rw(AspeedSMCState *s)
>> +{
>> +    MemTxResult result;
>> +    uint32_t data;
>> +
>> +    while (s->regs[R_DMA_LEN]) {
>> +        if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
>> +            result =3D address_space_read(&s->dma_as, s->regs[R_DMA_D=
RAM_ADDR],
>> +                                        MEMTXATTRS_UNSPECIFIED,
>> +                                        (uint8_t *)&data, 4);
>> +            if (result !=3D MEMTX_OK) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM read failed =
@%08x\n",
>> +                              __func__, s->regs[R_DMA_DRAM_ADDR]);
>> +                return;
>> +            }
>=20
> Does the device really not report DMA read/write failures via
> a status register bit or similar ?

The Interrupt Control and Status Register (FM0C8) has a DMA Status
BIT(11) to indicate that a DMA transfer is in progress or not. Nothing
for errors.

There are a SPI command abort status BIT(10) and a SPI Write Address
Protected status BIT(11) but these are for the command and address
filters.
=20
>> +
>> +/*
>> + * Populate our custom address space for DMAs with only the regions w=
e
>> + * need : the AHB window for the flash devices and the SDRAM.
>> + */
>> +static void aspeed_smc_dma_setup(AspeedSMCState *s)
>> +{
>> +    char name[32];
>> +    MemoryRegion *sysmem =3D get_system_memory();
>> +    MemoryRegion *flash_alias =3D g_new(MemoryRegion, 1);
>> +    MemoryRegion *sdram_alias =3D g_new(MemoryRegion, 1);
>> +
>> +    snprintf(name, sizeof(name), "%s-dma", s->ctrl->name);
>=20
> I would suggest using g_strdup_printf()/g_free(), since it's not
> immediately obvious here that s->ctrl->name is guaranteed
> to fit into the fixed-size array.

yes. sure.

>> +    memory_region_init(&s->dma_mr, OBJECT(s), name,
>> +                       s->sdram_base + s->max_ram_size);
>> +    address_space_init(&s->dma_as, &s->dma_mr, name);
>> +
>> +    snprintf(name, sizeof(name), "%s.flash", s->ctrl->name);
>> +    memory_region_init_alias(flash_alias, OBJECT(s), name, &s->mmio_f=
lash,
>> +                             0, s->ctrl->flash_window_size);
>> +    memory_region_add_subregion(&s->dma_mr, s->ctrl->flash_window_bas=
e,
>> +                                flash_alias);
>> +
>> +    memory_region_init_alias(sdram_alias, OBJECT(s), "ram", sysmem,
>> +                             s->sdram_base, s->max_ram_size);
>> +    memory_region_add_subregion(&s->dma_mr, s->sdram_base, sdram_alia=
s);
>=20
> Rather than having the DMA device directly grab the system_memory
> MR like this, it's better to have the device have a MemoryRegion
> property, which the SoC sets with whatever the DMA device should
> be able to see.

ok. I see, but it seems I have a chicken & egg problem.=20

The MemoryRegion I would liked to grab is the bmc->ram one in aspeed.c=20
but it is initialized after the SoC is. I don't know how to lazy bind=20
this region in the Aspeed SMC model using the Aspeed SoC model as a=20
proxy to pass the region property through a link or/and alias.

If I could find a way, the model would be much cleaner. =20

> Otherwise, patch looks good, though I don't know enough about
> the device/SoC to review those details.

For the moment the only use of these registers is in the Aspeed custom=20
u-boot of the SDK :=20

or in the rewrite I proposed in mainline :


Thanks,

C.
