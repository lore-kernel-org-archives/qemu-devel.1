Received: from eggs.gnu.org ([2001:4830:134:3::10]:55047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYBrt-0001n1-VZ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYBrs-0005cn-JK
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:56:25 -0400
Date: Wed, 27 Jun 2018 16:56:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180627165616.34d36aaf@redhat.com>
In-Reply-To: <1530094388-607-1-git-send-email-hongbo.zhang@linaro.org>
References: <1530094388-607-1-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Add SBSA machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Wed, 27 Jun 2018 18:13:08 +0800
Hongbo Zhang <hongbo.zhang@linaro.org> wrote:

> This patch introduces a new Arm machine type 'SBSA' with features:
>  - Based on legacy 'virt' machine type.
>  - Newly designed memory map.
>  - EL2 and EL3 are enabled by default.
>  - AHCI controller attached to system bus, and then CDROM and hard disc
>    can be added to it.
>  - EHCI controller attached to system bus, with USB mouse and key board
>    installed by default.
>  - E1000 ethernet card on PCIE bus.
>  - VGA display adaptor on PCIE bus.
>  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
>  - No virtio functions enabled, since this is to emulate real hardware.
I'd drop all default (convenience) devices unless they are specified in SBSA,
and make management explicitly provide needed devices on CLI.

> 
> This is the prototype, more features can be added in futrue.
> 
> Purpose of this is to have a standard QEMU platform for Arm firmware
> developement etc. where the legacy machines cannot meets requirements.
> 
> Arm Trusted Firmware and UEFI porting to this are done seperately.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
[...]

> @@ -94,6 +98,8 @@
>  
>  #define PLATFORM_BUS_NUM_IRQS 64
>  
> +#define SATA_NUM_PORTS 6
> +
>  /* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this means
>   * RAM can go up to the 256GB mark, leaving 256GB of the physical
>   * address space unallocated and free for future use between 256G and 512G.
> @@ -168,6 +174,47 @@ static const int a15irqmap[] = {
>      [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
>  };
>  
> +static const MemMapEntry sbsa_memmap[] = {
> +    /* Space up to 0x8000000 is reserved for a boot ROM */
> +    [VIRT_FLASH] =              {          0, 0x08000000 },
> +    [VIRT_CPUPERIPHS] =         { 0x08000000, 0x00020000 },
> +    /* GIC distributor and CPU interfaces sit inside the CPU peripheral space */
> +    [VIRT_GIC_DIST] =           { 0x08000000, 0x00010000 },
> +    [VIRT_GIC_CPU] =            { 0x08010000, 0x00010000 },
> +    [VIRT_GIC_V2M] =            { 0x08020000, 0x00001000 },
> +    /* The space in between here is reserved for GICv3 CPU/vCPU/HYP */
> +    [VIRT_GIC_ITS] =            { 0x08080000, 0x00020000 },
> +    /* This redistributor space allows up to 2*64kB*123 CPUs */
> +    [VIRT_GIC_REDIST] =         { 0x080A0000, 0x00F60000 },
> +    [VIRT_UART] =               { 0x09000000, 0x00001000 },
> +    [VIRT_RTC] =                { 0x09010000, 0x00001000 },
> +    [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
> +    [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
> +    [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
> +    [VIRT_AHCI] =               { 0x09050000, 0x00010000 },
> +    [VIRT_EHCI] =               { 0x09060000, 0x00010000 },
> +    [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> +    [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
> +    [VIRT_PCIE_MMIO] =          { 0x10000000, 0x7fff0000 },
> +    [VIRT_PCIE_PIO] =           { 0x8fff0000, 0x00010000 },
> +    [VIRT_PCIE_ECAM] =          { 0x90000000, 0x10000000 },
> +    /* Second PCIe window, 508GB wide at the 4GB boundary */
> +    [VIRT_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0x7F00000000ULL },
> +    [VIRT_MEM] =                { 0x8000000000ULL, RAMLIMIT_BYTES },
does spec require support for 32-bit guest or is it only 64bit,
if the later I'd put it somewhere high where we can increase region
to terrabytes.

another idea that was floating around (considering we don't care about legacy)
is to use flexible base address and tell firmware[*] via register where it's.
Then it would be able to support 32 guest with small amount of RAM
and 64 bit guests with huge amount of RAM using a single memory range.
(to keep memory management simple). It's also future friendly, as in case
if we need to move it we could do easily by changing base address for new machine
type only and firmware would automatically pick it up from register
(without all compat nightmare we have with 2 regions in pc/q35 machines).

[*] When I've talked with Laszlo about it he said it was not easy to do in uefi
but still possible.

same applies to GIG regions/mmio/ecam where we are twisting our hands when trying to
increase number of things.

[...]
