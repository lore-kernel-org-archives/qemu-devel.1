Received: from eggs.gnu.org ([2001:4830:134:3::10]:43098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eEcYb-0004Gc-KO
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eEcYX-0008Mh-6Z
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:51:21 -0500
Date: Tue, 14 Nov 2017 15:51:01 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171114145101.sjol4obuna4kcmkp@kamzik.brq.redhat.com>
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
	<1510622154-17224-5-git-send-email-zhuyijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510622154-17224-5-git-send-email-zhuyijun@huawei.com>
Subject: Re: [Qemu-devel] [RFC 4/5] hw/arm/boot: set fdt size cell of memory
 node from mem_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhuyijun@huawei.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, zhaoshenglong@huawei.com

On Tue, Nov 14, 2017 at 09:15:53AM +0800, zhuyijun@huawei.com wrote:
> From: Zhu Yijun <zhuyijun@huawei.com>
> 
> In case of accessing memory holes, we create memory fdt node by
> traversing mem_list and adjust memory address if the addr is not
> belong to RAM memory region.
> 
> Signed-off-by: Zhu Yijun <zhuyijun@huawei.com>
> ---
>  hw/arm/boot.c | 151 ++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 109 insertions(+), 42 deletions(-)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 30438f4..f4ca599 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -384,6 +384,25 @@ static void set_kernel_args_old(const struct arm_boot_info *info)
>      }
>  }
>  
> +static char *create_memory_fdt(void *fdt, uint32_t acells, hwaddr mem_base,
> +                                          uint32_t scells, hwaddr mem_len)
> +{
> +    char *nodename = NULL;
> +    int rc;
> +
> +    nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> +    rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells, mem_base,
> +                                      scells, mem_len);
> +    if (rc < 0) {
> +        fprintf(stderr, "couldn't set %s/reg\n", nodename);
> +        g_free(nodename);
> +    }
> +
> +    return nodename;
> +}
> +
>  /**
>   * load_dtb() - load a device tree binary image into memory
>   * @addr:       the address to load the image at
> @@ -412,7 +431,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>      uint32_t acells, scells;
>      char *nodename;
>      unsigned int i;
> -    hwaddr mem_base, mem_len;
> +    RAMRegion *reg;
>  
>      if (binfo->dtb_filename) {
>          char *filename;
> @@ -464,49 +483,65 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>          goto fail;
>      }
>  
> +    /*
> +     * Turn the /memory node created before into a NOP node, then create
> +     * /memory@addr nodes for all numa nodes respectively.
> +     */
> +    qemu_fdt_nop_node(fdt, "/memory");
> +
>      if (nb_numa_nodes > 0) {
> -        /*
> -         * Turn the /memory node created before into a NOP node, then create
> -         * /memory@addr nodes for all numa nodes respectively.
> -         */
> -        qemu_fdt_nop_node(fdt, "/memory");
> -        mem_base = binfo->loader_start;
> +        hwaddr reg_offset = 0; /* region base addr offset */
> +        hwaddr reg_alloc_size = 0; /* region consumed size */
> +        hwaddr node_mem_size = 0;
> +        RAMRegion *tmp_reg = QLIST_FIRST(&binfo->mem_list);
> +
>          for (i = 0; i < nb_numa_nodes; i++) {
> -            mem_len = numa_info[i].node_mem;
> -            nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
> -            qemu_fdt_add_subnode(fdt, nodename);
> -            qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> -            rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
> -                                              acells, mem_base,
> -                                              scells, mem_len);
> -            if (rc < 0) {
> -                fprintf(stderr, "couldn't set %s/reg for node %d\n", nodename,
> -                        i);
> -                goto fail;
> -            }
> +            node_mem_size = numa_info[i].node_mem;
> +            QLIST_FOREACH(reg, &binfo->mem_list, next) {
> +                if (reg->base != tmp_reg->base) {
> +                    continue;
> +                }
>  
> -            qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", i);
> -            mem_base += mem_len;
> -            g_free(nodename);
> -        }
> -    } else {
> -        Error *err = NULL;
> +                if (node_mem_size >= (reg->size - reg_offset)) {
> +                    reg_alloc_size = reg->size - reg_offset;
> +                } else {
> +                    reg_alloc_size = node_mem_size;
> +                }
>  
> -        rc = fdt_path_offset(fdt, "/memory");
> -        if (rc < 0) {
> -            qemu_fdt_add_subnode(fdt, "/memory");
> -        }
> +                nodename = create_memory_fdt(fdt, acells,
> +                                             reg->base + reg_offset,
> +                                             scells, reg_alloc_size);
> +                if (!nodename) {
> +                    goto fail;
> +                }
> +
> +                qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", i);
> +                g_free(nodename);
>  
> -        if (!qemu_fdt_getprop(fdt, "/memory", "device_type", NULL, &err)) {
> -            qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
> +                node_mem_size -= reg_alloc_size;
> +                reg_offset += reg_alloc_size;
> +                tmp_reg = reg;
> +
> +                /* The region is depleted */
> +                if (reg->size == reg_offset) {
> +                    reg_offset = 0;
> +                    tmp_reg = QLIST_NEXT(reg, next);
> +                }
> +
> +                if (node_mem_size == 0) {
> +                    break;
> +                }
> +            }
>          }
> +    } else {
> +        QLIST_FOREACH(reg, &binfo->mem_list, next) {
> +            nodename = create_memory_fdt(fdt, acells, reg->base,
> +                                         scells, reg->size);
> +            if (!nodename) {
> +                goto fail;
> +            }
>  
> -        rc = qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
> -                                          acells, binfo->loader_start,
> -                                          scells, binfo->ram_size);
> -        if (rc < 0) {
> -            fprintf(stderr, "couldn't set /memory/reg\n");
> -            goto fail;
> +            g_free(nodename);
>          }
>      }

