Received: from eggs.gnu.org ([2001:4830:134:3::10]:35540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ek4fz-0000sX-6b
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ek4fw-0006Hp-U8
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:08:59 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ek4fw-0006H7-L6
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:08:56 -0500
Received: by mail-ot0-x243.google.com with SMTP id f18so7087020otf.6
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 01:08:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NubFsYQ+0A=iURqTbQDpA=L+mgr7P+qDzZEyXacJcfyig@mail.gmail.com>
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-13-git-send-email-mjc@sifive.com>
	<82554ae4-5348-f30b-3b77-64754046198b@linaro.org>
	<CAHNT7NsYT_bPpiOx2oUqsYCCAU1TOhx3ytAoU-a6pTbkkA_pnA@mail.gmail.com>
	<CAHNT7NubFsYQ+0A=iURqTbQDpA=L+mgr7P+qDzZEyXacJcfyig@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 9 Feb 2018 22:08:55 +1300
Message-ID: <CAHNT7Nsw9-7G34fuUW1aBeiR_ouh1sZJdWYiw1w1ws6M0CY5Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 12/23] RISC-V HTIF Console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

https://github.com/michaeljclark/riscv-qemu/commit/17272f5c66adf8532f196d660d2a593c2178ac95

 hw/core/loader.c     |   18 ++++++++++++++++--
 include/hw/elf_ops.h |   28 ++++++++++++++++------------
 include/hw/loader.h  |   17 ++++++++++++++++-
 3 files changed, 48 insertions(+), 15 deletions(-)


On Fri, Feb 9, 2018 at 9:09 PM, Michael Clark <mjc@sifive.com> wrote:

