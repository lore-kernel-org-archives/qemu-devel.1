Received: from eggs.gnu.org ([2001:4830:134:3::10]:43782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqINs-0001pb-5b
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dqINo-0008AQ-U9
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:27:44 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:53291)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dqINo-000891-Ki
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:27:40 -0400
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 1E00E79BB2
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 14:27:37 +0200 (CEST)
Date: Fri, 8 Sep 2017 14:27:29 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170908142729.1008e033@bahia>
In-Reply-To: <1504541267-36954-4-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-4-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/lSso=A9Q6HUOtxSHaVAlbXh";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v10 3/6] throttle: move out function to
 reuse the code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

--Sig_/lSso=A9Q6HUOtxSHaVAlbXh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  4 Sep 2017 12:07:44 -0400
Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patch move out the throttle code to util/throttle.c to maximize
> the reusability of the code.The same code is also used by fsdev.

s/.The same code is also used by fsdev/. The same code will also be used by=
 fsdev/

> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Greg Kurz <groug@kaod.org>

> ---
>  blockdev.c                      | 53 +++---------------------------------
>  include/qemu/throttle-options.h |  2 ++
>  util/throttle.c                 | 59 +++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 64 insertions(+), 50 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 780ae58..1caf2e0 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2571,6 +2571,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg=
, Error **errp)
>      BlockDriverState *bs;
>      BlockBackend *blk;
>      AioContext *aio_context;
> +    IOThrottle *iothrottle;
> =20
>      blk =3D qmp_get_blk(arg->has_device ? arg->device : NULL,
>                        arg->has_id ? arg->id : NULL,
> @@ -2588,56 +2589,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle *ar=
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
> +    iothrottle =3D qapi_BlockIOThrottle_base(arg);
> +    throttle_set_io_limits(&cfg, iothrottle);
> =20
>      if (!throttle_is_valid(&cfg, errp)) {
>          goto out;
> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-opti=
ons.h
> index f63d38c..b736185 100644
> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -11,6 +11,7 @@
>  #define THROTTLE_OPTIONS_H
> =20
>  #include "typedefs.h"
> +#include "qapi-types.h"
> =20
>  #define THROTTLE_OPTS \
>            { \
> @@ -92,5 +93,6 @@
>          }
> =20
>  void throttle_parse_options(ThrottleConfig *, QemuOpts *);
> +void throttle_set_io_limits(ThrottleConfig *, IOThrottle *);
> =20
>  #endif
> diff --git a/util/throttle.c b/util/throttle.c
> index 95c2ecf..dcc9d5a 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -553,3 +553,62 @@ void throttle_parse_options(ThrottleConfig *throttle=
_cfg, QemuOpts *opts)
>      throttle_cfg->op_size =3D
>          qemu_opt_get_number(opts, "throttling.iops-size", 0);
>  }
> +
> +/* Initialize a throttle config from an IOThrottle structure
> + *
> + * @arg: iothrottle limits
> + * @cfg: throttle configuration
> + */
> +void throttle_set_io_limits(ThrottleConfig *cfg, IOThrottle *arg)
> +{
> +    throttle_config_init(cfg);
> +    cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps;
> +    cfg->buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_rd;
> +    cfg->buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_wr;
> +
> +    cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops;
> +    cfg->buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_rd;
> +    cfg->buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_wr;
> +
> +    if (arg->has_bps_max) {
> +        cfg->buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_max;
> +    }
> +    if (arg->has_bps_rd_max) {
> +        cfg->buckets[THROTTLE_BPS_READ].max =3D arg->bps_rd_max;
> +    }
> +    if (arg->has_bps_wr_max) {
> +        cfg->buckets[THROTTLE_BPS_WRITE].max =3D arg->bps_wr_max;
> +    }
> +    if (arg->has_iops_max) {
> +        cfg->buckets[THROTTLE_OPS_TOTAL].max =3D arg->iops_max;
> +    }
> +    if (arg->has_iops_rd_max) {
> +        cfg->buckets[THROTTLE_OPS_READ].max =3D arg->iops_rd_max;
> +    }
> +    if (arg->has_iops_wr_max) {
> +        cfg->buckets[THROTTLE_OPS_WRITE].max =3D arg->iops_wr_max;
> +    }
> +
> +    if (arg->has_bps_max_length) {
> +        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D arg->bps_max_l=
ength;
> +    }
> +    if (arg->has_bps_rd_max_length) {
> +        cfg->buckets[THROTTLE_BPS_READ].burst_length =3D arg->bps_rd_max=
_length;
> +    }
> +    if (arg->has_bps_wr_max_length) {
> +        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D arg->bps_wr_ma=
x_length;
> +    }
> +    if (arg->has_iops_max_length) {
> +        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D arg->iops_max_=
length;
> +    }
> +    if (arg->has_iops_rd_max_length) {
> +        cfg->buckets[THROTTLE_OPS_READ].burst_length =3D arg->iops_rd_ma=
x_length;
> +    }
> +    if (arg->has_iops_wr_max_length) {
> +        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D arg->iops_wr_m=
ax_length;
> +    }
> +
> +    if (arg->has_iops_size) {
> +        cfg->op_size =3D arg->iops_size;
> +    }
> +}


--Sig_/lSso=A9Q6HUOtxSHaVAlbXh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbKMsQAKCRAC/DrrAQHb
wjvUAJ4sFyjyRgdms106AwjBgiVfwrgJ5wCeIO/mn3VD0PK8UdmrtGIqmMHowEw=
=rcyR
-----END PGP SIGNATURE-----

--Sig_/lSso=A9Q6HUOtxSHaVAlbXh--
