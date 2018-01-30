Received: from eggs.gnu.org ([2001:4830:134:3::10]:36078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1egf7z-0000T9-7i
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1egf6b-0007Mq-C7
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:15:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1egf6a-0007Hu-Qa
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:14:21 -0500
References: <20180129204344.196196-1-anatol.pomozov@gmail.com>
From: Jack Schwartz <jack.schwartz@oracle.com>
Message-ID: <0052103f-9d90-fe35-eac1-b10966c829f6@oracle.com>
Date: Tue, 30 Jan 2018 15:15:17 -0800
MIME-Version: 1.0
In-Reply-To: <20180129204344.196196-1-anatol.pomozov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] multiboot: Change multiboot_info from
 array of bytes to a C struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>, qemu-devel@nongnu.org, kwolf@redhat.com

Hi Anatol and Kevin.

Even though I am new to Qemu, I have a patch to deliver for multiboot.c=20
(as you know) and so I feel familiar enough to do a review of this=20
patch.=C2=A0 One comment is probably more for maintainers.

Comments inline...


On 01/29/18 12:43, Anatol Pomozov wrote:
> Using C structs makes the code more readable and prevents type conversi=
on
> errors.
>
> Borrow multiboot1 header from GRUB project.
>
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---
>   hw/i386/multiboot.c         | 124 +++++++++------------
>   hw/i386/multiboot_header.h  | 254 +++++++++++++++++++++++++++++++++++=
+++++++++
>   tests/multiboot/mmap.c      |  14 +--
>   tests/multiboot/mmap.out    |  10 ++
>   tests/multiboot/modules.c   |  12 ++-
>   tests/multiboot/modules.out |  10 ++
>   tests/multiboot/multiboot.h |  66 ------------
>   7 files changed, 339 insertions(+), 151 deletions(-)
>   create mode 100644 hw/i386/multiboot_header.h
>   delete mode 100644 tests/multiboot/multiboot.h
>
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index c7b70c91d5..c6d05ca46b 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -28,6 +28,7 @@
>   #include "hw/hw.h"
>   #include "hw/nvram/fw_cfg.h"
>   #include "multiboot.h"
> +#include "multiboot_header.h"
>   #include "hw/loader.h"
>   #include "elf.h"
>   #include "sysemu/sysemu.h"
> @@ -47,39 +48,9 @@
>   #error multiboot struct needs to fit in 16 bit real mode
>   #endif
>  =20
> -enum {
> -    /* Multiboot info */
> -    MBI_FLAGS       =3D 0,
> -    MBI_MEM_LOWER   =3D 4,
> -    MBI_MEM_UPPER   =3D 8,
> -    MBI_BOOT_DEVICE =3D 12,
> -    MBI_CMDLINE     =3D 16,
> -    MBI_MODS_COUNT  =3D 20,
> -    MBI_MODS_ADDR   =3D 24,
> -    MBI_MMAP_ADDR   =3D 48,
> -    MBI_BOOTLOADER  =3D 64,
> -
> -    MBI_SIZE        =3D 88,
> -
> -    /* Multiboot modules */
> -    MB_MOD_START    =3D 0,
> -    MB_MOD_END      =3D 4,
> -    MB_MOD_CMDLINE  =3D 8,
> -
> -    MB_MOD_SIZE     =3D 16,
> -
> -    /* Region offsets */
> -    ADDR_E820_MAP =3D MULTIBOOT_STRUCT_ADDR + 0,
> -    ADDR_MBI      =3D ADDR_E820_MAP + 0x500,
> -
> -    /* Multiboot flags */
> -    MULTIBOOT_FLAGS_MEMORY      =3D 1 << 0,
> -    MULTIBOOT_FLAGS_BOOT_DEVICE =3D 1 << 1,
> -    MULTIBOOT_FLAGS_CMDLINE     =3D 1 << 2,
> -    MULTIBOOT_FLAGS_MODULES     =3D 1 << 3,
> -    MULTIBOOT_FLAGS_MMAP        =3D 1 << 6,
> -    MULTIBOOT_FLAGS_BOOTLOADER  =3D 1 << 9,
> -};
> +/* Region offsets */
> +#define ADDR_E820_MAP MULTIBOOT_STRUCT_ADDR
> +#define ADDR_MBI      (ADDR_E820_MAP + 0x500)
>  =20
>   typedef struct {
>       /* buffer holding kernel, cmdlines and mb_infos */
> @@ -128,14 +99,15 @@ static void mb_add_mod(MultibootState *s,
>                          hwaddr start, hwaddr end,
>                          hwaddr cmdline_phys)
>   {
> -    char *p;
> +    multiboot_module_t *mod;
>       assert(s->mb_mods_count < s->mb_mods_avail);
>  =20
> -    p =3D (char *)s->mb_buf + s->offset_mbinfo + MB_MOD_SIZE * s->mb_m=
ods_count;
> +    mod =3D s->mb_buf + s->offset_mbinfo +
> +          sizeof(multiboot_module_t) * s->mb_mods_count;
>  =20
> -    stl_p(p + MB_MOD_START,   start);
> -    stl_p(p + MB_MOD_END,     end);
> -    stl_p(p + MB_MOD_CMDLINE, cmdline_phys);
> +    stl_p(&mod->mod_start, start);
> +    stl_p(&mod->mod_end,   end);
> +    stl_p(&mod->cmdline,   cmdline_phys);
>  =20
>       mb_debug("mod%02d: "TARGET_FMT_plx" - "TARGET_FMT_plx"\n",
>                s->mb_mods_count, start, end);
> @@ -151,26 +123,29 @@ int load_multiboot(FWCfgState *fw_cfg,
>                      int kernel_file_size,
>                      uint8_t *header)
>   {
> -    int i, is_multiboot =3D 0;
> +    int i;
> +    bool is_multiboot =3D false;
>       uint32_t flags =3D 0;
>       uint32_t mh_entry_addr;
>       uint32_t mh_load_addr;
>       uint32_t mb_kernel_size;
>       MultibootState mbs;
> -    uint8_t bootinfo[MBI_SIZE];
> +    multiboot_info_t bootinfo;
>       uint8_t *mb_bootinfo_data;
>       uint32_t cmdline_len;
> +    struct multiboot_header *multiboot_header;
>  =20
>       /* Ok, let's see if it is a multiboot image.
>          The header is 12x32bit long, so the latest entry may be 8192 -=
 48. */
>       for (i =3D 0; i < (8192 - 48); i +=3D 4) {
> -        if (ldl_p(header+i) =3D=3D 0x1BADB002) {
> -            uint32_t checksum =3D ldl_p(header+i+8);
> -            flags =3D ldl_p(header+i+4);
> +        multiboot_header =3D (struct multiboot_header *)(header + i);
> +        if (ldl_p(&multiboot_header->magic) =3D=3D MULTIBOOT_HEADER_MA=
GIC) {
> +            uint32_t checksum =3D ldl_p(&multiboot_header->checksum);
> +            flags =3D ldl_p(&multiboot_header->flags);
>               checksum +=3D flags;
> -            checksum +=3D (uint32_t)0x1BADB002;
> +            checksum +=3D (uint32_t)MULTIBOOT_HEADER_MAGIC;
>               if (!checksum) {
> -                is_multiboot =3D 1;
> +                is_multiboot =3D true;
>                   break;
>               }
>           }
> @@ -180,13 +155,13 @@ int load_multiboot(FWCfgState *fw_cfg,
>           return 0; /* no multiboot */
>  =20
>       mb_debug("qemu: I believe we found a multiboot image!\n");
> -    memset(bootinfo, 0, sizeof(bootinfo));
> +    memset(&bootinfo, 0, sizeof(bootinfo));
>       memset(&mbs, 0, sizeof(mbs));
>  =20
> -    if (flags & 0x00000004) { /* MULTIBOOT_HEADER_HAS_VBE */
> +    if (flags & MULTIBOOT_VIDEO_MODE) {
>           fprintf(stderr, "qemu: multiboot knows VBE. we don't.\n");
>       }
> -    if (!(flags & 0x00010000)) { /* MULTIBOOT_HEADER_HAS_ADDR */
> +    if (!(flags & MULTIBOOT_AOUT_KLUDGE)) {
>           uint64_t elf_entry;
>           uint64_t elf_low, elf_high;
>           int kernel_size;
> @@ -217,12 +192,12 @@ int load_multiboot(FWCfgState *fw_cfg,
>           mb_debug("qemu: loading multiboot-elf kernel (%#x bytes) with=
 entry %#zx\n",
>                     mb_kernel_size, (size_t)mh_entry_addr);
>       } else {
> -        /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_ADDR. */
> -        uint32_t mh_header_addr =3D ldl_p(header+i+12);
> -        uint32_t mh_load_end_addr =3D ldl_p(header+i+20);
> -        uint32_t mh_bss_end_addr =3D ldl_p(header+i+24);
> +        /* Valid if mh_flags sets MULTIBOOT_AOUT_KLUDGE. */
> +        uint32_t mh_header_addr =3D ldl_p(&multiboot_header->header_ad=
dr);
> +        uint32_t mh_load_end_addr =3D ldl_p(&multiboot_header->load_en=
d_addr);
> +        uint32_t mh_bss_end_addr =3D ldl_p(&multiboot_header->bss_end_=
addr);
> +        mh_load_addr =3D ldl_p(&multiboot_header->load_addr);
>  =20
> -        mh_load_addr =3D ldl_p(header+i+16);
>           if (mh_header_addr < mh_load_addr) {
>               fprintf(stderr, "invalid mh_load_addr address\n");
>               exit(1);
> @@ -230,7 +205,7 @@ int load_multiboot(FWCfgState *fw_cfg,
>  =20
>           uint32_t mb_kernel_text_offset =3D i - (mh_header_addr - mh_l=
oad_addr);
>           uint32_t mb_load_size =3D 0;
> -        mh_entry_addr =3D ldl_p(header+i+28);
> +        mh_entry_addr =3D ldl_p(&multiboot_header->entry_addr);
>  =20
>           if (mh_load_end_addr) {
>               if (mh_bss_end_addr < mh_load_addr) {
> @@ -253,11 +228,11 @@ int load_multiboot(FWCfgState *fw_cfg,
>               mb_load_size =3D mb_kernel_size;
>           }
>  =20
> -        /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_VBE.
> -        uint32_t mh_mode_type =3D ldl_p(header+i+32);
> -        uint32_t mh_width =3D ldl_p(header+i+36);
> -        uint32_t mh_height =3D ldl_p(header+i+40);
> -        uint32_t mh_depth =3D ldl_p(header+i+44); */
> +        /* Valid if mh_flags sets MULTIBOOT_VIDEO_MODE.
> +        uint32_t mh_mode_type =3D ldl_p(&multiboot_header->mode_type);
> +        uint32_t mh_width =3D ldl_p(&multiboot_header->width);
> +        uint32_t mh_height =3D ldl_p(&multiboot_header->height);
> +        uint32_t mh_depth =3D ldl_p(&multiboot_header->depth); */
This question is probably more for maintainers...

In the patch series I submitted, people were OK that I was going to=20
delete these lines since they were only comments anyway.=C2=A0 Your appro=
ach=20
leaves these lines in and updates them even though they are comments.=C2=A0=
=20
Which way is preferred?
>           mb_debug("multiboot: mh_header_addr =3D %#x\n", mh_header_add=
r);
>           mb_debug("multiboot: mh_load_addr =3D %#x\n", mh_load_addr);
> @@ -295,14 +270,15 @@ int load_multiboot(FWCfgState *fw_cfg,
>       }
>  =20
>       mbs.mb_buf_size +=3D cmdline_len;
> -    mbs.mb_buf_size +=3D MB_MOD_SIZE * mbs.mb_mods_avail;
> +    mbs.mb_buf_size +=3D sizeof(multiboot_module_t) * mbs.mb_mods_avai=
l;
>       mbs.mb_buf_size +=3D strlen(bootloader_name) + 1;
>  =20
>       mbs.mb_buf_size =3D TARGET_PAGE_ALIGN(mbs.mb_buf_size);
>  =20
>       /* enlarge mb_buf to hold cmdlines, bootloader, mb-info structs *=
/
>       mbs.mb_buf            =3D g_realloc(mbs.mb_buf, mbs.mb_buf_size);
> -    mbs.offset_cmdlines   =3D mbs.offset_mbinfo + mbs.mb_mods_avail * =
MB_MOD_SIZE;
> +    mbs.offset_cmdlines   =3D mbs.offset_mbinfo +
> +        mbs.mb_mods_avail * sizeof(multiboot_module_t);
>       mbs.offset_bootloader =3D mbs.offset_cmdlines + cmdline_len;
>  =20
>       if (initrd_filename) {
> @@ -348,22 +324,22 @@ int load_multiboot(FWCfgState *fw_cfg,
>       char kcmdline[strlen(kernel_filename) + strlen(kernel_cmdline) + =
2];
>       snprintf(kcmdline, sizeof(kcmdline), "%s %s",
>                kernel_filename, kernel_cmdline);
> -    stl_p(bootinfo + MBI_CMDLINE, mb_add_cmdline(&mbs, kcmdline));
> +    stl_p(&bootinfo.cmdline, mb_add_cmdline(&mbs, kcmdline));
>  =20
> -    stl_p(bootinfo + MBI_BOOTLOADER, mb_add_bootloader(&mbs, bootloade=
r_name));
> +    stl_p(&bootinfo.boot_loader_name, mb_add_bootloader(&mbs, bootload=
er_name));
>  =20
> -    stl_p(bootinfo + MBI_MODS_ADDR,  mbs.mb_buf_phys + mbs.offset_mbin=
fo);
> -    stl_p(bootinfo + MBI_MODS_COUNT, mbs.mb_mods_count); /* mods_count=
 */
> +    stl_p(&bootinfo.mods_addr,  mbs.mb_buf_phys + mbs.offset_mbinfo);
> +    stl_p(&bootinfo.mods_count, mbs.mb_mods_count); /* mods_count */
>  =20
>       /* the kernel is where we want it to be now */
> -    stl_p(bootinfo + MBI_FLAGS, MULTIBOOT_FLAGS_MEMORY
> -                                | MULTIBOOT_FLAGS_BOOT_DEVICE
> -                                | MULTIBOOT_FLAGS_CMDLINE
> -                                | MULTIBOOT_FLAGS_MODULES
> -                                | MULTIBOOT_FLAGS_MMAP
> -                                | MULTIBOOT_FLAGS_BOOTLOADER);
> -    stl_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the -bo=
ot switch? */
> -    stl_p(bootinfo + MBI_MMAP_ADDR,   ADDR_E820_MAP);
> +    stl_p(&bootinfo.flags, MULTIBOOT_INFO_MEMORY
> +                           | MULTIBOOT_INFO_BOOTDEV
> +                           | MULTIBOOT_INFO_CMDLINE
> +                           | MULTIBOOT_INFO_MODS
> +                           | MULTIBOOT_INFO_MEM_MAP
> +                           | MULTIBOOT_INFO_BOOT_LOADER_NAME);
> +    stl_p(&bootinfo.boot_device, 0x8000ffff); /* XXX: use the -boot sw=
itch? */
> +    stl_p(&bootinfo.mmap_addr, ADDR_E820_MAP);
>  =20
>       mb_debug("multiboot: mh_entry_addr =3D %#x\n", mh_entry_addr);
>       mb_debug("           mb_buf_phys   =3D "TARGET_FMT_plx"\n", mbs.m=
b_buf_phys);
> @@ -371,7 +347,7 @@ int load_multiboot(FWCfgState *fw_cfg,
>       mb_debug("           mb_mods_count =3D %d\n", mbs.mb_mods_count);
>  =20
>       /* save bootinfo off the stack */
> -    mb_bootinfo_data =3D g_memdup(bootinfo, sizeof(bootinfo));
> +    mb_bootinfo_data =3D g_memdup(&bootinfo, sizeof(bootinfo));
>  =20
>       /* Pass variables to option rom */
>       fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, mh_entry_addr);
<snip>
> diff --git a/tests/multiboot/mmap.c b/tests/multiboot/mmap.c
> index 766b003f38..9cba8b07e0 100644
> --- a/tests/multiboot/mmap.c
> +++ b/tests/multiboot/mmap.c
> @@ -21,15 +21,17 @@
>    */
>  =20
>   #include "libc.h"
> -#include "multiboot.h"
> +#include "../../hw/i386/multiboot_header.h"
Suggestion: create a multiboot subdir under include, and put=20
multiboot_header.h and other multiboot includes there.=C2=A0 This way you=
 can=20
just #include "multiboot/multiboot_header.h" which seems cleaner to me=20
than "../../hw/i386/multiboot_header.h"
> -int test_main(uint32_t magic, struct mb_info *mbi)
> +int test_main(uint32_t magic, struct multiboot_info *mbi)
>   {
>       uintptr_t entry_addr;
> -    struct mb_mmap_entry *entry;
> +    struct multiboot_mmap_entry *entry;
>  =20
>       (void) magic;
>  =20
> +    printf("Multiboot header at %x\n\n", mbi);
> +
>       printf("Lower memory: %dk\n", mbi->mem_lower);
>       printf("Upper memory: %dk\n", mbi->mem_upper);
>  =20
> @@ -39,11 +41,11 @@ int test_main(uint32_t magic, struct mb_info *mbi)
>            entry_addr < mbi->mmap_addr + mbi->mmap_length;
>            entry_addr +=3D entry->size + 4)
>       {
> -        entry =3D (struct mb_mmap_entry*) entry_addr;
> +        entry =3D (struct multiboot_mmap_entry*) entry_addr;
>  =20
>           printf("%#llx - %#llx: type %d [entry size: %d]\n",
> -               entry->base_addr,
> -               entry->base_addr + entry->length,
> +               entry->addr,
> +               entry->addr + entry->len,
>                  entry->type,
>                  entry->size);
>       }
<snip>
>  =20
> diff --git a/tests/multiboot/modules.c b/tests/multiboot/modules.c
> index 531601fb30..a1da0ded44 100644
> --- a/tests/multiboot/modules.c
> +++ b/tests/multiboot/modules.c
> @@ -21,19 +21,21 @@
>    */
>  =20
>   #include "libc.h"
> -#include "multiboot.h"
> +#include "../../hw/i386/multiboot_header.h"
Same comment about putting multiboot_header.h into a multiboot subdir in=20
"include" subtree.

I have this same comment, as well as one other, for patch 2 sent separate=
ly.

 =C2=A0=C2=A0=C2=A0 Thanks,
 =C2=A0=C2=A0=C2=A0 Jack
> -int test_main(uint32_t magic, struct mb_info *mbi)
> +int test_main(uint32_t magic, struct multiboot_info *mbi)
>   {
> -    struct mb_module *mod;
> +    struct multiboot_mod_list *mod;
>       unsigned int i;
>  =20
>       (void) magic;
>  =20
> +    printf("Multiboot header at %x\n\n", mbi);
> +
>       printf("Module list with %d entries at %x\n",
>              mbi->mods_count, mbi->mods_addr);
>  =20
> -    for (i =3D 0, mod =3D (struct mb_module*) mbi->mods_addr;
> +    for (i =3D 0, mod =3D (struct multiboot_mod_list*) mbi->mods_addr;
>            i < mbi->mods_count;
>            i++, mod++)
>       {
> @@ -41,7 +43,7 @@ int test_main(uint32_t magic, struct mb_info *mbi)
>           unsigned int size =3D mod->mod_end - mod->mod_start;
>  =20
>           printf("[%p] Module: %x - %x (%d bytes) '%s'\n",
> -               mod, mod->mod_start, mod->mod_end, size, mod->string);
> +               mod, mod->mod_start, mod->mod_end, size, mod->cmdline);
>  =20
>           /* Print test file, but remove the newline at the end */
>           if (size < sizeof(buf)) {
>
<snip>
