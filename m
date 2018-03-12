Received: from eggs.gnu.org ([2001:4830:134:3::10]:57984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evNqz-00038N-Vw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evNqv-0006rX-Ul
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:51:06 -0400
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
	<20180309182202.31206-6-farosas@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <85241da1-47d9-4fee-62d6-e8c6a6c58944@redhat.com>
Date: Mon, 12 Mar 2018 14:50:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180309182202.31206-6-farosas@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Rd5czNz3HauQEztmKw3L9wZCDpFkTDXUi"
Subject: Re: [Qemu-devel] [PATCH 5/5] include/block/block_int: Document
 protocol related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rd5czNz3HauQEztmKw3L9wZCDpFkTDXUi
From: Max Reitz <mreitz@redhat.com>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <85241da1-47d9-4fee-62d6-e8c6a6c58944@redhat.com>
Subject: Re: [PATCH 5/5] include/block/block_int: Document protocol related
 functions
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
 <20180309182202.31206-6-farosas@linux.vnet.ibm.com>
In-Reply-To: <20180309182202.31206-6-farosas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 19:22, Fabiano Rosas wrote:
> Clarify that for protocols the brdv_file_open function is used instead
> of bdrv_open and that protocol_name is expected to be set.
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
> ---
>  include/block/block_int.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 64a5700f2b..d5e864c2dc 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -126,6 +126,8 @@ struct BlockDriver {
> =20
>      int (*bdrv_open)(BlockDriverState *bs, QDict *options, int flags,
>                       Error **errp);
> +
> +    /* Protocol drivers should implement this instead of bdrv_open */
>      int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int fl=
ags,
>                            Error **errp);
>      void (*bdrv_close)(BlockDriverState *bs);
> @@ -247,6 +249,10 @@ struct BlockDriver {
>       */
>      int coroutine_fn (*bdrv_co_flush_to_os)(BlockDriverState *bs);
> =20
> +    /*
> +     * Drivers that set this field should also provide a
> +     * bdrv_file_open implementation

Well...  In a sense.

Drivers that implement this should be expected to be given only a
filename and no other options.  Therefore, they should generally
implement .bdrv_parse_filename() so they can extract options from it
(exception: gluster, which parses the whole filename in its
=2Ebdrv_file_open() implementation).

(Or maybe they can just accept a URL and don't need to extract options
from it, like curl or file.)

So the stress lies on "Drivers setting this field must be able to work
with just a plain filename with this prefix, and no other options."
(Note that all of the drivers you removed this field from in this series
violated this.  They expect some other options and cannot work without.)

A driver doesn't need to be a protocol driver for this, and technically
a protocol driver doesn't need to set this.  Maybe we should rename it
to "filename_prefix"...?

Max

> +     */
>      const char *protocol_name;
>      int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset,
>                           PreallocMode prealloc, Error **errp);
>=20



--Rd5czNz3HauQEztmKw3L9wZCDpFkTDXUi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqmhboSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5gMH/08b6w5j8xi7SjfqF+o28XpyrmNVDARb
/9huFqRcpDyqGCxH1XpYFZJtj/qHOwz1gP48e4ruodQRUp3bhr4VH9IdIfIC4Qga
xCEuvilRTmc9bTTVYDQfLjllaVvs9z5JFrQXm08pPDLCHechYThY5SHNUO6Aa2j/
6BZ6KtNoMvKQjl4hBLQ6E7tu/9yvyP6O8kfJRkde5dVdTtm3nhdVpgu2JirHb2U+
pkaYwSL4IrM4ryYtRhRC7CyEdFuiK7yZgikZ6g1E0+sBOcFNZzQ/sUUnRSiPmcSB
Nd7geGRNaKtldUY8fqZ324DdrdzdN8m1KkXdED5OekThJ/w24uyRLC4=
=rgZs
-----END PGP SIGNATURE-----

--Rd5czNz3HauQEztmKw3L9wZCDpFkTDXUi--
