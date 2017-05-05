Received: from eggs.gnu.org ([2001:4830:134:3::10]:48939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6jV5-0000rv-Hr
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6jV4-00089v-Eu
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:06:51 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-3-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <53789feb-7a2d-09ae-cc03-8cde0b1b85e4@redhat.com>
Date: Fri, 5 May 2017 22:06:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170504030755.1001-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VCWofOnIJEti3ABDKUroChOvsOeWX1bQi"
Subject: Re: [Qemu-devel] [PATCH v12 02/10] block: Update comments on
 BDRV_BLOCK_* meanings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VCWofOnIJEti3ABDKUroChOvsOeWX1bQi
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <53789feb-7a2d-09ae-cc03-8cde0b1b85e4@redhat.com>
Subject: Re: [PATCH v12 02/10] block: Update comments on BDRV_BLOCK_* meanings
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-3-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.2017 05:07, Eric Blake wrote:
> We had some conflicting documentation: a nice 8-way table that
> described all possible combinations of DATA, ZERO, and
> OFFSET_VALID, contrasted with text that implied that OFFSET_VALID
> always meant raw data could be read directly.  Furthermore, the
> text refers a lot to bs->file, even though the interface was
> updated back in 67a0fd2a to let the driver pass back which BDS (not
> necessarily bs->file).

Not sure about my English skills here, but is this missing a verb? ("to
pass back which BDS...")

>                         As the 8-way table is the intended
> semantics, simplify the rest of the text to get rid of the
> confusion.
>=20
> ALLOCATED is always set by the block layer for convenience (drivers
> do not have to worry about it). RAW is used only internally, but

Just one space after the period? How inconsistent! :-)

> by more than the raw driver.  Document these additional items on
> the driver callback.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v12: even more wording tweaks
> v11: reserved for blkdebug half of v10
> v10: new patch
> ---
>  include/block/block.h     | 35 +++++++++++++++++++----------------
>  include/block/block_int.h |  7 +++++++
>  2 files changed, 26 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/block/block.h b/include/block/block.h
> index 862eb56..c8bec7d 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -120,29 +120,32 @@ typedef struct HDGeometry {
>  #define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTO=
R_BITS)
>=20
>  /*
> - * Allocation status flags
> - * BDRV_BLOCK_DATA: data is read from a file returned by bdrv_get_bloc=
k_status.
> - * BDRV_BLOCK_ZERO: sectors read as zero
> - * BDRV_BLOCK_OFFSET_VALID: sector stored as raw data in a file return=
ed by
> - *                          bdrv_get_block_status.
> + * Allocation status flags for bdrv_get_block_status() and friends.
> + *
> + * Public flags:
> + * BDRV_BLOCK_DATA: allocation for data at offset is tied to this laye=
r
> + * BDRV_BLOCK_ZERO: offset reads as zero
> + * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing =
raw data
>   * BDRV_BLOCK_ALLOCATED: the content of the block is determined by thi=
s
> - *                       layer (as opposed to the backing file)
> - * BDRV_BLOCK_RAW: used internally to indicate that the request
> - *                 was answered by the raw driver and that one
> - *                 should look in bs->file directly.
> + *                       layer (short for DATA || ZERO), set by block =
layer
>   *
> - * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 represent the offset i=
n
> - * bs->file where sector data can be read from as raw data.
> + * Internal flag:
> + * BDRV_BLOCK_RAW: used internally to indicate that the request was
> + *                 answered by a passthrough driver such as raw and th=
at the

s/passthrough/filter/? But I'm not even sure myself. Well, "passthrough"
is a safe bet, so let's just go with it.

With the commit message fixed or a =E2=80=9Cno it's fine=E2=80=9D:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> + *                 block layer should recompute the answer from bs->fi=
le.
>   *
> - * DATA =3D=3D 0 && ZERO =3D=3D 0 means that data is read from backing=
_hd if present.
> + * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MAS=
K)
> + * represent the offset in the returned BDS that is allocated for the
> + * corresponding raw data; however, whether that offset actually conta=
ins
> + * data also depends on BDRV_BLOCK_DATA and BDRV_BLOCK_ZERO, as follow=
s:
>   *
>   * DATA ZERO OFFSET_VALID
> - *  t    t        t       sectors read as zero, bs->file is zero at of=
fset
> - *  t    f        t       sectors read as valid from bs->file at offse=
t
> - *  f    t        t       sectors preallocated, read as zero, bs->file=
 not
> + *  t    t        t       sectors read as zero, returned file is zero =
at offset
> + *  t    f        t       sectors read as valid from file at offset
> + *  f    t        t       sectors preallocated, read as zero, returned=
 file not
>   *                        necessarily zero at offset
>   *  f    f        t       sectors preallocated but read from backing_h=
d,
> - *                        bs->file contains garbage at offset
> + *                        returned file contains garbage at offset
>   *  t    t        f       sectors preallocated, read as zero, unknown =
offset
>   *  t    f        f       sectors read from unknown file or offset
>   *  f    t        f       not allocated or unknown offset, read as zer=
o
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 8773940..1fdfff7 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -165,6 +165,13 @@ struct BlockDriver {
>          int64_t offset, int count, BdrvRequestFlags flags);
>      int coroutine_fn (*bdrv_co_pdiscard)(BlockDriverState *bs,
>          int64_t offset, int count);
> +
> +    /*
> +     * Building block for bdrv_block_status[_above]. The driver should=

> +     * answer only according to the current layer, and should not
> +     * set BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See bloc=
k.h
> +     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.
> +     */
>      int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState =
*bs,
>          int64_t sector_num, int nb_sectors, int *pnum,
>          BlockDriverState **file);
>=20



--VCWofOnIJEti3ABDKUroChOvsOeWX1bQi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM208SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9As64H/21QJaoQjqignlC3zUWaweoGcJ4K12b6
mJ7SVKl+qlACp3OFp3FiZGAcE/3nNy5NSRPStKOjF4vYtagsqLiB6CbVYpNFIHSz
Iq+05QTOQqex7HmukPlp2d8bUQwQNtPNr4Cpo7EeQpfHI6XN+SrsXpYRQ5k8jWL7
kNNmT8VEKkNgZkSLwWaaCnt4BTQj0aJa8RCeffgW+XcTICXGf57W7RTy0IWJl4f8
EBoE4csk40ZxA7Hp9IuNEO9xx6qYZDAl6r3YwG4NP9gCWEYE3Mit/f8yOxM+FpW3
gMnTywpLei7tvxODF36225ZimVBNFuqJrDE978JFtL7LCaga98yBAW4=
=i8lp
-----END PGP SIGNATURE-----

--VCWofOnIJEti3ABDKUroChOvsOeWX1bQi--
