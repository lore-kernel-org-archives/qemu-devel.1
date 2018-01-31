Received: from eggs.gnu.org ([2001:4830:134:3::10]:49430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egoRO-0006gE-M7
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egoRI-0005J9-Md
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:12:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1egoRI-0005Ic-DO
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:12:20 -0500
Date: Wed, 31 Jan 2018 10:12:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180131091217.GA3598@localhost.localdomain>
References: <20180129204344.196196-1-anatol.pomozov@gmail.com>
	<0052103f-9d90-fe35-eac1-b10966c829f6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0052103f-9d90-fe35-eac1-b10966c829f6@oracle.com>
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
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, qemu-devel@nongnu.org

Am 31.01.2018 um 00:15 hat Jack Schwartz geschrieben:
> Hi Anatol and Kevin.
>=20
> Even though I am new to Qemu, I have a patch to deliver for
> multiboot.c (as you know) and so I feel familiar enough to do a review
> of this patch.=A0 One comment is probably more for maintainers.

The Multiboot code is essentially unmaintained. It's technically part of
the PC/x86 subsystem, but their maintainers don't seem to care at all.
So in order to make any progress here, I decided that I will send a
pull request for Multiboot once we have the patches ready (as a one-time
thing, without officially making myself the maintainer).

So I am the closest thing to a maintainer that we have here, and while
I'm familiar with some of the Multiboot-specific code, I don't really
know the ELF code and don't have a lot of time to spend here.

Therefore it's very welcome if you review the patches of each other,
even if you're not perfectly familiar with the code, as there is
probably noone else who could do a better review.

> On 01/29/18 12:43, Anatol Pomozov wrote:
> > @@ -253,11 +228,11 @@ int load_multiboot(FWCfgState *fw_cfg,
> >               mb_load_size =3D mb_kernel_size;
> >           }
> > -        /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_VBE.
> > -        uint32_t mh_mode_type =3D ldl_p(header+i+32);
> > -        uint32_t mh_width =3D ldl_p(header+i+36);
> > -        uint32_t mh_height =3D ldl_p(header+i+40);
> > -        uint32_t mh_depth =3D ldl_p(header+i+44); */
> > +        /* Valid if mh_flags sets MULTIBOOT_VIDEO_MODE.
> > +        uint32_t mh_mode_type =3D ldl_p(&multiboot_header->mode_type=
);
> > +        uint32_t mh_width =3D ldl_p(&multiboot_header->width);
> > +        uint32_t mh_height =3D ldl_p(&multiboot_header->height);
> > +        uint32_t mh_depth =3D ldl_p(&multiboot_header->depth); */
> This question is probably more for maintainers...
>=20
> In the patch series I submitted, people were OK that I was going to del=
ete
> these lines since they were only comments anyway.=A0 Your approach leav=
es
> these lines in and updates them even though they are comments.=A0 Which=
 way is
> preferred?

As far as I am concerned, I honestly don't mind either way. It's
trivial code, so we won't lose anything by removing it.

The ideal solution would be just implementing support for it, of course.
If we wanted to do that, I think we would have to pass the values
through fw_cfg and then set the VBE mode in the Mutiboot option rom.

> >           mb_debug("multiboot: mh_header_addr =3D %#x\n", mh_header_a=
ddr);
> >           mb_debug("multiboot: mh_load_addr =3D %#x\n", mh_load_addr)=
;
> > @@ -295,14 +270,15 @@ int load_multiboot(FWCfgState *fw_cfg,
> >       }
> >       mbs.mb_buf_size +=3D cmdline_len;
> > -    mbs.mb_buf_size +=3D MB_MOD_SIZE * mbs.mb_mods_avail;
> > +    mbs.mb_buf_size +=3D sizeof(multiboot_module_t) * mbs.mb_mods_av=
ail;
> >       mbs.mb_buf_size +=3D strlen(bootloader_name) + 1;
> >       mbs.mb_buf_size =3D TARGET_PAGE_ALIGN(mbs.mb_buf_size);
> >       /* enlarge mb_buf to hold cmdlines, bootloader, mb-info structs=
 */
> >       mbs.mb_buf            =3D g_realloc(mbs.mb_buf, mbs.mb_buf_size=
);
> > -    mbs.offset_cmdlines   =3D mbs.offset_mbinfo + mbs.mb_mods_avail =
* MB_MOD_SIZE;
> > +    mbs.offset_cmdlines   =3D mbs.offset_mbinfo +
> > +        mbs.mb_mods_avail * sizeof(multiboot_module_t);
> >       mbs.offset_bootloader =3D mbs.offset_cmdlines + cmdline_len;
> >       if (initrd_filename) {
> > @@ -348,22 +324,22 @@ int load_multiboot(FWCfgState *fw_cfg,
> >       char kcmdline[strlen(kernel_filename) + strlen(kernel_cmdline) =
+ 2];
> >       snprintf(kcmdline, sizeof(kcmdline), "%s %s",
> >                kernel_filename, kernel_cmdline);
> > -    stl_p(bootinfo + MBI_CMDLINE, mb_add_cmdline(&mbs, kcmdline));
> > +    stl_p(&bootinfo.cmdline, mb_add_cmdline(&mbs, kcmdline));
> > -    stl_p(bootinfo + MBI_BOOTLOADER, mb_add_bootloader(&mbs, bootloa=
der_name));
> > +    stl_p(&bootinfo.boot_loader_name, mb_add_bootloader(&mbs, bootlo=
ader_name));
> > -    stl_p(bootinfo + MBI_MODS_ADDR,  mbs.mb_buf_phys + mbs.offset_mb=
info);
> > -    stl_p(bootinfo + MBI_MODS_COUNT, mbs.mb_mods_count); /* mods_cou=
nt */
> > +    stl_p(&bootinfo.mods_addr,  mbs.mb_buf_phys + mbs.offset_mbinfo)=
;
> > +    stl_p(&bootinfo.mods_count, mbs.mb_mods_count); /* mods_count */
> >       /* the kernel is where we want it to be now */
> > -    stl_p(bootinfo + MBI_FLAGS, MULTIBOOT_FLAGS_MEMORY
> > -                                | MULTIBOOT_FLAGS_BOOT_DEVICE
> > -                                | MULTIBOOT_FLAGS_CMDLINE
> > -                                | MULTIBOOT_FLAGS_MODULES
> > -                                | MULTIBOOT_FLAGS_MMAP
> > -                                | MULTIBOOT_FLAGS_BOOTLOADER);
> > -    stl_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the -=
boot switch? */
> > -    stl_p(bootinfo + MBI_MMAP_ADDR,   ADDR_E820_MAP);
> > +    stl_p(&bootinfo.flags, MULTIBOOT_INFO_MEMORY
> > +                           | MULTIBOOT_INFO_BOOTDEV
> > +                           | MULTIBOOT_INFO_CMDLINE
> > +                           | MULTIBOOT_INFO_MODS
> > +                           | MULTIBOOT_INFO_MEM_MAP
> > +                           | MULTIBOOT_INFO_BOOT_LOADER_NAME);
> > +    stl_p(&bootinfo.boot_device, 0x8000ffff); /* XXX: use the -boot =
switch? */
> > +    stl_p(&bootinfo.mmap_addr, ADDR_E820_MAP);
> >       mb_debug("multiboot: mh_entry_addr =3D %#x\n", mh_entry_addr);
> >       mb_debug("           mb_buf_phys   =3D "TARGET_FMT_plx"\n", mbs=
.mb_buf_phys);
> > @@ -371,7 +347,7 @@ int load_multiboot(FWCfgState *fw_cfg,
> >       mb_debug("           mb_mods_count =3D %d\n", mbs.mb_mods_count=
);
> >       /* save bootinfo off the stack */
> > -    mb_bootinfo_data =3D g_memdup(bootinfo, sizeof(bootinfo));
> > +    mb_bootinfo_data =3D g_memdup(&bootinfo, sizeof(bootinfo));
> >       /* Pass variables to option rom */
> >       fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, mh_entry_addr);
> <snip>
> > diff --git a/tests/multiboot/mmap.c b/tests/multiboot/mmap.c
> > index 766b003f38..9cba8b07e0 100644
> > --- a/tests/multiboot/mmap.c
> > +++ b/tests/multiboot/mmap.c
> > @@ -21,15 +21,17 @@
> >    */
> >   #include "libc.h"
> > -#include "multiboot.h"
> > +#include "../../hw/i386/multiboot_header.h"
> Suggestion: create a multiboot subdir under include, and put
> multiboot_header.h and other multiboot includes there.=A0 This way you =
can
> just #include "multiboot/multiboot_header.h" which seems cleaner to me =
than
> "../../hw/i386/multiboot_header.h"

Good point, but do we even have multiple header files for Multiboot to
justify a whole subdirectory?

There is include/hw/loader.h and include/elf.h, so I would suggest that
we add the new header as either include/hw/multiboot.h or directly
include/multiboot.h.

Kevin
