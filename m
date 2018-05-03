Received: from eggs.gnu.org ([2001:4830:134:3::10]:54506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEANS-00086Z-Mu
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEANR-0004Wa-Bh
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:18:14 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:36806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEANR-0004WB-5N
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:18:13 -0400
Received: by mail-ot0-x243.google.com with SMTP id m11-v6so13663280otf.3
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:18:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180503090532.3113-2-joel@jms.id.au>
References: <20180503090532.3113-1-joel@jms.id.au>
	<20180503090532.3113-2-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 10:17:51 +0100
Message-ID: <CAFEAcA_4EiWXdSNdbiEWO_Q2Sac7qzNduhyWVNwW-crc5=w_nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] arm: Add Nordic Semiconductor nRF51 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>

On 3 May 2018 at 10:05, Joel Stanley <joel@jms.id.au> wrote:
> The nRF51 is a Cortex-M0 microcontroller with an on-board radio module,
> plus other common ARM SoC peripherals.
>
>  http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
>
> This defines a basic model of the CPU and memory, with no peripherals
> implemented at this stage.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

> +static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    NRF51State *s = NRF51_SOC(dev_soc);
> +    DeviceState *nvic;
> +    Error *err = NULL;
> +
> +    /* IO space */
> +    create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
> +
> +    /* FICR */
> +    create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
> +
> +    MemoryRegion *system_memory = get_system_memory();
> +    MemoryRegion *sram = g_new(MemoryRegion, 1);
> +    MemoryRegion *flash = g_new(MemoryRegion, 1);

An SoC object doesn't need to allocate memory for things like this:
it can just put them as struct fields in its state structure.

> +
> +    memory_region_init_ram_nomigrate(flash, NULL, "nrf51.flash", FLASH_SIZE,

You should pass in OBJECT(s) as your owner argument, not NULL.

> +            &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    vmstate_register_ram_global(flash);

Rather than using the _nomigrate init function and then registering
the ram by hand, if you use memory_region_init_ram() it will automatically
register the memory for migration for you.

> +    memory_region_set_readonly(flash, true);
> +
> +    memory_region_add_subregion(system_memory, FLASH_BASE, flash);

SoC objects should avoid directly adding things to system memory.
If you look at hw/arm/iotkit.c it's an example of an SoC that
takes a MemoryRegion property from the board, creates a 'container'
region, adds the board memory and its devices to the container,
and then passes it to the CPU.

> +    memory_region_init_ram_nomigrate(sram, NULL, "nrf51.sram", SRAM_SIZE,
> +            &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    vmstate_register_ram_global(sram);
> +    memory_region_add_subregion(system_memory, SRAM_BASE, sram);
> +
> +    /* TODO: implement a cortex m0 and update this */
> +    nvic = armv7m_init(get_system_memory(), FLASH_SIZE, 96,
> +            s->kernel_filename, ARM_CPU_TYPE_NAME("cortex-m3"));

We recently refactored the armv7m init code so you don't have
to use this function. Instead you can:
 * in this SoC object, initialize and realize an armv7m object
 * in the board code, use armv7m_load_kernel() to do the initial
   image load

That way you don't need to pass in the kernel filename as a
property to this object.


I'm a bit reluctant to take these patches until we have an
actual cortex-m0 model, because anything we take into QEMU
master is then something we have to support. My rule of thumb
is that it's ok to have board models that are missing
functionality, but we should avoid models that have wrong
functionality (like the wrong CPU) where we can.

thanks
-- PMM
