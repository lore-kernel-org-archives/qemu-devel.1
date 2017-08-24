Received: from eggs.gnu.org ([2001:4830:134:3::10]:45811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkiIT-0006Da-Pg
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkiIS-0005Iz-5b
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:55:05 -0400
Date: Thu, 24 Aug 2017 12:54:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824025443.GB5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ab632ef70b02efb2257d9e2f08b45b097ebacb3a.1503249785.git.balaton@eik.bme.hu>
	<20170823041644.GP5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231217070.76247@zero.eik.bme.hu>
	<8fe81d01-0a39-02cc-c7d8-59437c4f94ac@free.fr>
	<alpine.BSF.2.21.1708231422390.35800@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="up2r7mkFEYHJ3y+X"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708231422390.35800@zero.eik.bme.hu>
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
Cc: =?iso-8859-1?Q?Fran=E7ois?= Revol <revol@free.fr>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--up2r7mkFEYHJ3y+X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 02:47:42PM +0200, BALATON Zoltan wrote:
> On Wed, 23 Aug 2017, Fran=E7ois Revol wrote:
> > Le 23/08/2017 =E0 13:12, BALATON Zoltan a =E9crit :
> > > > What's the connection with mips_malta?
> > >=20
> > > The board's firmware wants to see SPD EEPROMs of the connected memory
> > > while initialising the memory controller. This is why we need to
> > > implement SDRAM controller, I2C and SPD EEPROMs. MIPS malta board had
> > > already SPD EEPROM implementation so this is based on that. The comme=
nt
> > > just indicates where this code comes from.
> >=20
> > Indeed, and I copy-pasted from elsewhere for this.
> >=20
> > > > > +        fprintf(stderr, "qemu: Error registering flash memory.\n=
");
> > > >=20
> > > > Use error_report() instead, please.
> >=20
> > I guess this didn't exist back when I started writing it...
>=20
> No problem, I can take care of these.
>=20
> > > > > +/* Create reset TLB entries for BookE, mapping only the flash
> > > > > memory.  */
> > > > > +static void mmubooke_create_initial_mapping_uboot(CPUPPCState *e=
nv)
> > > > > +{
> > > > > +    ppcemb_tlb_t *tlb =3D &env->tlb.tlbe[0];
> > > > > +
> > > > > +    /* on reset the flash is mapped by a shadow TLB,
> > > > > +     * but since we don't implement them we need to use
> > > > > +     * the same values U-Boot will use to avoid a fault.
> > > > > +     */
> > > >=20
> > > > Usually the reset state of the MMU is handled in the cpu code rather
> > > > than the board code.  Is there a specific reason you need it in the
> > > > board code here?
> > >=20
> > > I'm not sure, probably lack of a better place. The ppc440_bamboo board
> > > this is based on has it the same way in the board code. Maybe this co=
uld
> > > be cleaned up when someone wants to QOMify the SoC models sometimes.
> >=20
> > Thing is, the code allows both booting with U-Boot and with a kernel
> > directly, and the MMU mapping differ in those cases.
> >=20
> > Maybe the CPU reset should use the U-Boot setup and the kernel boot
> > would just overwrite it?
> >=20
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
oes
> > > not matter.
> >=20
> > Absolutely no idea. It seems to be there from the first commit in my own
> > history here.
> >=20
> > I don't recall testing booting linux at all though.
> > Linux does check the magic, so it'd be weird if it booted:
> >=20
> > https://github.com/torvalds/linux/blob/master/arch/powerpc/boot/epapr.c
>=20
> Is this code used on Sam460 at all? Is U-Boot ePAPR compliant
> firmware?

It can be, depends on the build, I think.

> Isn't that only needed on OpenFirmware?

No, not at all.  True OF will generally *not* be ePAPR compliant -
ePAPR was explicitly built as a much simpler interface that doesn't
require an OF implementation.  It uses some concepts from OF,
specifically the contents of the device tree, but other than that it's
not related.

>=20
> > But maybe it got added later than the version you tested?
>=20
> I've tried some of these:
> http://www.supertuxkart-amiga.de/amiga/sam.html#downloads
> which also have kernel 4.5 so that's fairly recent. These kernels are
> "u-boot legacy uImage" so maybe they don't need ePAPR magic? Are there so=
me
> docs on what the kernel expects on this board or it has to be dug out from
> U-Boot?

If it's a legacy uImage I suspect it's not using ePAPR.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--up2r7mkFEYHJ3y+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmeP/MACgkQbDjKyiDZ
s5JrxA//QjxvJMpws9TRDcrmZa2jrc5N36Q0asQaLZR1cK1vm4rV1/DvCNLbSx7g
4+IULchhRNQ/Km8hFltARq8GGnaaZwRD+FHDIF+yhoL1TYHtJSvUo5hHSl5qCINJ
YXjBQKpTmbufGT7benNAbruVv9j7GxwSm/psZ1fLYH0HXGmeEIuy0Dt3N/g48EQq
pqtDaLZU90rJ0Rf65xc8OZ19/l9PtCnuqtKTf0HwUeEYtl3QCoqkF6XcdmCQ3Uuh
NJTP/NSh3PGjduna76OkSMB9dcS8yIiOhFBREA1WGzZfw+lBpjeafgfme1Z3V1+h
0iIKoQVctPix3rrfdsdTEDrxFvhn1JAmVajcKySEylQQYvfdMJX3mDxzb3MW5N27
RzWT98BoiFF4qtWpetdjLD7F89dAwSNtNiHfjEy6gGleoJ3q8KYBV++Ry9kfz4NB
s5IJSG1LHKDgs7As28QnVCkP2X6kBwrco+s69TtmIPWrV3eGc8qekOoIzHBcygCi
kTgJ2XjtViDvSoA3Pr47TCI6hEtVtKyKBXhkCRAz695xq/a/uV36x6xKsHCmSISD
eklvspnLAGlzam/hVi8bC7inmgk1/VTk8nZEB+gDhEWPmXN3Eple84wETmRhh7B1
XLforwuRcoNvrmYIOtlt7OrlcRTBxSEn3XjzruHLrd8jbZWAI1A=
=2rER
-----END PGP SIGNATURE-----

--up2r7mkFEYHJ3y+X--
