Received: from eggs.gnu.org ([2001:4830:134:3::10]:58019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ek1Jv-00089G-TA
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 00:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ek1Ju-0005gT-8x
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 00:33:59 -0500
Date: Fri, 9 Feb 2018 16:33:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180209053349.GH11634@umbus.fritz.box>
References: <20180130075847.6023-1-david.engraf@sysgo.com>
	<20180208083621.24435-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
Content-Disposition: inline
In-Reply-To: <20180208083621.24435-1-david.engraf@sysgo.com>
Subject: Re: [Qemu-devel] [RESEND PATCH] PPC: e500: Fix duplicate kernel
 load and device tree overlap
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


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2018 at 09:36:21AM +0100, David Engraf wrote:
> This patch fixes an incorrect behavior when the -kernel argument has been
> specified without -bios. In this case the kernel was loaded twice. At add=
ress
> 32M as a raw image and afterwards by load_elf/load_uimage at the
> corresponding load address. In this case the region for the device tree a=
nd
> the raw kernel image may overlap.
>=20
> The patch fixes the behavior by loading the kernel image once with
> load_elf/load_uimage and skips loading the raw image. It also ensures that
> the device tree is generated behind bios/kernel/initrd.
>=20
> Signed-off-by: David Engraf <david.engraf@sysgo.com>

Sorry I've taken so long to respond to this.  I've been busy, then
away, then busy, then recovering from surgery, then...

I think this looks good overall, just a couple of details I'd like to
check, see below.

> ---
>  hw/ppc/e500.c | 89 ++++++++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 48 insertions(+), 41 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index c4fe06ea2a..0321bd66a8 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -776,7 +776,6 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>      PCIBus *pci_bus;
>      CPUPPCState *env =3D NULL;
> -    uint64_t loadaddr;
>      hwaddr kernel_base =3D -1LL;
>      int kernel_size =3D 0;
>      hwaddr dt_base =3D 0;
> @@ -913,11 +912,6 @@ void ppce500_init(MachineState *machine, PPCE500Para=
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
> @@ -952,36 +946,6 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
>                                      sysbus_mmio_get_region(s, 0));
>      }
> =20
> -    /* Load kernel. */
> -    if (machine->kernel_filename) {
> -        kernel_base =3D cur_base;
> -        kernel_size =3D load_image_targphys(machine->kernel_filename,
> -                                          cur_base,
> -                                          ram_size - cur_base);
> -        if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> -                    machine->kernel_filename);
> -            exit(1);
> -        }
> -
> -        cur_base +=3D kernel_size;
> -    }
> -
> -    /* Load initrd. */
> -    if (machine->initrd_filename) {
> -        initrd_base =3D (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
> -        initrd_size =3D load_image_targphys(machine->initrd_filename, in=
itrd_base,
> -                                          ram_size - initrd_base);
> -
> -        if (initrd_size < 0) {
> -            fprintf(stderr, "qemu: could not load initial ram disk '%s'\=
n",
> -                    machine->initrd_filename);
> -            exit(1);
> -        }
> -
> -        cur_base =3D initrd_base + initrd_size;
> -    }
> -
>      /*
>       * Smart firmware defaults ahead!
>       *
> @@ -1006,24 +970,67 @@ void ppce500_init(MachineState *machine, PPCE500Pa=
rams *params)
>      }
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> =20
> -    bios_size =3D load_elf(filename, NULL, NULL, &bios_entry, &loadaddr,=
 NULL,
> +    bios_size =3D load_elf(filename, NULL, NULL, &bios_entry, &cur_base,=
 NULL,
>                           1, PPC_ELF_MACHINE, 0, 0);
>      if (bios_size < 0) {
>          /*
>           * Hrm. No ELF image? Try a uImage, maybe someone is giving us an
>           * ePAPR compliant kernel
>           */
> -        kernel_size =3D load_uimage(filename, &bios_entry, &loadaddr, NU=
LL,
> -                                  NULL, NULL);
> -        if (kernel_size < 0) {
> +        bios_size =3D load_uimage(filename, &bios_entry, &cur_base, NULL,
> +                                NULL, NULL);
> +        if (bios_size < 0) {
>              fprintf(stderr, "qemu: could not load firmware '%s'\n", file=
name);
>              exit(1);
>          }
>      }
> +    cur_base +=3D bios_size;
>      g_free(filename);
> =20
> +    /* Load bare kernel only if no bios/u-boot has been provided */
> +    if (machine->kernel_filename !=3D bios_name) {

This condition seems weird.  Why would the kernel and bios images be
the same.  I guess this because of the logic setting bios_name above,
which also seems kind of weird.  Can you clarify what's going on here,
changing that bios_name setting logic, if necessary?

> +        kernel_base =3D cur_base;
> +        kernel_size =3D load_image_targphys(machine->kernel_filename,
> +                                          cur_base,
> +                                          ram_size - cur_base);
> +        if (kernel_size < 0) {
> +            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +                    machine->kernel_filename);
> +            exit(1);
> +        }
> +
> +        cur_base +=3D kernel_size;
> +    } else {
> +        kernel_base =3D cur_base;
> +        kernel_size =3D bios_size;

Is this right?  You've already advanced cur_base by bios_size from
where you loaded the bios image, so kernel_base here will point
*after* the bios, not into it, but kernel_size is set to bios_size.
This seems strange.

> +    }
> +
> +    if (cur_base < (32 * 1024 * 1024)) {
> +        /* u-boot occupies memory up to 32MB, so load blobs above */
> +        cur_base =3D (32 * 1024 * 1024);
> +    }
> +
> +    /* Load initrd. */
> +    if (machine->initrd_filename) {
> +        initrd_base =3D (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
> +        initrd_size =3D load_image_targphys(machine->initrd_filename, in=
itrd_base,
> +                                          ram_size - initrd_base);
> +
> +        if (initrd_size < 0) {
> +            fprintf(stderr, "qemu: could not load initial ram disk '%s'\=
n",
> +                    machine->initrd_filename);
> +            exit(1);
> +        }
> +
> +        cur_base =3D initrd_base + initrd_size;
> +    }
> +
>      /* Reserve space for dtb */
> -    dt_base =3D (loadaddr + bios_size + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
> +    dt_base =3D (cur_base + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
> +    if (dt_base + DTB_MAX_SIZE > ram_size) {
> +            fprintf(stderr, "qemu: not enough memory for device tree\n");
> +            exit(1);
> +    }
> =20
>      dt_size =3D ppce500_prep_device_tree(machine, params, dt_base,
>                                         initrd_base, initrd_size,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp9MroACgkQbDjKyiDZ
s5JnTxAA0yH0PdmLhtYAAFAGahoazu/zATTLLCklOIKddw4mxd2XfWhaWRj9U/9e
ZNUv95VHBZOFsTR3LFxGp8FdlqDzYhYomNaEHbG+6igoqszOb6xV5KYsIPDfBR5k
lPXjeCz59bZ18mPCECQquVm44ROO6W8FMIIIF2mfvS3IQs5N92zU1BgBTcIiX351
rqiNnrhPIKTtaFuc00bGcP+qHoKmGS0oe88PyaJ3FKRVVeTTPBiiC49CQmA4TbjZ
kYFizfDzCa4GkDY4apq6BffMICqrDPI3thaKFR+BYiGDYZYWVUV7tkNuv7Lv6neG
LR5HHQwF2qGSG7FA6mhvbITyBzxi/tb3xnHJc3zOVYlKtUymRcfO0YtXu+0wjoVR
Om6s6ScAoQ5z8WSTA8qP14aKgkx9ZSBnbeEMbC5BmC+q5043RKnzknjZRzBumx2T
7dWkNzfATfwcZ2mHWbqmy3BPShiNwVWtSTe0lOh3WN5nAJ3zdmEAVKDc44GrVeXo
o4cmXzVxHF6FdQId/tYKWpONGHJ49NQjR5z+IbjSL0sEfxLApexyM35b9rwYTy8/
jLy7S2EvyZhmVYBNDggyGmskiCWCByDggMG4EFUiZsS+dDvtbw4zm6QPVIymPU9i
/nPJx0yf6+GNC3QCHOaUY7cKWkWrkPEwssBfhUWUD4Qvgh6k8EU=
=S5Fb
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--
