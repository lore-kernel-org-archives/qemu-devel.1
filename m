Received: from eggs.gnu.org ([2001:4830:134:3::10]:34778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWpzZ-0008GB-9m
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 17:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWpzW-0000za-49
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 17:22:45 -0400
Date: Sat, 23 Jun 2018 23:22:39 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <1529788685-31687-1-git-send-email-linux@roeck-us.net>
Message-ID: <alpine.BSF.2.21.1806232320570.73730@zero.eik.bme.hu>
References: <1529788685-31687-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v4] sam460ex: Fix sam460ex device tree when
 booting the Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Sat, 23 Jun 2018, Guenter Roeck wrote:
> sam460ex (or at least this emulation) does not support the "ibm,cpm" power
> management. As a result, Linux crashes when trying to access it. Remove
> its device tree node. Also, if/when we boot the Linux kernel directly,
> serial port clock frequencies in the device tree file will be unset, and
> serial port initialization will fail. Add valid frequency values to
> the serial ports to be able to use it. Also set valid values for the other
> clock nodes otherwise set by u-boot.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Thanks again for debugging and fixing it.

> ---
> v4: Use correct UART clock.
> v3: Fix style problems (ERROR: braces {} are necessary for all arms ...).
>    Use defines for clock frequencies.
>    Use clock frequencies as reported by u-boot in real system.
>    Use more specific prefix in subject.
>    Fix typos in description.
> v2: Initialize all serial nodes to match u-boot behavior more closely.
>    Use direct fdt API functions and ignore errors when clearing out
>    /cpm and for setting the serial port clocks.
>
> hw/ppc/sam460ex.c | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index bdc53d2..33ea518 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -37,6 +37,8 @@
> #include "hw/i2c/smbus.h"
> #include "hw/usb/hcd-ehci.h"
>
> +#include <libfdt.h>
> +
> #define BINARY_DEVICE_TREE_FILE "canyonlands.dtb"
> #define UBOOT_FILENAME "u-boot-sam460-20100605.bin"
> /* to extract the official U-Boot bin from the updater: */
> @@ -67,6 +69,10 @@
> */
>
> #define CPU_FREQ 1150000000
> +#define PLB_FREQ 230000000
> +#define OPB_FREQ 115000000
> +#define EBC_FREQ 115000000
> +#define UART_FREQ 11059200
> #define SDRAM_NR_BANKS 4
>
> /* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
> @@ -255,6 +261,7 @@ static int sam460ex_load_device_tree(hwaddr addr,
>     void *fdt;
>     uint32_t tb_freq = CPU_FREQ;
>     uint32_t clock_freq = CPU_FREQ;
> +    int offset;
>
>     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
>     if (!filename) {
> @@ -308,6 +315,27 @@ static int sam460ex_load_device_tree(hwaddr addr,
>     qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "timebase-frequency",
>                               tb_freq);
>
> +    /* Remove cpm node if it exists (it is not emulated) */
> +    offset = fdt_path_offset(fdt, "/cpm");
> +    if (offset >= 0) {
> +        fdt_nop_node(fdt, offset);
> +    }
> +
> +    /* set serial port clocks */
> +    offset = fdt_node_offset_by_compatible(fdt, -1, "ns16550");
> +    while (offset >= 0) {
> +        fdt_setprop_cell(fdt, offset, "clock-frequency", UART_FREQ);
> +        offset = fdt_node_offset_by_compatible(fdt, offset, "ns16550");
> +    }
> +
> +    /* some more clocks */
> +    qemu_fdt_setprop_cell(fdt, "/plb", "clock-frequency",
> +                              PLB_FREQ);
> +    qemu_fdt_setprop_cell(fdt, "/plb/opb", "clock-frequency",
> +                              OPB_FREQ);
> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/ebc", "clock-frequency",
> +                              EBC_FREQ);
> +
>     rom_add_blob_fixed(BINARY_DEVICE_TREE_FILE, fdt, fdt_size, addr);
>     g_free(fdt);
>     ret = fdt_size;
>
