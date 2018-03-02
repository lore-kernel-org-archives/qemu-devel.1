Received: from eggs.gnu.org ([2001:4830:134:3::10]:37039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erZlm-00006k-Di
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erZli-0004gV-GP
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 20:45:58 -0500
Date: Fri, 2 Mar 2018 12:45:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180302014546.GD13135@umbus.fritz.box>
References: <20180213102258.26145-1-david.engraf@sysgo.com>
	<20180215093600.18505-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline
In-Reply-To: <20180215093600.18505-1-david.engraf@sysgo.com>
Subject: Re: [Qemu-devel] [PATCH v3] PPC: e500: Fix duplicate kernel load
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


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 10:36:00AM +0100, David Engraf wrote:
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

Sorry I've taken so long to reply to this.  It looks fine to me,
however, other changes mean it longer quite applies to the
ppc-for-2.12 tree.  Can you fix that up and repost please.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/e500.c | 116 +++++++++++++++++++++++++++++++++++-----------------=
------
>  1 file changed, 70 insertions(+), 46 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index c4fe06ea2a..414c4beaab 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -784,8 +784,10 @@ void ppce500_init(MachineState *machine, PPCE500Para=
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
> @@ -913,11 +915,6 @@ void ppce500_init(MachineState *machine, PPCE500Para=
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
> @@ -952,8 +949,61 @@ void ppce500_init(MachineState *machine, PPCE500Para=
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
> +            fprintf(stderr, "qemu: could not load firmware '%s'\n", file=
name);
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
> @@ -967,6 +1017,11 @@ void ppce500_init(MachineState *machine, PPCE500Par=
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
> @@ -983,47 +1038,16 @@ void ppce500_init(MachineState *machine, PPCE500Pa=
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
> -            fprintf(stderr, "qemu: could not load firmware '%s'\n", file=
name);
> +    dt_base =3D (loadaddr + payload_size + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
> +    if (dt_base + DTB_MAX_SIZE > ram_size) {
> +            fprintf(stderr, "qemu: not enough memory for device tree\n");
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

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqYrMoACgkQbDjKyiDZ
s5JTYRAAwKiXn6t/elULLlWNZzabUMRayPqKcvJc1fE8xSeATkTHQW8Zi6DVcLKD
nJ1zynivpaCv4LlXOu9vduJ/CNoLvynWLEQap/bRo13/1v6uEiS5olqN/g7CnHdE
NLOohYo3H9N+xAdpCSt65ZEm5OdrKUGbJ/wRG+Lsjd0/Mqzg2X1XpuRkIi2cKENn
q0WHjHrXF09yLvIC00r8WSagzE8mOOOuX49jZnDzJ58tYzPnVUWaqpsjW8Q+Y8HY
YxKohLLg/4V0FZ33vu+kep2Xsu5vxamWR83pDjD5w8iV0z30oOZj+THILD1sJ2Gw
BxWEd/u5ltucY8bhA+pKokifNobLWqG3d19VjV7MnMGme+Em4GN+AH4oe/zbh4Kv
eZHNRMLIcGDsJLP0K4u4kGW7jFX2BaNOFQrhcUx8YQchJ8AApjxwqtMMj+M9IGJL
NqQCY7MPCffoyazVasVBGUgk4aUFiTSE06GUe0nOeLSf41MLeHxtPFeSDtLdCOGt
DDvfANE9wrytEofZq73PEORROoxz5ZwT63utBTbW2w+4qTHbftSrqOefIoCURr6J
O6HBs2BlfRu7ho0t8vo6gKeFuGQ2GE+uhiw6TGTKVkDQVQIP21pJfakktHnfmpVr
ZSFS5O8cmiN7ylUGf/rB3t9b0AWvzzyHaFjWoJnL/9uUODcN8og=
=k1QL
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
