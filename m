Received: from eggs.gnu.org ([2001:4830:134:3::10]:46843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep03O-0005rQ-QC
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep02Y-0006B4-KK
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:13:30 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-20-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <16106599-7a8b-016f-c778-7b94ad5f94df@redhat.com>
Date: Fri, 23 Feb 2018 00:10:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-20-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MOtfrbHYazCT5xovCrUOU2KRF30XE4m4C"
Subject: Re: [Qemu-devel] [PATCH v2 19/36] rbd: Factor out qemu_rbd_connect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MOtfrbHYazCT5xovCrUOU2KRF30XE4m4C
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <16106599-7a8b-016f-c778-7b94ad5f94df@redhat.com>
Subject: Re: [PATCH v2 19/36] rbd: Factor out qemu_rbd_connect()
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-20-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-20-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> The code to establish an RBD connection is duplicated between open and
> create. In order to be able to share the code, factor out the code from=

> qemu_rbd_open() as a first step.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/rbd.c | 100 ++++++++++++++++++++++++++++++++++++----------------=
--------
>  1 file changed, 60 insertions(+), 40 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index 27fa11b473..4bbcce4eca 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -544,32 +544,17 @@ out:
>      return rados_str;
>  }
> =20
> -static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int fla=
gs,
> -                         Error **errp)
> +static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> +                            char **s_snap, char **s_image_name,
> +                            QDict *options, bool cache, Error **errp)

Bikeshedding ahead:  Maybe this should be called qemu_rados_connect()?
I don't know anything about this, but there seems to be a distinction
between rados_* functions and rbd_* functions -- the former work on the
pool, the latter on the single block device.

Since this function only connects to the pool and not to a single device
within, I think it should be called qemu_rados_connect() instead of
qemu_rbd_connect().

(Also because qemu_rbd_connect() seems so similar to qemu_rbd_open().)

Up to you:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--MOtfrbHYazCT5xovCrUOU2KRF30XE4m4C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPTf4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Axy8H/0sWFOW/a3gPXNBdRfzvkWqkFTP/YybV
PblNB9W0vBiA9LgGD6A+Y3g5EQx8Gqtut3184U7mSwXz2U6I6xRQoOusH4U5CRgc
lwJOtydLJaiiC5eI0EcrbXoCKxApAVX7f8Zek7TnjALBkP6RaC0ht9vOthzm139u
Yxoa82wfpvcQfMYU//KeL1OhDu3x78spesjEXswFTE/7ARFrnZBwji5BGfHRLgJ2
8W8mjlmU0SxFWBxnWENy+AvQfx4kaoFnpb616qPdxPfNDQOchs1EXF3cGv3pcGqP
qfFRGtHHqaXT7e4xV/cFEGT+qEVYNnfIRHD8V70uKqULlxJnrF+IRnA=
=XYf9
-----END PGP SIGNATURE-----

--MOtfrbHYazCT5xovCrUOU2KRF30XE4m4C--
