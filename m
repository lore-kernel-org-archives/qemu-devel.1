Received: from eggs.gnu.org ([2001:4830:134:3::10]:56451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eGi7v-0002sn-0g
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eGi7r-00020S-R4
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:12:26 -0500
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:52148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eGi7r-0001x5-Hb
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:12:23 -0500
Received: from player786.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id EBB23151828
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 10:12:14 +0100 (CET)
Date: Mon, 20 Nov 2017 10:11:57 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171120101157.53dd6154@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20171119231751.GD19214@umbus.fritz.box>
References: <150789430473.4410.10317971414202753256.stgit@bahia.lan>
	<20171014093337.GG28032@umbus.fritz.box>
	<20171016102638.6977381f@nial.brq.redhat.com>
	<20171017061609.GL2776@umbus.fritz.box>
	<20171106160307.215d3cbd@bahia>
	<20171106190455.GA12514@umbus.fritz.box>
	<20171114085943.5f2439a9@bahia.lan>
	<20171119231751.GD19214@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/Wg6R7BdfNK71HsQv.cxmgHS";
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

--Sig_/Wg6R7BdfNK71HsQv.cxmgHS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Nov 2017 10:17:51 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Nov 14, 2017 at 08:59:43AM +0100, Greg Kurz wrote:
> > On Tue, 7 Nov 2017 06:04:55 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Mon, Nov 06, 2017 at 04:03:07PM +0100, Greg Kurz wrote: =20
> > > > On Tue, 17 Oct 2017 17:16:09 +1100
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >    =20
> > > > > On Mon, Oct 16, 2017 at 10:26:38AM +0200, Igor Mammedov wrote:   =
=20
> > > > > > On Sat, 14 Oct 2017 20:33:37 +1100
> > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > >      =20
> > > > > > > On Fri, Oct 13, 2017 at 01:31:44PM +0200, Greg Kurz wrote:   =
  =20
> > > > > > > > The current code assumes that only the CPU core object hold=
s a
> > > > > > > > reference on each individual CPU object, and happily frees =
their
> > > > > > > > allocated memory when the core is unrealized. This is dange=
rous
> > > > > > > > as some other code can legitimely keep a pointer to a CPU i=
f it
> > > > > > > > calls object_ref(), but it would end up with a dangling poi=
nter.
> > > > > > > >=20
> > > > > > > > Let's allocate all CPUs with object_new() and let QOM frees=
 them
> > > > > > > > when their reference count reaches zero. This greatly simpl=
ify the
> > > > > > > > code as we don't have to fiddle with the instance size anym=
ore.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>       =20
> > > > > > >=20
> > > > > > > So, I'm pretty sure my first drafts of the core stuff did thi=
ngs this
> > > > > > > waym and it got nacked, for QOM lifetime reasons that I never=
 really
> > > > > > > understood.     =20
> > > > > > From what I remember, Andreas would like to see composite CPU o=
bject
> > > > > > allocated in one go and then its children initialized with obje=
ct_initialize()
> > > > > > so that no more allocation were needed.     =20
> > > > >=20
> > > > > Ah, ok.
> > > > >    =20
> > > > > > That potentially would benefit hotplug, since we could graceful=
ly
> > > > > > fail object creation early if there is not enough memory.     =
=20
> > > > >=20
> > > > > Yeah, it sounds nice, but I don't see how we can do it.  In order=
 to
> > > > > do that the core object has to have enough space for all the thre=
ads,
> > > > > which means we need both the size of each thread object and the n=
umber
> > > > > of them.  The size we have (and will be easier to handle after Ig=
or's
> > > > > cleanups).  The number, we don't.
> > > > >    =20
> > > > > > But the way it's implemented currently doesn't really match tha=
t initial
> > > > > > goal as array for threads is dynamically allocated later
> > > > > > and then we need to dance around it with pointer arithmetic.
> > > > > >=20
> > > > > > BTW: almost any allocation failure in qemu currently
> > > > > > is fatal so whether we fail on array alloc or on individual
> > > > > > object_new() won't make any difference.
> > > > > >=20
> > > > > > I'd rather see this clean up merged as it simplifies code
> > > > > > in these case.     =20
> > > > >=20
> > > > > Ok, works for me.
> > > > >    =20
> > > >=20
> > > > Since we're in soft freeze already, I guess this won't go to 2.11. =
Maybe it's
> > > > time to create ppc-for-2.12 and apply it there ?   =20
> > >=20
> > > Yeah, sounds like a plan.
> > >  =20
> >=20
> > Friendly reminder: can you push this to ppc-for-2.12 so that it doesn't=
 fall
> > through the cracks ? :) =20
>=20
> Uh.. sorry.  I thought there was another spin of this coming.  Can you
> resend, and I'll apply to ppc-for-2.12.
>=20

Heh, I didn't resend because the patch still applies flawlessly. I'll repost
right away for your convenience.

--Sig_/Wg6R7BdfNK71HsQv.cxmgHS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAloSnF0ACgkQcdTV5YIv
c9Zcbw//WRpdkVTUao/8d3q/sp1imWggLvhk4JoZy9HHcCeiLtXz6X9uHWcm+7e5
gNELOFMPgIDpq6MgauFsoAc4AFdRznfY7febAO/6vaMDPxCrtp/KNjvRi6IZ1lyh
PmEkZTit2ZTmMl1covNk9VvFbQut+jaC5YERyPMDzWmVUMD/tkDnED+qZ1wRXH0A
e4nrfseUKvHEA51NY8kBQbm3Vp5TLjZ+/emDX4xy44Oig0V3OnbUm7h1d50KVTkA
pxYWtPk0AmsI24k3IStIe/UnRA7aukcNVEYsBjxqSXfie9kyl+4PUjb0rFwC/pqL
OLj/6EaWnpoLu70yMfYfmPE3/IVPA7jDIkD09XzDP9QWCsDBwh+17UfYFVuGDhHs
mL0qJWMq0kMi75YM9MLUwfLCEVucZpiwiruKz44TVU9ajXffhHraFehA+0ExRCAX
GPaapRIW/6kc9wr1PpyjfqKXKt0jvqo6cyCHvf8Lzo1662ZyNB/GMwxlNLenBECc
60TgThWt/UfYrIxVyBlsKP0oIMX8tPOd82e9UgEVGbkp1EuyXxmKQUtuZSwlitc8
wqAfG4GeYywRDRK1hYikVajPp5ubxa/2zY7n2Pwr0zA53WXs5Jt7XoeNj1TvFRsO
elBzSBX8Sf74vE+TSIYGsCSC4BEPrrFQDvfm6qQytXYy4fFn190=
=2MzG
-----END PGP SIGNATURE-----

--Sig_/Wg6R7BdfNK71HsQv.cxmgHS--
