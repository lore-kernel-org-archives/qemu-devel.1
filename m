Received: from eggs.gnu.org ([2001:4830:134:3::10]:33430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWf0U-0004pB-3G
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 05:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWf0M-0002Il-KR
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 05:38:55 -0400
Date: Sat, 23 Jun 2018 11:38:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <1529716721-28400-1-git-send-email-linux@roeck-us.net>
Message-ID: <alpine.BSF.2.21.1806231115020.11861@zero.eik.bme.hu>
References: <1529716721-28400-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2] ppc: Fix sam460ex devicetree when
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

On Fri, 22 Jun 2018, Guenter Roeck wrote:
> sam4660ex (or at least this emulation) does not support the "ibm,cpm" power
> management. As a result, Linux crashes when trying to access it. Remove
> its devicetree node. Also, if/when we boot the Linux kernel directly,
> serial port clock frequencies in the devicetree file will be unset, and
> serial port initialization will fail. Add plausible frequency values to
> the serials port to be able to use it. Also set valid values for the other
> clock nodes otherwise set by u-boot.

Apart from small fixes in commit message such as:
- prefix title with sam460ex: instead of ppc: to be more specific
- sam4660ex -> sam460ex
- serials port -> serial ports
- device tree may be two words but not sure and not so important

Should we set the correct frequencies set by u-boot instead of some 
plausible value? At boot u-boot prints:

CPU:   AMCC PowerPC 460EX Rev. B at 1150 MHz (PLB=230 OPB=115 EBC=115)

Where PLB, OPB and EBC freqs are not 50MHz. I'm not sure this would cause 
any problem but previously I've seen timing issues by clocks going slower 
or faster when such clock freqs are wrong.

Could you at least #define a constant next to CPU_FREQ instead of 
hardcoding values that appear in multiple places.

Thank you,
BALATON Zoltan

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Initialize all serial nodes to match u-boot behavior more closely.
>    Use direct fdt API functions and ignore errors when clearing out
>    /cpm and for setting the serial port clocks.
>
> hw/ppc/sam460ex.c | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index bdc53d2..a91382c 100644
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
> @@ -255,6 +257,7 @@ static int sam460ex_load_device_tree(hwaddr addr,
>     void *fdt;
>     uint32_t tb_freq = CPU_FREQ;
>     uint32_t clock_freq = CPU_FREQ;
> +    int offset;
>
>     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
>     if (!filename) {
> @@ -308,6 +311,26 @@ static int sam460ex_load_device_tree(hwaddr addr,
>     qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "timebase-frequency",
>                               tb_freq);
>
> +    /* Remove cpm node if it exists (it is not emulated) */
> +    offset = fdt_path_offset(fdt, "/cpm");
> +    if (offset >= 0)
> +        fdt_nop_node(fdt, offset);
> +
> +    /* set serial port clocks */
> +    offset = fdt_node_offset_by_compatible(fdt, -1, "ns16550");
> +    while (offset >= 0) {
> +        fdt_setprop_cell(fdt, offset, "clock-frequency", 50000000);
> +        offset = fdt_node_offset_by_compatible(fdt, offset, "ns16550");
> +    }
> +
> +    /* some more clocks */
> +    qemu_fdt_setprop_cell(fdt, "/plb", "clock-frequency",
> +                              50000000);
> +    qemu_fdt_setprop_cell(fdt, "/plb/opb", "clock-frequency",
> +                              50000000);
> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/ebc", "clock-frequency",
> +                              50000000);
> +
>     rom_add_blob_fixed(BINARY_DEVICE_TREE_FILE, fdt, fdt_size, addr);
>     g_free(fdt);
>     ret = fdt_size;
>
