Received: from eggs.gnu.org ([209.51.188.92]:58366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h2D1t-0005JI-69
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h2D1s-00088s-C7
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:47:05 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:36038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1h2D1s-00087m-1s
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:47:04 -0500
Received: by mail-ed1-x544.google.com with SMTP id g9so16028694eds.3
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 02:47:03 -0800 (PST)
References: <20190308094610.21210-1-armbru@redhat.com>
	<20190308094610.21210-11-armbru@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190308094610.21210-11-armbru@redhat.com>
Date: Fri, 08 Mar 2019 10:47:01 +0000
Message-ID: <878sxpfxsq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/15] mips_malta: Delete disabled,
 broken DEBUG_BOARD_INIT code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, philmd@redhat.com, balaton@eik.bme.hu


Markus Armbruster <armbru@redhat.com> writes:

> The debug code under DEBUG_BOARD_INIT doesn't compile:
>
>       hw/mips/mips_malta.c:1273:16: error: implicit declaration of functi=
on =E2=80=98blk_name=E2=80=99; did you mean =E2=80=98basename=E2=80=99? [-W=
error=3Dimplicit-function-declaration]
>                     blk_name(dinfo->bdrv), fl_sectors);
>                     ^~~~~~~~
>       hw/mips/mips_malta.c:1273:16: error: nested extern declaration of =
=E2=80=98blk_name=E2=80=99 [-Werror=3Dnested-externs]
>       hw/mips/mips_malta.c:1273:30: error: =E2=80=98DriveInfo=E2=80=99 {a=
ka =E2=80=98struct DriveInfo=E2=80=99} has no member named =E2=80=98bdrv=E2=
=80=99
>                     blk_name(dinfo->bdrv), fl_sectors);
>                                     ^~
>
> Delete it.
>
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/mips/mips_malta.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 2827074e9b..8736d3a00e 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -58,8 +58,6 @@
>  #include "exec/semihost.h"
>  #include "hw/mips/cps.h"
>
> -//#define DEBUG_BOARD_INIT
> -
>  #define ENVP_ADDR		0x80002000l
>  #define ENVP_NB_ENTRIES	 	16
>  #define ENVP_ENTRY_SIZE	 	256
> @@ -1265,14 +1263,6 @@ void mips_malta_init(MachineState *machine)
>
>      /* Load firmware in flash / BIOS. */
>      dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
> -#ifdef DEBUG_BOARD_INIT
> -    if (dinfo) {
> -        printf("Register parallel flash %d size " TARGET_FMT_lx " at "
> -               "addr %08llx '%s' %x\n",
> -               fl_idx, bios_size, FLASH_ADDRESS,
> -               blk_name(dinfo->bdrv), fl_sectors);
> -    }
> -#endif
>      fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
>                                 BIOS_SIZE,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,


--
Alex Benn=C3=A9e
