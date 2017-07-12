Received: from eggs.gnu.org ([2001:4830:134:3::10]:60127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVFDA-00020d-As
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVFD9-0007xL-I7
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:49:40 -0400
Date: Wed, 12 Jul 2017 11:49:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170712104929.GJ6923@stefanha-x1.localdomain>
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-3-famz@redhat.com>
	<20170710145526.GG14195@stefanha-x1.localdomain>
	<20170712013231.GC7449@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
Content-Disposition: inline
In-Reply-To: <20170712013231.GC7449@lemon>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Karl Rister <krister@redhat.com>


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 10:14:48AM +0800, Fam Zheng wrote:
> On Mon, 07/10 15:55, Stefan Hajnoczi wrote:
> > On Wed, Jul 05, 2017 at 09:36:31PM +0800, Fam Zheng wrote:
> > > +static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64=
_t bytes,
> > > +                       QEMUIOVector *qiov, bool is_write, int flags)
> > > +{
> > > +    BDRVNVMeState *s =3D bs->opaque;
> > > +    int r;
> > > +    uint8_t *buf =3D NULL;
> > > +    QEMUIOVector local_qiov;
> > > +
> > > +    assert(QEMU_IS_ALIGNED(offset, s->page_size));
> > > +    assert(QEMU_IS_ALIGNED(bytes, s->page_size));
> > > +    assert(bytes <=3D s->max_transfer);
> >=20
> > Who guarantees max_transfer?  I think request alignment is enforced by
> > block/io.c but there is no generic max_transfer handling code, so this
> > assertion can be triggered by the guest.  Please handle it as a genuine
> > request error instead of using an assertion.
>=20
> There has been one since 04ed95f4843281e292d93018d56d4b14705f9f2c, see th=
e code
> around max_transfer in block/io.c:bdrv_aligned_*.

Thanks for pointing that out!

> >=20
> > > +static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
> > > +                               BlockReopenQueue *queue, Error **errp)
> > > +{
> > > +    return 0;
> > > +}
> >=20
> > What is the purpose of this dummy .bdrv_reopen_prepare() implementation?
>=20
> This is necessary for block jobs to work, other drivers provides dummy
> implementations as well.

Please include a comment similar to what the other drivers with dummy
implements do.

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZf65AAoJEJykq7OBq3PIl9cIAMIeeOZjqK+g7/uzeErSbTrw
LdvmeujuVpXW17k6/QN5g0AnJ/8MN+P7uX5E3lssaxfnUqoUyWIax9so+Oc50lDM
hmksmsGsl0wXFXYWHVlVjAEZ6/fpZaCdKjlZviG+AT+E4L5jZp4IEyiGuGSxWuZ+
yiOOE3rk4p6nRZpt94HkAyM5Ubnniy+Gh7NY8jQCb3/tz8VkhjxedO2nKOcdgFAi
wVBEvwtURl+AykAt8JOOZE28dZ1RYPrdNiM+mjNIBh8vjsRftuVbs8CIbggYHt3G
fwwbt+6d+/5u/ZDw4m5RnmLV55ZFdCob4mlgunV1jEo9gAv85TYnJuTnYpxDQeg=
=oACp
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--
