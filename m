Received: from eggs.gnu.org ([2001:4830:134:3::10]:54752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fW0Pf-0008W9-Bo
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fW0Pb-0002uJ-6r
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:18:15 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:40208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fW0Pb-0002ti-0L
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:18:11 -0400
Received: from player732.ha.ovh.net (unknown [10.109.122.108])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 526171857E
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 16:18:09 +0200 (CEST)
Date: Thu, 21 Jun 2018 16:18:00 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180621161800.44118e93@bahia.lan>
In-Reply-To: <20180621140113.GA612@umbus.fritz.box>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-9-david@gibson.dropbear.id.au>
	<20180621142419.5c6d2ce2@bahia.lan>
	<20180621140113.GA612@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/V0VKRcMLhaXqCFBDJIRT=8=";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 8/9] spapr: Limit available pagesizes to
 provide a consistent guest environment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: abologna@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru

--Sig_/V0VKRcMLhaXqCFBDJIRT=8=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Jun 2018 00:01:13 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 21, 2018 at 02:24:19PM +0200, Greg Kurz wrote:
> > On Mon, 18 Jun 2018 16:36:05 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > KVM HV has some limitations (deriving from the hardware) that mean no=
t all
> > > host-cpu supported pagesizes may be usable in the guest.  At present =
this
> > > means that KVM guests and TCG guests may see different available page=
 sizes
> > > even if they notionally have the same vcpu model.  This is confusing =
and
> > > also prevents migration between TCG and KVM.
> > >=20
> > > This patch makes the environment consistent by always allowing the sa=
me set
> > > of pagesizes.  Since we can't remove the KVM limitations, we do this =
by
> > > always applying the same limitations it has, even to TCG guests.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr_caps.c | 33 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > > index 9fc739b3f5..0584c7c6ab 100644
> > > --- a/hw/ppc/spapr_caps.c
> > > +++ b/hw/ppc/spapr_caps.c
> > > @@ -334,6 +334,38 @@ static void cap_hpt_maxpagesize_apply(sPAPRMachi=
neState *spapr,
> > >      spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
> > >  }
> > > =20
> > > +static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift, uin=
t32_t pshift)
> > > +{
> > > +    unsigned maxshift =3D *((unsigned *)opaque);
> > > +
> > > +    assert(pshift >=3D seg_pshift);
> > > +
> > > +    /* Don't allow the guest to use pages bigger than the configured
> > > +     * maximum size */
> > > +    if (pshift > maxshift) {
> > > +        return false;
> > > +    }
> > > +
> > > +    /* For whatever reason, KVM doesn't allow multiple pagesizes
> > > +     * within a segment, *except* for the case of 16M pages in a 4k =
or
> > > +     * 64k segment.  Always exclude other cases, so that TCG and KVM
> > > +     * guests see a consistent environment */ =20
> >=20
> > Unless I'm missing something, I don't see how we could get "other cases"
> > with TCG, at least with the current content of ppc_hash64_opts_POWER7. =
=20
>=20
> You're missing something.  hash64_opts_POWER7 includes 64k pages in a
> segment with base page size of 4k.
>=20

/me should read more carefully... :(


Reviewed-by: Greg Kurz <groug@kaod.org>

--Sig_/V0VKRcMLhaXqCFBDJIRT=8=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsrs5gACgkQcdTV5YIv
c9aHBBAAl9Iyooo7CacF6NItKsCNqW9CvNSJqRq2Zuqo5mpfmwHBXQW4T5cWYmiK
HdYfM1AHF2zanvMcpCbmcjRx1OmMApBVFH2zsJfhE5Jvskbg7nv8cXleAziw0IqI
Q6kLlPInHdTnJiQerG5bq/hUjGVTNoVC3ro4VRYABkOJBpWswsKhwnrZGmEqi8b7
H/5VT+Jn75xjeiXQsQemARu0AfXIbTUNXZmpzV2ZwN3rNgrIoU81T8edUIvlf+K4
p7EGKGNxMk2NPiJAZ4qTIhDrqnhX4rztSnd//MQD8NQiPAuEt03tQak+pSarjrC6
9XriMhztLwnqKElU0LTz2L36eLIS45Uxf1lRAiuN8TWh037WHqZ+HXA+1VY1rxcC
F61xrUnjzqUB38+PVYQPQDegdLj1L+FzMsgnEdVY2AIDhjCxid+fBfVlFKjfn5A6
IAieT6mnhfKmCM9FfKNElF3vNBGf4Q89o/ORNp7LoKwwCr2SFUUW3sLBuqdokglX
8Q8JZ2rzoZvQbldsTPje+D+p5QZB4Biw+YhvvbAoGoKk63ksNzgHvrMWopJRQFm+
m7QIbsNeLoSo3fchqAJO1lVOdHHuC8vIR270Up4LGPahiPLvT37wST0ygtqppyod
aaeOa1Ubeb1NaELV2WNZcEDq+6aH5z5ZRiMckbr+cvNxMO5HGew=
=8srP
-----END PGP SIGNATURE-----

--Sig_/V0VKRcMLhaXqCFBDJIRT=8=--
