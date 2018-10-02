Received: from eggs.gnu.org ([2001:4830:134:3::10]:43347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7IMn-0006O4-De
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7IMB-00069s-ER
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:56:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7IMB-00069a-2z
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:56:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id 36-v6so1395750oth.11
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:56:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180921161939.822-9-clg@kaod.org>
References: <20180921161939.822-1-clg@kaod.org>
	<20180921161939.822-9-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 11:56:25 +0100
Message-ID: <CAFEAcA8W0ixkfje4NSx-+kdw4rNh44JgNTu2OhDD_p91nHK7hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 21 September 2018 at 17:19, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> The FMC controller on the Aspeed SoCs support DMA to access the flash
> modules. It can operate in a normal mode, to copy to or from the flash
> module mapping window, or in a checksum calculation mode, to evaluate
> the best clock settings for reads.
>
> The model introduces a custom address space for DMAs populated with
> the required regions : an alias region on the AHB window for the flash
> devices and another alias on the SDRAM.
>
> Our primary need is to support the checksum calculation mode and the
> model only implements synchronous DMA accesses. Something to improve
> in the future.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>


> +static void aspeed_smc_dma_rw(AspeedSMCState *s)
> +{
> +    MemTxResult result;
> +    uint32_t data;
> +
> +    while (s->regs[R_DMA_LEN]) {
> +        if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
> +            result =3D address_space_read(&s->dma_as, s->regs[R_DMA_DRAM=
_ADDR],
> +                                        MEMTXATTRS_UNSPECIFIED,
> +                                        (uint8_t *)&data, 4);
> +            if (result !=3D MEMTX_OK) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM read failed @%0=
8x\n",
> +                              __func__, s->regs[R_DMA_DRAM_ADDR]);
> +                return;
> +            }

Does the device really not report DMA read/write failures via
a status register bit or similar ?


> +
> +/*
> + * Populate our custom address space for DMAs with only the regions we
> + * need : the AHB window for the flash devices and the SDRAM.
> + */
> +static void aspeed_smc_dma_setup(AspeedSMCState *s)
> +{
> +    char name[32];
> +    MemoryRegion *sysmem =3D get_system_memory();
> +    MemoryRegion *flash_alias =3D g_new(MemoryRegion, 1);
> +    MemoryRegion *sdram_alias =3D g_new(MemoryRegion, 1);
> +
> +    snprintf(name, sizeof(name), "%s-dma", s->ctrl->name);

I would suggest using g_strdup_printf()/g_free(), since it's not
immediately obvious here that s->ctrl->name is guaranteed
to fit into the fixed-size array.

> +    memory_region_init(&s->dma_mr, OBJECT(s), name,
> +                       s->sdram_base + s->max_ram_size);
> +    address_space_init(&s->dma_as, &s->dma_mr, name);
> +
> +    snprintf(name, sizeof(name), "%s.flash", s->ctrl->name);
> +    memory_region_init_alias(flash_alias, OBJECT(s), name, &s->mmio_flas=
h,
> +                             0, s->ctrl->flash_window_size);
> +    memory_region_add_subregion(&s->dma_mr, s->ctrl->flash_window_base,
> +                                flash_alias);
> +
> +    memory_region_init_alias(sdram_alias, OBJECT(s), "ram", sysmem,
> +                             s->sdram_base, s->max_ram_size);
> +    memory_region_add_subregion(&s->dma_mr, s->sdram_base, sdram_alias);

Rather than having the DMA device directly grab the system_memory
MR like this, it's better to have the device have a MemoryRegion
property, which the SoC sets with whatever the DMA device should
be able to see.

Otherwise, patch looks good, though I don't know enough about
the device/SoC to review those details.

thanks
-- PMM
