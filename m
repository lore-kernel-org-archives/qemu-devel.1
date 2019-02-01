Received: from eggs.gnu.org ([209.51.188.92]:36530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpVxQ-0000CS-1g
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpVxM-0000vO-Ed
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:21:58 -0500
Date: Fri, 1 Feb 2019 11:21:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190201102149.GA5730@localhost.localdomain>
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-2-kwolf@redhat.com>
	<d887367f-053e-6541-a6d7-cc84b23db841@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <d887367f-053e-6541-a6d7-cc84b23db841@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 01/11] qcow2: Extend spec for external
 data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.01.2019 um 19:43 hat Eric Blake geschrieben:
> On 1/31/19 11:55 AM, Kevin Wolf wrote:
> > This adds external data file to the qcow2 spec as a new incompatible
> > feature.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  docs/interop/qcow2.txt | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >=20
>=20
> > @@ -148,6 +158,7 @@ be stored. Each extension has a structure like the =
following:
> >                          0x6803f857 - Feature name table
> >                          0x23852875 - Bitmaps extension
> >                          0x0537be77 - Full disk encryption header point=
er
> > +                        0x44415441 - External data file name
> >                          other      - Unknown header extension, can be =
safely
> >                                       ignored
>=20
> Missing a section describing the new header.

The header extension that have a separate section are those that contain
structured data. The backing file format name doesn't have one because
it's just a string, and so is the external data file name.

I guess I could add a section to describe the general concept of
external data files, if you think we have information to put there. All
that is really required should be contained in the feature bit
description already.

> > @@ -450,8 +461,10 @@ Standard Cluster Descriptor:
> >           1 -  8:    Reserved (set to 0)
> > =20
> >           9 - 55:    Bits 9-55 of host cluster offset. Must be aligned =
to a
> > -                    cluster boundary. If the offset is 0, the cluster =
is
> > -                    unallocated.
> > +                    cluster boundary. If the offset is 0 and bit 63 is=
 clear,
> > +                    the cluster is unallocated. The offset may only be=
 0 with
> > +                    bit 63 set (indicating a host cluster offset of 0)=
 when an
> > +                    external data file is used.
>=20
> Does that mean that the value 0x00000000 is invalid for external data
> files

Not sure whether you mean the L2 entry as 0x00000000 or the offset field
as 0x00000000 (neither of them are 32 bit like your value).

In any case, 0 is a valid value for an L2 entry, it means an unallocated
cluster. The same offset, but with bit 63 set (0x8000000000000000) is
valid only for external data files and means an allocated cluster at
offset 0.

> and that 0x00000001 is special-cased to mean read the contents of
> the external file (and NOT that the cluster reads as all zeroes)?

No, where do you read that? This is the description of the offset
field, and bit 0 isn't mentioned anywhere. The zero flag works the same
way as it always does.

> Is bit 0 allowed to be set for any other clusters when there is an
> external data file?

Wait, what are "other clusters"? Are you assuming that we have an image
that stores guest data both internally and externally, in some kind of a
mixed setup?

The idea is that the feature bit signals that _all_ guest data is stored
in the external data file. The offset in the L2 table always refers to
the external file then. Only metadata remains in the qcow2 file.

> And if so, are we requiring that it only be set
> when the external file is known to read as zero, or can we run into
> the situation where qcow2 says the cluster reads as 0 but the host
> file contains garbage?

Hm... This is a good point. Currently it behaves just like normal qcow2
files, but this means that the external file can contain stale data and
the zero flag determines the content. This makes it impossible to use
the external data file as a raw image. So I think we need to add a
requirement to write actual zeroes to the external file there.

> Should the external file header contain a flag
> that states whether writes to the image should wipe vs. leave
> unchanged a cluster in the external file when the qcow2 metadata
> prefers to grab that cluster's contents as all-0s or by reading from
> the backing file?  There are security vs. speed implications -
> security insists on wiping the host file to NOT leave stale data, but
> that slows things down compared to just leaving garbage if the qcow2
> metadata can effectively ignore those parts of the external file -
> hence a knob may be worth exposing?

If your argument is security, wouldn't the same tradeoff apply to
internally stored data as well?  zero_in_l2_slice() only adds the zero
flag, without overwriting the data in bs->file.

But then, for actual security, wouldn't we need to do an explicit write
rather that write_zeroes so that the same problem doesn't reoccur just
one layer down? Or potentially even more specialised operations?

Security is a different goal than just keeping the data file consistent
enough to be readable as a raw image.

> Should we preserve the meaning of bit 0 SOLELY for its 'reads-as-zeroes'
> meaning, and instead make bit 1 (currently reserved) as the special
> marker that MUST be set for clusters read from the external file,
> keeping the two ideas orthogonal?

We don't need bit 1, _all_ clusters are read from the external file.

> Worth a mention on the reftable section that when an external file is
> used, metadata clusters (in the qcow2 file) are still refcounted (and
> thus, offsets in the refcount table point to the qcow2 file, not the
> external file)?

I don't see how you could interpret the spec otherwise, but if you think
it's helpful, I guess being explicit can never hurt...

Kevin

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcVB29AAoJEH8JsnLIjy/WPdoP+gKPGykEehkzJSiOlwmcBMpZ
BwKTfkSb03MW47u5L50nuMtoa5KFyKxtrmLuIqYBZYUEesYYVK6IsvaRcD/wMbCF
9VYlDu5mv2G0Ccn8gqveKDoke5v9bELO7ceBaRnJpVgC9tBA86SugDsKf2ZMf5u4
YL85yiYyc2dIJzfC+QqZOwh0jBuT4iS3Wn8FvOJt0ysyFT04FZyn6mDjZmwB2ihm
QGZLGn7bVvIoC8bJuXcT4TMjO5sHBUtffU0fPD53+puqk72ZfpvSROrhrsIEYi8f
ktxoTJN9SdNWRF6H/SIZa5rbzIvyP50cjCBMAP4z5coajMjyyJHWU8XaYLYhLHsd
sp3C/xaU8rH9LTaiy9CH2Gt7Lxkt45iLe/+LyWq0B4NznmppKK6eLA/99x9RVGPK
j4kj7Ma0+Z1ZxIJoLfdbjTA7FFglaxqWW6dOoFEPB6MrF1mpxrzvNWhTzI19iyP9
Zi5ya7gbBCzDYMSq6XoKJ5JhGIdCT5eIdX5SuD/NJHbiGmZNecNCw1rbkBP0Frhg
0QuKAc58/ujEaTVG++JfWwrSb286uElke2IeyWah+D8+nm3mKlshEr4D1e0L+6cG
vXVIwwtNvpXbEY4xiFiNQkao6ZPQr0pbjO39JJ102GC18Xy/iccdPsYO+zV7fpn3
5SgsB7Im5kh9PAu1uPhx
=34of
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
