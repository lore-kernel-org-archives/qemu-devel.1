Received: from eggs.gnu.org ([2001:4830:134:3::10]:36298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSu4N-0006oF-NZ
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 20:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSu4M-0007LG-Fn
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 20:55:27 -0400
Date: Wed, 13 Jun 2018 10:47:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613004752.GN30690@umbus.fritz.box>
References: <20180530100754.15833-1-clg@kaod.org>
	<20180606063910.GK17757@umbus.fritz.box>
	<326e1949-28d0-941d-54f7-dbba6825388d@kaod.org>
	<20180612055855.GE30690@umbus.fritz.box>
	<87436236-09f6-9ee0-dbe6-00f0147050dc@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ggdAeHltlv4tpqCr"
Content-Disposition: inline
In-Reply-To: <87436236-09f6-9ee0-dbe6-00f0147050dc@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2] pnv: add a physical mapping array
 describing MMIO ranges in each chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--ggdAeHltlv4tpqCr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 08:13:49AM +0200, C=E9dric Le Goater wrote:
> On 06/12/2018 07:58 AM, David Gibson wrote:
> > On Wed, Jun 06, 2018 at 09:04:10AM +0200, C=E9dric Le Goater wrote:
> >> On 06/06/2018 08:39 AM, David Gibson wrote:
> >>> On Wed, May 30, 2018 at 12:07:54PM +0200, C=E9dric Le Goater wrote:
> >>>> Based on previous work done in skiboot, the physical mapping array
> >>>> helps in calculating the MMIO ranges of each controller depending on
> >>>> the chip id and the chip type. This is will be particularly useful f=
or
> >>>> the P9 models which use less the XSCOM bus and rely more on MMIOs.
> >>>>
> >>>> A link on the chip is now necessary to calculate MMIO BARs and
> >>>> sizes. This is why such a link is introduced in the PSIHB model.
> >>>
> >>> I think this message needs some work.  This says what it's for, but
> >>> what actually *is* this array, and how does it work?
> >>
> >> OK. It is relatively simple: each controller has an entry defining its=
=20
> >> MMIO range.=20
> >>
> >>> The outside-core differences between POWER8 and POWER9 are substantial
> >>> enough that I'm wondering if pnvP8 and pnvP9 would be better off as
> >>> different machine types (sharing some routines, of course).
> >>
> >> yes and no. I have survived using a common PnvChip framework but
> >> it is true that I had to add P9 classes for each: LPC, PSI, OCC=20
> >> They are very similar but not enough. P9 uses much more MMIOs than=20
> >> P8 which still uses a lot of XSCOM. I haven't looked at PHB4.=20
> >=20
> > Well, it's certainly *possible* to use the same machine type, I'm just
> > not convinced it's a good idea.  It seems kind of dodgy to me that so
> > many peripherals on the system change as a side-effect of setting the
> > cpu.  Compare to how x86 works where cpu really does change the CPU,
> > plugging it into the same virtual "chipset".  Different chipsets *are*
> > different machine types there (pc vs. q35).
>=20
> OK, I agree, and we can use a set of common routines to instantiate the=
=20
> different chipset models.=20
>=20
> So we would have a common pnv_init() routine to initialize the different=
=20
> 'powernv8' and 'powernv9' machines and the PnvChip typename would be a=20
> machine class attribute ?

Well.. that's one option.  Usually for these things, it works out
better to instead of parameterizing big high-level routines like
pnv_init(), you have separate versions of those calling a combination
of case-specific and common routines as necessary.

Mostly it just comes down to what is simplest to implement for you, though.

> Nevertheless we would still need to introduce "a physical mapping array=
=20
> describing MMIO ranges" but we can start by differentiating the chipsets=
=20
> first.

Well, maybe.  I'm wondering if you can more easily encapsulate the
information in that array in a top-level init routine, that calls
common helpers with different addresses / device types / whatever.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ggdAeHltlv4tpqCr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgabgACgkQbDjKyiDZ
s5I92hAAyjbdvj+TalI/6UudyEdRPJSYKOienRUOetWnVIt89HP0Qvmq+PmfQjo0
2hIwsgO+2SkHDeqekzoGQMKsED9SdEs2M1/UdeU03gMtWSCUb9SZRWPzEhFs6ac0
hQHOuerTifglP0byUY+dustS6qlZL3D7Pr99saB7e6q0qtAxYszjcXHq6uJZbi1V
zfE3OeLFOx4cQuk0E2pRI2zzPH05QVmn6KrQwZh1sgcvQCpU/E40CNlOK2qMukst
/th8e+qv34cQU90tX1W3IZkODImDA/uCFNKFF0SxhddPT4JWLi9IDcGAGKtJE/Yr
jIL3MsbWv+6iXtfrGb7JIH6XvjU4UU8AgVRlrSRNPvsLJpxOMmV7oHT3ZmhI/j4r
R/xPPlUq+RDNLJJCKKzXJlRGGohWo5ecmFLGJEbx6d0pJeB6D8mgJf7WKZtObTzv
r2INXGSyXK96Em2Q3BJslOVFabCZmtYDvfLNpKLuwrR80v+VWmiR+gW49DiEE8uT
gBVtX/UQu0AA1e99Qve+yKNe/CIm7HV+RF8onwwHei8mx8OOvgL30/lOCgOMdjvu
nzYYEZ8msuqv4u8aA4HRcFZ86vHRld5lDzCsaL3v8CMiIZq4txt/XD0v+XmQJ4dL
9YRsJR2DEuJEGISKFJi21A5Vz5IVhTJFvDm4SeY4dtMFrjrJhV8=
=YxNI
-----END PGP SIGNATURE-----

--ggdAeHltlv4tpqCr--
