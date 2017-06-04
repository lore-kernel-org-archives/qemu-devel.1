Received: from eggs.gnu.org ([2001:4830:134:3::10]:35372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dHU7P-0000vC-5S
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 07:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dHU7M-0002uv-27
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 07:54:51 -0400
Date: Sun, 4 Jun 2017 21:09:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170604110904.GW13397@umbus.fritz.box>
References: <20170530011416.01eea576@bahia.ttt.fr.ibm.com>
	<20170530061852.GE12163@umbus.fritz.box>
	<20170530100136.680ce96f@bahia.ttt.fr.ibm.com>
	<20170531025748.GG12163@umbus.fritz.box>
	<20170531105857.62a25a84@bahia.ttt.fr.ibm.com>
	<20170601065233.GD13397@umbus.fritz.box>
	<f353022f-6b48-ab18-f156-bd8fac8cf884@kaod.org>
	<20170601150915.2bb628f5@bahia.lan>
	<20170602020007.GH13397@umbus.fritz.box>
	<20170602101525.3fa2aad9@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TcuvTDpCAASXpu1W"
Content-Disposition: inline
In-Reply-To: <20170602101525.3fa2aad9@bahia.lan>
Subject: Re: [Qemu-devel] [PATCHv4 0/5] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com


--TcuvTDpCAASXpu1W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2017 at 10:15:25AM +0200, Greg Kurz wrote:
> On Fri, 2 Jun 2017 12:00:07 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jun 01, 2017 at 03:09:15PM +0200, Greg Kurz wrote:
> > > On Thu, 1 Jun 2017 13:59:14 +0200
> > > C=E9dric Le Goater <clg@kaod.org> wrote:
> > >  =20
> > > > On 06/01/2017 08:52 AM, David Gibson wrote: =20
> > > > > On Wed, May 31, 2017 at 10:58:57AM +0200, Greg Kurz wrote:   =20
> > > > >> On Wed, 31 May 2017 12:57:48 +1000
> > > > >> David Gibson <david@gibson.dropbear.id.au> wrote:   =20
> > > > >>> [...]   =20
> > > > >>>> All old non-pseries machine types already complain when starte=
d with
> > > > >>>> a POWER7 or newer CPU. Providing the extra error message looks=
 weird:
> > > > >>>>
> > > > >>>> qemu-system-ppc64 -machine ppce500 \
> > > > >>>>                   -cpu POWER7,compat=3Dpower6
> > > > >>>> qemu-system-ppc64: CPU 'compat' property is deprecated and has=
 no effect;
> > > > >>>>  use max-cpu-compat machine property instead
> > > > >>>> MMU model 983043 not supported by this machine.
> > > > >>>>
> > > > >>>> but I guess it's better than crashing. :)     =20
> > > > >>>
> > > > >>> Well, sure POWER7 doesn't make sense for an e500 machine for ot=
her
> > > > >>> reasons.  But POWER7 or POWER8 _would_ make sense for powernv, =
where
> > > > >>> compat=3D doesn't.
> > > > >>>   =20
> > > > >>
> > > > >> The powernv machine type doesn't even support CPU features at al=
l:
> > > > >>
> > > > >>     chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machi=
ne->cpu_model);
> > > > >>     if (!object_class_by_name(chip_typename)) {
> > > > >>         error_report("invalid CPU model '%s' for %s machine",
> > > > >>                      machine->cpu_model, MACHINE_GET_CLASS(machi=
ne)->name);
> > > > >>         exit(1);
> > > > >>     }   =20
> > > > >=20
> > > > > Ah, well, that's another bug, but not one that's in scope for this
> > > > > series.   =20
> > > >=20
> > > > PowerNV is still work in progress. I would not worry about it too m=
uch.
> > > >  =20
> > >=20
> > > Of course and this isn't the purpose of the discussion actually. We w=
ere
> > > talking about CPU features being relevant or not depending on the mac=
hine
> > > type.
> > >=20
> > > But I'm not even sure that CPU features are useful at all for ppc, no=
t to
> > > say very confusing (otherwise this series wouldn't be needed for exam=
ple).
> > >=20
> > > Speaking of PowerNV, just as an example, I guess the fix would be to
> > > forbid machine->cpu_model if it contains features. And probably the s=
ame
> > > for all other machine types, except pseries for backward compatibility
> > > reasons. =20
> >=20
> > I don't think that's correct in principle.  I can imagine CPU
> > properties it might make sense to really set on the cpu, regardless of
> > machine type.  A quick look says we don't have any such at the moment,
> > but I don't think it's something we should prevent as a matter of polic=
y.
>=20
> Fair enough. Then maybe all machine should parse CPU features and check w=
hich
> one are valid before instantiating the CPUs ?

Well, CPu properties *should* be valid for all machine types.  The
fact that compat=3D wasn't was a mistake.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TcuvTDpCAASXpu1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZM+pNAAoJEGw4ysog2bOS8EcP/0EXRANnbV4m95plgeFQxFlO
1MB5y70mI7qV96Z1f7KP+r/w5kmaDQR4mVMExjNkVD/gQ6UbnyBJ2ssCUOmyy7+0
VaxN7aj+8c+Bk8xrm5fnqEARXRiiE17Z2GdqhqFEQt1nbItQfnb8S/gs1Xqhlz8/
pMo23yXa1j83nCxVYb+/mDQHVj4eEPSbep/p96hE2qyuI1v2Wl44T5w2qtCac81V
ttg/TariR5BKMswUUHoJywKFYjp8EI1xUKo9bp7ttMuQ2VAaxumh03oHAvy/XCFN
E4rOU6PiPEedTtSpMYwYtL/72F0ZR81SF04onjz5YM3D1bw6q6ay/YWjX1EPqxL6
bDz30qW78bC3UZ5nw7R+BjUnJjgMsvWY3IAEje4O8ytQG2BIp+j2hm2A2qRjf46J
DOUQrgyPi00G10/2AAPt89LRrwjHEKQ2uS7mvSQ0uZQC3+2JPyEi6XGxDTnLvISf
7zSdnJqAUFBUpvh6CQhslDqNZtOFKz5kzFKtZ47VYovNlKeBJVQmC+EnLLcQKAWc
arI5gUEfVSl348fjwhPV3iubpH2dW7JBW8eyWz+se6kD4JQyCWtitSyLiBnNmyrQ
kmv4Lmmf68ewaLZuHboUWTtxPIAl5bjHA8psrNn/KD0CvkqDECSGIwMGPpb4sGF4
yrXF9DWDyesJ6skpPnr6
=o0Kp
-----END PGP SIGNATURE-----

--TcuvTDpCAASXpu1W--
