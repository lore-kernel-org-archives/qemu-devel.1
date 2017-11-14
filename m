Received: from eggs.gnu.org ([2001:4830:134:3::10]:60984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEW8T-00012f-7f
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEW8O-0001fW-Ew
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:59:57 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:50381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eEW8O-0001ee-7o
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:59:52 -0500
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 837EBCD0CE
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 08:59:50 +0100 (CET)
Date: Tue, 14 Nov 2017 08:59:43 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171114085943.5f2439a9@bahia.lan>
In-Reply-To: <20171106190455.GA12514@umbus.fritz.box>
References: <150789430473.4410.10317971414202753256.stgit@bahia.lan>
	<20171014093337.GG28032@umbus.fritz.box>
	<20171016102638.6977381f@nial.brq.redhat.com>
	<20171017061609.GL2776@umbus.fritz.box>
	<20171106160307.215d3cbd@bahia>
	<20171106190455.GA12514@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/Vyd6+D=/w3il8dV_DalK1Hx";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr_cpu_core: instantiate
 CPUs separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/Vyd6+D=/w3il8dV_DalK1Hx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Nov 2017 06:04:55 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Nov 06, 2017 at 04:03:07PM +0100, Greg Kurz wrote:
> > On Tue, 17 Oct 2017 17:16:09 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Mon, Oct 16, 2017 at 10:26:38AM +0200, Igor Mammedov wrote: =20
> > > > On Sat, 14 Oct 2017 20:33:37 +1100
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >    =20
> > > > > On Fri, Oct 13, 2017 at 01:31:44PM +0200, Greg Kurz wrote:   =20
> > > > > > The current code assumes that only the CPU core object holds a
> > > > > > reference on each individual CPU object, and happily frees their
> > > > > > allocated memory when the core is unrealized. This is dangerous
> > > > > > as some other code can legitimely keep a pointer to a CPU if it
> > > > > > calls object_ref(), but it would end up with a dangling pointer.
> > > > > >=20
> > > > > > Let's allocate all CPUs with object_new() and let QOM frees them
> > > > > > when their reference count reaches zero. This greatly simplify =
the
> > > > > > code as we don't have to fiddle with the instance size anymore.
> > > > > >=20
> > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>     =20
> > > > >=20
> > > > > So, I'm pretty sure my first drafts of the core stuff did things =
this
> > > > > waym and it got nacked, for QOM lifetime reasons that I never rea=
lly
> > > > > understood.   =20
> > > > From what I remember, Andreas would like to see composite CPU object
> > > > allocated in one go and then its children initialized with object_i=
nitialize()
> > > > so that no more allocation were needed.   =20
> > >=20
> > > Ah, ok.
> > >  =20
> > > > That potentially would benefit hotplug, since we could gracefully
> > > > fail object creation early if there is not enough memory.   =20
> > >=20
> > > Yeah, it sounds nice, but I don't see how we can do it.  In order to
> > > do that the core object has to have enough space for all the threads,
> > > which means we need both the size of each thread object and the number
> > > of them.  The size we have (and will be easier to handle after Igor's
> > > cleanups).  The number, we don't.
> > >  =20
> > > > But the way it's implemented currently doesn't really match that in=
itial
> > > > goal as array for threads is dynamically allocated later
> > > > and then we need to dance around it with pointer arithmetic.
> > > >=20
> > > > BTW: almost any allocation failure in qemu currently
> > > > is fatal so whether we fail on array alloc or on individual
> > > > object_new() won't make any difference.
> > > >=20
> > > > I'd rather see this clean up merged as it simplifies code
> > > > in these case.   =20
> > >=20
> > > Ok, works for me.
> > >  =20
> >=20
> > Since we're in soft freeze already, I guess this won't go to 2.11. Mayb=
e it's
> > time to create ppc-for-2.12 and apply it there ? =20
>=20
> Yeah, sounds like a plan.
>=20

Friendly reminder: can you push this to ppc-for-2.12 so that it doesn't fall
through the cracks ? :)

Cheers,

--
Greg

--Sig_/Vyd6+D=/w3il8dV_DalK1Hx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAloKom8ACgkQcdTV5YIv
c9ZSMQ//SB8OcmyXdzbaPzbyPegcCo88GRDXG+0nWZbEQIOJZinmk/gSTaF1mfeH
NjJ0F6dMuWg4FVKq6apFZpg7thLnxCwDq3Su1h2/fHgHEUXTa5I/HL/OO3KW2JJ4
ug3EQUlDrlsAgb1xKlz4Tfgw4Z6bRJ40O9uvUXplD9hKDlOzd/RvLLVSVuq7xIdR
fRjJSibRejKcNKc91YQ2rMMwQnTYIYL14OnA56CnfPP7mORzJnKdOvGgyd4pWpB1
PUODXCUtmsbKnvsLoHVEP6abYKMq6PSEcTKBJuDAna+C8QT049gnS4WkX1n8FtyR
JW7ZeklKwalu2Phen2IL6S8KNUCTmtFP/7ZmG9lYMSjfqqipX2QAwiDMEbYY/xLd
4aA2LRx0bc8/noPMNuJAHMNbJgf58m8ZMI/eSpo64ES0yE61BMnNlDfYjNOg2l9A
3Fdbimr29PJfI1QejHlF5Z1BXL85s5rSHS7jEODvG1qstJAz1kcOYPMZQQs5Rlpy
xuboYo5JgWDiG2IQGBQZSlLnkki9HLxUR3tvx1/Arf9r2X2W/aH9CxLIrOvLyPRV
1odfYXXSw8Q4bvoNZTOWWSIEubbbCCVg7NV4AApIYLDaM+y5mWJ4bgdiutCda0wu
+D/z5y2p/u25zUEU08gYnyxsR1YeA7LkNjrfx418yXdoCy1b9Qo=
=U/lS
-----END PGP SIGNATURE-----

--Sig_/Vyd6+D=/w3il8dV_DalK1Hx--
