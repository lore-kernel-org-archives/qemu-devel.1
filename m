Received: from eggs.gnu.org ([2001:4830:134:3::10]:50714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0Uk4-0005w5-KJ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0Uk1-0007TX-Q6
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:08:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37521)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d0Uk1-0007TG-HA
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:08:29 -0400
References: <20170418135726.28022-1-stefanha@redhat.com>
	<20170418135726.28022-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09309ca7-dea8-db26-5544-402964224ee1@redhat.com>
Date: Tue, 18 Apr 2017 10:08:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170418135726.28022-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SeQfLAK7w6PKMTirvItpQ31usqmPuoWfR"
Subject: Re: [Qemu-devel] [PATCH v5 1/9] block: add bdrv_measure() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SeQfLAK7w6PKMTirvItpQ31usqmPuoWfR
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>
Message-ID: <09309ca7-dea8-db26-5544-402964224ee1@redhat.com>
Subject: Re: [PATCH v5 1/9] block: add bdrv_measure() API
References: <20170418135726.28022-1-stefanha@redhat.com>
 <20170418135726.28022-2-stefanha@redhat.com>
In-Reply-To: <20170418135726.28022-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2017 08:57 AM, Stefan Hajnoczi wrote:
> bdrv_measure() provides a conservative maximum for the size of a new
> image.  This information is handy if storage needs to be allocated (e.g=
=2E
> a SAN or an LVM volume) ahead of time.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  qapi/block-core.json      | 25 +++++++++++++++++++++++++
>  include/block/block.h     |  4 ++++
>  include/block/block_int.h |  2 ++
>  block.c                   | 35 +++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 033457c..1ea5536 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -463,6 +463,31 @@
>             '*dirty-bitmaps': ['BlockDirtyInfo'] } }
> =20
>  ##
> +# @BlockMeasureInfo:
> +#
> +# Image size calculation information.  This structure describes the si=
ze
> +# requirements for creating a new image file.
> +#
> +# The size requirements depend on the new image file format.  File siz=
e always
> +# equals virtual disk size for the 'raw' format.  Compact formats such=
 as
> +# 'qcow2' represent unallocated and zero regions efficiently so file s=
ize may
> +# be smaller than virtual disk size.

I guess that implies that holes due to a file system that supports them
is NOT considered a compact format under qemu's control.  Or maybe
another way of wording it is that we are reporting the size of all guest
contents that are associated with a host offset by this layer (all
sectors of a raw format have a host offset, even if that offset falls in
the hole of a sparse file; but sectors of qcow2 do not necessarily have
a host offset if they are unallocated or zero).

But I'm not sure my alternative wording adds anything, so I'm also fine
if you don't feel like tweaking it any further.


> +#
> +# The values are upper bounds that are guaranteed to fit the new image=
 file.
> +# Subsequent modification, such as internal snapshot or bitmap creatio=
n, may
> +# require additional space and is not covered here.
> +#
> +# @required: Size required for a new image file, in bytes.
> +#
> +# @fully-allocated: Image file size, in bytes, once data has been writ=
ten
> +#                   to all sectors.
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'BlockMeasureInfo',
> +  'data': {'required': 'int', 'fully-allocated': 'int'} }
> +

> +++ b/include/block/block.h
> @@ -298,6 +298,10 @@ int bdrv_truncate(BdrvChild *child, int64_t offset=
);
>  int64_t bdrv_nb_sectors(BlockDriverState *bs);
>  int64_t bdrv_getlength(BlockDriverState *bs);
>  int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
> +void bdrv_measure(BlockDriver *drv, QemuOpts *opts,
> +                  BlockDriverState *in_bs,
> +                  BlockMeasureInfo *info,
> +                  Error **errp);

Would it be any better to have BlockMeasureInfo* be the return value (or
NULL on error), instead of an output-only parameter?  Of course, that
changes the allocation scheme (as written, a caller can stack-allocate
or malloc the pointer it passes in, but with a return value of a
pointer, it will always be malloc'd); on the other hand, the allocation
scheme may matter down the road if the struct ever gains a non-scalar
member where stack-allocation becomes harder to clean up than just
calling qapi_free_BlockMeasureInfo().


> +++ b/include/block/block_int.h
> @@ -201,6 +201,8 @@ struct BlockDriver {
>      int64_t (*bdrv_getlength)(BlockDriverState *bs);
>      bool has_variable_length;
>      int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
> +    void (*bdrv_measure)(QemuOpts *opts, BlockDriverState *in_bs,
> +                         BlockMeasureInfo *info, Error **errp);

I know we haven't done a good job in the past, but should we start
trying to do better at documenting callback constraints of new things
added in this header?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SeQfLAK7w6PKMTirvItpQ31usqmPuoWfR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9ivkAAoJEKeha0olJ0Nq7WoH/RyodFVceZ2bDglNljUiBHFu
AyxQM6akEsL04TaKyENc2UUb5zlDoRzs2OJ02f+ligZamWQA40FHeV6icgNANTxf
pruapuL0x1JGDrQxGIkU+FNKMD1JoSVfJh+ih62x+cmXZ+pepbG9XBUnfnIlJ4w2
RAxY1dxsP0bzYKp/zGBHjLlyCD8m/kwHiDYqkAe8PGrwcTscookbMTbnRE+JzPbK
NGqa8wtGzabbqrTyPRyhehUA+t164rwT2ne8EdzUKHVPIHv/csiejWJ4ln9EYaSt
jQp7SW2PNvP5f1gkmc5U8YSr02/V3DxMyqDiAcfjdBQ6x44zsIbCVwQzBx6GfcI=
=CzNF
-----END PGP SIGNATURE-----

--SeQfLAK7w6PKMTirvItpQ31usqmPuoWfR--
