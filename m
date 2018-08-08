Received: from eggs.gnu.org ([2001:4830:134:3::10]:36054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fnUvn-0003Iq-S4
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fnUvk-0007N9-M9
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:19:43 -0400
Received: from chuckie.co.uk ([82.165.15.123]:41658
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fnUvk-0007Mh-Cb
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 16:19:40 -0400
References: <20180808191951.23193-1-mark.cave-ayland@ilande.co.uk>
	<20180808195334.GX23195@localhost.localdomain>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1dcbf6a5-8824-97d4-16a9-db73ce93767d@ilande.co.uk>
Date: Wed, 8 Aug 2018 21:19:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180808195334.GX23195@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: add bootdevice-ignore-suffixes
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: lersek@redhat.com, qemu-devel@nongnu.org

On 08/08/18 20:53, Eduardo Habkost wrote:

> On Wed, Aug 08, 2018 at 08:19:51PM +0100, Mark Cave-Ayland wrote:
>> For the older machines (such as Mac and SPARC) the DT nodes representing
>> bootdevices for disk nodes are irregular for mainly historical reasons.
>>
>> Since the majority of bootdevice nodes for these machines either do not have a
>> separate disk node or require different (custom) names then it is much easier
>> to disable all suffixes for a particular machine by setting the ignore_suffixes
>> parameter to get_boot_devices_list() to true, and customise the disk nodes as
>> required.
>>
>> Here we add a new bootdevice-ignore-suffixes property to the FW_CFG device to
>> allow the generation of disk suffixes to be controlled on a per-machine basis.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> But I would prefer to see this merged only after we see machines
> actually using the property.  Can you send that as a single
> series later?

I don't have any more time until tomorrow evening now, but FWIW I've 
pushed my working branch to 
https://github.com/mcayland/qemu/commits/openbios-bootindex3 if you want 
to take a quick look. Example command line:

$ ./qemu-system-sparc64 -drive 
file=disk.img,if=none,index=0,id=cd,media=cdrom -device 
virtio-blk-pci,bus=pciB,drive=cd,bootindex=0 -m 256 -nographic

Would you still like me to post this to the list properly tomorrow evening?

> Also, maybe we can do it in a simpler way:
> 
> I now see that fw_cfg is not the only user of
> get_boot_devices_list().  I didn't want to have a fw_cfg-specific
> field in MachineClass, but but we can make it not fw_cfg-specific
> if we make it affect all get_boot_devices_list() calls.
> 
> What do you think of the patch below?
> 
> (Patch is untested)
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index d139a431a6..f82f28468b 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -206,6 +206,7 @@ struct MachineClass {
>       bool auto_enable_numa_with_memhp;
>       void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
>                                    int nb_nodes, ram_addr_t size);
> +    bool ignore_boot_device_suffixes;
>   
>       HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                              DeviceState *dev);
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 76ef6196a7..8d6095d98b 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -182,7 +182,7 @@ void hmp_info_usb(Monitor *mon, const QDict *qdict);
>   
>   void add_boot_device_path(int32_t bootindex, DeviceState *dev,
>                             const char *suffix);
> -char *get_boot_devices_list(size_t *size, bool ignore_suffixes);
> +char *get_boot_devices_list(size_t *size);
>   
>   DeviceState *get_boot_device(uint32_t position);
>   void check_boot_index(int32_t bootindex, Error **errp);
> diff --git a/bootdevice.c b/bootdevice.c
> index 1141009114..1d225202f9 100644
> --- a/bootdevice.c
> +++ b/bootdevice.c
> @@ -29,6 +29,7 @@
>   #include "qemu/error-report.h"
>   #include "sysemu/reset.h"
>   #include "hw/qdev-core.h"
> +#include "hw/boards.h"
>   
>   typedef struct FWBootEntry FWBootEntry;
>   
> @@ -208,11 +209,13 @@ DeviceState *get_boot_device(uint32_t position)
>    * memory pointed by "size" is assigned total length of the array in bytes
>    *
>    */
> -char *get_boot_devices_list(size_t *size, bool ignore_suffixes)
> +char *get_boot_devices_list(size_t *size)
>   {
>       FWBootEntry *i;
>       size_t total = 0;
>       char *list = NULL;
> +    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> +    bool ignore_suffixes = mc->ignore_boot_device_suffixes;
>   
>       QTAILQ_FOREACH(i, &fw_boot_order, link) {
>           char *devpath = NULL,  *suffix = NULL;
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index b23e7f64a8..d79a568f54 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -861,7 +861,7 @@ static void fw_cfg_machine_reset(void *opaque)
>       void *ptr;
>       size_t len;
>       FWCfgState *s = opaque;
> -    char *bootindex = get_boot_devices_list(&len, false);
> +    char *bootindex = get_boot_devices_list(&len);
>   
>       ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
>       g_free(ptr);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 421b2dd09b..47bc63b085 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1160,7 +1160,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
>       const char *boot_device = machine->boot_order;
>       char *stdout_path = spapr_vio_stdout_path(spapr->vio_bus);
>       size_t cb = 0;
> -    char *bootlist = get_boot_devices_list(&cb, true);
> +    char *bootlist = get_boot_devices_list(&cb);
>   
>       _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
>   
> @@ -3950,6 +3950,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>   
>       mc->desc = "pSeries Logical Partition (PAPR compliant)";
>   
> +    mc->ignore_boot_device_suffixes = true;
>       /*
>        * We set up the default / latest behaviour here.  The class_init
>        * functions for the specific versioned machine types can override

A quick glance makes me think it should work...


ATB,

Mark.
