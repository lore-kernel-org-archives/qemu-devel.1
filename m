Received: from eggs.gnu.org ([2001:4830:134:3::10]:46169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKn8M-0006DN-BJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKn8I-0006CW-Vz
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:49:30 -0400
Date: Tue, 13 Jun 2017 18:01:46 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170613100146.GA13420@umbus>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685584629.12025.14875914798241845062.stgit@bahia.lan>
	<20170608040857.GV13397@umbus.fritz.box>
	<20170608115410.2e7a2511@bahia.ttt.fr.ibm.com>
	<20170612142456.GJ18542@umbus>
	<20170613093359.4567ba94@bahia.ttt.fr.ibm.com>
	<20170613080631.GB30171@umbus>
	<20170613104003.233e21d5@bahia.ttt.fr.ibm.com>
	<20170613090002.GA2096@work-vm>
	<20170613112150.7f64171c@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20170613112150.7f64171c@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] spapr: fix migration of ICPState
 objects from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Juan Quintela <quintela@redhat.com>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 11:21:50AM +0200, Greg Kurz wrote:
> On Tue, 13 Jun 2017 10:00:03 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>=20
> > * Greg Kurz (groug@kaod.org) wrote:
> > > On Tue, 13 Jun 2017 16:06:31 +0800
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Tue, Jun 13, 2017 at 09:33:59AM +0200, Greg Kurz wrote: =20
> > > [...] =20
> > > > > > > > > +static void pre_2_10_vmstate_register_dummy_icp(sPAPRMac=
hineState *spapr, int i)
> > > > > > > > > +{
> > > > > > > > > +    bool *flag =3D &spapr->pre_2_10_ignore_icp[i];
> > > > > > > > > +
> > > > > > > > > +    g_assert(!*flag);       =20
> > > > > > > >=20
> > > > > > > > Apart from this assert(), you never seem to test the values=
 in the
> > > > > > > > pre_2_10_ignore_icp() array, so it seems a bit pointless.
> > > > > > > >      =20
> > > > > > >=20
> > > > > > > There's the opposite check in pre_2_10_vmstate_unregister_dum=
my_icp().
> > > > > > > But I agree it isn't really useful... but more because of par=
anoia :)     =20
> > > > > >=20
> > > > > > I'm all for paranoid assert()s if they can be made using data r=
eadily
> > > > > > to hand.  Adding a data structure just for the purpose of makin=
g an
> > > > > > assert() later, not so much.
> > > > > >    =20
> > > > >=20
> > > > > It is also passed as opaque argument to vmstate_register(), where=
 it is
> > > > > used as a key when calling vmstate_unregister(). I could possibly=
 pass
> > > > > (void *) i instead, but I'm not a big fan of hijacking pointer ar=
guments
> > > > > to pass numbers.   =20
> > > >=20
> > > > Ah, I see your point.  Creating an array, purely to generate arbitr=
ary
> > > > pointers is also kind of ugly, though.  Really the cpu_index / XICS
> > > > server number makes sense to identify the vmstate, but it looks like
> > > > vmstate_unregister() doesn't take that.
> > > >  =20
> > >=20
> > > Indeed... what about adding a vmstate_unregister_by_instance_id() the=
n ?
> > >=20
> > > Cc'ing Juan and David. =20
> >=20
> > So what's the problem with a (void *)i ?
>=20
> https://stackoverflow.com/questions/8618637/what-does-it-mean-to-convert-=
int-to-void-or-vice-versa
>=20
> > It's simple, as long as you're
> > not actually using the opaque anywhere it's easy.
> >=20
>=20
> but as you say, since the opaque isn't used anywhere, it is probably
> okay to pass (void *) i.

Right, that's probably the right short term approach.


Incidentally, for a somewhat safer-than-standard approach to this
common problem, see https://ccodearchive.net/info/ptrint.html

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZP7gIAAoJEGw4ysog2bOSE68QAKT2HZsHi0QZ99G6e2Wo7HVO
EItgsKxrnh30BY8dDgnZMSrvEPCAtTZxWZDYxKWsXsBtnlaj/1dQ/tdczgfokYZg
lMlrD6e2BC3Hg5tKVb3zHdHIe1lUWPPPxe4uzMCdvDWjEcgVvoEWlwYaRhooqGvU
Fa8bweI3PTzr68QKtdfBT3y+REYmqE03e9ti/gLhWn0fA1lOibwOOQb3QDketxFp
e81qlnYFe3CamwonB9Nw4NgA1WwMhKaS6hZsGpEBWnlKNY6HPGcb1HPiqPXl3MFg
naPlbNP8TTAtAYkBH6xvMX7qJqoWA8ODmz3vRq/IhDcPpVZ87w0DWPfA7ho46Ik8
v2ZAU5qf5X4c12+P1f0Gk+Rdd+4IT3ErXnJcB8N/DbZZjTxtg5Ss1En1RQb/K/HJ
7ivF/aktWeQznEq9HUTVmUDTdhPvrpCqlwNHRoxjtsSOaTOT5bYFsmMWFiPH4P/X
/pDl1U0DQ1kOol1J6TpAqCM1ipCnYEatfKt9zE1sR6qtqVFi9OXD0lGiz4w2p+sE
bpsUXSeu4oVfjHz0Q2i4mNiGL2Mgl/RB/qLpZ880K/n4HgtE7qPudeBdfkVpjhjj
8jZII5VB2qKW73uQgpkks125ej0Y1b0gSr77eMNYvSVFZWzOZpaBWyprraj/sUqN
b8fLzTOhXbrdDEIP0Niw
=wVjS
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
