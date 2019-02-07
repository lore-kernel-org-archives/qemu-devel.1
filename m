Received: from eggs.gnu.org ([209.51.188.92]:53862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grllQ-0004uK-Mz
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grllP-0003kK-Pf
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:38:56 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-17-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ed554ed-12fb-81df-7175-ff623a6292a3@redhat.com>
Date: Thu, 7 Feb 2019 09:38:30 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-17-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jSVbx8aPrlE2YTzhnQXVayEjeGYfG8bF2"
Subject: Re: [Qemu-devel] [PATCH v3 16/17] hw/ide: drop iov field from
 IDEBufferedRequest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jSVbx8aPrlE2YTzhnQXVayEjeGYfG8bF2
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <0ed554ed-12fb-81df-7175-ff623a6292a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 16/17] hw/ide: drop iov field from
 IDEBufferedRequest
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-17-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-17-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> @iov is used only to initialize @qiov. Let's use new
> qemu_iovec_init_buf() instead, which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/hw/ide/internal.h |  1 -
>  hw/ide/core.c             | 11 ++++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)

> +++ b/hw/ide/core.c
> @@ -629,13 +629,15 @@ static void ide_buffered_readv_cb(void *opaque, i=
nt ret)
>      IDEBufferedRequest *req =3D opaque;
>      if (!req->orphaned) {
>          if (!ret) {
> -            qemu_iovec_from_buf(req->original_qiov, 0, req->iov.iov_ba=
se,
> +            assert(req->qiov.size =3D=3D req->original_qiov->size);
> +            qemu_iovec_from_buf(req->original_qiov, 0,
> +                                req->qiov.local_iov.iov_base,
>                                  req->original_qiov->size);
>          }
>          req->original_cb(req->original_opaque, ret);
>      }
>      QLIST_REMOVE(req, list);
> -    qemu_vfree(req->iov.iov_base);
> +    qemu_vfree(qemu_iovec_get_buf(&req->qiov));

Okay, I can see that freeing this variable in the callback needs some
way to get at the buffer that was allocated earlier from a different
function.  Still, do we need qemu_iovec_get_buf(), or can we just
open-code it as qemu_vfree(req->qiov.local_iov.iov_base), since we
open-coded it in the qemu_iovec_from_buf() a few lines earlier?

>      g_free(req);
>  }
> =20
> @@ -660,9 +662,8 @@ BlockAIOCB *ide_buffered_readv(IDEState *s, int64_t=
 sector_num,
>      req->original_qiov =3D iov;
>      req->original_cb =3D cb;
>      req->original_opaque =3D opaque;
> -    req->iov.iov_base =3D qemu_blockalign(blk_bs(s->blk), iov->size);
> -    req->iov.iov_len =3D iov->size;
> -    qemu_iovec_init_external(&req->qiov, &req->iov, 1);
> +    qemu_iovec_init_buf(&req->qiov, blk_blockalign(s->blk, iov->size),=

> +                        iov->size);
> =20

Took me longer to review this one, but looks like a correct conversion.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jSVbx8aPrlE2YTzhnQXVayEjeGYfG8bF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcUPYACgkQp6FrSiUn
Q2qaWQf/ZKVtX4y2Mm172TWsIASawEnPEEPpIyImiMuUdXu3H/h2V/Q+QHBoV0ak
34mUoO86vT0+83RjuJ4K0cqTD7D8mRQ14WVvoRJmQOLfrHpsD5zqDji41Yak5uRj
uqU9K6CbtfXV2Ly2LsmxpDWUkUiSl4Qkz5Yl5kEkdJKRM0sJxEN5Hm1BDQNV+CgC
QLbQ1cZdN/kopjrLg4eekLVLxt7JhP0H35G6neqlQAwDm6KNfEmSs2QTGd4YSGQl
+wKdTHES7nLlTr3ZaX6/xzw/oayydXwMZTaFJdbtzZyizqQpODpyaflkfOGSeFjx
oKOHwDaBMiCpr/5dAw3Dtd7VmU+/wg==
=StLO
-----END PGP SIGNATURE-----

--jSVbx8aPrlE2YTzhnQXVayEjeGYfG8bF2--
