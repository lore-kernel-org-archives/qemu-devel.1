Received: from eggs.gnu.org ([2001:4830:134:3::10]:38915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejpAd-0006gv-2d
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejpAZ-00039X-5E
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:35:35 -0500
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:41430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejpAY-00039R-VS
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:35:31 -0500
Received: by mail-pg0-x234.google.com with SMTP id t4so738498pgp.8
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:35:30 -0800 (PST)
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-13-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <82554ae4-5348-f30b-3b77-64754046198b@linaro.org>
Date: Thu, 8 Feb 2018 08:35:26 -0800
MIME-Version: 1.0
In-Reply-To: <1518053328-34687-13-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 12/23] RISC-V HTIF Console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/07/2018 05:28 PM, Michael Clark wrote:
> +++ b/hw/riscv/riscv_elf.c
> @@ -0,0 +1,244 @@
> +/*
> + * elf.c - A simple package for manipulating symbol tables in elf binaries.
> + *
> + * Taken from
> + * https://www.cs.cmu.edu/afs/cs.cmu.edu/academic/class/15213-f03/www/
> + * ftrace/elf.c
> + *
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/mman.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <glib.h>
> +
> +#include "hw/riscv/riscv_elf.h"
> +
> +/*
> + * elf_open - Map a binary into the address space and extract the
> + * locations of the static and dynamic symbol tables and their string
> + * tables. Return this information in a Elf object file handle that will
> + * be passed to all of the other elf functions.
> + */
> +Elf_obj64 *elf_open64(const char *filename)
> +{
> +    int i, fd;
> +    struct stat sbuf;
> +    Elf_obj64 *ep;
> +    Elf64_Shdr *shdr;
> +
> +    ep = g_new(Elf_obj64, 1);
> +
> +    /* Do some consistency checks on the binary */
> +    fd = open(filename, O_RDONLY);
> +    if (fd == -1) {
> +        fprintf(stderr, "Can't open \"%s\": %s\n", filename, strerror(errno));
> +        exit(1);
> +    }
> +    if (fstat(fd, &sbuf) == -1) {
> +        fprintf(stderr, "Can't stat \"%s\": %s\n", filename, strerror(errno));
> +        exit(1);
> +    }
> +    if (sbuf.st_size < sizeof(Elf64_Ehdr)) {
> +        fprintf(stderr, "\"%s\" is not an ELF binary object\n", filename);
> +        exit(1);
> +    }
> +
> +    /* It looks OK, so map the Elf binary into our address space */
> +    ep->mlen = sbuf.st_size;
> +    ep->maddr = mmap(NULL, ep->mlen, PROT_READ, MAP_SHARED, fd, 0);
> +    if (ep->maddr == (void *)-1) {
> +        fprintf(stderr, "Can't mmap \"%s\": %s\n", filename, strerror(errno));
> +        exit(1);
> +    }
> +    close(fd);
> +
> +    /* The Elf binary begins with the Elf header */
> +    ep->ehdr = ep->maddr;
> +
> +    /* check we have a 64-bit little-endian RISC-V ELF object */
> +    if (ep->ehdr->e_ident[EI_MAG0] != ELFMAG0 ||
> +        ep->ehdr->e_ident[EI_MAG1] != ELFMAG1 ||
> +        ep->ehdr->e_ident[EI_MAG2] != ELFMAG2 ||
> +        ep->ehdr->e_ident[EI_MAG3] != ELFMAG3 ||
> +        ep->ehdr->e_ident[EI_CLASS] != ELFCLASS64 ||
> +        ep->ehdr->e_ident[EI_DATA] != ELFDATA2LSB ||
> +        ep->ehdr->e_machine != EM_RISCV)
> +    {
> +        fprintf(stderr, "\"%s\" is not a 64-bit RISC-V ELF object\n", filename);
> +        exit(1);
> +    }
> +
> +    /*
> +     * Find the static and dynamic symbol tables and their string
> +     * tables in the the mapped binary. The sh_link field in symbol
> +     * table section headers gives the section index of the string
> +     * table for that symbol table.
> +     */
> +    shdr = (Elf64_Shdr *)(ep->maddr + ep->ehdr->e_shoff);

This duplicates, badly, existing code within include/hw/elf_ops.h.

In particular, this fails to bswap these fields.  As such, this code will only
work on little-endian hosts.


r~