>
>
> On Fri, Feb 9, 2018 at 8:33 PM, Michael Clark <mjc@sifive.com> wrote:
>
>>
>>
>> On Fri, Feb 9, 2018 at 5:35 AM, Richard Henderson <
>> richard.henderson@linaro.org> wrote:
>>
>>> On 02/07/2018 05:28 PM, Michael Clark wrote:
>>> > +++ b/hw/riscv/riscv_elf.c
>>> > @@ -0,0 +1,244 @@
>>> > +/*
>>> > + * elf.c - A simple package for manipulating symbol tables in elf
>>> binaries.
>>> > + *
>>> > + * Taken from
>>> > + * https://www.cs.cmu.edu/afs/cs.cmu.edu/academic/class/15213-f
>>> 03/www/
>>> > + * ftrace/elf.c
>>> > + *
>>> > + */
>>> > +#include <stdio.h>
>>> > +#include <stdlib.h>
>>> > +#include <unistd.h>
>>> > +#include <string.h>
>>> > +#include <sys/stat.h>
>>> > +#include <sys/types.h>
>>> > +#include <sys/mman.h>
>>> > +#include <errno.h>
>>> > +#include <fcntl.h>
>>> > +#include <glib.h>
>>> > +
>>> > +#include "hw/riscv/riscv_elf.h"
>>> > +
>>> > +/*
>>> > + * elf_open - Map a binary into the address space and extract the
>>> > + * locations of the static and dynamic symbol tables and their string
>>> > + * tables. Return this information in a Elf object file handle that
>>> will
>>> > + * be passed to all of the other elf functions.
>>> > + */
>>> > +Elf_obj64 *elf_open64(const char *filename)
>>> > +{
>>> > +    int i, fd;
>>> > +    struct stat sbuf;
>>> > +    Elf_obj64 *ep;
>>> > +    Elf64_Shdr *shdr;
>>> > +
>>> > +    ep = g_new(Elf_obj64, 1);
>>> > +
>>> > +    /* Do some consistency checks on the binary */
>>> > +    fd = open(filename, O_RDONLY);
>>> > +    if (fd == -1) {
>>> > +        fprintf(stderr, "Can't open \"%s\": %s\n", filename,
>>> strerror(errno));
>>> > +        exit(1);
>>> > +    }
>>> > +    if (fstat(fd, &sbuf) == -1) {
>>> > +        fprintf(stderr, "Can't stat \"%s\": %s\n", filename,
>>> strerror(errno));
>>> > +        exit(1);
>>> > +    }
>>> > +    if (sbuf.st_size < sizeof(Elf64_Ehdr)) {
>>> > +        fprintf(stderr, "\"%s\" is not an ELF binary object\n",
>>> filename);
>>> > +        exit(1);
>>> > +    }
>>> > +
>>> > +    /* It looks OK, so map the Elf binary into our address space */
>>> > +    ep->mlen = sbuf.st_size;
>>> > +    ep->maddr = mmap(NULL, ep->mlen, PROT_READ, MAP_SHARED, fd, 0);
>>> > +    if (ep->maddr == (void *)-1) {
>>> > +        fprintf(stderr, "Can't mmap \"%s\": %s\n", filename,
>>> strerror(errno));
>>> > +        exit(1);
>>> > +    }
>>> > +    close(fd);
>>> > +
>>> > +    /* The Elf binary begins with the Elf header */
>>> > +    ep->ehdr = ep->maddr;
>>> > +
>>> > +    /* check we have a 64-bit little-endian RISC-V ELF object */
>>> > +    if (ep->ehdr->e_ident[EI_MAG0] != ELFMAG0 ||
>>> > +        ep->ehdr->e_ident[EI_MAG1] != ELFMAG1 ||
>>> > +        ep->ehdr->e_ident[EI_MAG2] != ELFMAG2 ||
>>> > +        ep->ehdr->e_ident[EI_MAG3] != ELFMAG3 ||
>>> > +        ep->ehdr->e_ident[EI_CLASS] != ELFCLASS64 ||
>>> > +        ep->ehdr->e_ident[EI_DATA] != ELFDATA2LSB ||
>>> > +        ep->ehdr->e_machine != EM_RISCV)
>>> > +    {
>>> > +        fprintf(stderr, "\"%s\" is not a 64-bit RISC-V ELF object\n",
>>> filename);
>>> > +        exit(1);
>>> > +    }
>>> > +
>>> > +    /*
>>> > +     * Find the static and dynamic symbol tables and their string
>>> > +     * tables in the the mapped binary. The sh_link field in symbol
>>> > +     * table section headers gives the section index of the string
>>> > +     * table for that symbol table.
>>> > +     */
>>> > +    shdr = (Elf64_Shdr *)(ep->maddr + ep->ehdr->e_shoff);
>>>
>>> This duplicates, badly, existing code within include/hw/elf_ops.h.
>>>
>>> In particular, this fails to bswap these fields.  As such, this code
>>> will only
>>> work on little-endian hosts.
>>>
>>
>> There is enough information in the structures held in the syminfo table
>> used by the disassembler however elf_ops.h currently throws away all
>> symbols that are not STT_FUNC, and we are after STT_OBJECT symbols. We
>> would need to add an option to load_elf to load the entire symbol table.
>> Also, it runs qsort on the table by address, so we'd need to do a linear
>> scan for the HTIF symbols by name. There are only two symbols we need:
>> 'fromhost' and 'tohost'.
>>
>>         /* We are only interested in function symbols.
>>            Throw everything else away.  */
>>         if (syms[i].st_shndx == SHN_UNDEF ||
>>                 syms[i].st_shndx >= SHN_LORESERVE ||
>>                 ELF_ST_TYPE(syms[i].st_info) != STT_FUNC) {
>>             nsyms--;
>>             if (i < nsyms) {
>>                 syms[i] = syms[nsyms];
>>             }
>>             continue;
>>         }
>>
>> It would be really nice if HTIF just specified registers in device-tree;
>> alas it doesn't; and there is still quite a bit of code that depend on
>> using these magic HTIF 'fromhost' and 'tohost' symbols. riscv-tests for one
>> uses the HTIF mechanism and spike the official ISA simulator uses HTIF for
>> IO.
>>
>
> Luckily elf_ops.h load_elf32 and load_elf64 are wrapped by load_elf, and
> several load_elf_* variants.
>
> We need the symbol name, type, address and size to find and validate the
> HTIF symbols. The current thought is to pass a callback function pointer to
> a new load_elf_sym variant, where the new function pointer, in the common
> case, won't be called by load_elf32 and load_elf64 as it will be NULL for
> all present users. We could use uint64_t to abstract the caller from
> the elf32_sym/elf64_sym address and size types. This approach would likely
> require less code than adding a new /linear/ search by name method, along
> with a retain all symbols argument to load_symbols and associated plumbing.
> It's also inherently one pass e.g.
>
> typedef void (*symbol_fn_t)(const char *st_name, int st_info,
> uint64_t st_value, uint64_t st_size);
>
> static int glue(load_symbols, SZ)(struct elfhdr *ehdr, int fd, int
> must_swab,
>                                   int clear_lsb, symbol_fn_t sym_cb)
> {
>
>     ....
>
>         if (sym_cb) {
>             sym_cb(strtab + syms[i].st_name, syms[i].st_info,
> syms[i].st_value, syms[i].st_size)
>         }
>
>     ...
>
> }
>
> static int glue(load_elf, SZ)(const char *name, int fd,
>                               uint64_t (*translate_fn)(void *, uint64_t),
>                               void *translate_opaque,
>                               int must_swab, uint64_t *pentry,
>                               uint64_t *lowaddr, uint64_t *highaddr,
>                               int elf_machine, int clear_lsb, int
> data_swab,
>                               AddressSpace *as, bool load_rom,
>                               symbol_fn_t sym_cb)
> {
>     ....
>
>     glue(load_symbols, SZ)(&ehdr, fd, must_swab, clear_lsb, sym_cb);
>
>     ....
> }
>
>
