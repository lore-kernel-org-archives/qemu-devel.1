Received: from eggs.gnu.org ([2001:4830:134:3::10]:47117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWHhy-0002E6-Ee
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWHhv-0002su-7v
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:18:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWHhu-0002qc-Uz
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:18:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so10120982wmh.1
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 01:18:30 -0800 (PST)
References: <20181207170400.5129-1-philmd@redhat.com>
	<20181207170400.5129-6-philmd@redhat.com>
	<20181207124425-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <682e51c1-443f-4cbe-83ae-06f742d9913a@redhat.com>
Date: Mon, 10 Dec 2018 10:18:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181207124425-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/nvram/fw_cfg: Add HMP 'info fw_cfg'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 12/7/18 6:54 PM, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 06:03:59PM +0100, Philippe Mathieu-Daudé wrote:
>> $ qemu-system-x86_64 -S -monitor stdio
>> (qemu) info fw_cfg
>>         Type    Perm    Size    Specific   Order   Info
> 
> Can we do better than "Info"?

For some entry this is the "content", but for the files this is the
"path". Do you prefer "Content or path"?

> 
>>    signature      RO       4                       QEMU
>>           id      RO       4                       0x00000003
>>         uuid      RO      16                       00000000-0000-0000-0000-000000000000
>>     ram_size      RO       8                       0x0000000008000000
>>    nographic      RO       2                       0x0000
>>      nb_cpus      RO       2                       0x0001
>>         numa      RO      16
>>    boot_menu      RO       2                       0x0000
>>     max_cpus      RO       2                       0x0001
>>     file_dir      RO    2052
>>  file (id 1)      RO      36                 160   etc/acpi/rsdp
>>  file (id 2)      RO  131072                 130   etc/acpi/tables
>>  file (id 3)      RO       4                  15   etc/boot-fail-wait
>>  file (id 4)      RO      20                  40   etc/e820
>>  file (id 5)      RO      31                  30   etc/smbios/smbios-anchor
>>  file (id 6)      RO     320                  20   etc/smbios/smbios-tables
>>  file (id 7)      RO       6                  90   etc/system-states
>>  file (id 8)      RO    4096                 140   etc/table-loader
>> file (id 10)      RO    9216                  55   genroms/kvmvapic.bin
>>         uuid      RO       4  (arch spec)          01000000-0000-0000-0000-000000000000
>>     ram_size      RO     324  (arch spec)
>>    nographic      RO     121  (arch spec)
> 
> Weird. Your code has arch_spec.

Hmmm I'll check that.

> 
>> (qemu)
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> 
> Looks helpful but generally IMHO whatever is exposed through hmp
> should be in the qmp as well.

OK.

> 
> 
>> ---
>>  hmp-commands-info.hx      |  14 +++++
>>  hw/nvram/fw_cfg.c         | 115 ++++++++++++++++++++++++++++++++++++++
>>  include/hw/nvram/fw_cfg.h |   2 +
>>  3 files changed, 131 insertions(+)
>>
>> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
>> index cbee8b944d..9e86dceeb4 100644
>> --- a/hmp-commands-info.hx
>> +++ b/hmp-commands-info.hx
>> @@ -916,6 +916,20 @@ STEXI
>>  @item info sev
>>  @findex info sev
>>  Show SEV information.
>> +ETEXI
>> +
>> +    {
>> +        .name       = "fw_cfg",
>> +        .args_type  = "",
>> +        .params     = "",
>> +        .help       = "Display the table of the fw_cfg entries registered",
> 
> I think the help line should be a bit more verbose.
> Mention it's a paravirtualized interface, and why
> would one want to display it (debugging guest firmware?).

OK.

> 
> 
>> +        .cmd        = hmp_info_fw_cfg,
>> +    },
>> +
>> +STEXI
>> +@item info fw_cfg
>> +@findex info fw_cfg
>> +Show roms.
>>  ETEXI
>>  
>>  STEXI
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 582653f07e..50525ec1dd 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -36,6 +36,7 @@
>>  #include "qemu/config-file.h"
>>  #include "qemu/cutils.h"
>>  #include "qapi/error.h"
>> +#include "monitor/monitor.h"
>>  
>>  #define FW_CFG_FILE_SLOTS_DFLT 0x20
>>  
>> @@ -1164,3 +1165,117 @@ static void fw_cfg_register_types(void)
>>  }
>>  
>>  type_init(fw_cfg_register_types)
>> +
>> +static const char *fw_cfg_wellknown_entries[0x20] = {
>> +    [FW_CFG_SIGNATURE] = "signature",
>> +    [FW_CFG_ID] = "id",
>> +    [FW_CFG_UUID] = "uuid",
>> +    [FW_CFG_RAM_SIZE] = "ram_size",
>> +    [FW_CFG_NOGRAPHIC] = "nographic",
>> +    [FW_CFG_NB_CPUS] = "nb_cpus",
>> +    [FW_CFG_MACHINE_ID] = "machine_id",
>> +    [FW_CFG_KERNEL_ADDR] = "kernel_addr",
>> +    [FW_CFG_KERNEL_SIZE] = "kernel_size",
>> +    [FW_CFG_KERNEL_CMDLINE] = "kernel_cmdline",
>> +    [FW_CFG_INITRD_ADDR] = "initrd_addr",
>> +    [FW_CFG_INITRD_SIZE] = "initdr_size",
>> +    [FW_CFG_BOOT_DEVICE] = "boot_device",
>> +    [FW_CFG_NUMA] = "numa",
>> +    [FW_CFG_BOOT_MENU] = "boot_menu",
>> +    [FW_CFG_MAX_CPUS] = "max_cpus",
>> +    [FW_CFG_KERNEL_ENTRY] = "kernel_entry",
>> +    [FW_CFG_KERNEL_DATA] = "kernel_data",
>> +    [FW_CFG_INITRD_DATA] = "initrd_data",
>> +    [FW_CFG_CMDLINE_ADDR] = "cmdline_addr",
>> +    [FW_CFG_CMDLINE_SIZE] = "cmdline_size",
>> +    [FW_CFG_CMDLINE_DATA] = "cmdline_data",
>> +    [FW_CFG_SETUP_ADDR] = "setup_addr",
>> +    [FW_CFG_SETUP_SIZE] = "setup_size",
>> +    [FW_CFG_SETUP_DATA] = "setup_data",
>> +    [FW_CFG_FILE_DIR] = "file_dir",
>> +};
>> +
>> +void hmp_info_fw_cfg(Monitor *mon, const QDict *qdict)
>> +{
>> +    FWCfgState *s = fw_cfg_find();
>> +    int arch, key;
> 
> Looks like this will crash on a machine without fw cfg.

Oops, good catch :)

