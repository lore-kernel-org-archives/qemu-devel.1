Received: from eggs.gnu.org ([2001:4830:134:3::10]:44472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl2TU-0002Hl-Ve
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 20:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl2TS-0007fw-VC
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 20:27:48 -0400
Date: Fri, 25 Aug 2017 10:15:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825001526.GM5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ab632ef70b02efb2257d9e2f08b45b097ebacb3a.1503249785.git.balaton@eik.bme.hu>
	<20170823041644.GP5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231217070.76247@zero.eik.bme.hu>
	<20170824024438.GZ5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708242241030.96438@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hS2jB1L/urRucW8g"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708242241030.96438@zero.eik.bme.hu>
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


--hS2jB1L/urRucW8g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 11:37:09PM +0200, BALATON Zoltan wrote:
> On Thu, 24 Aug 2017, David Gibson wrote:
> > On Wed, Aug 23, 2017 at 01:12:06PM +0200, BALATON Zoltan wrote:
> > > On Wed, 23 Aug 2017, David Gibson wrote:
> > > > On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> > > > > Add emulation of aCube Sam460ex board based on AMCC 460EX embedde=
d SoC.
> > > > > This is not a full implementation yet with a lot of components st=
ill
> > > > > missing but enough to start a Linux kernel and the U-Boot firmwar=
e.
> > > > >=20
> > > > > Signed-off-by: Fran=E7ois Revol <revol@free.fr>
> > > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > >=20
> > > > As usual, only fairly superficial review here.
> > > >=20
> > > > > ---
> > > > >  default-configs/ppcemb-softmmu.mak |   3 +
> > > > >  hw/ppc/Makefile.objs               |   2 +
> > > > >  hw/ppc/sam460ex.c                  | 611 +++++++++++++++++++++++=
++++++++++++++
> > > > >  3 files changed, 616 insertions(+)
> > > > >  create mode 100644 hw/ppc/sam460ex.c
> > > > >=20
> > > > > diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs=
/ppcemb-softmmu.mak
> > > > > index 635923a..90b42f0 100644
> > > > > --- a/default-configs/ppcemb-softmmu.mak
> > > > > +++ b/default-configs/ppcemb-softmmu.mak
> > > [...]
> > > > > +/***************************************************************=
**************/
> > > > > +/* SPD eeprom content from mips_malta.c */
> > > >=20
> > > > What's the connection with mips_malta?
> > >=20
> > > The board's firmware wants to see SPD EEPROMs of the connected memory=
 while
> > > initialising the memory controller. This is why we need to implement =
SDRAM
> > > controller, I2C and SPD EEPROMs. MIPS malta board had already SPD EEP=
ROM
> > > implementation so this is based on that. The comment just indicates w=
here
> > > this code comes from.
> >=20
> > Ok.
> >=20
> > [snip]
> > > > > +        env->nip =3D bi->entry;
> > > > > +
> > > > > +        /* Create a mapping for the kernel.  */
> > > > > +        mmubooke_create_initial_mapping(env, 0, 0);
> > > > > +        env->gpr[6] =3D tswap32(EPAPR_MAGIC);
> > > >=20
> > > > I'm pretty sure the tswap can't be right here.  env->gpr is in host
> > > > native order and I'd expect the constant to be as well.
> > >=20
> > > I know nothing about this, maybe Francois remembers why it's there. B=
ut
> > > booting linux with -kernel works so it's probably either correct or d=
oes not
> > > matter.
> >=20
> > Have you attempted it on both BE and LE hosts though?
>=20
> No, I don't have a BE host, only tried on LE. I'm guessing this may come
> from hw/ppc/virtex_ml507.c where EPAPR_MAGIC is also swapped.

Sounds like virtex is wrong too - bet they haven't tried on a BE host eithe=
r.

> The only other
> place this magic number appears is in e500 where it's not swapped though =
so
> I don't really know what should be correct here. In u-boot sources
> (arch/powerpc/lib/bootm.c) it seems to use this magic if CONFIG_OF_LIBFDT=
 is
> defined which seems to be set for this board so that means we likely need
> this (but maybe not for the legacy uImages I've tried). Since CPU is big
> endian and constant is defined on the host this probably should be
> cpu_to_be32(EPAPR_MAGIC). Does that sound better?

No.  It's going into a register, not memory, and the registers are in
host-native order, since they're being manipulated as whole values,
not byte arrays (the appropriate swaps for the guest endianness happen
when emulating load and store instructions).  Remember an integer is
just an integer - it's only when you encode it into a byte array that
it acquires an endianness.

Although it sounded from another part of this thread as if this might
be a non-epapr boot anyway, making the whole thing moot.

> [...]
> > > > > +    /* FIXME: remove this after fixing l2sram mapping in ppc440_=
uc.c? */
> > > > > +    memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ra=
m", 256 << 10,
> > > > > +                           &error_abort);
> > > > > +    memory_region_add_subregion(address_space_mem, 0x400000000LL=
, l2cache_ram);
> > > > > +
> > > > > +    /* USB */
> > > > > +    sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400, uic[2][2=
9]);
> > > > > +    dev =3D qdev_create(NULL, "sysbus-ohci");
> > > > > +    qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
> > > > > +    qdev_prop_set_uint32(dev, "num-ports", 6);
> > > > > +    qdev_init_nofail(dev);
> > > > > +    sbdev =3D SYS_BUS_DEVICE(dev);
> > > > > +    sysbus_mmio_map(sbdev, 0, 0x4bffd0000);
> > > > > +    sysbus_connect_irq(sbdev, 0, uic[2][30]);
> > > > > +    usb_create_simple(usb_bus_find(-1), "usb-kbd");
> > > > > +    usb_create_simple(usb_bus_find(-1), "usb-mouse");
> > > > > +
> > > > > +    /* PCI bus */
> > > > > +    ppc460ex_pcie_init(env);
> > > > > +    /*XXX: FIXME: is this correct? */
> > > > > +    dev =3D sysbus_create_varargs("ppc440-pcix-host", 0xc0ec0000=
0,
> > > > > +                                uic[1][0], uic[1][20], uic[1][21=
], uic[1][22],
> > > > > +                                NULL);
> > > > > +    pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
> > > > > +    if (!pci_bus) {
> > > > > +        fprintf(stderr, "couldn't create PCI controller!\n");
> > > > > +        exit(1);
> > > > > +    }
> > > > > +    memory_region_init_alias(isa, NULL, "isa_mmio", get_system_i=
o(),
> > > > > +                             0, 0x10000);
> > > > > +    memory_region_add_subregion(get_system_memory(), 0xc08000000=
, isa);
> > > >=20
> > > > Does it really make sense to just embed the ISA IO space here, rath=
er
> > > > than actually instanting a PCI<->ISA bridge?
> > >=20
> > > I'm not sure if this is correct but I don't know how it's handled on =
real
> > > hardware. The board does not have ISA and I don't think it has a brid=
ge but
> > > the IO space appears at this location according to the datasheet (In =
System
> > > Memory Address Map it's listed as PCI I/O 0xc08000000-0xc0800ffff) and
> > > clients expect PCI card's io registers to be accessible here. If anyo=
ne
> > > knows how it's done on real hardware and if there's a better way to m=
odel
> > > this please let me know.
> >=20
> > Ah, ok.  I think the confusion here is that you can have PCI I/O space
> > without ISA or a system IO space.  In fact that's pretty standard on
> > things without a CPU level IO space (which means just about everything
> > except x86).
> >=20
> > But in that case I'd expect the PCI host bridge to map its IO memory
> > regions directly into address_space_memory rather than involving the
> > global address_space_io (what get_system_io()) returns.  The only
> > reason I can see that you'd need to involve get_system_io() is if you
> > have devices registering themselves directly into the global IO space,
> > which should only happen for legacy ISA devices, which it sounds like
> > you don't have.
> >=20
> > Possibly this is an error in the PCI bridge implementation that your
> > code here is essentially a workaround for, though.
>=20
> So in my understanding, there's a system_io space created automatically
> which appears in the memory tree anyway but would otherwise be unused and
> this was just reused here for the pci io space so it does not need another
> memory region for this. If it's not acceptable this way (although
> ppc440_bamboo.c and ppc4xx_pci.c also does it the exact same way) an
> alternative may be to change it to add another mem region for io to
> ppc440_pcix.c (although it already has iomem for pci.reg so this might be
> more confusing than using system_io here) but I think pcix device can't m=
ap
> this to address_space_memory itself because this device could appear in
> different SoCs where the memory areas might be at different addresses so
> this new region should then be registered as a sysbus mmio space and be
> mapped from the board code with sysbus_mmio_map()? I find that much more
> confusing than how it's done now which is also more consistent with exist=
ing
> code modelling similar devices.

