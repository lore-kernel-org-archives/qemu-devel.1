Received: from eggs.gnu.org ([2001:4830:134:3::10]:36164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elugP-0000xL-MM
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elugO-0000zs-MI
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 05:53:01 -0500
References: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
	<1518189456-2873-6-git-send-email-geert+renesas@glider.be>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <79b1983f-cf83-624b-bd4d-86a2b6cc25e0@redhat.com>
Date: Wed, 14 Feb 2018 11:52:32 +0100
MIME-Version: 1.0
In-Reply-To: <1518189456-2873-6-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC 5/5] hw/arm/sysbus-fdt: Enable
 rcar-gen3-gpio dynamic instantiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org

Hi Geert,

On 09/02/18 16:17, Geert Uytterhoeven wrote:
> Allow the instantiation of a Renesas R-Car Gen3 GPIO controller device
> from the QEMU command line:
> 
> -device vfio-platform,host=<device>,manufacturer=renesas,model=rcar-gen3-gpio
> -device vfio-platform,sysfsdev=<path>,manufacturer=renesas,model=rcar-gen3-gpio
> 
> A specialized device tree node is created for the guest, containing
> compatible, reg, gpio-controller, and #gpio-cells properties.
> 
> Not-Yet-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Question:
>   - Why do we need the manufacturer=foo,model=bar syntax? Can't this
>     just be extracted from the host DT?
I think this could be achieved that way too. We just need to pay
attention to the fact the dt node creation function matches the exact
same compatible property value.

> 
> TODO:
>   - Copy properties from the host DT, as add_amd_xgbe_fdt_node() does,
>   - Make this more generic?

Yes I think devising helpers to generate regs/interrupts properties
could help reducing the amount of code to be written

Thanks

Eric
> ---
>  hw/arm/sysbus-fdt.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> index c5d4fd5604c28118..428175f343d9f3b9 100644
> --- a/hw/arm/sysbus-fdt.c
> +++ b/hw/arm/sysbus-fdt.c
> @@ -416,6 +416,52 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
>      return 0;
>  }
>  
> +/**
> + * add_rcar_gpio_fdt_node
> + *
> + * Generates a simple node with following properties:
> + * compatible string, regs, #gpio-cells, gpio-controller
> + */
> +static int add_rcar_gpio_fdt_node(SysBusDevice *sbdev, void *opaque)
> +{
> +    PlatformBusFDTData *data = opaque;
> +    PlatformBusDevice *pbus = data->pbus;
> +    void *fdt = data->fdt;
> +    const char *parent_node = data->pbus_node_name;
> +    int compat_str_len, i;
> +    char *nodename;
> +    uint32_t *reg_attr;
> +    uint64_t mmio_base;
> +    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
> +
> +    mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    nodename = g_strdup_printf("%s/%s@%" PRIx64, parent_node,
> +                               vbasedev->name, mmio_base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +
> +    compat_str_len = strlen(vdev->compat) + 1;
> +    qemu_fdt_setprop(fdt, nodename, "compatible",
> +                          vdev->compat, compat_str_len);
> +
> +    qemu_fdt_setprop(fdt, nodename, "gpio-controller", NULL, 0);
> +    qemu_fdt_setprop_cells(fdt, nodename, "#gpio-cells", 2);
> +
> +    reg_attr = g_new(uint32_t, vbasedev->num_regions * 2);
> +    for (i = 0; i < vbasedev->num_regions; i++) {
> +        mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, i);
> +        reg_attr[2 * i] = cpu_to_be32(mmio_base);
> +        reg_attr[2 * i + 1] = cpu_to_be32(
> +                                memory_region_size(vdev->regions[i]->mem));
> +    }
> +    qemu_fdt_setprop(fdt, nodename, "reg", reg_attr,
> +                     vbasedev->num_regions * 2 * sizeof(uint32_t));
> +
> +    g_free(reg_attr);
> +    g_free(nodename);
> +    return 0;
> +}
> +
>  /* manufacturer/model matching */
>  static bool vfio_platform_match(SysBusDevice *sbdev,
>                                  const BindingEntry *entry)
> @@ -454,6 +500,7 @@ static const BindingEntry bindings[] = {
>      TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
>      TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
>      VFIO_PLATFORM_BINDING("amd", "xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
> +    VFIO_PLATFORM_BINDING("renesas", "rcar-gen3-gpio", add_rcar_gpio_fdt_node),
>  #endif
>      TYPE_BINDING("", NULL), /* last element */
>  };
> 
