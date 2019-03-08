Received: from eggs.gnu.org ([209.51.188.92]:39388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h236C-00044G-QP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h236A-0003qG-Gt
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:10:52 -0500
Date: Fri, 8 Mar 2019 11:10:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308001032.GF7722@umbus.fritz.box>
References: <20190307130323.9353-1-armbru@redhat.com>
	<20190307130323.9353-8-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vK3aNhhOnFYnG5nq"
Content-Disposition: inline
In-Reply-To: <20190307130323.9353-8-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/14] ppc405_boards: Don't size flash
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
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, philmd@redhat.com, balaton@eik.bme.hu


--vK3aNhhOnFYnG5nq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 02:03:16PM +0100, Markus Armbruster wrote:
> Machine "ref405ep" maps its flash memory at address 2^32 - image size.
> Image size is rounded up to the next multiple of 64KiB.  Useless,
> because pflash_cfi02_realize() fails with "failed to read the initial
> flash content" unless the rounding is a no-op.
>=20
> If the image size exceeds 0x80000 Bytes, we overlap first SRAM, then
> other stuff.  No idea how that would play out, but useful outcomes
> seem unlikely.
>=20
> Map the flash memory at fixed address 0xFFF80000 with size 512KiB,
> regardless of image size, to match the physical hardware.
>=20
> Machine "taihu" maps its boot flash memory similarly.  The code even
> has a comment /* XXX: should check that size is 2MB */, followed by
> disabled code to adjust the size to 2MiB regardless of image size.
>=20
> Its code to map its application flash memory looks the same, except
> there the XXX comment asks for 32MiB, and the code to adjust the size
> isn't disabled.  Note that pflash_cfi02_realize() fails with "failed
> to read the initial flash content" for images smaller than 32MiB.
>=20
> Map the boot flash memory at fixed address 0xFFE00000 with size 2MiB,
> to match the physical hardware.  Delete dead code from application
> flash mapping, and simplify some.
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>

I'm assuming because this is in a series I'm not otherwise CCed on
that this is going in through someone else's tree.  Let me know if you
want me take it through mine.

> ---
>  hw/ppc/ppc405_boards.c | 51 +++++++++++++-----------------------------
>  1 file changed, 15 insertions(+), 36 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index f47b15f10e..672717ef1b 100644
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
> =20
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
> +        bios_size =3D 8 * MiB;
>          pflash_cfi02_register((uint32_t)(-bios_size),
>                                NULL, "ef405ep.bios", bios_size,
> -                              blk, 65536, fl_sectors, 1,
> +                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                              64 * KiB, bios_size / (64 * KiB), 1,
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
> =20
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
> +                              64 * KiB, bios_size / (64 * KiB), 1,
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
> +                              64 * KiB, bios_size / (64 * KiB), 1,
>                                4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
>                                1);
>          fl_idx++;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vK3aNhhOnFYnG5nq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBsvgACgkQbDjKyiDZ
s5KPqhAAruYVfrQC4V1UVp2Ll5lJdXlJvaVHpth3TPX5G4XfYz637sbZdEBHrCcC
Q3paD9DdD6QjQ2ODut9WfMdoQfl9S4ntxe0YEBsd5ZVDQ7Um/CfTlNNgXl+HEbta
0yQRDBBySyhLta/Qu2Xnmun1i9LEgX/+tE3x4TnGpZ83ZaqruEqB3LpEttNEgLPN
RoR9AliMIPJ7tUBFMXsD3LARMSFr1n/xtDnabrnqGjjGK73MqrSn15YSWEu0sS8G
yM2ZqIE04NtLS/KsbonmjVRNp1MBywHJl+t/BrVgpzhElsRS0h0gr9zrz+AtFRUf
xiSlArw+sFlI9KBKaKMkN6AL6f+nvMDmwgJn1bKr68Gv5tsT7G51GvYMOcdkfpvB
nBAR2ZEh9LQv0ZOTWrNhLTZrwRa7cVvrdU/NGzKAI8uDrWSbwMIwRET+kECNnDdA
ecEBC+hxK4U7vFWAx/u8tdh9yXBKGIb3ZRHjNJ1WemNp4A/g2XzDEy17o5u3qN/r
eqNLY2AQUzQ9E+JLCsv2K537xjqKPXvDabrWnwrBL1wtZh4rD4FsbjlgMJfUm+mq
ba55H68LzpyTK89/pdZRewuBrY1b6QYlfCMyyYYOfgP6eCd7JkAsCdOpFHXdapda
7H89Mt5/ug0r1lZ/wKdmd+xYxAMZrl7xd8Qn4q/UovXcSSIcARA=
=XPuI
-----END PGP SIGNATURE-----

--vK3aNhhOnFYnG5nq--
