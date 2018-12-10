Received: from eggs.gnu.org ([2001:4830:134:3::10]:35076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWOkI-0006zD-Ed
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWOkE-000387-DX
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:49:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gWOkE-00037l-4e
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:49:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 678623001FE5
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 16:49:21 +0000 (UTC)
References: <20181207170400.5129-1-philmd@redhat.com>
	<20181207170400.5129-6-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6fe1ddab-17cf-ca72-0c49-7a50cb7b1b20@redhat.com>
Date: Mon, 10 Dec 2018 17:49:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181207170400.5129-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

I can only muster some random thoughts for this one, presently:

On 12/07/18 18:03, Philippe Mathieu-Daud=C3=A9 wrote:
> $ qemu-system-x86_64 -S -monitor stdio
> (qemu) info fw_cfg
>         Type    Perm    Size    Specific   Order   Info
>    signature      RO       4                       QEMU
>           id      RO       4                       0x00000003
>         uuid      RO      16                       00000000-0000-0000-0=
000-000000000000
>     ram_size      RO       8                       0x0000000008000000
>    nographic      RO       2                       0x0000
>      nb_cpus      RO       2                       0x0001
>         numa      RO      16
>    boot_menu      RO       2                       0x0000
>     max_cpus      RO       2                       0x0001
>     file_dir      RO    2052
>  file (id 1)      RO      36                 160   etc/acpi/rsdp
>  file (id 2)      RO  131072                 130   etc/acpi/tables
>  file (id 3)      RO       4                  15   etc/boot-fail-wait
>  file (id 4)      RO      20                  40   etc/e820
>  file (id 5)      RO      31                  30   etc/smbios/smbios-an=
chor
>  file (id 6)      RO     320                  20   etc/smbios/smbios-ta=
bles
>  file (id 7)      RO       6                  90   etc/system-states
>  file (id 8)      RO    4096                 140   etc/table-loader
> file (id 10)      RO    9216                  55   genroms/kvmvapic.bin
>         uuid      RO       4  (arch spec)          01000000-0000-0000-0=
000-000000000000
>     ram_size      RO     324  (arch spec)
>    nographic      RO     121  (arch spec)
> (qemu)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hmp-commands-info.hx      |  14 +++++
>  hw/nvram/fw_cfg.c         | 115 ++++++++++++++++++++++++++++++++++++++
>  include/hw/nvram/fw_cfg.h |   2 +
>  3 files changed, 131 insertions(+)
>
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index cbee8b944d..9e86dceeb4 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -916,6 +916,20 @@ STEXI
>  @item info sev
>  @findex info sev
>  Show SEV information.
> +ETEXI
> +
> +    {
> +        .name       =3D "fw_cfg",
> +        .args_type  =3D "",
> +        .params     =3D "",
> +        .help       =3D "Display the table of the fw_cfg entries regis=
tered",
> +        .cmd        =3D hmp_info_fw_cfg,
> +    },
> +
> +STEXI
> +@item info fw_cfg
> +@findex info fw_cfg
> +Show roms.
>  ETEXI
>
>  STEXI
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 582653f07e..50525ec1dd 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -36,6 +36,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
> +#include "monitor/monitor.h"
>
>  #define FW_CFG_FILE_SLOTS_DFLT 0x20
>
> @@ -1164,3 +1165,117 @@ static void fw_cfg_register_types(void)
>  }
>
>  type_init(fw_cfg_register_types)
> +
> +static const char *fw_cfg_wellknown_entries[0x20] =3D {

(1) Using 0x20 is not wrong here (it is a well-known magic constant),
but we should refer to it by name: please refer to FW_CFG_FILE_FIRST.
(See "include/standard-headers/linux/qemu_fw_cfg.h")

> +    [FW_CFG_SIGNATURE] =3D "signature",
> +    [FW_CFG_ID] =3D "id",
> +    [FW_CFG_UUID] =3D "uuid",
> +    [FW_CFG_RAM_SIZE] =3D "ram_size",
> +    [FW_CFG_NOGRAPHIC] =3D "nographic",
> +    [FW_CFG_NB_CPUS] =3D "nb_cpus",
> +    [FW_CFG_MACHINE_ID] =3D "machine_id",
> +    [FW_CFG_KERNEL_ADDR] =3D "kernel_addr",
> +    [FW_CFG_KERNEL_SIZE] =3D "kernel_size",
> +    [FW_CFG_KERNEL_CMDLINE] =3D "kernel_cmdline",
> +    [FW_CFG_INITRD_ADDR] =3D "initrd_addr",
> +    [FW_CFG_INITRD_SIZE] =3D "initdr_size",
> +    [FW_CFG_BOOT_DEVICE] =3D "boot_device",
> +    [FW_CFG_NUMA] =3D "numa",
> +    [FW_CFG_BOOT_MENU] =3D "boot_menu",
> +    [FW_CFG_MAX_CPUS] =3D "max_cpus",
> +    [FW_CFG_KERNEL_ENTRY] =3D "kernel_entry",
> +    [FW_CFG_KERNEL_DATA] =3D "kernel_data",
> +    [FW_CFG_INITRD_DATA] =3D "initrd_data",
> +    [FW_CFG_CMDLINE_ADDR] =3D "cmdline_addr",
> +    [FW_CFG_CMDLINE_SIZE] =3D "cmdline_size",
> +    [FW_CFG_CMDLINE_DATA] =3D "cmdline_data",
> +    [FW_CFG_SETUP_ADDR] =3D "setup_addr",
> +    [FW_CFG_SETUP_SIZE] =3D "setup_size",
> +    [FW_CFG_SETUP_DATA] =3D "setup_data",
> +    [FW_CFG_FILE_DIR] =3D "file_dir",
> +};

