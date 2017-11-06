Received: from eggs.gnu.org ([2001:4830:134:3::10]:46270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBivy-0005es-Hz
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBivs-0005Wi-KY
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:03:30 -0500
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:45014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eBivs-0005Vw-E2
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:03:24 -0500
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id A2267F083A
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 16:03:21 +0100 (CET)
Date: Mon, 6 Nov 2017 16:03:07 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171106160307.215d3cbd@bahia>
In-Reply-To: <20171017061609.GL2776@umbus.fritz.box>
References: <150789430473.4410.10317971414202753256.stgit@bahia.lan>
	<20171014093337.GG28032@umbus.fritz.box>
	<20171016102638.6977381f@nial.brq.redhat.com>
	<20171017061609.GL2776@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/6Q/egHq59+/K1gM05CCFp./";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr_cpu_core: instantiate CPUs separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/6Q/egHq59+/K1gM05CCFp./
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Oct 2017 17:16:09 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Oct 16, 2017 at 10:26:38AM +0200, Igor Mammedov wrote:
> > On Sat, 14 Oct 2017 20:33:37 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Fri, Oct 13, 2017 at 01:31:44PM +0200, Greg Kurz wrote: =20
> > > > The current code assumes that only the CPU core object holds a
> > > > reference on each individual CPU object, and happily frees their
> > > > allocated memory when the core is unrealized. This is dangerous
> > > > as some other code can legitimely keep a pointer to a CPU if it
> > > > calls object_ref(), but it would end up with a dangling pointer.
> > > >=20
> > > > Let's allocate all CPUs with object_new() and let QOM frees them
> > > > when their reference count reaches zero. This greatly simplify the
> > > > code as we don't have to fiddle with the instance size anymore.
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>   =20
> > >=20
> > > So, I'm pretty sure my first drafts of the core stuff did things this
> > > waym and it got nacked, for QOM lifetime reasons that I never really
> > > understood. =20
> > From what I remember, Andreas would like to see composite CPU object
> > allocated in one go and then its children initialized with object_initi=
alize()
> > so that no more allocation were needed. =20
>=20
> Ah, ok.
>=20
> > That potentially would benefit hotplug, since we could gracefully
> > fail object creation early if there is not enough memory. =20
>=20
> Yeah, it sounds nice, but I don't see how we can do it.  In order to
> do that the core object has to have enough space for all the threads,
> which means we need both the size of each thread object and the number
> of them.  The size we have (and will be easier to handle after Igor's
> cleanups).  The number, we don't.
>=20
> > But the way it's implemented currently doesn't really match that initial
> > goal as array for threads is dynamically allocated later
> > and then we need to dance around it with pointer arithmetic.
> >=20
> > BTW: almost any allocation failure in qemu currently
> > is fatal so whether we fail on array alloc or on individual
> > object_new() won't make any difference.
> >=20
> > I'd rather see this clean up merged as it simplifies code
> > in these case. =20
>=20
> Ok, works for me.
>=20

Since we're in soft freeze already, I guess this won't go to 2.11. Maybe it=
's
time to create ppc-for-2.12 and apply it there ?

--Sig_/6Q/egHq59+/K1gM05CCFp./
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAloAeawACgkQcdTV5YIv
c9YPFQ//dj3mn8TiSJNVu0xkLPnmmjtBknehX8DBWapiPvu7XLcTW6G2twl/+CH3
qy5ILvciWZ1OLGUs1AoTFgC7NKT/d1rBw5LsB368nFcw2+jFaCQO1bvRLYM2d1Ml
kFh286yhSZEMe+jMsFBk3h5lBSdb9hpUznD5/mTgY9/aOq8npCPvqf8bvOAVw4Bf
qxw3EJ67YpPLM2Y62CCOzuNxwDf1igvr9KyjHv6LkROgyVVffWqU0VrCnuhzN9CY
Z/s7UEQDy2714a0nViviYR6IzfgZdAo6387+Zfuw07Ysuq0LTbjzXgepzZCW3ji7
Si3tGHYw9GSX6RiLiKokuts25B+Dfmu1b8T95qbiJdjJmV9e80ajaYITj+ecEusW
0knRCTYAk6F25Br9qRY+7rEbp202wp0IfBBPFO1sLXynGZQql1QFVsZSxrzssrCw
YhoER2e+ohz+uLlaac5DWlI7R16kjOu3PQgITflK7Spmj6bsJdH0GFfmB6Me5zGS
KIo0mPwgx0q1iHQQ2wMkdPfloHGD2OqeOZ4XPgvqJM3kmxK44TXF9AxGgvf9erDL
2079ysjLHszDIpH5NvyoMK/xkYPu8xeHzUx370Sc0BvMeC8+x8MDP0bl1EdFIn7e
TTiwfWlPUM6Gqaj21Nkyu09mCnkB4wosIf1t0WevNRIIu/GXglQ=
=UkYd
-----END PGP SIGNATURE-----

--Sig_/6Q/egHq59+/K1gM05CCFp./--
