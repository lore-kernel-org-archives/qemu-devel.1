Received: from eggs.gnu.org ([2001:4830:134:3::10]:45817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkiIU-0006De-3m
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkiIS-0005J5-Cx
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:55:06 -0400
Date: Thu, 24 Aug 2017 12:44:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824024438.GZ5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ab632ef70b02efb2257d9e2f08b45b097ebacb3a.1503249785.git.balaton@eik.bme.hu>
	<20170823041644.GP5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231217070.76247@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p+/4B2pcxE3X6xU6"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708231217070.76247@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 15/15] ppc: Add aCube Sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--p+/4B2pcxE3X6xU6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 01:12:06PM +0200, BALATON Zoltan wrote:
> On Wed, 23 Aug 2017, David Gibson wrote:
> > On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> > > Add emulation of aCube Sam460ex board based on AMCC 460EX embedded So=
C.
> > > This is not a full implementation yet with a lot of components still
> > > missing but enough to start a Linux kernel and the U-Boot firmware.
> > >=20
> > > Signed-off-by: Fran=E7ois Revol <revol@free.fr>
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >=20
> > As usual, only fairly superficial review here.
> >=20
> > > ---
> > >  default-configs/ppcemb-softmmu.mak |   3 +
> > >  hw/ppc/Makefile.objs               |   2 +
> > >  hw/ppc/sam460ex.c                  | 611 +++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 616 insertions(+)
> > >  create mode 100644 hw/ppc/sam460ex.c
> > >=20
> > > diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppc=
emb-softmmu.mak
> > > index 635923a..90b42f0 100644
> > > --- a/default-configs/ppcemb-softmmu.mak
> > > +++ b/default-configs/ppcemb-softmmu.mak
> [...]
> > > +/*******************************************************************=
**********/
> > > +/* SPD eeprom content from mips_malta.c */
> >=20
> > What's the connection with mips_malta?
>=20
> The board's firmware wants to see SPD EEPROMs of the connected memory whi=
le
> initialising the memory controller. This is why we need to implement SDRAM
> controller, I2C and SPD EEPROMs. MIPS malta board had already SPD EEPROM
> implementation so this is based on that. The comment just indicates where
> this code comes from.

Ok.

[snip]
> > > +        env->nip =3D bi->entry;
> > > +
> > > +        /* Create a mapping for the kernel.  */
> > > +        mmubooke_create_initial_mapping(env, 0, 0);
> > > +        env->gpr[6] =3D tswap32(EPAPR_MAGIC);
> >=20
> > I'm pretty sure the tswap can't be right here.  env->gpr is in host
> > native order and I'd expect the constant to be as well.
>=20
> I know nothing about this, maybe Francois remembers why it's there. But
> booting linux with -kernel works so it's probably either correct or does =
not
> matter.

Have you attempted it on both BE and LE hosts though?

>=20
> > > +        env->gpr[7] =3D (16 << 20) - 8; /*bi->ima_size;*/
> >=20
> > So, entering the kernel directly can be useful, particularly during
> > early development.  However, having both firmware and non-firmware
> > entry paths can lead to confusing bugs if there's a subtle difference
> > between the initial (to the kernel) states between the two paths.  For
> > that reason, the usual preferred way to implement -kernel is to still
> > run the usual firmware, but use some way of telling it to boot
> > immediately into the supplied kernel.
> >=20
> > I won't object to merging it this way - just a wanrning that this may
> > bite you in the future if you're not careful.
>=20
> Warning taken, at this point until firmware cannot reliably boot things
> having another way to test is useful to have. In the future when booting =
via
> firmware works well we can figure out what to do with this.

Fair enough.

[snip]
> > > +        generate_eeprom_spd(&smbus_eeprom_buf[i * 256], ram_sizes[i]=
);
> > > +    }
> > > +    generate_eeprom_serial(&smbus_eeprom_buf[4 * 256]);
> > > +    generate_eeprom_serial(&smbus_eeprom_buf[6 * 256]);
> > > +
> > > +    /* IIC controllers */
> > > +    dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600700, uic[0=
][2]);
> > > +    i2c[0] =3D PPC4xx_I2C(dev);
> > > +    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
> > > +    smbus_eeprom_init(i2c[0]->bus, 8, smbus_eeprom_buf, smbus_eeprom=
_size);
> > > +    g_free(smbus_eeprom_buf);
> > > +
> > > +    dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600800, uic[0=
][3]);
> > > +    i2c[1] =3D PPC4xx_I2C(dev);
> > > +
> > > +    /* External bus controller */
> > > +    ppc405_ebc_init(env);
> > > +
> > > +    /* CPR */
> > > +    ppc4xx_cpr_init(env);
> > > +
> > > +    /* PLB to AHB bridge */
> > > +    ppc4xx_ahb_init(env);
> > > +
> > > +    /* System DCRs */
> > > +    ppc4xx_sdr_init(env);
> > > +
> > > +    /* MAL */
> > > +    ppc4xx_mal_init(env, 4, 16, &uic[2][3]);
> > > +
> > > +    /* 256K of L2 cache as memory */
> > > +    ppc4xx_l2sram_init(env);
> >=20
> > Seems like a lot of this peripheral setup should be handled by a SoC
> > helper function, since it's not really board specific (I'm guessing).
> > I'm ok with that being a later clean up though.
>=20
> I know, the ppc405 has an init function and I considered moving some of t=
his
> to a similar function but I've left it here for now for simplicity until
> it's decided what's the best way to clean this up.

Ok, seems reasonable.

