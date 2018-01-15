Received: from eggs.gnu.org ([2001:4830:134:3::10]:42256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eb6t9-00059m-Nv
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eb6t6-00087S-I0
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:41:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eb6t6-00086V-3w
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:41:28 -0500
Date: Mon, 15 Jan 2018 16:41:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180115154118.GI32271@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-4-anatol.pomozov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012235439.19457-4-anatol.pomozov@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] multiboot: load elf sections and
 section headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, agraf@suse.de, pbonzini@redhat.com, rth@twiddle.net

Am 13.10.2017 um 01:54 hat Anatol Pomozov geschrieben:
> Multiboot may load section headers and all sections (even those that are
> not part of any segment) to target memory.
> 
> Tested with an ELF application that uses data from strings table
> section.
> 
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---
>  hw/core/loader.c                         |   8 +--
>  hw/i386/multiboot.c                      |  83 +++++++++++++-----------
>  hw/s390x/ipl.c                           |   2 +-
>  include/hw/elf_ops.h                     | 107 ++++++++++++++++++++++++++++++-
>  include/hw/loader.h                      |  11 +++-
>  tests/multiboot/Makefile                 |   8 ++-
>  tests/multiboot/generate_sections_out.py |  33 ++++++++++
>  tests/multiboot/modules.out              |  22 +++----
>  tests/multiboot/run_test.sh              |   6 +-
>  tests/multiboot/sections.c               |  55 ++++++++++++++++
>  tests/multiboot/start.S                  |   2 +-
>  11 files changed, 276 insertions(+), 61 deletions(-)
>  create mode 100755 tests/multiboot/generate_sections_out.py
>  create mode 100644 tests/multiboot/sections.c
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 4593061445..a8787f7685 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -439,7 +439,7 @@ int load_elf_as(const char *filename,
>  {
>      return load_elf_ram(filename, translate_fn, translate_opaque,
>                          pentry, lowaddr, highaddr, big_endian, elf_machine,
> -                        clear_lsb, data_swab, as, true);
> +                        clear_lsb, data_swab, as, true, NULL);
>  }
>  
>  /* return < 0 if error, otherwise the number of bytes loaded in memory */
> @@ -448,7 +448,7 @@ int load_elf_ram(const char *filename,
>                   void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
>                   uint64_t *highaddr, int big_endian, int elf_machine,
>                   int clear_lsb, int data_swab, AddressSpace *as,
> -                 bool load_rom)
> +                 bool load_rom, SectionsData *sections)
>  {
>      int fd, data_order, target_data_order, must_swab, ret = ELF_LOAD_FAILED;
>      uint8_t e_ident[EI_NIDENT];
> @@ -488,11 +488,11 @@ int load_elf_ram(const char *filename,
>      if (e_ident[EI_CLASS] == ELFCLASS64) {
>          ret = load_elf64(filename, fd, translate_fn, translate_opaque, must_swab,
>                           pentry, lowaddr, highaddr, elf_machine, clear_lsb,
> -                         data_swab, as, load_rom);
> +                         data_swab, as, load_rom, sections);
>      } else {
>          ret = load_elf32(filename, fd, translate_fn, translate_opaque, must_swab,
>                           pentry, lowaddr, highaddr, elf_machine, clear_lsb,
> -                         data_swab, as, load_rom);
> +                         data_swab, as, load_rom, sections);
>      }
>  
>   fail:
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index 7dacd6d827..841d05160a 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -125,7 +125,7 @@ int load_multiboot(FWCfgState *fw_cfg,
>  {
>      int i;
>      bool is_multiboot = false;
> -    uint32_t flags = 0;
> +    uint32_t flags = 0, bootinfo_flags = 0;
>      uint32_t mh_entry_addr;
>      uint32_t mh_load_addr;
>      uint32_t mb_kernel_size;
> @@ -134,6 +134,7 @@ int load_multiboot(FWCfgState *fw_cfg,
>      uint8_t *mb_bootinfo_data;
>      uint32_t cmdline_len;
>      struct multiboot_header *multiboot_header;
> +    SectionsData sections;
>  
>      /* Ok, let's see if it is a multiboot image.
>         The header is 12x32bit long, so the latest entry may be 8192 - 48. */
> @@ -161,37 +162,8 @@ int load_multiboot(FWCfgState *fw_cfg,
>      if (flags & MULTIBOOT_VIDEO_MODE) {
>          fprintf(stderr, "qemu: multiboot knows VBE. we don't.\n");
>      }
> -    if (!(flags & MULTIBOOT_AOUT_KLUDGE)) {
> -        uint64_t elf_entry;
> -        uint64_t elf_low, elf_high;
> -        int kernel_size;
> -        fclose(f);
>  
> -        if (((struct elf64_hdr*)header)->e_machine == EM_X86_64) {
> -            fprintf(stderr, "Cannot load x86-64 image, give a 32bit one.\n");
> -            exit(1);
> -        }

I'm not sure why you're reversing the condition and moving this branch
down, but in the code movements the EM_X86_64 check got lost. Please
keep it, we don't support 64 bit ELFs at the moment. If you want to
change this, it should be a separate patch.

> -        kernel_size = load_elf(kernel_filename, NULL, NULL, &elf_entry,
> -                               &elf_low, &elf_high, 0, EM_NONE,
> -                               0, 0);
> -        if (kernel_size < 0) {
> -            fprintf(stderr, "Error while loading elf kernel\n");
> -            exit(1);
> -        }
> -        mh_load_addr = elf_low;
> -        mb_kernel_size = elf_high - elf_low;
> -        mh_entry_addr = elf_entry;
> -
> -        mbs.mb_buf = g_malloc(mb_kernel_size);
> -        if (rom_copy(mbs.mb_buf, mh_load_addr, mb_kernel_size) != mb_kernel_size) {
> -            fprintf(stderr, "Error while fetching elf kernel from rom\n");
> -            exit(1);
> -        }
> -
> -        mb_debug("qemu: loading multiboot-elf kernel (%#x bytes) with entry %#zx\n",
> -                  mb_kernel_size, (size_t)mh_entry_addr);
> -    } else {
> +    if (flags & MULTIBOOT_AOUT_KLUDGE) {
>          /* Valid if mh_flags sets MULTIBOOT_AOUT_KLUDGE. */
>          uint32_t mh_header_addr = ldl_p(&multiboot_header->header_addr);
>          uint32_t mh_load_end_addr = ldl_p(&multiboot_header->load_end_addr);
> @@ -228,12 +200,6 @@ int load_multiboot(FWCfgState *fw_cfg,
>              mb_load_size = mb_kernel_size;
>          }
>  
> -        /* Valid if mh_flags sets MULTIBOOT_VIDEO_MODE.
> -        uint32_t mh_mode_type = ldl_p(&multiboot_header->mode_type);
> -        uint32_t mh_width = ldl_p(&multiboot_header->width);
> -        uint32_t mh_height = ldl_p(&multiboot_header->height);
> -        uint32_t mh_depth = ldl_p(&multiboot_header->depth); */
> -
>          mb_debug("multiboot: mh_header_addr = %#x\n", mh_header_addr);
>          mb_debug("multiboot: mh_load_addr = %#x\n", mh_load_addr);
>          mb_debug("multiboot: mh_load_end_addr = %#x\n", mh_load_end_addr);
> @@ -248,9 +214,45 @@ int load_multiboot(FWCfgState *fw_cfg,
>              exit(1);
>          }
>          memset(mbs.mb_buf + mb_load_size, 0, mb_kernel_size - mb_load_size);
> -        fclose(f);
> +    } else {
> +        uint64_t elf_entry;
> +        uint64_t elf_low, elf_high;
> +        int kernel_size;
> +
> +        kernel_size = load_elf_ram(kernel_filename, NULL, NULL, &elf_entry,
> +                               &elf_low, &elf_high, 0, I386_ELF_MACHINE,
> +                               0, 0, NULL, true, &sections);
> +        if (kernel_size < 0) {
> +            fprintf(stderr, "Error while loading elf kernel\n");
> +            exit(1);
> +        }
> +        mh_load_addr = elf_low;
> +        mb_kernel_size = elf_high - elf_low;
> +        mh_entry_addr = elf_entry;
> +
> +        mbs.mb_buf = g_malloc(mb_kernel_size);
> +        if (rom_copy(mbs.mb_buf, mh_load_addr, mb_kernel_size) != mb_kernel_size) {
> +            fprintf(stderr, "Error while fetching elf kernel from rom\n");
> +            exit(1);
> +        }
> +
> +        mb_debug("qemu: loading multiboot-elf kernel (%#x bytes) with entry %#zx\n",
> +                  mb_kernel_size, (size_t)mh_entry_addr);
> +
> +        stl_p(&bootinfo.u.elf_sec.num, sections.num);
> +        stl_p(&bootinfo.u.elf_sec.size, sections.size);
> +        stl_p(&bootinfo.u.elf_sec.addr, sections.addr);
> +        stl_p(&bootinfo.u.elf_sec.shndx, sections.shndx);
> +
> +        bootinfo_flags |= MULTIBOOT_INFO_ELF_SHDR;
>      }
>  
> +    /* Valid if mh_flags sets MULTIBOOT_VIDEO_MODE.
> +    uint32_t mh_mode_type = ldl_p(&multiboot_header->mode_type);
> +    uint32_t mh_width = ldl_p(&multiboot_header->width);
> +    uint32_t mh_height = ldl_p(&multiboot_header->height);
> +    uint32_t mh_depth = ldl_p(&multiboot_header->depth); */
> +
>      mbs.mb_buf_phys = mh_load_addr;
>  
>      mbs.mb_buf_size = TARGET_PAGE_ALIGN(mb_kernel_size);
> @@ -332,7 +334,8 @@ int load_multiboot(FWCfgState *fw_cfg,
>      stl_p(&bootinfo.mods_count, mbs.mb_mods_count); /* mods_count */
>  
>      /* the kernel is where we want it to be now */
> -    stl_p(&bootinfo.flags, MULTIBOOT_INFO_MEMORY
> +    stl_p(&bootinfo.flags, bootinfo_flags
> +                           | MULTIBOOT_INFO_MEMORY
>                             | MULTIBOOT_INFO_BOOTDEV
>                             | MULTIBOOT_INFO_CMDLINE
>                             | MULTIBOOT_INFO_MODS
> @@ -365,5 +368,7 @@ int load_multiboot(FWCfgState *fw_cfg,
>      option_rom[nb_option_roms].bootindex = 0;
>      nb_option_roms++;
>  
> +    fclose(f);
> +
>      return 1; /* yes, we are multiboot */
>  }
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 0d06fc12b6..4d9cc6261a 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -327,7 +327,7 @@ static int load_netboot_image(Error **errp)
>      }
>  
>      img_size = load_elf_ram(netboot_filename, NULL, NULL, &ipl->start_addr,
> -                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false);
> +                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false, NULL);
>  
>      if (img_size < 0) {
>          img_size = load_image_size(netboot_filename, ram_ptr, ram_size);
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index d192e7e2a3..7a7f7983a4 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h

The code in this file is rather old and not quite compliant with the
QEMU coding style. This is not an excuse not to apply the correct coding
style to new additions to the file:

> @@ -264,12 +264,13 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>                                int must_swab, uint64_t *pentry,
>                                uint64_t *lowaddr, uint64_t *highaddr,
>                                int elf_machine, int clear_lsb, int data_swab,
> -                              AddressSpace *as, bool load_rom)
> +                              AddressSpace *as, bool load_rom,
> +                              SectionsData *sections)
>  {
>      struct elfhdr ehdr;
>      struct elf_phdr *phdr = NULL, *ph;
>      int size, i, total_size;
> -    elf_word mem_size, file_size;
> +    elf_word mem_size, file_size, sec_size;
>      uint64_t addr, low = (uint64_t)-1, high = 0;
>      uint8_t *data = NULL;
>      char label[128];
> @@ -481,6 +482,108 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>          }
>      }
>      g_free(phdr);
> +
> +    if (sections) {
> +        struct elf_shdr *shdr = NULL, *sh;
> +        int shsize;
> +
> +        // user requested loading all ELF sections

Please use C-style comments: /* ... */

> +        shsize = ehdr.e_shnum * sizeof(shdr[0]);
> +        if (lseek(fd, ehdr.e_shoff, SEEK_SET) != ehdr.e_shoff) {
> +            goto fail;
> +        }
> +        shdr = g_malloc0(shsize);
> +        if (!shdr)
> +            goto fail;

g_malloc0() never returns NULL. If you want it to return NULL instead of
aborting qemu when the allocation fails, you need g_try_malloc0().

Also, the QEMU coding style requires braces after an if condition. I'm
mentioning this only here, but it applies to multiple places in the
whole patch.

> +        if (read(fd, shdr, shsize) != shsize)
> +            goto fail;
> +        if (must_swab) {
> +            for (i = 0; i < ehdr.e_shnum; i++) {
> +                sh = &shdr[i];
> +                glue(bswap_shdr, SZ)(sh);
> +            }
> +        }
> +
> +        for(i = 0; i < ehdr.e_shnum; i++) {

A space character is required between for and the bracket.

> +            sh = &shdr[i];
> +            if (sh->sh_type == SHT_NULL)
> +                continue;
> +            // if section has address then it is loaded (XXX: is it true?), no need to load it again

This exceeds the limit of 80 characters per line.

> +            if (sh->sh_addr)
> +                continue;
> +
> +            // append section data at the end of the loaded segments
> +            addr = ROUND_UP(high, sh->sh_addralign);
> +            sh->sh_addr = addr;
> +
> +            sec_size = sh->sh_size; /* Size of the section data */
> +            data = g_malloc0(sec_size);
> +            if (sec_size > 0) {
> +                if (lseek(fd, sh->sh_offset, SEEK_SET) < 0) {
> +                    goto fail;
> +                }
> +                if (read(fd, data, sec_size) != sec_size) {
> +                    goto fail;
> +                }
> +            }
> +
> +            // As these sections are not loadable no need to perform reloaction
> +            // using translate_fn()
> +
> +            if (data_swab) {
> +                int j;
> +                for (j = 0; j < sec_size; j += (1 << data_swab)) {

Is sec_size guaranteed to be aligned? I don't see a check to verify
this. Otherwise, could we call bswap64() on the last byte of section,
accessing seven more bytes outside the allocated buffer?

> +                    uint8_t *dp = data + j;
> +                    switch (data_swab) {
> +                    case (1):

Why 'case (1):' instead of 'case 1:' looks odd.

> +                        *(uint16_t *)dp = bswap16(*(uint16_t *)dp);
> +                        break;
> +                    case (2):
> +                        *(uint32_t *)dp = bswap32(*(uint32_t *)dp);
> +                        break;
> +                    case (3):
> +                        *(uint64_t *)dp = bswap64(*(uint64_t *)dp);
> +                        break;
> +                    default:
> +                        g_assert_not_reached();
> +                    }
> +                }
> +            }
> +
> +            if (load_rom) {
> +                snprintf(label, sizeof(label), "shdr #%d: %s", i, name);
> +
> +                /* rom_add_elf_program() seize the ownership of 'data' */
> +                rom_add_elf_program(label, data, sec_size, sec_size, addr, as);
> +            } else {
> +                cpu_physical_memory_write(addr, data, sec_size);
> +                g_free(data);
> +            }
> +
> +            total_size += sec_size;
> +            high = addr + sec_size;
> +
> +            data = NULL;
> +        }
> +
> +        sections->num = ehdr.e_shnum;
> +        sections->size = ehdr.e_shentsize;
> +        sections->addr = high; // Address where we load the sections header
> +        sections->shndx = ehdr.e_shstrndx;
> +
> +        // Append section headers at the end of loaded segments/sections
> +        if (load_rom) {
> +            snprintf(label, sizeof(label), "shdrs");
> +
> +            /* rom_add_elf_program() seize the ownership of 'shdr' */
> +            rom_add_elf_program(label, shdr, shsize, shsize, high, as);
> +        } else {
> +            cpu_physical_memory_write(high, shdr, shsize);
> +            g_free(shdr);
> +        }
> +        high += shsize;
> +    }
> +
>      if (lowaddr)
>          *lowaddr = (uint64_t)(elf_sword)low;
>      if (highaddr)
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 355fe0f5a2..3cf2d6da0f 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -65,6 +65,13 @@ int load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz);
>  #define ELF_LOAD_WRONG_ENDIAN -4
>  const char *load_elf_strerror(int error);
>  
> +typedef struct {
> +    uint32_t num; // number of loaded sections
> +    uint32_t size; // size of entry in sections header list
> +    uint32_t addr; // address of loaded sections header
> +    uint32_t shndx; // number of section that contains string table
> +} SectionsData;
> +
>  /** load_elf_ram:
>   * @filename: Path of ELF file
>   * @translate_fn: optional function to translate load addresses
> @@ -82,6 +89,8 @@ const char *load_elf_strerror(int error);
>   * @as: The AddressSpace to load the ELF to. The value of address_space_memory
>   *      is used if nothing is supplied here.
>   * @load_rom : Load ELF binary as ROM
> + * @sections: If parameter is non-NULL then all ELF sections loaded into memory
> + *      and this structure is populated.
>   *
>   * Load an ELF file's contents to the emulated system's address space.
>   * Clients may optionally specify a callback to perform address
> @@ -99,7 +108,7 @@ int load_elf_ram(const char *filename,
>                   void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr,
>                   uint64_t *highaddr, int big_endian, int elf_machine,
>                   int clear_lsb, int data_swab, AddressSpace *as,
> -                 bool load_rom);
> +                 bool load_rom, SectionsData *sections);
>  
>  /** load_elf_as:
>   * Same as load_elf_ram(), but always loads the elf as ROM
> diff --git a/tests/multiboot/Makefile b/tests/multiboot/Makefile
> index 36f01dc647..b6a5056347 100644
> --- a/tests/multiboot/Makefile
> +++ b/tests/multiboot/Makefile
> @@ -6,7 +6,7 @@ LD=ld
>  LDFLAGS=-melf_i386 -T link.ld
>  LIBS=$(shell $(CC) $(CCFLAGS) -print-libgcc-file-name)
>  
> -all: mmap.elf modules.elf
> +all: mmap.elf modules.elf sections.elf sections.out
>  
>  mmap.elf: start.o mmap.o libc.o
>  	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
> @@ -14,6 +14,12 @@ mmap.elf: start.o mmap.o libc.o
>  modules.elf: start.o modules.o libc.o
>  	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
>  
> +sections.elf: start.o sections.o libc.o
> +	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
> +
> +sections.out: sections.elf generate_sections_out.py
> +	python2 generate_sections_out.py $^ > $@
> +
>  %.o: %.c
>  	$(CC) $(CCFLAGS) -c -o $@ $^
>  
> diff --git a/tests/multiboot/generate_sections_out.py b/tests/multiboot/generate_sections_out.py
> new file mode 100755
> index 0000000000..8077856823
> --- /dev/null
> +++ b/tests/multiboot/generate_sections_out.py
> @@ -0,0 +1,33 @@
> +#!/usr/bin/env python2
> +
> +import sys
> +
> +from elftools.elf.elffile import ELFFile

I don't think we can expect this module to be present. For example, on
my system, attempting to run the test fails:

ImportError: No module named elftools.elf.elffile

Maybe we can parse the output of readelf instead?

> +def roundup(num, align):
> +  return (num + align - 1) / align * align
> +
> +def main(filename):
> +  print "\n\n\n=== Running test case: sections.elf  ===\n"
> +  print "Multiboot header at 9500, ELF section headers present\n"
> +
> +  with open(filename, 'rb') as f:
> +    elf = ELFFile(f)
> +    header = elf.header
> +    load_addr = 0x100000  # we load image starting from 1M
> +    sections = ""
> +    for s in elf.iter_sections():
> +      align = s.header.sh_addralign
> +      addr = 0
> +      if s.header.sh_type != 'SHT_NULL':
> +        addr = s.header.sh_addr
> +        if addr == 0:
> +          addr = roundup(load_addr, s.header.sh_addralign)
> +        load_addr = addr + s.header.sh_size
> +      sections += "Elf section name=%s addr=%x size=%d\n" % (s.name, addr, s.header.sh_size)
> +
> +    print "Sections list with %d entries of size %d at %x, string index %d" % (header.e_shnum, header.e_shentsize, load_addr, header.e_shstrndx)

We're not as strict about the 80 characters rule in Python code, but I
think this line could use being wrapped.

> +    print sections,
> +
> +if __name__ == '__main__':
> +  main(sys.argv[1])
> diff --git a/tests/multiboot/modules.out b/tests/multiboot/modules.out
> index 0da7b39374..b6c1a01be1 100644
> --- a/tests/multiboot/modules.out
> +++ b/tests/multiboot/modules.out
> @@ -5,15 +5,15 @@
>  
>  Multiboot header at 9500
>  
> -Module list with 0 entries at 102000
> +Module list with 0 entries at 104000
>  
>  
>  === Running test case: modules.elf -initrd module.txt ===
>  
>  Multiboot header at 9500
>  
> -Module list with 1 entries at 102000
> -[102000] Module: 103000 - 103038 (56 bytes) 'module.txt'
> +Module list with 1 entries at 104000
> +[104000] Module: 105000 - 105038 (56 bytes) 'module.txt'
>           Content: 'This is a test file that is used as a multiboot module.'
>  
>  
> @@ -21,8 +21,8 @@ Module list with 1 entries at 102000
>  
>  Multiboot header at 9500
>  
> -Module list with 1 entries at 102000
> -[102000] Module: 103000 - 103038 (56 bytes) 'module.txt argument'
> +Module list with 1 entries at 104000
> +[104000] Module: 105000 - 105038 (56 bytes) 'module.txt argument'
>           Content: 'This is a test file that is used as a multiboot module.'
>  
>  
> @@ -30,8 +30,8 @@ Module list with 1 entries at 102000
>  
>  Multiboot header at 9500
>  
> -Module list with 1 entries at 102000
> -[102000] Module: 103000 - 103038 (56 bytes) 'module.txt argument,with,commas'
> +Module list with 1 entries at 104000
> +[104000] Module: 105000 - 105038 (56 bytes) 'module.txt argument,with,commas'
>           Content: 'This is a test file that is used as a multiboot module.'
>  
>  
> @@ -39,10 +39,10 @@ Module list with 1 entries at 102000
>  
>  Multiboot header at 9500
>  
> -Module list with 3 entries at 102000
> -[102000] Module: 103000 - 103038 (56 bytes) 'module.txt'
> +Module list with 3 entries at 104000
> +[104000] Module: 105000 - 105038 (56 bytes) 'module.txt'
>           Content: 'This is a test file that is used as a multiboot module.'
> -[102010] Module: 104000 - 104038 (56 bytes) 'module.txt argument'
> +[104010] Module: 106000 - 106038 (56 bytes) 'module.txt argument'
>           Content: 'This is a test file that is used as a multiboot module.'
> -[102020] Module: 105000 - 105038 (56 bytes) 'module.txt'
> +[104020] Module: 107000 - 107038 (56 bytes) 'module.txt'
>           Content: 'This is a test file that is used as a multiboot module.'
> diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
> index 0278148b43..f04e35cbf0 100755
> --- a/tests/multiboot/run_test.sh
> +++ b/tests/multiboot/run_test.sh
> @@ -56,9 +56,13 @@ modules() {
>      run_qemu modules.elf -initrd "module.txt,module.txt argument,module.txt"
>  }
>  
> +sections() {
> +    run_qemu sections.elf
> +}
> +
>  make all
>  
> -for t in mmap modules; do
> +for t in mmap modules sections; do
>  
>      echo > test.log
>      $t
> diff --git a/tests/multiboot/sections.c b/tests/multiboot/sections.c
> new file mode 100644
> index 0000000000..05a88f99ac
> --- /dev/null
> +++ b/tests/multiboot/sections.c
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright (c) 2017 Anatol Pomozov <anatol.pomozov@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "libc.h"
> +#include "../../hw/i386/multiboot_header.h"
> +#include "../../include/elf.h"
> +
> +int test_main(uint32_t magic, struct multiboot_info *mbi)
> +{
> +    void *p;
> +    unsigned int i;
> +
> +    (void) magic;
> +    multiboot_elf_section_header_table_t shdr;
> +
> +    printf("Multiboot header at %x, ELF section headers %s\n\n", mbi,
> +        mbi->flags & MULTIBOOT_INFO_ELF_SHDR ? "present" : "don't present");
> +
> +    shdr = mbi->u.elf_sec;
> +    printf("Sections list with %d entries of size %d at %x, string index %d\n",
> +        shdr.num, shdr.size, shdr.addr, shdr.shndx);
> +
> +    const char *string_table = (char *)((Elf32_Shdr *)(uintptr_t)(shdr.addr + shdr.shndx * shdr.size))->sh_addr;

80 characters again.

> +
> +    for (i = 0, p = (void *)shdr.addr;
> +         i < shdr.num;
> +         i++, p += shdr.size)
> +    {
> +        Elf32_Shdr *sec;
> +
> +        sec = (Elf32_Shdr *)p;
> +        printf("Elf section name=%s addr=%lx size=%ld\n", string_table + sec->sh_name, sec->sh_addr, sec->sh_size);

And here.

> +    }
> +
> +    return 0;
> +}

Should we try to access one of the section headers to make sure that we
didn't only get the correct addresses, but that data is actually loaded
there?

Kevin
