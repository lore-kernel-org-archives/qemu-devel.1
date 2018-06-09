Received: from eggs.gnu.org ([2001:4830:134:3::10]:59957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRezY-0002y5-56
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 10:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRezX-00026c-2D
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 10:37:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1528554193-27270-1-git-send-email-eric.auger@redhat.com>
	<1528554193-27270-3-git-send-email-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0bdf92a5-7500-028c-5043-3d082b7051e8@amsat.org>
Date: Sat, 9 Jun 2018 11:37:09 -0300
MIME-Version: 1.0
In-Reply-To: <1528554193-27270-3-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/2] hw/arm/virt: Silence dtc
 /memory warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org

Hi Eric,

On 06/09/2018 11:23 AM, Eric Auger wrote:
> When running dtc on the guest /proc/device-tree we get the
> following warning: Warning (unit_address_vs_reg): Node /memory
> has a reg or ranges property, but no unit name".
> 
> Let's fix that by adding the unit address to the node name. We also
> don't create the /memory node anymore in create_fdt(). We directly
> create it in load_dtb. /chosen still needs to be created in create_fdt
> as the uart needs it. In case the user provided his own dtb, either
> the bank is added to the existing /memory node or if this latter is
> not found we create a new separate memory node.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/boot.c | 20 ++++++++++++++------
>  hw/arm/virt.c |  6 ------
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 1e2be20..2054670 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -593,24 +593,32 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>              g_free(nodename);
>          }
>      } else {
> +        char *nodename = g_strdup("/memory");
>          Error *err = NULL;
>  
> -        rc = fdt_path_offset(fdt, "/memory");
> +        /* If there is an existing /memory node (user provided dtb), we add the
> +         * new bank into it, otherwise we create a /memory@addr node
> +         */
> +        rc = fdt_path_offset(fdt, nodename);
>          if (rc < 0) {
> -            qemu_fdt_add_subnode(fdt, "/memory");
> +            g_free(nodename);
> +            nodename = g_strdup_printf("/memory@%" PRIx64, binfo->loader_start);
> +
> +            qemu_fdt_add_subnode(fdt, nodename);
>          }
>  
> -        if (!qemu_fdt_getprop(fdt, "/memory", "device_type", NULL, &err)) {
> -            qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
> +        if (!qemu_fdt_getprop(fdt, nodename, "device_type", NULL, &err)) {
> +            qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
>          }
>  
> -        rc = qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
> +        rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
>                                            acells, binfo->loader_start,
>                                            scells, binfo->ram_size);
>          if (rc < 0) {
> -            fprintf(stderr, "couldn't set /memory/reg\n");
> +            fprintf(stderr, "couldn't set %s reg\n", nodename);
>              goto fail;
>          }
> +        g_free(nodename);
>      }

This part looks good.

>  
>      rc = fdt_path_offset(fdt, "/chosen");
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b1e9a6b..46c5c3f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -203,13 +203,7 @@ static void create_fdt(VirtMachineState *vms)
>      qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
>      qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
>  
> -    /*
> -     * /chosen and /memory nodes must exist for load_dtb
> -     * to fill in necessary properties later
> -     */
>      qemu_fdt_add_subnode(fdt, "/chosen");

Here I think you should keep the comment, but update it (info from your
commit message).

> -    qemu_fdt_add_subnode(fdt, "/memory");
> -    qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
>  
>      /* Clock node, for the benefit of the UART. The kernel device tree
>       * binding documentation claims the PL011 node clock properties are
> 
