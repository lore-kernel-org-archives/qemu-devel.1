Received: from eggs.gnu.org ([2001:4830:134:3::10]:38427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pburton@wavecomp.com>) id 1gJl3q-0004KO-Dk
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 15:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pburton@wavecomp.com>) id 1gJl3j-00083Z-VR
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 15:01:22 -0500
Received: from mail-eopbgr740092.outbound.protection.outlook.com
	([40.107.74.92]:40296
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pburton@wavecomp.com>)
	id 1gJl3j-0007s8-IC
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 15:01:15 -0500
From: Paul Burton <paul.burton@mips.com>
Date: Mon, 5 Nov 2018 20:01:03 +0000
Message-ID: <20181105200101.xwbvht3rbu2mq5br@pburton-laptop>
References: <1540300334-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540300334-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <01511B0522ED294BAC69710868BD03FE@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/mips: Add initrd support for Boston
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Hi Aleksandar,

On Tue, Oct 23, 2018 at 03:12:14PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>=20
> Add support for initial ramdisk loading for the Mips Boston board.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
> v2->v3:
>   - a comment was reformatted
>   - rebased to the latest QEMU code
> v1->v2:
>   - 'long inird_size' is changed to 'target_ulong initrd_size',
>     as it should be
>   - error_report() is used instead of fprintf()
> ---
>  hw/mips/boston.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++----=
-----
>  1 file changed, 46 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 6c9c20a..788bf69 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -31,6 +31,7 @@
>  #include "hw/loader-fit.h"
>  #include "hw/mips/cps.h"
>  #include "hw/mips/cpudevs.h"
> +#include "hw/mips/mips.h"
>  #include "hw/pci-host/xilinx-pcie.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> @@ -333,10 +334,12 @@ static const void *boston_fdt_filter(void *opaque, =
const void *fdt_orig,
>  {
>      BostonState *s =3D BOSTON(opaque);
>      MachineState *machine =3D s->mach;
> -    const char *cmdline;
> +    GString *cmdline;
>      int err;
>      void *fdt;
>      size_t fdt_sz, ram_low_sz, ram_high_sz;
> +    target_ulong initrd_size;
> +    ram_addr_t initrd_offset;
> =20
>      fdt_sz =3D fdt_totalsize(fdt_orig) * 2;
>      fdt =3D g_malloc0(fdt_sz);
> @@ -347,20 +350,54 @@ static const void *boston_fdt_filter(void *opaque, =
const void *fdt_orig,
>          return NULL;
>      }
> =20
> -    cmdline =3D (machine->kernel_cmdline && machine->kernel_cmdline[0])
> -            ? machine->kernel_cmdline : " ";

Just a bit of background (which I probably ought to have written as a
comment here): the string consisting of a single space character there
is a workaround for a Linux bug wherein if the DT doesn't contain a
bootargs property on its /chosen node, or it does but it's of length
zero, then any kernel command line arguments that are built-in using
CONFIG_CMDLINE get duplicated. That is, the final command line ends up
being CONFIG_CMDLINE concatenated with itself (with a space character in
the middle).

That can be problematic for some arguments, including the earlycon
argument which is commonly part of CONFIG_CMDLINE - when given twice the
kernel tries to register the same early console twice & shows a scary
warning about it.

This problem should be fixed from Linux v4.16 onwards by commit
8ce355cf2e38 ("MIPS: Setup boot_command_line before plat_mem_setup") and
later commit 951d223c6c16 ("MIPS: Fix CONFIG_CMDLINE handling").

> -    err =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline)=
;
> -    if (err < 0) {
> -        fprintf(stderr, "couldn't set /chosen/bootargs\n");
> -        return NULL;
> -    }
> -
>      ram_low_sz =3D MIN(256 * MiB, machine->ram_size);
>      ram_high_sz =3D machine->ram_size - ram_low_sz;
>      qemu_fdt_setprop_sized_cells(fdt, "/memory@0", "reg",
>                                   1, 0x00000000, 1, ram_low_sz,
>                                   1, 0x90000000, 1, ram_high_sz);
> =20
> +    cmdline =3D g_string_new(machine->kernel_cmdline);

As such, I suspect this may be problematic for Linux earlier than v4.16
since it appears to remove that workaround. If you want to remove the
workaround anyway then fair enough, but it seems a little too soon to
me.

> +
> +    /* load initrd */
> +    initrd_offset =3D 0;
> +    if (machine->initrd_filename) {
> +        initrd_size =3D get_image_size(machine->initrd_filename);
> +        if (initrd_size !=3D (target_ulong) -1) {
> +            /*
> +             * The kernel allocates the bootmap memory in the low memory=
 after
> +             * the initrd. It takes at most 128kiB for 2GB RAM and 4kiB =
pages.
> +             */

Just FYI this may have changed from Linux v4.20 where we switch from the
old bootmem allocator to memblock. But if the kernel tries to use memory
containing the initrd then I'd say that's a kernel bug anyway & we
should fix it there. So catering for the old bootmem case probably makes
most sense, to deal with pre-v4.20 kernels.

There's also conceptually no reason Boston has to be limited to 2GB RAM
- it could in theory have more.

> +            initrd_offset =3D (ram_low_sz - initrd_size - 131072
> +                             - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;

As such I wonder if the magic number 131072 would be best changed to
something like this:

  uint32_t min_page =3D 4 * KiB;

  machine->ram_size / min_page / BITS_PER_BYTE

Although the result of that for 2GB RAM is 64KB for the bitmap - if it
really should be 128KB then it'd probably be worth commenting why &
changing the arithmetic accordingly.

Or given that we constrain Boston to 2GB RAM at the moment anyway
perhaps it'd be better to just go with the hardcoded number & deal with
it if & when we remove the 2GB limitation.

> +
> +            if ((int64_t)cpu_mips_kseg0_to_phys(NULL, *load_addr + fdt_s=
z)
> +                >=3D (int64_t)initrd_offset) {
> +                error_report("memory too small for initial ram disk '%s'=
",
> +                             machine->initrd_filename);
> +                exit(1);
> +            }
> +
> +            initrd_size =3D load_image_targphys(machine->initrd_filename=
,
> +                                              initrd_offset,
> +                                              initrd_size);
> +        }
> +        if (initrd_size =3D=3D (target_ulong) -1) {
> +            error_report("could not load initial ram disk '%s'",
> +                         machine->initrd_filename);
> +            exit(1);
> +        }
> +        g_string_append_printf(cmdline, " rd_start=3D0x%" PRIx64 " rd_si=
ze=3D%li",
> +                               cpu_mips_phys_to_kseg0(NULL, initrd_offse=
t),
> +                               initrd_size);
> +    }
> +
> +    err =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline-=
>str);
> +    g_string_free(cmdline, true);
> +    if (err < 0) {
> +        error_report("couldn't set /chosen/bootargs");
> +        exit(1);
> +    }
> +
>      fdt =3D g_realloc(fdt, fdt_totalsize(fdt));
>      qemu_fdt_dumpdtb(fdt, fdt_sz);
> =20
> --=20
> 2.7.4

Apart from those comments, this looks good to me.

Thanks,
    Paul
