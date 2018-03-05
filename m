Received: from eggs.gnu.org ([2001:4830:134:3::10]:35627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esf5L-00010q-3e
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 20:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esf5H-0003i2-45
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 20:38:39 -0500
Date: Mon, 5 Mar 2018 12:37:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180305013746.GE2650@umbus.fritz.box>
References: <20180302014546.GD13135@umbus.fritz.box>
	<20180302112013.17928-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EXKGNeO8l0xGFBjy"
Content-Disposition: inline
In-Reply-To: <20180302112013.17928-1-david.engraf@sysgo.com>
Subject: Re: [Qemu-devel] [PATCH v4] PPC: e500: Fix duplicate kernel load
 and device tree overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Engraf <david.engraf@sysgo.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 12:20:13PM +0100, David Engraf wrote:
> This patch fixes an incorrect behavior when the -kernel argument has been
> specified without -bios. In this case the kernel was loaded twice. At add=
ress
> 32M as a raw image and afterwards by load_elf/load_uimage at the
> corresponding load address. In this case the region for the device tree a=
nd
> the raw kernel image may overlap.
>=20
> The patch fixes the behavior by loading the kernel image once with
> load_elf/load_uimage and skips loading the raw image.
>=20
> When here do not use bios_name/size for the kernel and use a more generic
> name called payload_name/size.
>=20
> New in v3: dtb must be stored between kernel and initrd because Linux can
>            handle the dtb only within the first 64MB. Add a comment to
>            clarify the behavior.
>=20
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied, thanks.

> ---
>  hw/ppc/e500.c | 116 +++++++++++++++++++++++++++++++++++-----------------=
------
>  1 file changed, 70 insertions(+), 46 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index ef541a00be..43c15d18c4 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -792,8 +792,10 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
>      int initrd_size =3D 0;
>      hwaddr cur_base =3D 0;
>      char *filename;
> +    const char *payload_name;
> +    bool kernel_as_payload;
>      hwaddr bios_entry =3D 0;
> -    target_long bios_size;
> +    target_long payload_size;
>      struct boot_info *boot_info;
>      int dt_size;
>      int i;
> @@ -921,11 +923,6 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
>      /* Register spinning region */
>      sysbus_create_simple("e500-spin", params->spin_base, NULL);
> =20
> -    if (cur_base < (32 * 1024 * 1024)) {
> -        /* u-boot occupies memory up to 32MB, so load blobs above */
> -        cur_base =3D (32 * 1024 * 1024);
> -    }
> -
>      if (params->has_mpc8xxx_gpio) {
>          qemu_irq poweroff_irq;
> =20
> @@ -960,8 +957,61 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
>                                      sysbus_mmio_get_region(s, 0));
>      }
> =20
> -    /* Load kernel. */
> -    if (machine->kernel_filename) {
> +    /*
> +     * Smart firmware defaults ahead!
> +     *
> +     * We follow the following table to select which payload we execute.
> +     *
> +     *  -kernel | -bios | payload
> +     * ---------+-------+---------
> +     *     N    |   Y   | u-boot
> +     *     N    |   N   | u-boot
> +     *     Y    |   Y   | u-boot
> +     *     Y    |   N   | kernel
> +     *
> +     * This ensures backwards compatibility with how we used to expose
> +     * -kernel to users but allows them to run through u-boot as well.
> +     */
> +    kernel_as_payload =3D false;
> +    if (bios_name =3D=3D NULL) {
> +        if (machine->kernel_filename) {
> +            payload_name =3D machine->kernel_filename;
> +            kernel_as_payload =3D true;
> +        } else {
> +            payload_name =3D "u-boot.e500";
> +        }
> +    } else {
> +        payload_name =3D bios_name;
> +    }
> +
> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
> +
> +    payload_size =3D load_elf(filename, NULL, NULL, &bios_entry, &loadad=
dr, NULL,
> +                            1, PPC_ELF_MACHINE, 0, 0);
> +    if (payload_size < 0) {
> +        /*
> +         * Hrm. No ELF image? Try a uImage, maybe someone is giving us an
> +         * ePAPR compliant kernel
> +         */
> +        payload_size =3D load_uimage(filename, &bios_entry, &loadaddr, N=
ULL,
> +                                   NULL, NULL);
> +        if (payload_size < 0) {
> +            error_report("qemu: could not load firmware '%s'", filename);
> +            exit(1);
> +        }
> +    }
> +
> +    g_free(filename);
> +
> +    if (kernel_as_payload) {
> +        kernel_base =3D loadaddr;
> +        kernel_size =3D payload_size;
> +    }
> +
> +    cur_base =3D loadaddr + payload_size;
> +
> +    /* Load bare kernel only if no bios/u-boot has been provided */
> +    if (machine->kernel_filename && !kernel_as_payload) {
>          kernel_base =3D cur_base;
>          kernel_size =3D load_image_targphys(machine->kernel_filename,
>                                            cur_base,
> @@ -975,6 +1025,11 @@ void ppce500_init(MachineState *machine, PPCE500Par=
ams *params)
>          cur_base +=3D kernel_size;
>      }
> =20
> +    if (cur_base < (32 * 1024 * 1024)) {
> +        /* u-boot occupies memory up to 32MB, so load blobs above */
> +        cur_base =3D (32 * 1024 * 1024);
> +    }
> +
>      /* Load initrd. */
>      if (machine->initrd_filename) {
>          initrd_base =3D (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
> @@ -991,47 +1046,16 @@ void ppce500_init(MachineState *machine, PPCE500Pa=
rams *params)
>      }
> =20
>      /*
> -     * Smart firmware defaults ahead!
> -     *
> -     * We follow the following table to select which payload we execute.
> -     *
> -     *  -kernel | -bios | payload
> -     * ---------+-------+---------
> -     *     N    |   Y   | u-boot
> -     *     N    |   N   | u-boot
> -     *     Y    |   Y   | u-boot
> -     *     Y    |   N   | kernel
> -     *
> -     * This ensures backwards compatibility with how we used to expose
> -     * -kernel to users but allows them to run through u-boot as well.
> +     * Reserve space for dtb behind the kernel image because Linux has a=
 bug
> +     * where it can only handle the dtb if it's within the first 64MB of=
 where
> +     * <kernel> starts. dtb cannot not reach initrd_base because INITRD_=
LOAD_PAD
> +     * ensures enough space between kernel and initrd.
>       */
> -    if (bios_name =3D=3D NULL) {
> -        if (machine->kernel_filename) {
> -            bios_name =3D machine->kernel_filename;
> -        } else {
> -            bios_name =3D "u-boot.e500";
> -        }
> -    }
> -    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -
> -    bios_size =3D load_elf(filename, NULL, NULL, &bios_entry, &loadaddr,=
 NULL,
> -                         1, PPC_ELF_MACHINE, 0, 0);
> -    if (bios_size < 0) {
> -        /*
> -         * Hrm. No ELF image? Try a uImage, maybe someone is giving us an
> -         * ePAPR compliant kernel
> -         */
> -        kernel_size =3D load_uimage(filename, &bios_entry, &loadaddr, NU=
LL,
> -                                  NULL, NULL);
> -        if (kernel_size < 0) {
> -            error_report("could not load firmware '%s'", filename);
> +    dt_base =3D (loadaddr + payload_size + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
> +    if (dt_base + DTB_MAX_SIZE > ram_size) {
> +            error_report("qemu: not enough memory for device tree");
>              exit(1);
> -        }
>      }
> -    g_free(filename);
> -
> -    /* Reserve space for dtb */
> -    dt_base =3D (loadaddr + bios_size + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
> =20
>      dt_size =3D ppce500_prep_device_tree(machine, params, dt_base,
>                                         initrd_base, initrd_size,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EXKGNeO8l0xGFBjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqcn2oACgkQbDjKyiDZ
s5IyMxAAyNly2LRE1xOUKs//dx8X0QErMydMd2bKv+yNpmBVQuxij0WzgW2fSzPn
pEuR5UJ1EiuI8RCOlLvQhiRscVRqDYC1sLznYlKSx5R/z+gSu/1s7QQ/hj3Dq7ON
d5UB2wuvOG14hYdVwugP2cTBkzm/7BHDsUQLX1y1O6UWBiSffVHaZvWLrn13iXN3
wr2W30mFySdBU0Ji7ZljLPyTKYmXeRjL8wf1Muu2H//c11x5f71xF+OheHCvY10Y
0Bq2rBVILtiZ61TOlWaz2kU8YI/EudqYtgwIMbDYdbQGAKgEv2yR/tg/9Uc3pSr/
yiByObqxOEJVxxuYA1q+hJlflmMUCKxVy2DybkhwWC08C/9tAN+o60+QlIFPRjht
w8bHQ/Qr+sA0ByJvKZi6BNxrFGwqa/zx4uR+E5ridxso3AMO2PhToPC7J7gdgr8I
/Blx9QDd3YITUfqxIWiQGF3G/HA1GJ+2pcq7Alko74ccE2mzfcE0TaVDiY3BkeFK
V/1L2q9ei9T70j2oEQkhtdmwbUPUh1ZDjnhplVzrc3JZ0G3qpdH6Xz1pNPQ5PAQI
I2BID2DGhmc3tJSy0yPZkUMxUYzt1qYtsfqMajspRgx42oD/lMoaE3soC6A35/sQ
eNWu/elOzxc78G5kklxUEkVV7WV2Xrspv+ujgga/eK8u5ZEY4+Y=
=X2Lv
-----END PGP SIGNATURE-----

--EXKGNeO8l0xGFBjy--
