Received: from eggs.gnu.org ([2001:4830:134:3::10]:56709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cfloh-0007w8-5R
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cfloe-0001xI-1C
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 06:07:39 -0500
Date: Mon, 20 Feb 2017 11:07:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170220110732.GE21255@stefanha-x1.localdomain>
References: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
	<20170215151419.GD16064@stefanha-x1.localdomain>
	<CAMRbyysZUv1YQa+veW--K9FDDLkXnY5TCSmTS4xPb1sB6kODcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline
In-Reply-To: <CAMRbyysZUv1YQa+veW--K9FDDLkXnY5TCSmTS4xPb1sB6kODcw@mail.gmail.com>
Subject: Re: [Qemu-devel] Estimation of qcow2 image size converted from raw
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: Maor Lipchuk <mlipchuk@redhat.com>, qemu-devel@nongnu.org, qemu-discuss@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Allon Mureinik <amureini@redhat.com>, Max Reitz <mreitz@redhat.com>


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 05:49:58PM +0200, Nir Soffer wrote:
> On Wed, Feb 15, 2017 at 5:14 PM, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > On Mon, Feb 13, 2017 at 05:46:19PM +0200, Maor Lipchuk wrote:
> >> I was wondering if that is possible to provide a new API that
> >> estimates the size of
> >> qcow2 image converted from a raw image. We could use this new API to
> >> allocate the
> >> size more precisely before the convert operation.
> >>
> > [...]
> >> We think that the best way to solve this issue is to return this info
> >> from qemu-img, maybe as a flag to qemu-img convert that will
> >> calculate the size of the converted image without doing any writes.
> >
> > Sounds reasonable.  qcow2 actually already does some of this calculation
> > internally for image preallocation in qcow2_create2().
> >
> > Let's try this syntax:
> >
> >   $ qemu-img query-max-size -f raw -O qcow2 input.raw
> >   1234678000
>=20
> This is little bit verbose compared to other commands
> (e.g. info, check, convert)
>=20
> Since this is needed only during convert, maybe this can be
> a convert flag?
>=20
>     qemu-img convert -f xxx -O yyy src dst --estimate-size --output json
>     {
>         "estimated size": 1234678000
>     }

What is dst?  It's a dummy argument.

Let's not try to shoehorn this new sub-command into qemu-img convert.

> > As John explained, it is only an estimate.  But it will be a
> > conservative maximum.
> >
> > Internally BlockDriver needs a new interface:
> >
> > struct BlockDriver {
> >     /*
> >      * Return a conservative estimate of the maximum host file size
> >      * required by a new image given an existing BlockDriverState (not
> >      * necessarily opened with this BlockDriver).
> >      */
> >     uint64_t (*bdrv_query_max_size)(BlockDriverState *other_bs,
> >                                     Error **errp);
> > };
> >
> > This interface allows individual block drivers to probe other_bs in
> > whatever way necessary (e.g. querying block allocation status).
> >
> > Since this is a conservative max estimate there's no need to read all
> > data to check for zero regions.  We should give the best estimate that
> > can be generated quickly.
>=20
> I think we need to check allocation (e.g. with SEEK_DATA), I hope this
> is what you mean by not read all data.

Yes, allocation data must be checked.  But it will not read data
clusters from disk to check if they contains only zeroes.

Stefan

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYqs30AAoJEJykq7OBq3PIYlQH/12nL8oGVT00Co6pA8LX9EG+
IXP7c8UmKzMAwP+p5+M8AAreQQ8a8+dZLddo+j/C8OEmFUXiKirnSs3bMPRQMQsc
9aM8/7CH2+zwm9ZQdTquYG1rz4AEBUotdNJA2JQnPaKXGyGxfwJ2tdxba7k8s09u
aRY7gPH5rJKoF7QoQN/Uh1NmuI/OqiTqHU+msBJKp24X1uKcRL+uXhvR14j+6O8f
w5u3Qv+aZJpytIXj/b3AqyO0K7zhyaGAyEifB1/MxmXARcEle/rGYEywK5TMATnX
UjryMKyfsTbzQ9HSlyXCInzRY+T2mpC0Lo2ZEkIb2zhklxQGWIMt34MIHsrHJDk=
=u59E
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
