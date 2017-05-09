Received: from eggs.gnu.org ([2001:4830:134:3::10]:33482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d878K-0002vI-Ir
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d878G-0001m3-4b
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:33:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d878F-0001l8-Rf
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:33:00 -0400
Date: Tue, 9 May 2017 11:32:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170509153255.GJ16825@stefanha-x1.localdomain>
References: <20170508141536.20690-1-stefanha@redhat.com>
	<20170508141536.20690-5-stefanha@redhat.com>
	<8b49e6e9-043d-e628-3c49-1433ba0b5d5e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Content-Disposition: inline
In-Reply-To: <8b49e6e9-043d-e628-3c49-1433ba0b5d5e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 4/9] qcow2: make refcount size
 calculation conservative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 11:26:18PM +0200, Max Reitz wrote:
> On 08.05.2017 16:15, Stefan Hajnoczi wrote:
> > The refcount metadata size calculation is inaccurate and can produce
> > numbers that are too small.  This is bad because we should calculate a
> > conservative number - one that is guaranteed to be large enough.
> >=20
> > This patch switches the approach to a fixed point calculation because
> > the existing equation is hard to solve when inaccuracies are taken care
> > of.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
> > ---
> >  block/qcow2.c | 82 ++++++++++++++++++++++++++++++---------------------=
--------
> >  1 file changed, 42 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 5569b63..ff0d825 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -2095,6 +2095,43 @@ static int preallocate(BlockDriverState *bs)
> >      return 0;
> >  }
> > =20
> > +/* qcow2_refcount_metadata_size:
> > + * @clusters: number of clusters to refcount (including data and L1/L2=
 tables)
> > + * @cluster_size: size of a cluster, in bytes
> > + * @refcount_order: refcount bits power-of-2 exponent
> > + *
> > + * Returns: Number of bytes required for refcount blocks and table met=
adata.
> > + */
> > +static int64_t qcow2_refcount_metadata_size(int64_t clusters,
> > +                                            size_t cluster_size,
> > +                                            int refcount_order)
> > +{
> > +    /*
> > +     * Every host cluster is reference-counted, including metadata (ev=
en
> > +     * refcount metadata is recursively included).
> > +     *
> > +     * An accurate formula for the size of refcount metadata size is d=
ifficult
> > +     * to derive.
>=20
> Oh, by the way:
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2014-04/msg04820.html
>=20
> *cough* *cough*
>=20
> (No, this is not the formula that was used for this preallocation.
> Otherwise, it would have been correct. O:-))

Interesting, I'll have to review the PDF.  I spent some time working
through the equations when writing this patch and decided that
ceil()/floor() make it difficult to manipulate the equations without
sacrificing accuracy.

Stefan

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEeEnAAoJEJykq7OBq3PIurYH/1hcvXMocCClHbbrZa7bfiXD
1NeY0GcVoPq6x+mEBiCKrlr3xG96niXljcz594TnN6ulbE4lxRZRjls9sMxlsiau
X+9nrgXvzIeiKZLRybh5yDWbRH/+z6nRcQtyhROXRY0BRHzqFoKnIUrEYqpjNJ17
HCsnwSRpkHpvoEomYcCBt6YFg3u2afea4ch6Sma1/KF2hYyIx0aPxS+aVZZCYUYD
geZjLQd/xnOc3ZUG/0gWrkYZJxy+z5UfC9U905xX2B0UXgs5QeGldJVU6FfM8X0B
qTk3KKYsgQr1j36Eko1+cN7DLfn4OaHp2iGKwKdTylta738PO/tz+l51trdIvpE=
=OCsj
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--
