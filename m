Received: from eggs.gnu.org ([209.51.188.92]:33927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gnjuf-0000tg-48
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gnjue-0000sR-EA
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:51:49 -0500
Date: Sun, 27 Jan 2019 12:51:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190127125144.GB13784@stefanha-x1.localdomain>
References: <20190124172323.230296-1-sgarzare@redhat.com>
	<20190124172323.230296-2-sgarzare@redhat.com>
	<20190125145856.GC28305@stefanha-x1.localdomain>
	<20190125161813.tyd5ququvhdunt4d@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <20190125161813.tyd5ququvhdunt4d@steredhat>
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] virtio-blk: add DISCARD and WRITE
 ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 05:18:13PM +0100, Stefano Garzarella wrote:
> On Fri, Jan 25, 2019 at 02:58:56PM +0000, Stefan Hajnoczi wrote:
> > On Thu, Jan 24, 2019 at 06:23:22PM +0100, Stefano Garzarella wrote:
> > > +            virtio_error(vdev, "virtio-blk discard/wzeroes header to=
o short");
> > > +            return -1;
> > > +        }
> > > +
> > > +        sector =3D virtio_ldq_p(VIRTIO_DEVICE(req->dev), &dwz_hdr.se=
ctor);
> > > +        bytes =3D virtio_ldl_p(VIRTIO_DEVICE(req->dev),
> > > +                             &dwz_hdr.num_sectors) << BDRV_SECTOR_BI=
TS;
> >=20
> > Please handle num_sectors << BDRV_SECTOR_BITS overflow so that we don't
> > need to worry about what happens with an overflowed value later on.
> >=20
>=20
> Should I also check if num_sectors is less than "max_discard_sectors" or
> "max_write_zeroes_sectors"?

Yes, anything that virtio_blk_sect_range_ok() doesn't check needs to be
checked manually in this patch.  I can't see a reason for allowing
requests through that exceed the limit.

> Do you think make sense flush the MultiReqBuffer before call
> blk_aio_pdiscard() or blk_aio_pwrite_zeroes()?

I don't think that is necessary since virtio-blk doesn't guarantee
ordering (the legacy barrier feature isn't supported by QEMU).

Even the MultiReqBuffer is flushed, -drive aio=3Dthreads (the default
setting) could end up submitting discard/write zeroes before "earlier"
requests - it depends on host kernel thread scheduler decisions.

Stefan

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcTalgAAoJEJykq7OBq3PImLcH/j0eDIVlPTnS58rnHyaM6hU1
KubYrb6CSyotrx2e47gZQ4Zj79JX5AoPDthujbTC6jZlXkSHQlVP8v1L1ga0L4Bj
1OIykaFCxPvKf1NSY7EtAqgDeLemA3DGQheq0FRoArGIJuxz7Ahri3Slm7otQdw9
X4SG4ZcAG/aBA27FlFWZcgTr9MthOevx+7GgaZbilWSV9v5lr4n6O8ZIQ9AuBPYv
ck/UKj/n0SUSRoufjzzr8xJRR03YbvpfrPc6xMd3EFv0rP6SJXC+Vl/h2tp/roOB
/bEKvrgIaVlFB6ZmkubtasONAs5ZvEBDOqiIpgWDUV5sdUxDJvsldULXCdlDG0c=
=wqI8
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