(2) I suggest introducing a macro that generates the initializer, using
the stringify() macro from "include/qemu/compiler.h". It should go
something like

#define FW_CFG_KEY_STRINGIFY(key) [key] =3D stringify(key),

Feel free to disagree though; this set of predefined, fixed numeric keys
will never change (nor will it ever be extened), so we might as well
live with the currently proposed verbosity.

> +
> +void hmp_info_fw_cfg(Monitor *mon, const QDict *qdict)
> +{
> +    FWCfgState *s =3D fw_cfg_find();
> +    int arch, key;
> +
> +    monitor_printf(mon, "%12s %5s %7s %9s %6s %-24s\n",
> +                   "Type", "Perm", "Size", "Specific", "Order", "Info"=
);
> +    for (arch =3D 0; arch < ARRAY_SIZE(s->entries); ++arch) {
> +        for (key =3D 0; key < fw_cfg_max_entry(s); ++key) {
> +            FWCfgEntry *e =3D &s->entries[arch][key];
> +            const char *perm =3D e->allow_write ? "RW" : "RO";
> +            const char *arch_spec =3D arch ? "arch_spec" : "";
> +            char *type, *info =3D NULL;
> +
> +            if (!e->len) {
> +                continue;
> +            }
> +            if (key >=3D FW_CFG_FILE_FIRST) {
> +                int id =3D key - FW_CFG_FILE_FIRST;
> +                const char *path =3D s->files->f[id].name;
> +
> +                type =3D g_strdup_printf("file (id %d)", id);
> +                monitor_printf(mon, "%12s %5s %7d %10s %5d %-24s\n",
> +                               type, perm, e->len, arch_spec,
> +                               get_fw_cfg_order(s, path), path);
> +                g_free(type);
> +                continue;
> +            }
> +            type =3D g_strdup(fw_cfg_wellknown_entries[key]);
> +            if (!type) {
> +                type =3D g_strdup_printf("entry_%d", key);
> +            }
> +
> +            switch (key) {
> +            case FW_CFG_SIGNATURE:
> +                info =3D g_strndup((const gchar *)e->data, e->len);
> +                break;
> +            case FW_CFG_UUID:
> +                info =3D qemu_uuid_unparse_strdup((const QemuUUID *)e-=
>data);
> +                break;
> +            case FW_CFG_ID:
> +            case FW_CFG_NOGRAPHIC:
> +            case FW_CFG_NB_CPUS:
> +            case FW_CFG_BOOT_MENU:
> +            case FW_CFG_MAX_CPUS:
> +            case FW_CFG_RAM_SIZE:
> +            case FW_CFG_KERNEL_ADDR:
> +            case FW_CFG_KERNEL_SIZE:
> +            case FW_CFG_KERNEL_CMDLINE:
> +            case FW_CFG_KERNEL_ENTRY:
> +            case FW_CFG_KERNEL_DATA:
> +            case FW_CFG_INITRD_ADDR:
> +            case FW_CFG_INITRD_SIZE:
> +            case FW_CFG_INITRD_DATA:
> +            case FW_CFG_CMDLINE_ADDR:
> +            case FW_CFG_CMDLINE_SIZE:
> +            case FW_CFG_CMDLINE_DATA:
> +            case FW_CFG_SETUP_ADDR:
> +            case FW_CFG_SETUP_SIZE:
> +            case FW_CFG_SETUP_DATA:
> +                switch (e->len) {
> +                case 2:
> +                    info =3D g_strdup_printf("0x%04x", lduw_le_p(e->da=
ta));
> +                    break;
> +                case 4:
> +                    info =3D g_strdup_printf("0x%08x", ldl_le_p(e->dat=
a));
> +                    break;
> +                case 8:
> +                    info =3D g_strdup_printf("0x%016" PRIx64, ldq_le_p=
(e->data));
> +                    break;
> +                default:
> +                    break;
> +                }
> +                break;
> +            default:
> +                break;
> +            }
> +            monitor_printf(mon, "%12s %5s %7d %10s %5s %-24s\n",
> +                           type, perm, e->len, arch_spec, "", info ? i=
nfo : "");
> +            g_free(type);
> +            g_free(info);
> +        }
> +    }
> +}

