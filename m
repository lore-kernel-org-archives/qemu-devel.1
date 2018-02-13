Received: from eggs.gnu.org ([2001:4830:134:3::10]:47344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elRdc-0000j1-8r
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 22:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elRda-0004RU-H5
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 22:52:12 -0500
Date: Tue, 13 Feb 2018 14:51:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180213035159.GJ11634@umbus.fritz.box>
References: <20180130075847.6023-1-david.engraf@sysgo.com>
	<20180208083621.24435-1-david.engraf@sysgo.com>
	<20180209053349.GH11634@umbus.fritz.box>
	<78c633d2-d693-2879-5431-e3991bbb4026@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LuMRVxdB65zydaDL"
Content-Disposition: inline
In-Reply-To: <78c633d2-d693-2879-5431-e3991bbb4026@sysgo.com>
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


--LuMRVxdB65zydaDL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 08:49:45AM +0100, David Engraf wrote:
> Hello David,
>=20
> Am 09.02.2018 um 06:33 schrieb David Gibson:
> > On Thu, Feb 08, 2018 at 09:36:21AM +0100, David Engraf wrote:
> > > This patch fixes an incorrect behavior when the -kernel argument has =
been
> > > specified without -bios. In this case the kernel was loaded twice. At=
 address
> > > 32M as a raw image and afterwards by load_elf/load_uimage at the
> > > corresponding load address. In this case the region for the device tr=
ee and
> > > the raw kernel image may overlap.
> > >=20
> > > The patch fixes the behavior by loading the kernel image once with
> > > load_elf/load_uimage and skips loading the raw image. It also ensures=
 that
> > > the device tree is generated behind bios/kernel/initrd.
> > >=20
> > > Signed-off-by: David Engraf <david.engraf@sysgo.com>
> >=20
> > Sorry I've taken so long to respond to this.  I've been busy, then
> > away, then busy, then recovering from surgery, then...
> >=20
> > I think this looks good overall, just a couple of details I'd like to
> > check, see below.
> >=20
> > > ---
> > >   hw/ppc/e500.c | 89 ++++++++++++++++++++++++++++++++----------------=
-----------
> > >   1 file changed, 48 insertions(+), 41 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> > > index c4fe06ea2a..0321bd66a8 100644
> > > --- a/hw/ppc/e500.c
> > > +++ b/hw/ppc/e500.c
> > > @@ -776,7 +776,6 @@ void ppce500_init(MachineState *machine, PPCE500P=
arams *params)
> > >       MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> > >       PCIBus *pci_bus;
> > >       CPUPPCState *env =3D NULL;
> > > -    uint64_t loadaddr;
> > >       hwaddr kernel_base =3D -1LL;
> > >       int kernel_size =3D 0;
> > >       hwaddr dt_base =3D 0;
> > > @@ -913,11 +912,6 @@ void ppce500_init(MachineState *machine, PPCE500=
Params *params)
> > >       /* Register spinning region */
> > >       sysbus_create_simple("e500-spin", params->spin_base, NULL);
> > > -    if (cur_base < (32 * 1024 * 1024)) {
> > > -        /* u-boot occupies memory up to 32MB, so load blobs above */
> > > -        cur_base =3D (32 * 1024 * 1024);
> > > -    }
> > > -
> > >       if (params->has_mpc8xxx_gpio) {
> > >           qemu_irq poweroff_irq;
> > > @@ -952,36 +946,6 @@ void ppce500_init(MachineState *machine, PPCE500=
Params *params)
> > >                                       sysbus_mmio_get_region(s, 0));
> > >       }
> > > -    /* Load kernel. */
> > > -    if (machine->kernel_filename) {
> > > -        kernel_base =3D cur_base;
> > > -        kernel_size =3D load_image_targphys(machine->kernel_filename,
> > > -                                          cur_base,
> > > -                                          ram_size - cur_base);
> > > -        if (kernel_size < 0) {
> > > -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> > > -                    machine->kernel_filename);
> > > -            exit(1);
> > > -        }
> > > -
> > > -        cur_base +=3D kernel_size;
> > > -    }
> > > -
> > > -    /* Load initrd. */
> > > -    if (machine->initrd_filename) {
> > > -        initrd_base =3D (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_M=
ASK;
> > > -        initrd_size =3D load_image_targphys(machine->initrd_filename=
, initrd_base,
> > > -                                          ram_size - initrd_base);
> > > -
> > > -        if (initrd_size < 0) {
> > > -            fprintf(stderr, "qemu: could not load initial ram disk '=
%s'\n",
> > > -                    machine->initrd_filename);
> > > -            exit(1);
> > > -        }
> > > -
> > > -        cur_base =3D initrd_base + initrd_size;
> > > -    }
> > > -
> > >       /*
> > >        * Smart firmware defaults ahead!
> > >        *
> > > @@ -1006,24 +970,67 @@ void ppce500_init(MachineState *machine, PPCE5=
00Params *params)
> > >       }
> > >       filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> > > -    bios_size =3D load_elf(filename, NULL, NULL, &bios_entry, &loada=
ddr, NULL,
> > > +    bios_size =3D load_elf(filename, NULL, NULL, &bios_entry, &cur_b=
ase, NULL,
> > >                            1, PPC_ELF_MACHINE, 0, 0);
> > >       if (bios_size < 0) {
> > >           /*
> > >            * Hrm. No ELF image? Try a uImage, maybe someone is giving=
 us an
> > >            * ePAPR compliant kernel
> > >            */
> > > -        kernel_size =3D load_uimage(filename, &bios_entry, &loadaddr=
, NULL,
> > > -                                  NULL, NULL);
> > > -        if (kernel_size < 0) {
> > > +        bios_size =3D load_uimage(filename, &bios_entry, &cur_base, =
NULL,
> > > +                                NULL, NULL);
> > > +        if (bios_size < 0) {
> > >               fprintf(stderr, "qemu: could not load firmware '%s'\n",=
 filename);
> > >               exit(1);
> > >           }
> > >       }
> > > +    cur_base +=3D bios_size;
> > >       g_free(filename);
> > > +    /* Load bare kernel only if no bios/u-boot has been provided */
> > > +    if (machine->kernel_filename !=3D bios_name) {
> >=20
> > This condition seems weird.  Why would the kernel and bios images be
> > the same.  I guess this because of the logic setting bios_name above,
> > which also seems kind of weird.  Can you clarify what's going on here,
> > changing that bios_name setting logic, if necessary?
>=20
> Basically I didn't change the logic to store the kernel name into bios_na=
me
> when the -bios options was not provided. In this case the kernel will be
> used as payload. Indeed the name is a bit weird. What do you think about
> changing the names from bios to payload?

That might be useful.  I'm still a bit confused, though - why does
combining bios and kernel as a single "payload" make sense?  From the
looks of the code it seems that they are separate things and either or
both could be loaded separately.  What am I missing?

>=20
> > > +        kernel_base =3D cur_base;
> > > +        kernel_size =3D load_image_targphys(machine->kernel_filename,
> > > +                                          cur_base,
> > > +                                          ram_size - cur_base);
> > > +        if (kernel_size < 0) {
> > > +            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> > > +                    machine->kernel_filename);
> > > +            exit(1);
> > > +        }
> > > +
> > > +        cur_base +=3D kernel_size;
> > > +    } else {
> > > +        kernel_base =3D cur_base;
> > > +        kernel_size =3D bios_size;
> >=20
> > Is this right?  You've already advanced cur_base by bios_size from
> > where you loaded the bios image, so kernel_base here will point
> > *after* the bios, not into it, but kernel_size is set to bios_size.
> > This seems strange.
>=20
> Right, kernel_base should point to the start of the kernel.
>=20
> Best regards
> - David
>=20
>=20
> > > +    }
> > > +
> > > +    if (cur_base < (32 * 1024 * 1024)) {
> > > +        /* u-boot occupies memory up to 32MB, so load blobs above */
> > > +        cur_base =3D (32 * 1024 * 1024);
> > > +    }
> > > +
> > > +    /* Load initrd. */
> > > +    if (machine->initrd_filename) {
> > > +        initrd_base =3D (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_M=
ASK;
> > > +        initrd_size =3D load_image_targphys(machine->initrd_filename=
, initrd_base,
> > > +                                          ram_size - initrd_base);
> > > +
> > > +        if (initrd_size < 0) {
> > > +            fprintf(stderr, "qemu: could not load initial ram disk '=
%s'\n",
> > > +                    machine->initrd_filename);
> > > +            exit(1);
> > > +        }
> > > +
> > > +        cur_base =3D initrd_base + initrd_size;
> > > +    }
> > > +
> > >       /* Reserve space for dtb */
> > > -    dt_base =3D (loadaddr + bios_size + DTC_LOAD_PAD) & ~DTC_PAD_MAS=
K;
> > > +    dt_base =3D (cur_base + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
> > > +    if (dt_base + DTB_MAX_SIZE > ram_size) {
> > > +            fprintf(stderr, "qemu: not enough memory for device tree=
\n");
> > > +            exit(1);
> > > +    }
> > >       dt_size =3D ppce500_prep_device_tree(machine, params, dt_base,
> > >                                          initrd_base, initrd_size,
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LuMRVxdB65zydaDL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqCYN8ACgkQbDjKyiDZ
s5LrdRAAvkg6fohE2NB/pToX1/PUs6lrPMBT5j+OGpWLX59n3/2XbTisM1SDaNvE
pqxkEWWEGFcUplBiTE5cHl1UOWrjgWw+u3CeFDwUneqhygSbxh5Rv4Ir8NKSvD+8
l3dM6asbJ2xYMGZFNy83+uwlpHZEHfrZmk1FYPhaLXZzdaB0TCqB9BCBNuHFX/2U
ct8Hi2gjngLh9iquZLaKiZBOCK55vebF4/JuJREBloPplxoH/Weuh+qIxNMwIPTr
wgaqFV1VFLbUBFgcFJQYXRMtHs210hJYNdBGcz6u7VNX2DDfL+cpGeNlRf2vv505
gPf3oVgu16ypeJatQ/HL4UXj/bFOPSxMMeeKrS4v0VaouEuN9zye5+8H21IM+5Oa
k/Ygw7TF123PKML/XMGkEFP6+wi/a4qrp4SX/Q7NE3g9in3v2lnJ2m/RQi9sCMj5
B3Hhp0Rx0AZYthGuJq3WJFSe9IVscp36UwOxEItreddaZfinpWaPpbJfePG/LIcn
KksmthtlU8Gt7/X0cHXqFpmauKr/3jeWUSFaD25fdZmJSw5bJbjCJ6RLgJMS/8Sj
MYG+pZi8MEf2o5+NWnnMr1EcWAISVx/VadRoDb+MP6MsSpG1V9EReP9Qit2OCpYY
7KJYeY9yWB+Ri55BIq4G7JiqW2+E6zOdmpqxV8yK67wyGGJkJ8Q=
=hz4h
-----END PGP SIGNATURE-----

--LuMRVxdB65zydaDL--
