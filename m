Received: from eggs.gnu.org ([2001:4830:134:3::10]:50678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fnL10-0002Mo-HT
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fnL0z-0000z1-9a
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:44:26 -0400
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
	<1530602398-16127-9-git-send-email-eric.auger@redhat.com>
	<20180718160413.5c4dc514@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ff206af7-91fb-1ed7-9f92-c24980044254@redhat.com>
Date: Wed, 8 Aug 2018 11:44:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180718160413.5c4dc514@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 08/15] hw/arm/boot: introduce
 fdt_add_memory_node helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

Hi Igor,

On 07/18/2018 04:04 PM, Igor Mammedov wrote:
> On Tue,  3 Jul 2018 09:19:51 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>
>> We introduce an helper to create a memory node.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>
>> ---
>>
>> v1 -> v2:
>> - nop of existing /memory nodes was already handled
>> ---
>>  hw/arm/boot.c | 54 ++++++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 34 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index e09201c..5243a25 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -413,6 +413,36 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
>>      }
>>  }
>>  
>> +static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
>> +                               uint32_t scells, hwaddr mem_len,
>> +                               int numa_node_id)
>> +{
>> +    char *nodename = NULL;
>> +    int ret;
>> +
>> +    nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
>> +    qemu_fdt_add_subnode(fdt, nodename);
>> +    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
>> +    ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells, mem_base,
>> +                                       scells, mem_len);
>> +    if (ret < 0) {
>> +        fprintf(stderr, "couldn't set %s/reg\n", nodename);
>> +        goto out;
>> +    }
>> +    if (numa_node_id < 0) {
>> +        goto out;
>> +    }
>> +
>> +    ret = qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", numa_node_id);
>> +    if (ret < 0) {
>> +        fprintf(stderr, "couldn't set %s/numa-node-id\n", nodename);
>> +    }
>> +
>> +out:
>> +    g_free(nodename);
>> +    return ret;
>> +}
>> +
> 
> not related question from hotplug POV,
> is entry size fixed?
Sorry I don't get what entry you are referring to?
> can we estimate exact size for #slots number of dimms and reserve it in advance
> in FDT 'rom'?
Not sure I get your drift either.

patch "[RFC v3 09/15] hw/arm/boot: Expose the PC-DIMM nodes in the DT"
builds the DT nodes for each node, by enumerating the MemoryDeviceInfoList.

> 
>>  static void fdt_add_psci_node(void *fdt)
>>  {
>>      uint32_t cpu_suspend_fn;
>> @@ -492,7 +522,6 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>>      void *fdt = NULL;
>>      int size, rc, n = 0;
>>      uint32_t acells, scells;
>> -    char *nodename;
>>      unsigned int i;
>>      hwaddr mem_base, mem_len;
>>      char **node_path;
>> @@ -566,35 +595,20 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>>          mem_base = binfo->loader_start;
>>          for (i = 0; i < nb_numa_nodes; i++) {
>>              mem_len = numa_info[i].node_mem;
>> -            nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
>> -            qemu_fdt_add_subnode(fdt, nodename);
>> -            qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
>> -            rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
>> -                                              acells, mem_base,
>> -                                              scells, mem_len);
>> +            rc = fdt_add_memory_node(fdt, acells, mem_base,
>> +                                     scells, mem_len, i);
>>              if (rc < 0) {
>> -                fprintf(stderr, "couldn't set %s/reg for node %d\n", nodename,
>> -                        i);
>>                  goto fail;
>>              }
>>  
>> -            qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", i);
>>              mem_base += mem_len;
>> -            g_free(nodename);
>>          }
>>      } else {
>> -        nodename = g_strdup_printf("/memory@%" PRIx64, binfo->loader_start);
>> -        qemu_fdt_add_subnode(fdt, nodename);
>> -        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
>> -
>> -        rc = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
>> -                                          acells, binfo->loader_start,
>> -                                          scells, binfo->ram_size);
>> +        rc = fdt_add_memory_node(fdt, acells, binfo->loader_start,
>> +                                 scells, binfo->ram_size, -1);
>>          if (rc < 0) {
>> -            fprintf(stderr, "couldn't set %s reg\n", nodename);
>>              goto fail;
>>          }
>> -        g_free(nodename);
>>      }
>>  
>>      rc = fdt_path_offset(fdt, "/chosen");
> nice cleanup, but I won't stop here just yet if hotplug to be considered.
> 
> I see arm_load_dtb() as a hack called from every board
> where we dump everything that might be related to DTB regardless
> if it's generic for every board or only a board specific stuff.
> 
> Could we split it in several logical parts that do a single thing
> and preferably user only when they are actually need?
> Something along following lines:
> (cleanups/refactoring should be a separate from pcdimm series as it's self sufficient
> and it would be easier to review/merge and could simplify following up pcdimm series):
The refactoring of arm_load_dtb() may be relevant indeed but I prefer to
keep it out of the scope of this series. Please feel free to send a
separate series. As you advise, I will send this very patch separately too.

Thanks

Eric
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index e09201c..9c41efd 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @ -486,9 +486,6 @@ static void fdt_add_psci_node(void *fdt)
>      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
>  }
>  
> -int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
> -                 hwaddr addr_limit, AddressSpace *as)
> -{
> ...
> 
> @@ -1158,9 +1158,14 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
>      }
>  
>      if (!info->skip_dtb_autoload && have_dtb(info)) {
> -        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
> -            exit(1);
> -        }
> +        load_dtb_from_file() /* reuse generic machine_get_dtb() ??? */
> +        create_dtb_memory_nodes() /* non numa variant */
> +        /* move out mac-virt specific binfo->get_dtb into the board */
> +        /* move out modify_dtb() which vexpress hack into vexpress */
> +        /* move out fdt_add_psci_node() into mac-ivrt */
> +        create_dtb_initrd_kernel_nodes()
> +        dump_fdt()
> +        rom_add_blob_fixed_as()
>      }
>  }
>  
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 281ddcd..7686abf 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1285,9 +1285,12 @@ void virt_machine_done(Notifier *notifier, void *data)
>                                         vms->memmap[VIRT_PLATFORM_BUS].size,
>                                         vms->irqmap[VIRT_PLATFORM_BUS]);
>      }
> -    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
> -        exit(1);
> -    }
> +    load_dtb_from_file()/get_dtb() stuff
> +    virt_create_dtb_memory_nodes() /* incl. numa variant nad later pcdimm nodes */                         
> +    fdt_add_psci_node()                         
> +    create_dtb_initrd_kernel_nodes()                                         
> +    dump_fdt()                                                               
> +    rom_add_blob_fixed_as()
>  
>      virt_acpi_setup(vms);
>      virt_build_smbios(vms);
> 