(3) In general I wouldn't try to be smart here, regarding the contents.
I suggest simply dumping arrays of uint8_t values, in hex.

(4) Also I wouldn't reuse the same column for different purposes; I
think it's easier to read if a column always means the same thing, and
if it doesn't apply, it's just left blank. Something like this:

  Selector  Well-Known Numeric  Pathname  Perm  Size  Arch-Spec  Order  D=
ata

- "Selector" is the uint16 selector key
- "Well-Known Numeric" is the stringified name if the selector refers to
  a well-known numerically defined item.
- "Pathname" is the pathname for named files. Mutually exclusive with
  "Well-Known Numeric", but that's OK, IMO.
- "Arch-Spec" should be left blank, or marked as "set" with an asterisk.
- "Data" should be a hexdump of uint8_t values (normally limited to 8
  bytes, if the array is larger).

(5) I think this interface would benefit from being exposed over QMP /
JSON, and then the tabular presentation would be a separate question in
HMP.

(6) If we want bells and whistles, two optional parameters could be
considered: one for identifying one specific key to request info about
(identify by selector? well-known macro name? file pathname?), and
another param for placing a limit, different from 8, on the individual
hexdump size.


Important: these are not "requirements", just random ideas, food for
thought. I'm fine if you reject any subset of them, after consideration.
I don't intend this to spiral into feature creep; take whatever you
like.

Thanks!
Laszlo

> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index f5a6895a74..28630b2f26 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -226,4 +226,6 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>  FWCfgState *fw_cfg_find(void);
>  bool fw_cfg_dma_enabled(void *opaque);
>
> +void hmp_info_fw_cfg(Monitor *mon, const QDict *qdict);
> +
>  #endif
>
