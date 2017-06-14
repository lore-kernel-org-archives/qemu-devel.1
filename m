Received: from eggs.gnu.org ([2001:4830:134:3::10]:38409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKxJt-00049n-Iy
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 21:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKxJp-0000SS-Lb
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 21:42:05 -0400
Date: Wed, 14 Jun 2017 09:40:34 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170614014034.GE13420@umbus>
References: <20170608040857.GV13397@umbus.fritz.box>
	<20170608115410.2e7a2511@bahia.ttt.fr.ibm.com>
	<20170612142456.GJ18542@umbus>
	<20170613093359.4567ba94@bahia.ttt.fr.ibm.com>
	<20170613080631.GB30171@umbus>
	<20170613104003.233e21d5@bahia.ttt.fr.ibm.com>
	<20170613090002.GA2096@work-vm>
	<20170613112150.7f64171c@bahia.ttt.fr.ibm.com>
	<20170613100146.GA13420@umbus>
	<20170613172428.08dee7ea@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <20170613172428.08dee7ea@bahia.ttt.fr.ibm.com>
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


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 05:24:28PM +0200, Greg Kurz wrote:
> On Tue, 13 Jun 2017 18:01:46 +0800
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jun 13, 2017 at 11:21:50AM +0200, Greg Kurz wrote:
> > > On Tue, 13 Jun 2017 10:00:03 +0100
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >  =20
> > > > * Greg Kurz (groug@kaod.org) wrote: =20
> > > > > On Tue, 13 Jun 2017 16:06:31 +0800
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >    =20
> > > > > > On Tue, Jun 13, 2017 at 09:33:59AM +0200, Greg Kurz wrote:   =
=20
> > > > > [...]   =20
> > > > > > > > > > > +static void pre_2_10_vmstate_register_dummy_icp(sPAP=
RMachineState *spapr, int i)
> > > > > > > > > > > +{
> > > > > > > > > > > +    bool *flag =3D &spapr->pre_2_10_ignore_icp[i];
> > > > > > > > > > > +
> > > > > > > > > > > +    g_assert(!*flag);         =20
> > > > > > > > > >=20
> > > > > > > > > > Apart from this assert(), you never seem to test the va=
lues in the
> > > > > > > > > > pre_2_10_ignore_icp() array, so it seems a bit pointles=
s.
> > > > > > > > > >        =20
> > > > > > > > >=20
> > > > > > > > > There's the opposite check in pre_2_10_vmstate_unregister=
_dummy_icp().
> > > > > > > > > But I agree it isn't really useful... but more because of=
 paranoia :)       =20
> > > > > > > >=20
> > > > > > > > I'm all for paranoid assert()s if they can be made using da=
ta readily
> > > > > > > > to hand.  Adding a data structure just for the purpose of m=
aking an
> > > > > > > > assert() later, not so much.
> > > > > > > >      =20
> > > > > > >=20
> > > > > > > It is also passed as opaque argument to vmstate_register(), w=
here it is
> > > > > > > used as a key when calling vmstate_unregister(). I could poss=
ibly pass
> > > > > > > (void *) i instead, but I'm not a big fan of hijacking pointe=
r arguments
> > > > > > > to pass numbers.     =20
> > > > > >=20
> > > > > > Ah, I see your point.  Creating an array, purely to generate ar=
bitrary
> > > > > > pointers is also kind of ugly, though.  Really the cpu_index / =
XICS
> > > > > > server number makes sense to identify the vmstate, but it looks=
 like
> > > > > > vmstate_unregister() doesn't take that.
> > > > > >    =20
> > > > >=20
> > > > > Indeed... what about adding a vmstate_unregister_by_instance_id()=
 then ?
> > > > >=20
> > > > > Cc'ing Juan and David.   =20
> > > >=20
> > > > So what's the problem with a (void *)i ? =20
> > >=20
> > > https://stackoverflow.com/questions/8618637/what-does-it-mean-to-conv=
ert-int-to-void-or-vice-versa
> > >  =20
> > > > It's simple, as long as you're
> > > > not actually using the opaque anywhere it's easy.
> > > >  =20
> > >=20
> > > but as you say, since the opaque isn't used anywhere, it is probably
> > > okay to pass (void *) i. =20
> >=20
> > Right, that's probably the right short term approach.
> >=20
>=20
> I'm currently heading towards (void *)(intptr_t) i
>=20
> >=20
> > Incidentally, for a somewhat safer-than-standard approach to this
> > common problem, see https://ccodearchive.net/info/ptrint.html
> >=20
>=20
> Heh, your code :)
>=20
> IIUC it is licensed under the terms of CC0, which I believe to be GPL
> compatible. Why not using it in QEMU ?

Well, we could.  I just haven't bothered to import it and convince
people to use it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQJQSAAoJEGw4ysog2bOS/BkP/0GIO8XDTxDREtbPQsCcIySG
hcVpzLAD9qxXJIDMuSc+rAgzF/a34bM+8+iIlkfZ20AuRxfv+5ocOGFxnEBzMBKx
d0iLOToTCMnh9YDyi3KDbp1JDGui7jtVFqogKGTSNwqFT8TyoBh3Sd9y4UwSCIEL
bhudAktu/cgc2ULqaYOyV2qkaSHmy68lZlKJ0/oeb7SESPYuIxrRDHji+DR6Zz5w
itYsJV4JR/cQWZnxxAYEZ842YNnx8yxv2s0hfx+H68+z+ROBgXqfMbHYCfJidcT5
G0bNSqYxROOvPW/+/XLXrSgpzJhREIBoqxjSb7kKDmDmWqGECzlNhtAMukJBQU80
iaswfbYdAjVOgwb/OOgKxlXu7h3GEPPz4wQ8Fs59SewIBSVGDX5o6fod7gxbsKAZ
9X6fJ8Qps4701cjYVQHTxpz9O4j8u2/Ydpi6VRSdsqg2t8YYA5y54YXwx9cWit8B
YWP3oM7y2CRfUI3CAbanSGaqXNo/y3YilUvpa7hAQDZFPGinUFGn3v5gxMun0JT0
wD1lxSEhQ0SzdmWSknZqeGRzSkHWzHZjk9QSQ4jzweDb9ibN6R+T6mtN1j8G9KsO
xUtcWG2zSuDbetO/ASs7VEF9B1GNGXf553ODzZT5//5n7rpVAtpttEBoj/dUC5eq
C/JwdQOB5edR6Cg3QE5s
=rL+c
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
