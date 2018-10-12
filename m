Received: from eggs.gnu.org ([2001:4830:134:3::10]:37181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAzJG-0006HG-9W
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAzJD-0001sF-L0
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:25:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gAzJD-0001rP-Aw
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 11:24:59 -0400
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
	<1535739372-24454-9-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bcb804f5-bf89-a8a8-216a-144e495aae38@redhat.com>
Date: Fri, 12 Oct 2018 17:24:56 +0200
MIME-Version: 1.0
In-Reply-To: <1535739372-24454-9-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u7hMdsu0IK5SSMD4nUgLGOYK6zuvI0FFy"
Subject: Re: [Qemu-devel] [PATCH v3 8/8] qcow2: Read outside array bounds in
 qcow2_pre_write_overlap_check()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u7hMdsu0IK5SSMD4nUgLGOYK6zuvI0FFy
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Message-ID: <bcb804f5-bf89-a8a8-216a-144e495aae38@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 8/8] qcow2: Read outside array bounds in
 qcow2_pre_write_overlap_check()
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
 <1535739372-24454-9-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535739372-24454-9-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.08.18 20:16, Liam Merwick wrote:
> The commit for 0e4e4318eaa5 increments QCOW2_OL_MAX_BITNR but does not
> add an array entry for QCOW2_OL_BITMAP_DIRECTORY_BITNR to metadata_ol_n=
ames[].
> As a result, an array dereference of metadata_ol_names[8] in
> qcow2_pre_write_overlap_check() could result in a read outside of the a=
rray bounds.
>=20
> Fixes: 0e4e4318eaa5 ('qcow2: add overlap check for bitmap directory')
>=20
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-refcount.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 3c539f02e5ec..46082aeac1d6 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -2719,15 +2719,17 @@ int qcow2_check_metadata_overlap(BlockDriverSta=
te *bs, int ign, int64_t offset,
>  }
> =20
>  static const char *metadata_ol_names[] =3D {
> -    [QCOW2_OL_MAIN_HEADER_BITNR]    =3D "qcow2_header",
> -    [QCOW2_OL_ACTIVE_L1_BITNR]      =3D "active L1 table",
> -    [QCOW2_OL_ACTIVE_L2_BITNR]      =3D "active L2 table",
> -    [QCOW2_OL_REFCOUNT_TABLE_BITNR] =3D "refcount table",
> -    [QCOW2_OL_REFCOUNT_BLOCK_BITNR] =3D "refcount block",
> -    [QCOW2_OL_SNAPSHOT_TABLE_BITNR] =3D "snapshot table",
> -    [QCOW2_OL_INACTIVE_L1_BITNR]    =3D "inactive L1 table",
> -    [QCOW2_OL_INACTIVE_L2_BITNR]    =3D "inactive L2 table",
> +    [QCOW2_OL_MAIN_HEADER_BITNR]        =3D "qcow2_header",
> +    [QCOW2_OL_ACTIVE_L1_BITNR]          =3D "active L1 table",
> +    [QCOW2_OL_ACTIVE_L2_BITNR]          =3D "active L2 table",
> +    [QCOW2_OL_REFCOUNT_TABLE_BITNR]     =3D "refcount table",
> +    [QCOW2_OL_REFCOUNT_BLOCK_BITNR]     =3D "refcount block",
> +    [QCOW2_OL_SNAPSHOT_TABLE_BITNR]     =3D "snapshot table",
> +    [QCOW2_OL_INACTIVE_L1_BITNR]        =3D "inactive L1 table",
> +    [QCOW2_OL_INACTIVE_L2_BITNR]        =3D "inactive L2 table",
> +    [QCOW2_OL_BITMAP_DIRECTORY_BITNR]   =3D "bitmap directory",
>  };
> +QEMU_BUILD_BUG_ON(QCOW2_OL_MAX_BITNR !=3D ARRAY_SIZE(metadata_ol_names=
));
> =20
>  /*
>   * First performs a check for metadata overlaps (through
>=20



--u7hMdsu0IK5SSMD4nUgLGOYK6zuvI0FFy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvAvMgACgkQ9AfbAGHV
z0Cg5Af+PiQJVnYiXvASrpbu1gmSiN/AJBsTdViizcZ8WAiIKEnxpUNRrtE+1Uaw
lgfscTVRhUmrruQcTqUlbk23KRSxzo0/RnxpUQ35LZKRtPPaBBRdddQjE2f5zDwE
tTH5XLJNB/uJEhjsr8az0J9fHaLqCPCCGBv+0WzxRdhSdd7SP3iJ1jL+j1lr2zxd
KT3096rjEFfVESWPFXfKQF4A0CMqKUn5DrTPFzpTqKF6wuNgvjqXRMSko+6cn2V0
24MxO/bHuXnAEwwOGJBrqlnaE8efUFF6yyPKRmmBKWdPAZUb2b22wv11/QAYTRdJ
JlxSfowJIOq8OIR68AxLvRJaPDLPQg==
=SVhR
-----END PGP SIGNATURE-----

--u7hMdsu0IK5SSMD4nUgLGOYK6zuvI0FFy--
