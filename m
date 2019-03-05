Received: from eggs.gnu.org ([209.51.188.92]:42437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Jpy-0003U5-8Z
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Jpx-000613-68
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:51:06 -0500
Received: from ozlabs.org ([203.11.71.1]:53925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1h1Jpv-0005We-M7
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:51:05 -0500
Date: Wed, 6 Mar 2019 10:33:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190305233324.GA19715@umbus.fritz.box>
References: <20190221173326.31874-1-mst@redhat.com>
	<20190214043916.22128-6-david@gibson.dropbear.id.au>
	<CAFEAcA_Xc6A017YJNvxHReC_D2d0C4cJ_pbro+E3EEcGLfbhhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Xc6A017YJNvxHReC_D2d0C4cJ_pbro+E3EEcGLfbhhQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 23/26] virtio-balloon: Safely handle
 BALLOON_PAGE_SIZE < host page size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 04:06:54PM +0000, Peter Maydell wrote:
> On Fri, 22 Feb 2019 at 02:41, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: David Gibson <david@gibson.dropbear.id.au>
> >
> > The virtio-balloon always works in units of 4kiB (BALLOON_PAGE_SIZE), b=
ut
> > we can only actually discard memory in units of the host page size.
>=20
> Hi -- Coverity points out an issue in this patch (CID 1399146):
>=20
> > +    /* Hard case
> > +     *
> > +     * We've put a piece of a larger host page into the balloon - we
> > +     * need to keep track until we have a whole host page to
> > +     * discard
> > +     */
> > +    warn_report_once(
> > +"Balloon used with backing page size > 4kiB, this may not be reliable"=
);
> > +
> > +    subpages =3D rb_page_size / BALLOON_PAGE_SIZE;
> > +
> > +    if (balloon->pbp
> > +        && (rb !=3D balloon->pbp->rb
> > +            || host_page_base !=3D balloon->pbp->base)) {
> > +        /* We've partially ballooned part of a host page, but now
> > +         * we're trying to balloon part of a different one.  Too hard,
> > +         * give up on the old partial page */
> > +        free(balloon->pbp);
> > +        balloon->pbp =3D NULL;
> >      }
> >
> > -    ram_block_discard_range(rb, ram_offset, rb_page_size);
> > -    /* We ignore errors from ram_block_discard_range(), because it has
> > -     * already reported them, and failing to discard a balloon page is
> > -     * not fatal */
> > +    if (!balloon->pbp) {
> > +        /* Starting on a new host page */
> > +        size_t bitlen =3D BITS_TO_LONGS(subpages) * sizeof(unsigned lo=
ng);
> > +        balloon->pbp =3D g_malloc0(sizeof(PartiallyBalloonedPage) + bi=
tlen);
>=20
>=20
> We allocate balloon->pbp with g_malloc0() here...
>=20
> > +        balloon->pbp->rb =3D rb;
> > +        balloon->pbp->base =3D host_page_base;
> > +    }
> > +
> > +    bitmap_set(balloon->pbp->bitmap,
> > +               (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> > +               subpages);
> > +
> > +    if (bitmap_full(balloon->pbp->bitmap, subpages)) {
> > +        /* We've accumulated a full host page, we can actually discard
> > +         * it now */
> > +
> > +        ram_block_discard_range(rb, balloon->pbp->base, rb_page_size);
> > +        /* We ignore errors from ram_block_discard_range(), because it
> > +         * has already reported them, and failing to discard a balloon
> > +         * page is not fatal */
> > +
> > +        free(balloon->pbp);
>=20
> ...but we free it (here and elsewhere) with free(), not g_free().

Ah.  Whoops.

I'll put a fix for that in the series of followup balloon patches I'm
working on right now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx/B0QACgkQbDjKyiDZ
s5JguhAAlIS4vrwcU0sQMxxM2pj97TOtRN27LJIQN2arOvzXX5FVjBDu00D1jQz5
vbOVH5FtrSltz8XLOaPseL4LHB/zbnuXBHa2u1GxUnkgJw1nIopIW802eThZEBB0
uz+8cS0dOb7SNjFuzLaBw1jVY4o7HAKmKVtoE2KXARhZsPqaeC5UExoy2GGOHf9n
YQ+yusmnI2yZd7ov9yR2gjS+SpkEmzPACeFi9l/dVDJbQU37hgD44zo8HrW6ttbI
P/CU6yoQ2kh+zMZHElAZWYhjFIUX3InyYC4jNVcA79nwtb4krmFjiqpxKOW3Ka7J
nO3E2YOWDE7O5WSVoR7BieSzqJRayUtm4UYvfsoWLs8+7AygfxKFv1kHMm5mZHOL
j3bFOtn/W6AdsX1HhB98j+CA6VIQ1K3ZTaQyGw1HjuUDSTedMo6jB+1bDFPFRUZ4
GI2+l3j5xfcdCuDTuixFbgT3Mu4gqDIrZ68uRmoWfpt1F7BHK6FVKay6Hml6qqoi
ORp6L1JCZQJSpEno5/S91oehZcA/2+BI+itcaG7aJb5vikcGgPCC8V6c7rNfRHon
Ie9pzsV1v0ylY0zHhjrAV8mvXYx8W322A7UFLpjIE5EKI4vBTfpW1JuCriEzlt1e
xDmNSilodalpabUaACOeQ7VL3UQhYSxJhmVOIZknUXLw/ZGHUdk=
=kt9X
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
