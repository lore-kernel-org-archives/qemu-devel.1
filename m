Received: from eggs.gnu.org ([209.51.188.92]:59900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwq9Q-0000wc-Go
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwq9K-00049g-DY
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:20:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwq9I-00044b-BH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 10:20:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id d17so16520484wre.10
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 07:20:29 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-6-armbru@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190218125615.18970-6-armbru@redhat.com>
Date: Thu, 21 Feb 2019 15:20:26 +0000
Message-ID: <878sy9418l.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/10] ppc405_boards: Don't size flash
 memory to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>


Markus Armbruster <armbru@redhat.com> writes:

> Machine "ref405ep" maps its flash memory at address 2^32 - image size.
> Image size is rounded up to the next multiple of 64KiB.  Useless,
> because pflash_cfi02_realize() fails with "failed to read the initial
> flash content" unless the rounding is a no-op.
>
> If the image size exceeds 0x80000 Bytes, we overlap first SRAM, then
> other stuff.  No idea how that would play out, but a useful outcomes
> seem unlikely.
>
> Map the flash memory at fixed address 0xFFF80000 with size 512KiB,
> regardless of image size, to match the physical hardware.
>
> Machine "taihu" maps its boot flash memory similarly.  The code even
> has a comment /* XXX: should check that size is 2MB */, followed by
> disabled code to adjust the size to 2MiB regardless of image size.
>
> Its code to map its application flash memory looks the same, except
> there the XXX comment asks for 32MiB, and the code to adjust the size
> isn't disabled.  Note that pflash_cfi02_realize() fails with "failed
> to read the initial flash content" for images smaller than 32MiB.
>
> Map the boot flash memory at fixed address 0xFFE00000 with size 2MiB,
> to match the physical hardware.  Delete dead code from application
> flash mapping, and simplify some.
>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/ppc/ppc405_boards.c | 53 +++++++++++++-----------------------------
>  1 file changed, 16 insertions(+), 37 deletions(-)
>
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index f47b15f10e..728154aebb 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -158,7 +158,7 @@ static void ref405ep_init(MachineState *machine)
>      target_ulong kernel_base, initrd_base;
>      long kernel_size, initrd_size;
>      int linux_boot;
> -    int fl_idx, fl_sectors, len;
> +    int len;
>      DriveInfo *dinfo;
>      MemoryRegion *sysmem =3D get_system_memory();
>
> @@ -185,26 +185,19 @@ static void ref405ep_init(MachineState *machine)
>  #ifdef DEBUG_BOARD_INIT
>      printf("%s: register BIOS\n", __func__);
>  #endif
> -    fl_idx =3D 0;
>  #ifdef USE_FLASH_BIOS
> -    dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
> +    dinfo =3D drive_get(IF_PFLASH, 0, 0);
>      if (dinfo) {
> -        BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
> -
> -        bios_size =3D blk_getlength(blk);
> -        fl_sectors =3D (bios_size + 65535) >> 16;
>  #ifdef DEBUG_BOARD_INIT
> -        printf("Register parallel flash %d size %lx"
> -               " at addr %lx '%s' %d\n",
> -               fl_idx, bios_size, -bios_size,
> -               blk_name(blk), fl_sectors);
> +        printf("Register parallel flash\n");
>  #endif
> -        pflash_cfi02_register((uint32_t)(-bios_size),
> +        bios_size =3D 0x80000;

 bios_size =3D 8 * MiB?

> +        pflash_cfi02_register(0xFFF80000,
>                                NULL, "ef405ep.bios", bios_size,
> -                              blk, 65536, fl_sectors, 1,
> +                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                              65536, bios_size / 65536, 1,

64 * KiB?

>                                2, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);
> -        fl_idx++;
>      } else
>  #endif
>      {
> @@ -455,7 +448,7 @@ static void taihu_405ep_init(MachineState *machine)
>      target_ulong kernel_base, initrd_base;
>      long kernel_size, initrd_size;
>      int linux_boot;
> -    int fl_idx, fl_sectors;
> +    int fl_idx;
>      DriveInfo *dinfo;
>
>      /* RAM is soldered to the board so the size cannot be changed */
> @@ -486,21 +479,14 @@ static void taihu_405ep_init(MachineState *machine)
>  #if defined(USE_FLASH_BIOS)
>      dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
>      if (dinfo) {
> -        BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
> -
> -        bios_size =3D blk_getlength(blk);
> -        /* XXX: should check that size is 2MB */
> -        //        bios_size =3D 2 * 1024 * 1024;
> -        fl_sectors =3D (bios_size + 65535) >> 16;
>  #ifdef DEBUG_BOARD_INIT
> -        printf("Register parallel flash %d size %lx"
> -               " at addr %lx '%s' %d\n",
> -               fl_idx, bios_size, -bios_size,
> -               blk_name(blk), fl_sectors);
> +        printf("Register boot flash\n");
>  #endif
> -        pflash_cfi02_register((uint32_t)(-bios_size),
> +        bios_size =3D 2 * MiB;
> +        pflash_cfi02_register(0xFFE00000,
>                                NULL, "taihu_405ep.bios", bios_size,
> -                              blk, 65536, fl_sectors, 1,
> +                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                              65536, bios_size / 65536, 1,

64 * KiB

>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);
>          fl_idx++;
> @@ -536,20 +522,13 @@ static void taihu_405ep_init(MachineState *machine)
>      /* Register Linux flash */
>      dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
>      if (dinfo) {
> -        BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
> -
> -        bios_size =3D blk_getlength(blk);
> -        /* XXX: should check that size is 32MB */
>          bios_size =3D 32 * MiB;
> -        fl_sectors =3D (bios_size + 65535) >> 16;
>  #ifdef DEBUG_BOARD_INIT
> -        printf("Register parallel flash %d size %lx"
> -               " at addr " TARGET_FMT_lx " '%s'\n",
> -               fl_idx, bios_size, (target_ulong)0xfc000000,
> -               blk_name(blk));
> +        printf("Register application flash\n"
>  #endif
>          pflash_cfi02_register(0xfc000000, NULL, "taihu_405ep.flash", bio=
s_size,
> -                              blk, 65536, fl_sectors, 1,
> +                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                              65536, bios_size / 65536, 1,

64 * KiB

>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);
>          fl_idx++;


--
Alex Benn=C3=A9e
