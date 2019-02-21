Received: from eggs.gnu.org ([209.51.188.92]:33717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwqGF-0005IR-H5
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwqGD-0001Jx-Ue
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:27:43 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwqGD-0001Dn-OW
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:27:41 -0500
Received: by mail-wr1-x442.google.com with SMTP id q1so31000378wrp.7
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 07:27:34 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-8-armbru@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190218125615.18970-8-armbru@redhat.com>
Date: Thu, 21 Feb 2019 15:27:32 +0000
Message-ID: <877edt40wr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/10] mips_malta: Clean up definition of
 flash memory size somewhat
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

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/mips/mips_malta.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index fff5ed19bd..65cdda4881 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1269,12 +1269,12 @@ void mips_malta_init(MachineState *machine)
>      if (dinfo) {
>          printf("Register parallel flash %d size " TARGET_FMT_lx " at "
>                 "addr %08llx '%s' %x\n",
> -               fl_idx, bios_size, FLASH_ADDRESS,
> +               fl_idx, FLASH_SIZE, FLASH_ADDRESS,
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
