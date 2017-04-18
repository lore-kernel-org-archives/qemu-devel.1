Received: from eggs.gnu.org ([2001:4830:134:3::10]:36483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0aAj-0003fk-0m
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 16:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0aAh-0003k4-M2
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 16:56:24 -0400
References: <20170418013356.3578-1-eblake@redhat.com>
	<20170418013356.3578-14-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49861bf2-b648-2c85-ebba-31fb7b499d46@redhat.com>
Date: Tue, 18 Apr 2017 15:56:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170418013356.3578-14-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iF1w9l1w2wlT3lBRejS71KdKHNUGhAQOE"
Subject: Re: [Qemu-devel] [PATCH 13/31] file-posix: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iF1w9l1w2wlT3lBRejS71KdKHNUGhAQOE
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <49861bf2-b648-2c85-ebba-31fb7b499d46@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/31] file-posix: Switch to
 .bdrv_co_block_status()
References: <20170418013356.3578-1-eblake@redhat.com>
 <20170418013356.3578-14-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-14-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2017 08:33 PM, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the file protocol driver accordingly.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/file-posix.c | 47 +++++++++++++++++++++++-----------------------=
-
>  1 file changed, 23 insertions(+), 24 deletions(-)

This patch makes qemu-iotests 109 fail, due to an assertion in 6/31 that
the nested call to bdrv_block_status() [thanks to BDRV_BLOCK_RAW] is
still sector-aligned.  The culprit:

> +static int64_t coroutine_fn raw_co_block_status(BlockDriverState *bs,
> +                                                int64_t offset,
> +                                                int64_t bytes, int64_t=
 *pnum,
> +                                                BlockDriverState **fil=
e)
>  {
> -    off_t start, data =3D 0, hole =3D 0;
> +    off_t data =3D 0, hole =3D 0;
>      int64_t total_size;
>      int ret;
>=20
> @@ -1856,39 +1856,38 @@ static int64_t coroutine_fn raw_co_get_block_st=
atus(BlockDriverState *bs,
>          return ret;
>      }
>=20
> -    start =3D sector_num * BDRV_SECTOR_SIZE;
>      total_size =3D bdrv_getlength(bs);

total_size is always sector-aligned (bdrv_getlength() purposefully
widens the input file size, 560 bytes in the case of an empty qcow image
in test 109, out to a sector boundary)...

>      if (total_size < 0) {
>          return total_size;
> -    } else if (start >=3D total_size) {
> +    } else if (offset >=3D total_size) {
>          *pnum =3D 0;
>          return 0;
> -    } else if (start + nb_sectors * BDRV_SECTOR_SIZE > total_size) {
> -        nb_sectors =3D DIV_ROUND_UP(total_size - start, BDRV_SECTOR_SI=
ZE);
> +    } else if (offset + bytes > total_size) {
> +        bytes =3D total_size - offset;
>      }
>=20
> -    ret =3D find_allocation(bs, start, &data, &hole);
> +    ret =3D find_allocation(bs, offset, &data, &hole);

=2E..while find_allocation still obeys byte-granularity limits of the
underlying file system, and therefore reports a hole starting at offset
560 (the only time a hole starts at a non-sector boundary); pre-patch
that didn't matter (because we rounded before returning sectors through
*pnum), but post-patch, returning 560 instead of 1024 triggers problems.

I'm still debating whether the best fix is to tweak the file-posix
limits to just round up to sector boundaries at EOF, or to make the
block layer itself special-case EOF in case other protocols also have
byte-granularity support.  Any advice you have while reviewing is
appreciated, but it does mean I'll need a v2 of the series one way or
another.

And I didn't spot it during my earlier testing because I was skipping
109 as failing prior to my patches even started testing it - but now
that Jeff and Fam have both posted patches for two separate problems in
test 109 (the need to munge "len", and failure to do proper cleanup), I
no longer have that excuse.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iF1w9l1w2wlT3lBRejS71KdKHNUGhAQOE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9n1sAAoJEKeha0olJ0Nq3/gIAIbu6BZy2e7D5jCIRy8xj+a6
Ll5F6QiMevHJVhvG22AdjAFIMs7YQFh1vtiVggymoi5sTzCVOE0ZE0g58oAJUmjQ
cUAQ/w0OA0yXaZA4YIcijC5DzmclnVgCTHPL2D+yzEzx6Ap6W3FN4Av+LqKWA+/z
wQwB5GXl8eT4FKp3lpkPC5C0WMWGWxRjAy4xBnY9ORYmN91btj0bwF8X0BlY+nBy
4GsCoaIT2YLWpFD4Zg4e9LTFMvRKeS26dLd7FFxnj6bTbHfXTSX/dK9DrQWTfs5L
g8c3GONrn6JZzOb6IWAfbHD24xa2pxBNj6OddnS1iCusSNcqxpUKwuj3TKQVDa4=
=fjSN
-----END PGP SIGNATURE-----

--iF1w9l1w2wlT3lBRejS71KdKHNUGhAQOE--
