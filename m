Received: from eggs.gnu.org ([2001:4830:134:3::10]:48854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dkaRX-0002rv-Fq
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 14:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dkaRU-0000t9-W2
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 14:31:55 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:38736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1dkaRU-0000t3-OK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 14:31:52 -0400
Received: by mail-vk0-x242.google.com with SMTP id m201so135447vkd.5
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 11:31:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823172257.48011-3-anatol.pomozov@gmail.com>
References: <20170823172257.48011-1-anatol.pomozov@gmail.com>
	<20170823172257.48011-3-anatol.pomozov@gmail.com>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Wed, 23 Aug 2017 11:31:50 -0700
Message-ID: <CAOMFOmU3tPi6NT1gN=dxWhbAYj8_oiywMLsXKJtqNVo8aA-NhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] multiboot: load elf sections and
 section headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Anatol Pomozov <anatol.pomozov@gmail.com>

Hi

On Wed, Aug 23, 2017 at 10:22 AM, Anatol Pomozov
<anatol.pomozov@gmail.com> wrote:
> Multiboot may load section headers and all sections (even those that are
> not part of any segment) to target memory.
>
> Tested with an ELF application that uses data from strings table
> section.
>
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---
>  hw/core/loader.c             |   8 ++--
>  hw/i386/multiboot.c          |  83 +++++++++++++++++----------------
>  hw/s390x/ipl.c               |   2 +-
>  include/hw/elf_ops.h         | 107 ++++++++++++++++++++++++++++++++++++++++++-
>  include/hw/loader.h          |  11 ++++-
>  tests/multiboot/Makefile     |   5 +-
>  tests/multiboot/modules.out  |  22 ++++-----
>  tests/multiboot/run_test.sh  |   6 ++-
>  tests/multiboot/sections.c   |  55 ++++++++++++++++++++++
>  tests/multiboot/sections.out |  21 +++++++++
>  tests/multiboot/start.S      |   2 +-
>  11 files changed, 261 insertions(+), 61 deletions(-)
>  create mode 100644 tests/multiboot/sections.c
>  create mode 100644 tests/multiboot/sections.out
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index ebe574c7ea..c7e3608e7a 100644
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
> +                 bool load_rom, struct sections_data *sections)
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
> index a49217ac62..9ced0bfe30 100644
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
> +    struct sections_data sections;
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
> -
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
> @@ -209,12 +181,6 @@ int load_multiboot(FWCfgState *fw_cfg,
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
> @@ -229,9 +195,45 @@ int load_multiboot(FWCfgState *fw_cfg,
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
> @@ -313,7 +315,8 @@ int load_multiboot(FWCfgState *fw_cfg,
>      stl_p(&bootinfo.mods_count, mbs.mb_mods_count); /* mods_count */
>
>      /* the kernel is where we want it to be now */
> -    stl_p(&bootinfo.flags, MULTIBOOT_INFO_MEMORY
> +    stl_p(&bootinfo.flags, bootinfo_flags
> +                           | MULTIBOOT_INFO_MEMORY
>                             | MULTIBOOT_INFO_BOOTDEV
>                             | MULTIBOOT_INFO_CMDLINE
>                             | MULTIBOOT_INFO_MODS
> @@ -347,5 +350,7 @@ int load_multiboot(FWCfgState *fw_cfg,
>      option_rom[nb_option_roms].bootindex = 0;
>      nb_option_roms++;
>
> +    fclose(f);
> +
>      return 1; /* yes, we are multiboot */
>  }
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index cc360031ef..32afae9f1f 100644
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
> index a172a6068a..be131b1c19 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -264,12 +264,13 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>                                int must_swab, uint64_t *pentry,
>                                uint64_t *lowaddr, uint64_t *highaddr,
>                                int elf_machine, int clear_lsb, int data_swab,
> -                              AddressSpace *as, bool load_rom)
> +                              AddressSpace *as, bool load_rom,
> +                              struct sections_data *sections)
>  {
>      struct elfhdr ehdr;
>      struct elf_phdr *phdr = NULL, *ph;
>      int size, i, total_size;
> -    elf_word mem_size, file_size;
> +    elf_word mem_size, file_size, sec_size;
>      uint64_t addr, low = (uint64_t)-1, high = 0;
>      uint8_t *data = NULL;
>      char label[128];
> @@ -423,6 +424,108 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>          }
>      }
>      g_free(phdr);
> +
> +    if (sections) {
> +        struct elf_shdr *shdr = NULL, *sh;
> +        int shsize;
> +
> +        // user requested loading all ELF sections
> +        shsize = ehdr.e_shnum * sizeof(shdr[0]);
> +        if (lseek(fd, ehdr.e_shoff, SEEK_SET) != ehdr.e_shoff) {
> +            goto fail;
> +        }
> +        shdr = g_malloc0(shsize);
> +        if (!shdr)
> +            goto fail;
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
> +            sh = &shdr[i];
> +            if (sh->sh_type == SHT_NULL)
> +                continue;
> +            // if section has address then it is loaded (XXX: is it true?), no need to load it again
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
> +                    uint8_t *dp = data + j;
> +                    switch (data_swab) {
> +                    case (1):
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
> index 490c9ff8e6..6bd42db675 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -65,6 +65,13 @@ int load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz);
>  #define ELF_LOAD_WRONG_ENDIAN -4
>  const char *load_elf_strerror(int error);
>
> +struct sections_data {
> +    uint32_t num; // number of loaded sections
> +    uint32_t size; // size of entry in sections header list
> +    uint32_t addr; // address of loaded sections header
> +    uint32_t shndx; // number of section that contains string table
> +};
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
> +                 bool load_rom, struct sections_data *sections);
>
>  /** load_elf_as:
>   * Same as load_elf_ram(), but always loads the elf as ROM
> diff --git a/tests/multiboot/Makefile b/tests/multiboot/Makefile
> index 36f01dc647..856e76682a 100644
> --- a/tests/multiboot/Makefile
> +++ b/tests/multiboot/Makefile
> @@ -6,7 +6,7 @@ LD=ld
>  LDFLAGS=-melf_i386 -T link.ld
>  LIBS=$(shell $(CC) $(CCFLAGS) -print-libgcc-file-name)
>
> -all: mmap.elf modules.elf
> +all: mmap.elf modules.elf sections.elf
>
>  mmap.elf: start.o mmap.o libc.o
>         $(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
> @@ -14,6 +14,9 @@ mmap.elf: start.o mmap.o libc.o
>  modules.elf: start.o modules.o libc.o
>         $(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
>
> +sections.elf: start.o sections.o libc.o
> +       $(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
> +
>  %.o: %.c
>         $(CC) $(CCFLAGS) -c -o $@ $^
>
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
> +
> +    for (i = 0, p = (void *)shdr.addr;
> +         i < shdr.num;
> +         i++, p += shdr.size)
> +    {
> +        Elf32_Shdr *sec;
> +
> +        sec = (Elf32_Shdr *)p;
> +        printf("Elf section name=%s addr=%lx size=%ld\n", string_table + sec->sh_name, sec->sh_addr, sec->sh_size);
> +    }
> +
> +    return 0;
> +}
> diff --git a/tests/multiboot/sections.out b/tests/multiboot/sections.out
> new file mode 100644
> index 0000000000..c9a38aa5e8
> --- /dev/null
> +++ b/tests/multiboot/sections.out
> @@ -0,0 +1,21 @@
> +
> +
> +
> +=== Running test case: sections.elf  ===
> +
> +Multiboot header at 9500, ELF section headers present
> +
> +Sections list with 13 entries of size 40 at 103675, string index 12
> +Elf section name= addr=0 size=0
> +Elf section name=.text addr=100000 size=1873
> +Elf section name=.text.__x86.get_pc_thunk.bx addr=100751 size=4
> +Elf section name=.text.__x86.get_pc_thunk.ax addr=100755 size=4
> +Elf section name=.text.__x86.get_pc_thunk.di addr=100759 size=4
> +Elf section name=.got.plt addr=100760 size=12
> +Elf section name=.rodata addr=101000 size=186
> +Elf section name=.eh_frame addr=1010bc size=596
> +Elf section name=bss addr=101310 size=8192
> +Elf section name=.comment addr=103310 size=38
> +Elf section name=.symtab addr=103338 size=464
> +Elf section name=.strtab addr=103508 size=208
> +Elf section name=.shstrtab addr=1035d8 size=157

I like the idea of automated tests. It makes sure that the future
changes do not break existing functionality. Thus I added a test for
multiboot elf sections data. But a problem here is that number, order
and size of these sections depend on compiler and linker versions. The
data above is for gcc 6.3.0 from debian but I am pretty sure other
compilers produce different set of elf sections. What would be the
best way to adopt this test and make it independent of compiler
internals?

> diff --git a/tests/multiboot/start.S b/tests/multiboot/start.S
> index 7d33959650..bd404100c2 100644
> --- a/tests/multiboot/start.S
> +++ b/tests/multiboot/start.S
> @@ -23,7 +23,7 @@
>  .section multiboot
>
>  #define MB_MAGIC 0x1badb002
> -#define MB_FLAGS 0x0
> +#define MB_FLAGS 0x2
>  #define MB_CHECKSUM -(MB_MAGIC + MB_FLAGS)
>
>  .align  4
> --
> 2.14.1.342.g6490525c54-goog
>
