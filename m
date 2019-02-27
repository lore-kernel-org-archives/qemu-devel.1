Received: from eggs.gnu.org ([209.51.188.92]:38797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyxOI-0000dN-Fq
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyxOG-0000WY-Oq
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:28:46 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyxOG-0000Er-GN
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:28:44 -0500
Received: by mail-wm1-x343.google.com with SMTP id z84so5208623wmg.4
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 03:28:27 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-10-armbru@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190226193408.23862-10-armbru@redhat.com>
Date: Wed, 27 Feb 2019 11:28:25 +0000
Message-ID: <87pnrdlbc6.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/11] mips_malta: Clean up definition
 of flash memory size somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>


Markus Armbruster <armbru@redhat.com> writes:

> pflash_cfi01_register() takes a size in bytes, a block size in bytes
> and a number of blocks.  mips_malta_init() passes BIOS_SIZE, 65536,
> FLASH_SIZE >> 16.  Actually consistent only because BIOS_SIZE (defined
> in include/hw/mips/bios.h as (4 * MiB)) matches FLASH_SIZE (defined
> locally as 0x400000).  Confusing all the same.
>
> Pass FLASH_SIZE instead of BIOS_SIZE.
>
> There are more uses of BIOS_SIZE, but I don't sufficiently understand
> them to attempt cleanup.
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/mips/mips_malta.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 172ee033af..c2a5c65a24 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1269,12 +1269,12 @@ void mips_malta_init(MachineState *machine)
>      if (dinfo) {
>          printf("Register parallel flash %d size " TARGET_FMT_lx " at "
>                 "addr %08llx '%s' %x\n",
> -               fl_idx, bios_size, FLASH_ADDRESS,
> +               fl_idx, FLASH_SIZE, FLASH_ADDRESS,

bios_size =3D=3D FLASH_SIZE at this point, but is then overwritten later in
the function *if* the flash is loaded (and not already set via a dinfo).
I'd say you could move bios_size down to were it's used but then you
confused the byte swapping machinery which expects something to be set.

All that said these changes so far are not wrong:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>                 blk_name(dinfo->bdrv), fl_sectors);
>      }
>  #endif
>      fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
> -                               BIOS_SIZE,
> +                               FLASH_SIZE,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                                 65536, fl_sectors,
>                                 4, 0x0000, 0x0000, 0x0000, 0x0000, be);


--
Alex Benn=C3=A9e