I think we should move the numa allocation into board specific code,
mach-virt, and we should also map dimms to numa nodes, rather than
just dividing memory up.

>  
> @@ -814,6 +849,35 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
>      return size;
>  }
>  
> +/* Find the max size memory region after info->initrd_start.
> + * TODO: we may have a corner case where the memory node size may not correctly
> + * fit into kernel/initrd/dtb Image sizes.
> + * */
> +static RAMRegion *find_initrd_memregion(const struct arm_boot_info *info,
> +                                        hwaddr *initrd_start)
> +{
> +    RAMRegion *reg, *initrd_reg = NULL;
> +    hwaddr max_size = 0;
> +    hwaddr addr = *initrd_start;
> +
> +    QLIST_FOREACH(reg, &info->mem_list, next) {
> +        if (addr < reg->base) {
> +            if (max_size < reg->size) {
> +                max_size = reg->size;
> +                *initrd_start = reg->base;
> +                initrd_reg = reg;
> +            }
> +        } else if (addr >= reg->base && addr < (reg->base + reg->size)) {
> +            if (max_size < reg->base + reg->size - addr) {
> +                max_size = reg->base + reg->size - addr;
> +                initrd_reg = reg;
> +            }
> +        }
> +    }
> +
> +    return initrd_reg;
> +}
> +
>  static void arm_load_kernel_notify(Notifier *notifier, void *data)
>  {
>      CPUState *cs;
> @@ -837,11 +901,11 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
>      assert(!(info->secure_board_setup && kvm_enabled()));
>  
>      /* If machine is not virt, the mem_list will empty. */
> -    if (QLIST_EMPTY(&vms->bootinfo.mem_list)) {
> +    if (QLIST_EMPTY(&info->mem_list)) {
>          RAMRegion *new = g_new(RAMRegion, 1);
>          new->base = info->loader_start;
>          new->size = info->ram_size;
> -        QLIST_INSERT_HEAD(&vms->bootinfo.mem_list, new, next);
> +        QLIST_INSERT_HEAD(&info->mem_list, new, next);
>      }
>  
>      info->dtb_filename = qemu_opt_get(qemu_get_machine_opts(), "dtb");
> @@ -973,14 +1037,16 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
>          uint32_t fixupcontext[FIXUP_MAX];
>  
>          if (info->initrd_filename) {
> +            RAMRegion *reg = find_initrd_memregion(info, &info->initrd_start);
> +
>              initrd_size = load_ramdisk(info->initrd_filename,
>                                         info->initrd_start,
> -                                       info->ram_size -
> +                                       reg->base + reg->size -
>                                         info->initrd_start);
>              if (initrd_size < 0) {
>                  initrd_size = load_image_targphys(info->initrd_filename,
>                                                    info->initrd_start,
> -                                                  info->ram_size -
> +                                                  reg->base + reg->size -
>                                                    info->initrd_start);
>              }
>              if (initrd_size < 0) {
> @@ -1027,7 +1093,8 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
>              }
>              fixupcontext[FIXUP_ARGPTR] = dtb_start;
>          } else {
> -            fixupcontext[FIXUP_ARGPTR] = info->loader_start + KERNEL_ARGS_ADDR;
> +            hwaddr kernel_args_addr = info->loader_start + KERNEL_ARGS_ADDR;
> +            fixupcontext[FIXUP_ARGPTR] = kernel_args_addr;

What's this unrelated change for?

>              if (info->ram_size >= (1ULL << 32)) {
>                  fprintf(stderr, "qemu: RAM size must be less than 4GB to boot"
>                          " Linux kernel using ATAGS (try passing a device tree"
> -- 
> 1.8.3.1
> 
> 
>

Thanks,
drew 
