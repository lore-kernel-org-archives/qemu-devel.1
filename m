Received: from eggs.gnu.org ([2001:4830:134:3::10]:33623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1eioYE-0006Vk-Eo
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1eioYD-00016X-26
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:43:46 -0500
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:33619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1eioYC-00015K-SV
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:43:44 -0500
Received: by mail-ua0-x244.google.com with SMTP id p12so19693119uad.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 13:43:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180131091217.GA3598@localhost.localdomain>
References: <20180129204344.196196-1-anatol.pomozov@gmail.com>
	<0052103f-9d90-fe35-eac1-b10966c829f6@oracle.com>
	<20180131091217.GA3598@localhost.localdomain>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Mon, 5 Feb 2018 13:43:43 -0800
Message-ID: <CAOMFOmVVQupKSnXBdS5xNvo5gOp9zXncMHi4wP9DV0URLwjf1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Jack Schwartz <jack.schwartz@oracle.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Wed, Jan 31, 2018 at 1:12 AM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 31.01.2018 um 00:15 hat Jack Schwartz geschrieben:
>> Hi Anatol and Kevin.
>>
>> Even though I am new to Qemu, I have a patch to deliver for
>> multiboot.c (as you know) and so I feel familiar enough to do a review
>> of this patch.  One comment is probably more for maintainers.
>
> The Multiboot code is essentially unmaintained. It's technically part of
> the PC/x86 subsystem, but their maintainers don't seem to care at all.
> So in order to make any progress here, I decided that I will send a
> pull request for Multiboot once we have the patches ready (as a one-time
> thing, without officially making myself the maintainer).
>
> So I am the closest thing to a maintainer that we have here, and while
> I'm familiar with some of the Multiboot-specific code, I don't really
> know the ELF code and don't have a lot of time to spend here.
>
> Therefore it's very welcome if you review the patches of each other,
> even if you're not perfectly familiar with the code, as there is
> probably noone else who could do a better review.
>
>> On 01/29/18 12:43, Anatol Pomozov wrote:
>> > @@ -253,11 +228,11 @@ int load_multiboot(FWCfgState *fw_cfg,
>> >               mb_load_size = mb_kernel_size;
>> >           }
>> > -        /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_VBE.
>> > -        uint32_t mh_mode_type = ldl_p(header+i+32);
>> > -        uint32_t mh_width = ldl_p(header+i+36);
>> > -        uint32_t mh_height = ldl_p(header+i+40);
>> > -        uint32_t mh_depth = ldl_p(header+i+44); */
>> > +        /* Valid if mh_flags sets MULTIBOOT_VIDEO_MODE.
>> > +        uint32_t mh_mode_type = ldl_p(&multiboot_header->mode_type);
>> > +        uint32_t mh_width = ldl_p(&multiboot_header->width);
>> > +        uint32_t mh_height = ldl_p(&multiboot_header->height);
>> > +        uint32_t mh_depth = ldl_p(&multiboot_header->depth); */
>> This question is probably more for maintainers...
>>
>> In the patch series I submitted, people were OK that I was going to delete
>> these lines since they were only comments anyway.  Your approach leaves
>> these lines in and updates them even though they are comments.  Which way is
>> preferred?
>
> As far as I am concerned, I honestly don't mind either way. It's
> trivial code, so we won't lose anything by removing it.

This change suppose to be a refactoring and tries to avoid functional
changes. I can remove it in a separate change.

>
> The ideal solution would be just implementing support for it, of course.
> If we wanted to do that, I think we would have to pass the values
> through fw_cfg and then set the VBE mode in the Mutiboot option rom.
>
>> >           mb_debug("multiboot: mh_header_addr = %#x\n", mh_header_addr);
>> >           mb_debug("multiboot: mh_load_addr = %#x\n", mh_load_addr);
>> > @@ -295,14 +270,15 @@ int load_multiboot(FWCfgState *fw_cfg,
>> >       }
>> >       mbs.mb_buf_size += cmdline_len;
>> > -    mbs.mb_buf_size += MB_MOD_SIZE * mbs.mb_mods_avail;
>> > +    mbs.mb_buf_size += sizeof(multiboot_module_t) * mbs.mb_mods_avail;
>> >       mbs.mb_buf_size += strlen(bootloader_name) + 1;
>> >       mbs.mb_buf_size = TARGET_PAGE_ALIGN(mbs.mb_buf_size);
>> >       /* enlarge mb_buf to hold cmdlines, bootloader, mb-info structs */
>> >       mbs.mb_buf            = g_realloc(mbs.mb_buf, mbs.mb_buf_size);
>> > -    mbs.offset_cmdlines   = mbs.offset_mbinfo + mbs.mb_mods_avail * MB_MOD_SIZE;
>> > +    mbs.offset_cmdlines   = mbs.offset_mbinfo +
>> > +        mbs.mb_mods_avail * sizeof(multiboot_module_t);
>> >       mbs.offset_bootloader = mbs.offset_cmdlines + cmdline_len;
>> >       if (initrd_filename) {
>> > @@ -348,22 +324,22 @@ int load_multiboot(FWCfgState *fw_cfg,
>> >       char kcmdline[strlen(kernel_filename) + strlen(kernel_cmdline) + 2];
>> >       snprintf(kcmdline, sizeof(kcmdline), "%s %s",
>> >                kernel_filename, kernel_cmdline);
>> > -    stl_p(bootinfo + MBI_CMDLINE, mb_add_cmdline(&mbs, kcmdline));
>> > +    stl_p(&bootinfo.cmdline, mb_add_cmdline(&mbs, kcmdline));
>> > -    stl_p(bootinfo + MBI_BOOTLOADER, mb_add_bootloader(&mbs, bootloader_name));
>> > +    stl_p(&bootinfo.boot_loader_name, mb_add_bootloader(&mbs, bootloader_name));
>> > -    stl_p(bootinfo + MBI_MODS_ADDR,  mbs.mb_buf_phys + mbs.offset_mbinfo);
>> > -    stl_p(bootinfo + MBI_MODS_COUNT, mbs.mb_mods_count); /* mods_count */
>> > +    stl_p(&bootinfo.mods_addr,  mbs.mb_buf_phys + mbs.offset_mbinfo);
>> > +    stl_p(&bootinfo.mods_count, mbs.mb_mods_count); /* mods_count */
>> >       /* the kernel is where we want it to be now */
>> > -    stl_p(bootinfo + MBI_FLAGS, MULTIBOOT_FLAGS_MEMORY
>> > -                                | MULTIBOOT_FLAGS_BOOT_DEVICE
>> > -                                | MULTIBOOT_FLAGS_CMDLINE
>> > -                                | MULTIBOOT_FLAGS_MODULES
>> > -                                | MULTIBOOT_FLAGS_MMAP
>> > -                                | MULTIBOOT_FLAGS_BOOTLOADER);
>> > -    stl_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the -boot switch? */
>> > -    stl_p(bootinfo + MBI_MMAP_ADDR,   ADDR_E820_MAP);
>> > +    stl_p(&bootinfo.flags, MULTIBOOT_INFO_MEMORY
>> > +                           | MULTIBOOT_INFO_BOOTDEV
>> > +                           | MULTIBOOT_INFO_CMDLINE
>> > +                           | MULTIBOOT_INFO_MODS
>> > +                           | MULTIBOOT_INFO_MEM_MAP
>> > +                           | MULTIBOOT_INFO_BOOT_LOADER_NAME);
>> > +    stl_p(&bootinfo.boot_device, 0x8000ffff); /* XXX: use the -boot switch? */
>> > +    stl_p(&bootinfo.mmap_addr, ADDR_E820_MAP);
>> >       mb_debug("multiboot: mh_entry_addr = %#x\n", mh_entry_addr);
>> >       mb_debug("           mb_buf_phys   = "TARGET_FMT_plx"\n", mbs.mb_buf_phys);
>> > @@ -371,7 +347,7 @@ int load_multiboot(FWCfgState *fw_cfg,
>> >       mb_debug("           mb_mods_count = %d\n", mbs.mb_mods_count);
>> >       /* save bootinfo off the stack */
>> > -    mb_bootinfo_data = g_memdup(bootinfo, sizeof(bootinfo));
>> > +    mb_bootinfo_data = g_memdup(&bootinfo, sizeof(bootinfo));
>> >       /* Pass variables to option rom */
>> >       fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, mh_entry_addr);
>> <snip>
>> > diff --git a/tests/multiboot/mmap.c b/tests/multiboot/mmap.c
>> > index 766b003f38..9cba8b07e0 100644
>> > --- a/tests/multiboot/mmap.c
>> > +++ b/tests/multiboot/mmap.c
>> > @@ -21,15 +21,17 @@
>> >    */
>> >   #include "libc.h"
>> > -#include "multiboot.h"
>> > +#include "../../hw/i386/multiboot_header.h"
>> Suggestion: create a multiboot subdir under include, and put
>> multiboot_header.h and other multiboot includes there.  This way you can
>> just #include "multiboot/multiboot_header.h" which seems cleaner to me than
>> "../../hw/i386/multiboot_header.h"
>
> Good point, but do we even have multiple header files for Multiboot to
> justify a whole subdirectory?

I do not think there is a justification for it. +1 for keeping it in "/include/"

> There is include/hw/loader.h and include/elf.h, so I would suggest that
> we add the new header as either include/hw/multiboot.h or directly
> include/multiboot.h.

There is already ./hw/i386/multiboot.h file so it is going to be
confusing to have multiple files with the same name.

I propose to rename ./hw/i386/multiboot.h to something like
./hw/i386/multiboot_loader.h or ./hw/i386/load_multiboot.h
