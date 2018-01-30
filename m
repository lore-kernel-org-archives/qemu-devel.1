Received: from eggs.gnu.org ([2001:4830:134:3::10]:34313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1egf7G-0000GN-2O
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1egf6b-0007N0-EG
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:15:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1egf6a-0007Hp-QT
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 18:14:21 -0500
References: <20180129204344.196196-1-anatol.pomozov@gmail.com>
	<20180129204344.196196-2-anatol.pomozov@gmail.com>
From: Jack Schwartz <jack.schwartz@oracle.com>
Message-ID: <93ef2002-3dac-4cb9-094a-03a46409788b@oracle.com>
Date: Tue, 30 Jan 2018 15:15:20 -0800
MIME-Version: 1.0
In-Reply-To: <20180129204344.196196-2-anatol.pomozov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] multiboot: load elf sections and
 section headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>

Hi Anatol.

I have one comment about sections.c headers (and didn't really look=20
further in that file), and start.S.

Comments inline...

On 01/29/18 12:43, Anatol Pomozov wrote:
> Multiboot may load section headers and all sections (even those that ar=
e
> not part of any segment) to target memory.
>
> Tested with an ELF application that uses data from strings table
> section.
>
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---
>   hw/core/loader.c                         |   8 +--
>   hw/i386/multiboot.c                      |  17 +++--
>   hw/s390x/ipl.c                           |   2 +-
>   include/hw/elf_ops.h                     | 110 ++++++++++++++++++++++=
+++++++--
>   include/hw/loader.h                      |  11 +++-
>   tests/multiboot/Makefile                 |   8 ++-
>   tests/multiboot/generate_sections_out.py |  33 ++++++++++
>   tests/multiboot/modules.out              |  22 +++----
>   tests/multiboot/run_test.sh              |   6 +-
>   tests/multiboot/sections.c               |  57 ++++++++++++++++
>   tests/multiboot/start.S                  |   2 +-
>   11 files changed, 248 insertions(+), 28 deletions(-)
>   create mode 100755 tests/multiboot/generate_sections_out.py
>   create mode 100644 tests/multiboot/sections.c
>
<snip>
> diff --git a/tests/multiboot/sections.c b/tests/multiboot/sections.c
> new file mode 100644
> index 0000000000..64060510ce
> --- /dev/null
> +++ b/tests/multiboot/sections.c
> @@ -0,0 +1,57 @@
> +/*
> + * Copyright (c) 2017 Anatol Pomozov <anatol.pomozov@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "libc.h"
> +#include "../../hw/i386/multiboot_header.h"
As like the first patch, I suggest creating a "multiboot" subdir in the=20
"include" subtree and putting all multiboot header files there.=20
Including "multiboot/multiboot_header.h" would be cleaner.
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
> +        mbi->flags & MULTIBOOT_INFO_ELF_SHDR ? "present" : "doesn't pr=
esent");
> +
> +    shdr =3D mbi->u.elf_sec;
> +    printf("Sections list with %d entries of size %d at %x, string ind=
ex %d\n",
> +        shdr.num, shdr.size, shdr.addr, shdr.shndx);
> +
> +    const char *string_table =3D (char *)((Elf32_Shdr *)(uintptr_t)(sh=
dr.addr +
> +        shdr.shndx * shdr.size))->sh_addr;
> +
> +    for (i =3D 0, p =3D (void *)shdr.addr;
> +         i < shdr.num;
> +         i++, p +=3D shdr.size)
> +    {
> +        Elf32_Shdr *sec;
> +
> +        sec =3D (Elf32_Shdr *)p;
> +        printf("Elf section name=3D%s addr=3D%lx size=3D%ld\n",
> +            string_table + sec->sh_name, sec->sh_addr, sec->sh_size);
> +    }
> +
> +    return 0;
> +}
> diff --git a/tests/multiboot/start.S b/tests/multiboot/start.S
> index 7d33959650..bd404100c2 100644
> --- a/tests/multiboot/start.S
> +++ b/tests/multiboot/start.S
> @@ -23,7 +23,7 @@
>   .section multiboot
>  =20
>   #define MB_MAGIC 0x1badb002
> -#define MB_FLAGS 0x0
> +#define MB_FLAGS 0x2
>   #define MB_CHECKSUM -(MB_MAGIC + MB_FLAGS)
C headers can be included in assembly files.=C2=A0 Since you are bringing=
=20
over multiboot_header.h, why not include it and use its values instead=20
of re-defining them here?

 =C2=A0=C2=A0=C2=A0 Thanks,
 =C2=A0=C2=A0=C2=A0 Jack
>  =20
>   .align  4
