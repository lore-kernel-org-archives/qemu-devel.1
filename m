Received: from eggs.gnu.org ([2001:4830:134:3::10]:44468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl2TU-0002Hk-B1
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 20:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl2TS-0007g1-VM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 20:27:48 -0400
Date: Fri, 25 Aug 2017 09:55:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824235547.GL5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ab632ef70b02efb2257d9e2f08b45b097ebacb3a.1503249785.git.balaton@eik.bme.hu>
	<20170823041644.GP5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231217070.76247@zero.eik.bme.hu>
	<8fe81d01-0a39-02cc-c7d8-59437c4f94ac@free.fr>
	<20170824025151.GA5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708242338140.96438@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ahst0DKxuyFxAqHk"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708242338140.96438@zero.eik.bme.hu>
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


--Ahst0DKxuyFxAqHk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 11:43:18PM +0200, BALATON Zoltan wrote:
> On Thu, 24 Aug 2017, David Gibson wrote:
> > On Wed, Aug 23, 2017 at 01:43:56PM +0200, Fran=E7ois Revol wrote:
> > > Le 23/08/2017 =E0 13:12, BALATON Zoltan a =E9crit :
> > > > > What's the connection with mips_malta?
> > > >=20
> > > > The board's firmware wants to see SPD EEPROMs of the connected memo=
ry
> > > > while initialising the memory controller. This is why we need to
> > > > implement SDRAM controller, I2C and SPD EEPROMs. MIPS malta board h=
ad
> > > > already SPD EEPROM implementation so this is based on that. The com=
ment
> > > > just indicates where this code comes from.
> > >=20
> > > Indeed, and I copy-pasted from elsewhere for this.
> > >=20
> > > > > > +        fprintf(stderr, "qemu: Error registering flash memory.=
\n");
> > > > >=20
> > > > > Use error_report() instead, please.
> > >=20
> > > I guess this didn't exist back when I started writing it...
> >=20
> > Probably not.
> >=20
> > > > > > +/* Create reset TLB entries for BookE, mapping only the flash
> > > > > > memory.  */
> > > > > > +static void mmubooke_create_initial_mapping_uboot(CPUPPCState =
*env)
> > > > > > +{
> > > > > > +    ppcemb_tlb_t *tlb =3D &env->tlb.tlbe[0];
> > > > > > +
> > > > > > +    /* on reset the flash is mapped by a shadow TLB,
> > > > > > +     * but since we don't implement them we need to use
> > > > > > +     * the same values U-Boot will use to avoid a fault.
> > > > > > +     */
> > > > >=20
> > > > > Usually the reset state of the MMU is handled in the cpu code rat=
her
> > > > > than the board code.  Is there a specific reason you need it in t=
he
> > > > > board code here?
> > > >=20
> > > > I'm not sure, probably lack of a better place. The ppc440_bamboo bo=
ard
> > > > this is based on has it the same way in the board code. Maybe this =
could
> > > > be cleaned up when someone wants to QOMify the SoC models sometimes.
> > >=20
> > > Thing is, the code allows both booting with U-Boot and with a kernel
> > > directly, and the MMU mapping differ in those cases.
> > >=20
> > > Maybe the CPU reset should use the U-Boot setup and the kernel boot
> > > would just overwrite it?
> >=20
> > Yes.  Basically the CPU reset should do what real hardware does - and
> > I'd expect u-boot to be written to work with that.  The kernel, on the
> > other hand will expect whatever mappings come out of u-boot (or
> > another bootloader).  Long term, I think you want to always use the
> > hardware setup and actually run the guest firmware to set up the
> > mappings the kernel expects.
>=20
> Maybe we should emulate the nvram for that and then we could patch it to
> have it boot the kernel with the parameters specified in the command line?
> This would also be needed to avoid the warning from u-boot about bad
> checksum and always going with the built in defaults and would also allow
> users to store settings like on real hardware but it's not something that
> looks high priority to me at the moment.

That all sounds reasonable.

> >  For early development where it's useful
> > to be able to boot into a kernel without firmware, faking the right
> > mappings in the board code is perfectly reasonable.
>=20
> So for now I'd just go with this, because there's much more to clean up a=
nd
> improve before this becomes and issue I think.

Yup, makes sense.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ahst0DKxuyFxAqHk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmfZ4EACgkQbDjKyiDZ
s5L+4hAAshgmT6O4Sq3Wf/hZxCMDNzjn5jDnIAI3h9SOup2KOECokNo3B+6L9h3y
nT5yvQxOH2nzwamzMWTvU5v7gfec51SvXKBKMdI0w5nUn72EAtPiIbt8WyIpptAq
HnhiV6g5qjN/R5Z+IWR0oL41bledGfLELuG7OZm7Js9HnCN5/mNLqTQFnAf07VdX
JjKoI/Sk5na+EDuqmT1HlE3hXnEGbILzVlIdnm3q4rtBxl6vQURsaFL+wGSHjfg1
n0CTpzCE9F1rPoPMv3greeHLmGdHyMnSWici6QW33clgkcP7y3gqEsbzP915qtrQ
6hSLx/wJjplUcA5rOT9RJDV2lXluSwmdrwJyosN8CcQD/n6kAZVABH04ex6hq04S
291rMxk9tkuKD4Gh2ndQSX4EOVMmoAPuSTV8rvh0+0+xSq8z0xQsnlJRekx3+164
fmMQnf3wnipdDGXHno0p64dEju0Rhj21MTMJxjtKh3JhxIXSPFcw+HPa4I/NmdmO
xAJie8lh2L9AZexSn3hahukcpPcM/OdksaVwLxhoUUUCri4nxKVp3uQrsJBaGtV5
7Vg4WF5TSAZIdnKzSOeoPrRlWyURJeIww3gS+Jg7wqCJSVqSjv9l9jNv6VL6mnLg
77fLsFfEcZ2DJi7ArXOHX6D5a7SoyxAR1jqgMdBujBP1GpbKLP4=
=U2vq
-----END PGP SIGNATURE-----

--Ahst0DKxuyFxAqHk--
