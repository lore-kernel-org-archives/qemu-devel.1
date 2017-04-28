Received: from eggs.gnu.org ([2001:4830:134:3::10]:52420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4CLS-0007aC-R0
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4CLR-0003MS-NV
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:18:26 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-2-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5999516c-a114-263e-a2b4-434035b40588@redhat.com>
Date: Fri, 28 Apr 2017 15:18:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hLg4SFHDeQsjCl5cgpnRcBuKTFDAl3xcP"
Subject: Re: [Qemu-devel] [PATCH v10 01/17] block: Update comments on
 BDRV_BLOCK_* meanings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hLg4SFHDeQsjCl5cgpnRcBuKTFDAl3xcP
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <5999516c-a114-263e-a2b4-434035b40588@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 01/17] block: Update comments on
 BDRV_BLOCK_* meanings
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-2-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 08:46 PM, Eric Blake wrote:
> We had some conflicting documentation: a nice 8-way table that
> described all possible combinations of DATA, ZERO, and
> OFFSET_VALID, couple with text that implied that OFFSET_VALID
> always meant raw data could be read directly.  As the 8-way
> table is the intended semantics, simplify the rest of the text
> to get rid of the confusion.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---

>  /*
>   * Allocation status flags
> - * BDRV_BLOCK_DATA: data is read from a file returned by bdrv_get_bloc=
k_status.
> + * BDRV_BLOCK_DATA: data is read from a file returned by bdrv_get_bloc=
k_status

I guess we always return the BDS where the data is read from, even when
we can't actually provide an offset to that data (such as when the
actual data is encrypted or compressed, and therefore has no raw
offset).  But I'm still wondering if this line can be shortened.

>   * BDRV_BLOCK_ZERO: sectors read as zero
> - * BDRV_BLOCK_OFFSET_VALID: sector stored as raw data in a file return=
ed by
> - *                          bdrv_get_block_status.

I think when this was originally written, we blindly assumed that offset
pointed into bs->file.  Then with the exposure of the BDS graph, we
changed bdrv_get_block_status() to have a BlockDriverState **file
parameter (offset points into the returned file), since bs->file need
not always be the right BDS.  This old comment is on track...

> + * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing =
raw data
>   * BDRV_BLOCK_ALLOCATED: the content of the block is determined by thi=
s
>   *                       layer (as opposed to the backing file)
>   * BDRV_BLOCK_RAW: used internally to indicate that the request
>   *                 was answered by the raw driver and that one
>   *                 should look in bs->file directly.
>   *
> - * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 represent the offset i=
n
> - * bs->file where sector data can be read from as raw data.

=2E..but this one is stale...

> - *
>   * DATA =3D=3D 0 && ZERO =3D=3D 0 means that data is read from backing=
_hd if present.
>   *
> + * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 represent the offset
> + * in bs->file that is allocated for the corresponding raw data;

=2E..and I reused the stale wording.  Oops.

> + * however, whether that offset actually contains data also depends on=

> + * BDRV_BLOCK_DATA, as follows:
> + *
>   * DATA ZERO OFFSET_VALID
>   *  t    t        t       sectors read as zero, bs->file is zero at of=
fset
>   *  t    f        t       sectors read as valid from bs->file at offse=
t

And these references to bs->file are stale too.

Guess I have more to fix on the respin.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hLg4SFHDeQsjCl5cgpnRcBuKTFDAl3xcP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA6OGAAoJEKeha0olJ0NqqAIH/j1f/7uD1LAajRhWpDWWne9/
XW+xFDt5ryF1SxOKaUPRzeCbndK9bKt1BjE6MQm5KaIX2KzrSY4YB5kAhVkm6i0V
TSiMptgKHydEmnLWUCAjwmwTPZYLNmrEf4fgzB9+2sX3Hx802k4UnqTa0E3oI4Ah
7BrJeWJtYtqtIXgbLdAUQxyRlXM/q97YaOJ+6WI3nrp0CgRlf4uJxpS6uYMePaJ2
L6Wcqb33Cz2dSPxfEnr3o37twU3RY4ycLEJMONS/0Gzj061+hA6iReTgyCXLqv9h
DOn5wA28+h8/r6/+idD5QxeiVvYGsSyY4gsV2nmfyVeWgHiAWscVwxSUD7QVNNs=
=KPm/
-----END PGP SIGNATURE-----

--hLg4SFHDeQsjCl5cgpnRcBuKTFDAl3xcP--