> 
> 
>> +
>> +    monitor_printf(mon, "%12s %5s %7s %9s %6s %-24s\n",
>> +                   "Type", "Perm", "Size", "Specific", "Order", "Info");
>> +    for (arch = 0; arch < ARRAY_SIZE(s->entries); ++arch) {
>> +        for (key = 0; key < fw_cfg_max_entry(s); ++key) {
>> +            FWCfgEntry *e = &s->entries[arch][key];
>> +            const char *perm = e->allow_write ? "RW" : "RO";
>> +            const char *arch_spec = arch ? "arch_spec" : "";
>> +            char *type, *info = NULL;
>> +
>> +            if (!e->len) {
>> +                continue;
>> +            }
>> +            if (key >= FW_CFG_FILE_FIRST) {
>> +                int id = key - FW_CFG_FILE_FIRST;
>> +                const char *path = s->files->f[id].name;
>> +
>> +                type = g_strdup_printf("file (id %d)", id);
>> +                monitor_printf(mon, "%12s %5s %7d %10s %5d %-24s\n",
>> +                               type, perm, e->len, arch_spec,
>> +                               get_fw_cfg_order(s, path), path);
>> +                g_free(type);
>> +                continue;
>> +            }
>> +            type = g_strdup(fw_cfg_wellknown_entries[key]);
>> +            if (!type) {
>> +                type = g_strdup_printf("entry_%d", key);
>> +            }
>> +
>> +            switch (key) {
>> +            case FW_CFG_SIGNATURE:
>> +                info = g_strndup((const gchar *)e->data, e->len);
>> +                break;
>> +            case FW_CFG_UUID:
>> +                info = qemu_uuid_unparse_strdup((const QemuUUID *)e->data);
>> +                break;
>> +            case FW_CFG_ID:
>> +            case FW_CFG_NOGRAPHIC:
>> +            case FW_CFG_NB_CPUS:
>> +            case FW_CFG_BOOT_MENU:
>> +            case FW_CFG_MAX_CPUS:
>> +            case FW_CFG_RAM_SIZE:
>> +            case FW_CFG_KERNEL_ADDR:
>> +            case FW_CFG_KERNEL_SIZE:
>> +            case FW_CFG_KERNEL_CMDLINE:
>> +            case FW_CFG_KERNEL_ENTRY:
>> +            case FW_CFG_KERNEL_DATA:
>> +            case FW_CFG_INITRD_ADDR:
>> +            case FW_CFG_INITRD_SIZE:
>> +            case FW_CFG_INITRD_DATA:
>> +            case FW_CFG_CMDLINE_ADDR:
>> +            case FW_CFG_CMDLINE_SIZE:
>> +            case FW_CFG_CMDLINE_DATA:
>> +            case FW_CFG_SETUP_ADDR:
>> +            case FW_CFG_SETUP_SIZE:
>> +            case FW_CFG_SETUP_DATA:
>> +                switch (e->len) {
>> +                case 2:
>> +                    info = g_strdup_printf("0x%04x", lduw_le_p(e->data));
>> +                    break;
>> +                case 4:
>> +                    info = g_strdup_printf("0x%08x", ldl_le_p(e->data));
>> +                    break;
>> +                case 8:
>> +                    info = g_strdup_printf("0x%016" PRIx64, ldq_le_p(e->data));
>> +                    break;
>> +                default:
>> +                    break;
>> +                }
>> +                break;
>> +            default:
>> +                break;
>> +            }
>> +            monitor_printf(mon, "%12s %5s %7d %10s %5s %-24s\n",
>> +                           type, perm, e->len, arch_spec, "", info ? info : "");
>> +            g_free(type);
>> +            g_free(info);
>> +        }
>> +    }
>> +}
>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>> index f5a6895a74..28630b2f26 100644
>> --- a/include/hw/nvram/fw_cfg.h
>> +++ b/include/hw/nvram/fw_cfg.h
>> @@ -226,4 +226,6 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>>  FWCfgState *fw_cfg_find(void);
>>  bool fw_cfg_dma_enabled(void *opaque);
>>  
>> +void hmp_info_fw_cfg(Monitor *mon, const QDict *qdict);
>> +
>>  #endif
>> -- 
>> 2.17.2