> > > +    /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.c=
? */
> > > +    memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram", =
256 << 10,
> > > +                           &error_abort);
> > > +    memory_region_add_subregion(address_space_mem, 0x400000000LL, l2=
cache_ram);
> > > +
> > > +    /* USB */
> > > +    sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400, uic[2][29]);
> > > +    dev =3D qdev_create(NULL, "sysbus-ohci");
> > > +    qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
> > > +    qdev_prop_set_uint32(dev, "num-ports", 6);
> > > +    qdev_init_nofail(dev);
> > > +    sbdev =3D SYS_BUS_DEVICE(dev);
> > > +    sysbus_mmio_map(sbdev, 0, 0x4bffd0000);
> > > +    sysbus_connect_irq(sbdev, 0, uic[2][30]);
> > > +    usb_create_simple(usb_bus_find(-1), "usb-kbd");
> > > +    usb_create_simple(usb_bus_find(-1), "usb-mouse");
> > > +
> > > +    /* PCI bus */
> > > +    ppc460ex_pcie_init(env);
> > > +    /*XXX: FIXME: is this correct? */
> > > +    dev =3D sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
> > > +                                uic[1][0], uic[1][20], uic[1][21], u=
ic[1][22],
> > > +                                NULL);
> > > +    pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
> > > +    if (!pci_bus) {
> > > +        fprintf(stderr, "couldn't create PCI controller!\n");
> > > +        exit(1);
> > > +    }
> > > +    memory_region_init_alias(isa, NULL, "isa_mmio", get_system_io(),
> > > +                             0, 0x10000);
> > > +    memory_region_add_subregion(get_system_memory(), 0xc08000000, is=
a);
> >=20
> > Does it really make sense to just embed the ISA IO space here, rather
> > than actually instanting a PCI<->ISA bridge?
>=20
> I'm not sure if this is correct but I don't know how it's handled on real
> hardware. The board does not have ISA and I don't think it has a bridge b=
ut
> the IO space appears at this location according to the datasheet (In Syst=
em
> Memory Address Map it's listed as PCI I/O 0xc08000000-0xc0800ffff) and
> clients expect PCI card's io registers to be accessible here. If anyone
> knows how it's done on real hardware and if there's a better way to model
> this please let me know.

Ah, ok.  I think the confusion here is that you can have PCI I/O space
without ISA or a system IO space.  In fact that's pretty standard on
things without a CPU level IO space (which means just about everything
except x86).

But in that case I'd expect the PCI host bridge to map its IO memory
regions directly into address_space_memory rather than involving the
global address_space_io (what get_system_io()) returns.  The only
reason I can see that you'd need to involve get_system_io() is if you
have devices registering themselves directly into the global IO space,
which should only happen for legacy ISA devices, which it sounds like
you don't have.

Possibly this is an error in the PCI bridge implementation that your
code here is essentially a workaround for, though.

>=20
> > > +    /* PCI devices */
> > > +    pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
> > > +    /* SoC has a single SATA port but we don't emulate that yet
> > > +     * However, firmware and usual clients have driver for SiI311x
> > > +     * so add one for convenience by default */
> > > +    pci_create_simple(pci_bus, -1, "sii3112");
> >=20
> > You should probably not create this when started with -nodefaults.
>=20
> We don't emulate the on-board SATA port of the SoC and without this there=
's
> no other way to connect disks (maybe over USB, but firmware has a bug whi=
ch
> prevents that too even on real hardware AFAIK, I've backported a fix which
> made booting from USB work but that broke keyboard) so while this is an
> external card it's pretty much unusable without this so it's added by
> default.

Yes, but you're not just adding it by default, you're adding it
*always*.  -nodefaults should turn that off (and the user will need to
manually instantiate it - or another disk controller, I guess).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p+/4B2pcxE3X6xU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmePZYACgkQbDjKyiDZ
s5I0lhAA0kG3bPLO4FuPZI6T5gwJQ7QjDArRJ5HzpoEX76u/qhFdz1C4D1Ll137X
IXxNdi/pnDXnR6ff5rb0zy5eiGLt5ow6EzQga8YdRsK09QByu40mRgKeTPwGPtKQ
6eUho92F8bbwRsHedr+bYbWv+nb7BLf3K68Fhl5YVGrameMEXrMukQBgJZLgSSCG
CEYUebnJxu/LP+n0j2mMaZ2S1WBrrRaEmWiveKoBkgk6ZugbTNLKAiYGwgZHCNqK
RGm2QMRH1k91Yv9CBgeBx2Gr32LAa2yX73wZCsX/BHZbR/7x3dxBy5lU0v9xBfUG
S6zET7IUgIbJ6OTn/mu+o5p/yA26ZkoK2I8MMye15Baxap9X4S/RXxIO4Fbl+jFx
2yIvsWFpL2xdbBsimvx1OOZjZ/e+8IKT0zvURZTppd4OiSk0WgxtKWndbR+Dhw9N
lGSBodajVlT4n3p9N2zwGCjlgVHrmr8SQqFU5lcrAWhTyMg6jlc4fr/RrR6FROVk
2qed1j9bwt50tbKoaVD7yXP+Gsqmb1zIvJSKSH+TSqHudXPtR8FLM9fvTRwLsMle
Ddlo4/M9SxPLmMIOlwGncWBNen2SZBeZIg4bI5d0CFhU4BvPHKPAjCm5s6DtLE0+
1ICLkBkS2Z4BjvQAZO/dcT2H1RZbUgZo4QBbxHLnJ4ztXI7JO6w=
=uXCq
-----END PGP SIGNATURE-----

--p+/4B2pcxE3X6xU6--