Ugh, I see.  I hadn't realized bamboo etc. were doing this.  It's not
a good idea - most obviously it breaks down if you have multiple
independent PCI host bridges, which have independent IO spaces.

I'm a bit torn whether to let this in as is because precedent and hope
to get them all fixed at some future point, or to insist that you
change it to stop the bad idea spreading.

The right way is, indeed, to create a new memory region for the
bridge's IO space.  A SysBusDevice can have multiple MMIO regions, so
you can use one for the bridge's memory space, another for its IO
space (and still more for config space and/or bridge internal
registers if you need them).

> > > > > +    /* PCI devices */
> > > > > +    pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
> > > > > +    /* SoC has a single SATA port but we don't emulate that yet
> > > > > +     * However, firmware and usual clients have driver for SiI31=
1x
> > > > > +     * so add one for convenience by default */
> > > > > +    pci_create_simple(pci_bus, -1, "sii3112");
> > > >=20
> > > > You should probably not create this when started with -nodefaults.
> > >=20
> > > We don't emulate the on-board SATA port of the SoC and without this t=
here's
> > > no other way to connect disks (maybe over USB, but firmware has a bug=
 which
> > > prevents that too even on real hardware AFAIK, I've backported a fix =
which
> > > made booting from USB work but that broke keyboard) so while this is =
an
> > > external card it's pretty much unusable without this so it's added by
> > > default.
> >=20
> > Yes, but you're not just adding it by default, you're adding it
> > *always*.  -nodefaults should turn that off (and the user will need to
> > manually instantiate it - or another disk controller, I guess).
>=20
> OK I got it now. I still don't see when -nodefaults could be useful to
> cripple the board and make it easier to create non-working configurations
> but I can easily add this conditional around this line and hope users stay
> away from this switch and won't complain when it does not boot when they =
use
> it. (Well, it does not really boot most of the time without this switch
> either so I don't think it matters much at the moment :-) )

The convention exists because for non-trivial cases the next layer up
- whether it's a person or a management layer like livirt - often
needs more explicit and complete control of the device in the system.
Even if that's at the cost of having to explicitly add essential
devices.  It's still pretty imperfect, there's still a distinction
between "default" and "always present" devices which can be far from
obvious.

Nonetheless, I think the sil device lies firmly enough on the
"shouldn't be always present" side of the fuzzy line to exclude it
with -nodefaults.

Note that this can also be useful for experiments - e.g. just looking
at firmware behaviour with no disk at all, adding some entirely
different block interface with a specialized kernel to handle it.  Or
even booting into a kernel running purely from a ramfs with no disk.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hS2jB1L/urRucW8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmfbBwACgkQbDjKyiDZ
s5I/dBAAuwDoFGjnBdUHcwSImc1oSuZe9Rm1DGVUFu+cA2FdKeVmnw66H14fzFf0
6C0xuTzgozbhW0FnEHls5OAf8h/iVzK3lZspvDwVrFbg6BS79LxmN6H0CJHJL0c4
yUHL42wDLd0z3ZGmVD2jdy93yanEWES8ImIB7oS5cfxgy+CgbxFODFhtD+ZeBLvK
zbF2nkbe7g7nMyKKFgEWvkBnhrXpK396Iu830dyTQiQKW6wviFT6yZ+DsAlvWOkd
QYcqVNmZptCiRG9o59PK07d56IsDR/JN5znbigYhCuTiikeelyIkh9fShLFnxtYT
J5i+Rk8h2hSZQItmTEcVUyk+epiWS4YvjDXjxqvTQCKCjOPi3t4QTzAxSlOTaZzM
EG3f15eu70Ck7rLrHxby53mvH1PWSjLOvh9gvfstFyB/5+wMrG+kJjmhOTxWQK21
pDe4weqLa6x2o4hIVkBwXoDktcsIxBYJSew9a0kwpj0q2o5OFn4J3S5aHGM21kuY
3wKivtvXyQ68pTck6mU6dlBrw+kNGn1XPc1ZDINClAVKYrpKRFISxw33BqKrzzWt
zycpAA/sakNVrJefYZ4/+UrhkRRX71ayRMINOWhAiDSoMOJ+BJq9v+Tw+eoeOzer
4hzlzpXq+GleXo++2uZB4BUZ0+TGt9lOsruAA88LjFW89EOmlGQ=
=9VTV
-----END PGP SIGNATURE-----

--hS2jB1L/urRucW8g--
