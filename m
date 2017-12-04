Received: from eggs.gnu.org ([2001:4830:134:3::10]:52012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLgFd-0007gF-6V
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 21:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLgFZ-000487-6Z
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 21:12:57 -0500
Date: Mon, 4 Dec 2017 12:59:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204015918.GK2130@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-18-clg@kaod.org>
	<20171130055542.GG3023@umbus.fritz.box>
	<2cee93ff-060a-aa04-852c-d3585dba0c7f@kaod.org>
	<20171201041423.GF30161@umbus.fritz.box>
	<8d2e92cc-a305-d9d4-b28c-873acd76ee6a@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jITzwD3HDGXid3BE"
Content-Disposition: inline
In-Reply-To: <8d2e92cc-a305-d9d4-b28c-873acd76ee6a@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 17/25] spapr: add a sPAPRXive object to the
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--jITzwD3HDGXid3BE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 09:10:24AM +0100, C=E9dric Le Goater wrote:
> On 12/01/2017 05:14 AM, David Gibson wrote:
> > On Thu, Nov 30, 2017 at 03:15:09PM +0000, C=E9dric Le Goater wrote:
> >> On 11/30/2017 05:55 AM, David Gibson wrote:
> >>> On Thu, Nov 23, 2017 at 02:29:47PM +0100, C=E9dric Le Goater wrote:
> >>>> The XIVE object is designed to be always available, so it is created
> >>>> unconditionally on newer machines.
> >>>
> >>> There doesn't actually seem to be anything dependent on machine
> >>> version here.
> >>
> >> No. I thought that was too early in the patchset. This is handled=20
> >> in the last patch with a 'xive_exploitation' bool which is set to=20
> >> false on older machines.=20
> >>
> >> But, nevertheless, the XIVE objects are always created even if not
> >> used. Something to discuss.
> >=20
> > That'll definitely break backwards migration, since the destination
> > won't understand the (unused but still present) xive state it
> > receives.=20
>=20
> no because it's not sent. the vmstate 'needed' op of the sPAPRXive
> object discards it :
>=20
>     static bool vmstate_spapr_xive_needed(void *opaque)
>     {
>         sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> =20
>         return spapr->xive_exploitation;
>     }

Ah, sorry, missed that.  Once we have negotiation we'll need to make
sure the xive_exploitation bit is sent first, of course, but I'm
pretty sure the machine state is already sent first.

> > So xives can only be created on new machine types.=20
>=20
> That would be better I agree. I can probably use the 'xive_exploitation'
> bool to condition its creation.

Hrm.  I'm less sure about that - I'm not sure the lifetimes line up.
But I'd like to avoid creating them on earlier machine types, even if
xive_exploitation can't do the trick.

>=20
> > I'm ok
> > (at least tentatively) with always creating them on the newer machine
> > types, regardless of whether the guest ends up exploiting it or not.
>=20
> OK.
>=20
>=20
> >>>> Depending on the configuration and
> >>>> the guest capabilities, the CAS negotiation process will decide which
> >>>> interrupt model to use, legacy or XIVE.
> >>>>
> >>>> The XIVE model makes use of the full range of the IRQ number space
> >>>> because the IRQ numbers for the CPU IPIs are allocated in the range
> >>>> below XICS_IRQ_BASE, which is unused by XICS.
> >>>
> >>> Ok.  And I take it 4096 is enough space for the XIVE IPIs for the
> >>> forseeable future?
> >>
> >> The biggest real system I am aware of as 16 sockets, 192 cores, SMT8.=
=20
> >> That's 1536 cpus. pseries has a max_cpus of 1024.
> >=20
> > Ok, so we can go to double the current system size, but not 4x.  Not
> > sure if that seems adequate or not.  Still it's a relatively minor
> > detail.
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jITzwD3HDGXid3BE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlokq/MACgkQbDjKyiDZ
s5LQzhAAkNHfG1CdISZIs02IK+CdKbhWRfhQy8vgVaDrX2uSCO1OUg3wl7MtORE0
Ibo+Rz+KDzA0R7tb3q5D3TEQ8uumuLPGnhQaBh7SvpB2hGZtFTwuKhdIRGW82GtT
TYtydy+bi7uEDGDPVHlpfGKXErkUMPLZnIOcMS7z8d4xm6JnKiXkUvmmSrnsR0EM
DJGIi/gqLszVp9zUruo26+LucIyu0Ra/1rm7UJNcYTgGSF6IR2miObG6yelGHBsP
19pDK5P2TOab1tKnKf/Vrh+sVmVSWYQLBTCgG9TEs3Z6YadIuGoDevqrE5LcwtJz
K3wyMJoEd8UI72oTxTTK6dvyVae5QMfdRLEYTrKLgJ7Ss4qVdIj7yy38NaKkOhQm
sa2ULK7LyHBtp/oTgEJanMeO0boStgHL/68fkOo7zlE3baZMetMF6gqiodqJFfW1
XnM+xSreXIBi+bflqiTtLzz0AmgjFyIJqC31hwyvZevcXfDNFzQYZFuGbokoE1cr
fY6DRi3PQ4Lw1UpULmQM5h/OIjZ/R8Cpk9REotZ6AA+SuPr8+mz+/Hit8ToKPBoj
IKFGIjSEtQfLFnTxvBxBD7doknzdO4jxKhLo2ZRgE2PIV2yGv9oV29MCfTO3Vznf
O1RXqZeflUBQx4+uaog5bBS6yHMPD1vAASsN1w2igkiA4a9rn6E=
=GvfU
-----END PGP SIGNATURE-----

--jITzwD3HDGXid3BE--
