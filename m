Received: from eggs.gnu.org ([2001:4830:134:3::10]:41115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTDqw-0007xa-Fr
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTDqv-0001HH-Fv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:26:06 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-9-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5d05da0d-e0f5-5fa6-6bd2-5cecc1834124@redhat.com>
Date: Mon, 16 Jan 2017 21:25:55 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-9-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5mVaOGqerubkSbE0WI6bnsOsXi1MQiWsx"
Subject: Re: [Qemu-devel] [PATCH v1 08/15] qcow: make encrypt_sectors
 encrypt in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5mVaOGqerubkSbE0WI6bnsOsXi1MQiWsx
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <5d05da0d-e0f5-5fa6-6bd2-5cecc1834124@redhat.com>
Subject: Re: [PATCH v1 08/15] qcow: make encrypt_sectors encrypt in place
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-9-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-9-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> Instead of requiring separate input/output buffers for
> encrypting data, change encrypt_sectors() to assume
> use of a single buffer, encrypting in place. One current
> caller all uses the same buffer for input/output already

-all?

> and the other two callers are easily converted todo so.

s/todo/to do/

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
>=20
> diff --git a/block/qcow.c b/block/qcow.c
> index 8133fda..bc9fa2f 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -310,11 +310,10 @@ static int qcow_set_key(BlockDriverState *bs, con=
st char *key)
>  }
> =20
>  /* The crypt function is compatible with the linux cryptoloop
> -   algorithm for < 4 GB images. NOTE: out_buf =3D=3D in_buf is
> -   supported */
> +   algorithm for < 4 GB images. */
>  static int encrypt_sectors(BDRVQcowState *s, int64_t sector_num,
> -                           uint8_t *out_buf, const uint8_t *in_buf,
> -                           int nb_sectors, bool enc, Error **errp)
> +                           uint8_t *buf, int nb_sectors, bool enc,
> +                           Error **errp)
>  {
>      union {
>          uint64_t ll[2];
> @@ -333,14 +332,12 @@ static int encrypt_sectors(BDRVQcowState *s, int6=
4_t sector_num,
>          }
>          if (enc) {
>              ret =3D qcrypto_cipher_encrypt(s->cipher,
> -                                         in_buf,
> -                                         out_buf,
> +                                         buf, buf,
>                                           512,
>                                           errp);
>          } else {
>              ret =3D qcrypto_cipher_decrypt(s->cipher,
> -                                         in_buf,
> -                                         out_buf,
> +                                         buf, buf,
>                                           512,
>                                           errp);
>          }
> @@ -348,8 +345,7 @@ static int encrypt_sectors(BDRVQcowState *s, int64_=
t sector_num,
>              return -1;
>          }
>          sector_num++;
> -        in_buf +=3D 512;
> -        out_buf +=3D 512;
> +        buf +=3D 512;
>      }
>      return 0;
>  }
> @@ -469,13 +465,12 @@ static uint64_t get_cluster_offset(BlockDriverSta=
te *bs,
>                      uint64_t start_sect;
>                      assert(s->cipher);
>                      start_sect =3D (offset & ~(s->cluster_size - 1)) >=
> 9;
> -                    memset(s->cluster_data + 512, 0x00, 512);
> +                    memset(s->cluster_data, 0x00, 512);
>                      for(i =3D 0; i < s->cluster_sectors; i++) {
>                          if (i < n_start || i >=3D n_end) {
>                              Error *err =3D NULL;
>                              if (encrypt_sectors(s, start_sect + i,
> -                                                s->cluster_data,
> -                                                s->cluster_data + 512,=
 1,
> +                                                s->cluster_data, 1,
>                                                  true, &err) < 0) {
>                                  error_free(err);
>                                  errno =3D EIO;

After the first iteration of the surrounding for () loop,
s->cluster_data is unlikely to still be filled with zeros -- but I
suspect the code intended to always write encrypted zeros.

> @@ -653,7 +648,7 @@ static coroutine_fn int qcow_co_readv(BlockDriverSt=
ate *bs, int64_t sector_num,
>              }
>              if (bs->encrypted) {
>                  assert(s->cipher);
> -                if (encrypt_sectors(s, sector_num, buf, buf,
> +                if (encrypt_sectors(s, sector_num, buf,
>                                      n, false, &err) < 0) {
>                      goto fail;
>                  }
> @@ -688,9 +683,7 @@ static coroutine_fn int qcow_co_writev(BlockDriverS=
tate *bs, int64_t sector_num,
>      BDRVQcowState *s =3D bs->opaque;
>      int index_in_cluster;
>      uint64_t cluster_offset;
> -    const uint8_t *src_buf;
>      int ret =3D 0, n;
> -    uint8_t *cluster_data =3D NULL;
>      struct iovec hd_iov;
>      QEMUIOVector hd_qiov;
>      uint8_t *buf;
> @@ -728,21 +721,15 @@ static coroutine_fn int qcow_co_writev(BlockDrive=
rState *bs, int64_t sector_num,
>          if (bs->encrypted) {
>              Error *err =3D NULL;
>              assert(s->cipher);
> -            if (!cluster_data) {
> -                cluster_data =3D g_malloc0(s->cluster_size);
> -            }
> -            if (encrypt_sectors(s, sector_num, cluster_data, buf,
> +            if (encrypt_sectors(s, sector_num, buf,

If qiov->niov =3D=3D 1, buf is not copied from the I/O vector but just th=
e
I/O vector base itself. Then, this will modify the data pointed to by
that vector. I don't think that is a good idea.

Max

>                                  n, true, &err) < 0) {
>                  error_free(err);
>                  ret =3D -EIO;
>                  break;
>              }
> -            src_buf =3D cluster_data;
> -        } else {
> -            src_buf =3D buf;
>          }
> =20
> -        hd_iov.iov_base =3D (void *)src_buf;
> +        hd_iov.iov_base =3D (void *)buf;
>          hd_iov.iov_len =3D n * 512;
>          qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
>          qemu_co_mutex_unlock(&s->lock);
> @@ -764,7 +751,6 @@ static coroutine_fn int qcow_co_writev(BlockDriverS=
tate *bs, int64_t sector_num,
>      if (qiov->niov > 1) {
>          qemu_vfree(orig_buf);
>      }
> -    g_free(cluster_data);
> =20
>      return ret;
>  }
>=20



--5mVaOGqerubkSbE0WI6bnsOsXi1MQiWsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh9LFMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASHAH/3ThztgABm6ApbVnAW5n8Xj/HmDhTQTW
Ihf5PmswVePgltFwhjYRQ9FOHAJhqeeGJA5/OeJaAJYZqNiMl08Ue29n1u8XNwl6
x8KkKLQMFdYgMobinQGEfcHxBMgvakvjsyBjnoeS0BwAfZ2KH0zxYk+oh9HsS73r
lX5zb8Bg32Z6DmklL9v2BCtUER4MeNQekK2AicvoSMTr40n59xpnP/nnodIE1Aoz
Ti1ZTTYNHXWaU1yb7SdaQEjTWHiX7WSx8dM1gi1erTfwKmeQoTcg4OKGcCk9g6t3
s7IXp/FRzsRzDgtc0Tbl5uWmpNAG1JE7N/48KsFOVkKKbO0fwTZp9XM=
=Ur5Y
-----END PGP SIGNATURE-----

--5mVaOGqerubkSbE0WI6bnsOsXi1MQiWsx--
