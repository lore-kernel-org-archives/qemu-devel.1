Received: from eggs.gnu.org ([2001:4830:134:3::10]:39425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drMPT-0007oA-K4
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drMPP-0002HP-O8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:57:47 -0400
Date: Mon, 11 Sep 2017 20:48:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170911104854.GB2784@umbus.fritz.box>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20170911093032.GA2857@work-vm>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] ppc: add CPU IRQ state to
 PPC VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 10:30:33AM +0100, Dr. David Alan Gilbert wrote:
> * Greg Kurz (groug@kaod.org) wrote:
> > On Sun, 10 Sep 2017 15:37:33 +0100
> > Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> >=20
> > > Commit a90db15 "target-ppc: Convert ppc cpu savevm to VMStateDescript=
ion"
> > > appears to drop the internal CPU IRQ state from the migration stream.=
 Whilst
> > > testing migration on g3beige/mac99 machines, test images would random=
ly fail to
> > > resume unless a key was pressed on the VGA console.
> > >=20
> > > Further investigation suggests that internal CPU IRQ state isn't being
> > > preserved and so interrupts asserted at the time of migration are los=
t. Adding
> > > the pending_interrupts and irq_input_state fields back into the migra=
tion
> > > stream appears to fix the problem here during local tests.
> > >=20
> > > As part of this commit we bump the vmstate_ppc version from 5 to 6 to=
 handle
> > > the additional fields.
> > >=20
> >=20
> > And so this unconditionally breaks backward migration... what about add=
ing
> > a subsection for this ?
>=20
> and wiring it to a flag on the machine type so that older machine types
> don't send it.

Right, a subsection is certainly necessary to avoid breaking backwards
migration.

But apart from that I want to understand better exactly why this is
necessary.  What's the state that's being lost, and is it really not
recoverable from anywhere else.

The other thing that concerns me is how we're encoding the
information.  These are essentially internal fields, not reflecting
something with an architected encoding - adding those to the migration
stream is often a bad idea - it inhibits our ability to rework
internal encodings.
>=20
> Dave
>=20
> > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > ---
> > >  target/ppc/machine.c |    6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > > index e59049f..8fec1a4 100644
> > > --- a/target/ppc/machine.c
> > > +++ b/target/ppc/machine.c
> > > @@ -647,7 +647,7 @@ static const VMStateDescription vmstate_compat =
=3D {
> > > =20
> > >  const VMStateDescription vmstate_ppc_cpu =3D {
> > >      .name =3D "cpu",
> > > -    .version_id =3D 5,
> > > +    .version_id =3D 6,
> > >      .minimum_version_id =3D 5,
> > >      .minimum_version_id_old =3D 4,
> > >      .load_state_old =3D cpu_load_old,
> > > @@ -678,6 +678,10 @@ const VMStateDescription vmstate_ppc_cpu =3D {
> > >          VMSTATE_UINTTL(env.hflags_nmsr, PowerPCCPU),
> > >          /* FIXME: access_type? */
> > > =20
> > > +        /* Interrupt state */
> > > +        VMSTATE_UINT32_V(env.pending_interrupts, PowerPCCPU, 6),
> > > +        VMSTATE_UINT32_V(env.irq_input_state, PowerPCCPU, 6),
> > > +
> > >          /* Sanity checking */
> > >          VMSTATE_UINTTL_TEST(mig_msr_mask, PowerPCCPU, cpu_pre_2_8_mi=
gration),
> > >          VMSTATE_UINT64_TEST(mig_insns_flags, PowerPCCPU, cpu_pre_2_8=
_migration),
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm2ahMACgkQbDjKyiDZ
s5JGZRAA1aFMgFtRtJpR/1o5BT2Dub4KqjwRmV8aCCRxwU7g1I3PUMRE5id0AQ5y
xXGZn+dLzHcO3ZyCdIHXmQArzXpEmHwmxEjl8EqbFei415t8qms6n4HzLXFn1RyJ
wINC56sFVMODI/u2eh97sb5AGrzB4cU7pntgDRo/VwAFld/+W2GUo0mqeJHKri1P
gwSJeTtQ/TMri3gAAvYxOeNttPhw0xVf1z4i8dABNqHjcYECR6irQPr5/ItsDgCW
CBdOQkwAZY/gtWSlZyIuX6km7pWi/2L/K5u6yb3bhhcqwgL8oDDAfuK5eBJq8Pkb
D5vkU/Xr/GpLSmYy1Z/FF1AcGa12s+TRoYFuxZl5/cfkI0mSuuax8KqKO1BaGcHk
0uvQV/DH4KC1xoy4B+OAT+Y/ChRh64uaIBy64B13/eF+A8NE1qAMU933RkQ8A18s
C6KnJOPIWvZ3DIpJ8JSeEgKtm3JRdm+Vrrgdekvw6OP0fy0oXejV/dDQa9llK3v8
qRiauLWrFnYhgbeLOejZ4Vmr01xMVWBmsmj9FJU4XVr8HMfWMVeZp8d8fTLqv2YK
Nb0hT/ws/gw8S4iPcFqBsCZVpH+zy8xbe2QT6ZvuzRGBHLYqGp/+cPwHnZ+8z69v
Lj5guwkHu5NXI25IGMNdwNzUxvTbDre/SUo0Z+sCdo2TGomzmJY=
=k2BT
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
