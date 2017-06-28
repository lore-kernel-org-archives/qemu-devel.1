Received: from eggs.gnu.org ([2001:4830:134:3::10]:39060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQLX5-0000MP-9o
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 18:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQLX4-0003dk-6z
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 18:33:59 -0400
References: <1498475064-39816-1-git-send-email-sochin.jiang@huawei.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d2c26bda-b166-cc2b-8596-ad48783e7e7c@redhat.com>
Date: Thu, 29 Jun 2017 00:33:47 +0200
MIME-Version: 1.0
In-Reply-To: <1498475064-39816-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xcIQbVVmhUhAfex6s46l1M9L92lNj5oP6"
Subject: Re: [Qemu-devel] [PATCH] mirror: fix the inconsistent AioContext
 problem in the backing BDSs during mirroring.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin.jiang@huawei.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xcIQbVVmhUhAfex6s46l1M9L92lNj5oP6
From: Max Reitz <mreitz@redhat.com>
To: "sochin.jiang" <sochin.jiang@huawei.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com,
 subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com,
 zhangshuai13@huawei.com, lizhengui@huawei.com
Message-ID: <d2c26bda-b166-cc2b-8596-ad48783e7e7c@redhat.com>
Subject: Re: [PATCH] mirror: fix the inconsistent AioContext problem in the
 backing BDSs during mirroring.
References: <1498475064-39816-1-git-send-email-sochin.jiang@huawei.com>
In-Reply-To: <1498475064-39816-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-26 13:04, sochin.jiang wrote:
> From: "sochin.jiang" <sochin.jiang@huawei.com>
>=20
>  mirror_complete opens the backings, BDSs of the new open backings shou=
ld have a
>  same AioContext with the top when using iothreads, fix the code to gua=
rantee this,
>  also avoiding unexpected qemu exit(assert fails in bdrv_attach_child).=


Thanks! The functional change looks good to me. I'll see to add an
iotest to cover this case.

Some notes: There shouldn't be any spaces at the front of these lines,
and every line should be limited to 72 characters.

Also, the commit message should not end in a full stop (and it's good to
keep it short).

I've reworded a bit of the commit message (and shortened the title*) and
applied it to my block branch:

https://github.com/XanClic/qemu/commits/block

Max

[1] I've shortened it to "mirror: Fix inconsistent backing AioContext
for after mirroring". I usually try to fit the title into 50 characters
(because that's what the default vim highlighting is proposing...), so
for reference, I would have made it something like "block: Align backing
BDS's AioContext with overlay" -- if it had been my patch. Since it was
yours, I'm fine with commit titles longer than 50 characters (although
they really should not exceed 72).

> Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
> ---
>  block.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/block.c b/block.c
> index 6943962..b312fe6 100644
> --- a/block.c
> +++ b/block.c
> @@ -2185,6 +2185,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, =
QDict *parent_options,
>          ret =3D -EINVAL;
>          goto free_exit;
>      }
> +    bdrv_set_aio_context(backing_hd, bdrv_get_aio_context(bs));
> =20
>      /* Hook up the backing file link; drop our reference, bs owns the
>       * backing_hd reference now */
>=20



--xcIQbVVmhUhAfex6s46l1M9L92lNj5oP6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVC7LEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQBJF
CACtGvs/yfInj5Hg9gtH0i9tztlOvDlok1nEXlRxvQ43DdnWzYqj5tc9D5cftFyp
IuDk+EgkhEcYkydTAFNzXewo8oo+4UV48fpc+o+HAijdLBW7qt0hzvhmQvM1lL+b
Pdu/lzzbO/RWEjPmB3s64YBgUNBS35Sp79syxSoiS4UeT5wmnbJyV/RWezdiMpLS
6K4XOBTmykoVt397gqOmUvRjh8Y/MF80dK080S1aEGIvPpUZPDKf7pJcxMEK+lI7
8/Lu4MTj9bt+uvj39JJIvgBrrn0s3enXJ5xoXyO9xGnzbl5zBuGn8XumgYUIN7Ug
f8hDeI8cGX0UvXe/SWwJ5TyM
=xW4p
-----END PGP SIGNATURE-----

--xcIQbVVmhUhAfex6s46l1M9L92lNj5oP6--
