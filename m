Received: from eggs.gnu.org ([2001:4830:134:3::10]:44493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsSDl-0006aG-E5
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsSDh-00076r-6b
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:22:13 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:45109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsSDg-00075P-Vs
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:22:09 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id BB080AA975
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 13:22:07 +0200 (CEST)
Date: Thu, 14 Sep 2017 13:22:00 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170914132200.6d9dd860@bahia.lan>
In-Reply-To: <1505385610-35529-4-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1505385610-35529-4-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/L+cPxva5Yk+RHB=FUZCik8u";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v11 3/6] qmp: factor out throttle code to
 reuse code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, qemu-devel@nongnu.org, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>

--Sig_/L+cPxva5Yk+RHB=FUZCik8u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Sep 2017 06:40:07 -0400
Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patch reuses the code to set throttle limits.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>  blockdev.c | 53 +++--------------------------------------------------

Same remarks as for the previous patch...

>  1 file changed, 3 insertions(+), 50 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 9d33c25..2bd8ebd 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2569,6 +2569,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg=
, Error **errp)
>      BlockDriverState *bs;
>      BlockBackend *blk;
>      AioContext *aio_context;
> +    ThrottleLimits *tlimit;
> =20
>      blk =3D qmp_get_blk(arg->has_device ? arg->device : NULL,
>                        arg->has_id ? arg->id : NULL,
> @@ -2586,56 +2587,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle *ar=
g, Error **errp)
>          goto out;
>      }
> =20
> -    throttle_config_init(&cfg);
> -    cfg.buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps;
> -    cfg.buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_rd;
> -    cfg.buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_wr;
> -
> -    cfg.buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops;
> -    cfg.buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_rd;
> -    cfg.buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_wr;
> -
> -    if (arg->has_bps_max) {
> -        cfg.buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_max;
> -    }
> -    if (arg->has_bps_rd_max) {
> -        cfg.buckets[THROTTLE_BPS_READ].max =3D arg->bps_rd_max;
> -    }
> -    if (arg->has_bps_wr_max) {
> -        cfg.buckets[THROTTLE_BPS_WRITE].max =3D arg->bps_wr_max;
> -    }
> -    if (arg->has_iops_max) {
> -        cfg.buckets[THROTTLE_OPS_TOTAL].max =3D arg->iops_max;
> -    }
> -    if (arg->has_iops_rd_max) {
> -        cfg.buckets[THROTTLE_OPS_READ].max =3D arg->iops_rd_max;
> -    }
> -    if (arg->has_iops_wr_max) {
> -        cfg.buckets[THROTTLE_OPS_WRITE].max =3D arg->iops_wr_max;
> -    }
> -
> -    if (arg->has_bps_max_length) {
> -        cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =3D arg->bps_max_le=
ngth;
> -    }
> -    if (arg->has_bps_rd_max_length) {
> -        cfg.buckets[THROTTLE_BPS_READ].burst_length =3D arg->bps_rd_max_=
length;
> -    }
> -    if (arg->has_bps_wr_max_length) {
> -        cfg.buckets[THROTTLE_BPS_WRITE].burst_length =3D arg->bps_wr_max=
_length;
> -    }
> -    if (arg->has_iops_max_length) {
> -        cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =3D arg->iops_max_l=
ength;
> -    }
> -    if (arg->has_iops_rd_max_length) {
> -        cfg.buckets[THROTTLE_OPS_READ].burst_length =3D arg->iops_rd_max=
_length;
> -    }
> -    if (arg->has_iops_wr_max_length) {
> -        cfg.buckets[THROTTLE_OPS_WRITE].burst_length =3D arg->iops_wr_ma=
x_length;
> -    }
> -
> -    if (arg->has_iops_size) {
> -        cfg.op_size =3D arg->iops_size;
> -    }
> +    tlimit =3D qapi_BlockIOThrottle_base(arg);
> +    throttle_config_to_limits(&cfg, tlimit);
> =20
>      if (!throttle_is_valid(&cfg, errp)) {
>          goto out;


--Sig_/L+cPxva5Yk+RHB=FUZCik8u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbpmWAAKCRAC/DrrAQHb
wv3/AKCaAQlQ8mYRYdeKXaqj3Zvc37glqQCeOYriJe/9Z+Jszt3rMtOSgvOdYck=
=sCTa
-----END PGP SIGNATURE-----

--Sig_/L+cPxva5Yk+RHB=FUZCik8u--
