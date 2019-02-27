Received: from eggs.gnu.org ([209.51.188.92]:34464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyx1s-0007XU-W5
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyx1r-0008No-3e
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:05:36 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyx1q-0007qc-TW
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:05:35 -0500
Received: by mail-wm1-x344.google.com with SMTP id g20so4411020wmh.5
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 03:04:53 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-7-armbru@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190226193408.23862-7-armbru@redhat.com>
Date: Wed, 27 Feb 2019 11:04:50 +0000
Message-ID: <87tvgplcfh.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/11] sam460ex: Don't size flash memory
 to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>


Markus Armbruster <armbru@redhat.com> writes:

> Machine "sam460ex" maps its flash memory at address 0xFFF00000.  When
> no image is supplied, its size is 1MiB (0x100000), and 512KiB of ROM
> get mapped on top of its second half.  Else, it's the size of the
> image rounded up to the next multiple of 64KiB.
>
> The rounding is actually useless: pflash_cfi01_realize() fails with
> "failed to read the initial flash content" unless it's a no-op.
>
> I have no idea what happens when the pflash's size exceeds 1MiB.
> Useful outcomes seem unlikely.
>
> I guess memory at the end of the address space remains unmapped when
> it's smaller than 1MiB.  Again, useful outcomes seem unlikely.
>
> The physical hardware appears to have 512KiB of flash memory:
> https://eu.mouser.com/datasheet/2/268/atmel_AT49BV040B-1180330.pdf
>
> For now, just set the flash memory size to 1MiB regardless of image
> size, and document the mess.
>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/ppc/sam460ex.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 75250d49e4..0c919529f8 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -91,32 +91,43 @@ struct boot_info {
>
>  static int sam460ex_load_uboot(void)
>  {
> +    /*
> +     * This first creates 1MiB of flash memory mapped at the end of
> +     * the 32-bit address space (0xFFF00000..0xFFFFFFFF).
> +     *
> +     * If_PFLASH unit 0 is defined, the flash memory is initialized
> +     * from that block backend.
> +     *
> +     * Else, it's initialized to zero.  And then 512KiB of ROM get
> +     * mapped on top of its second half (0xFFF80000..0xFFFFFFFF),
> +     * initialized from u-boot-sam460-20100605.bin.
> +     *
> +     * This doesn't smell right.
> +     *
> +     * The physical hardware appears to have 512KiB flash memory.
> +     *
> +     * TODO Figure out what we really need here, and clean this up.
> +     */
> +
>      DriveInfo *dinfo;
> -    BlockBackend *blk =3D NULL;
> -    hwaddr base =3D FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32);
> -    long bios_size =3D FLASH_SIZE;
> -    int fl_sectors;
>
>      dinfo =3D drive_get(IF_PFLASH, 0, 0);
> -    if (dinfo) {
> -        blk =3D blk_by_legacy_dinfo(dinfo);
> -        bios_size =3D blk_getlength(blk);
> -    }
> -    fl_sectors =3D (bios_size + 65535) >> 16;
> -
> -    if (!pflash_cfi01_register(base, NULL, "sam460ex.flash", bios_size,
> -                               blk, 64 * KiB, fl_sectors,
> +    if (!pflash_cfi01_register(FLASH_BASE | ((hwaddr)FLASH_BASE_H << 32),
> +                               NULL, "sam460ex.flash", FLASH_SIZE,
> +                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> +                               64 * KiB, FLASH_SIZE / (64 * KiB),
>                                 1, 0x89, 0x18, 0x0000, 0x0, 1)) {
>          error_report("Error registering flash memory");
>          /* XXX: return an error instead? */
>          exit(1);
>      }
>
> -    if (!blk) {
> +    if (!dinfo) {
>          /*error_report("No flash image given with the 'pflash' parameter=
,"
>                  " using default u-boot image");*/
> -        base =3D UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32);
> -        rom_add_file_fixed(UBOOT_FILENAME, base, -1);
> +        rom_add_file_fixed(UBOOT_FILENAME,
> +                           UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32=
),
> +                           -1);
>      }
>
>      return 0;


--
Alex Benn=C3=A9e
