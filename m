Received: from eggs.gnu.org ([2001:4830:134:3::10]:34531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d8iru-00030F-RG
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d8irq-0006ac-S9
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:50:38 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:34538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d8irq-0006Zy-Hx
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:50:34 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 98D75D170D
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 09:50:32 +0200 (CEST)
Date: Thu, 11 May 2017 09:50:22 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170511095022.2478c784@bahia.lan>
In-Reply-To: <1494405683-20877-4-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-4-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/5x6qqTffPsfsae2Ht69ZwQ4";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 3/4] qmp: refactor duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani
	kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

--Sig_/5x6qqTffPsfsae2Ht69ZwQ4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 May 2017 04:41:22 -0400
Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patch factor out the duplicate qmp throttle interface code
> that was present in both block and fsdev device files.
>=20

There isn't any duplicated code at this stage since you have changed the
patch ordering.

Also, this patch is factoring out several things:
- factoring code out of qmp_block_set_io_throttle()
- factoring code out of hmp_block_set_io_throttle()

So I'm not sure the patch title is quite right either.

This seems to be the same in patch 4: it only mentions QMP even though
it adds QMP and HMP interfaces. Maybe you should change this part of
the series.

A patch to introduce the full QMP interface, including the associated
code refactoring (whose need would then be obvious). And a similar patch
for the HMP interface.

> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---
>  blockdev.c                      | 53 +++--------------------------------=
-----
>  hmp.c                           | 21 +++++++++++-----
>  include/qemu/throttle-options.h |  2 ++
>  util/throttle-options.c         | 54 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 74 insertions(+), 56 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index a0eb2ed..a55f6be 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2593,6 +2593,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg=
, Error **errp)
>      BlockDriverState *bs;
>      BlockBackend *blk;
>      AioContext *aio_context;
> +    IOThrottle *iothrottle;
> =20
>      blk =3D qmp_get_blk(arg->has_device ? arg->device : NULL,
>                        arg->has_id ? arg->id : NULL,
> @@ -2610,56 +2611,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle *ar=
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
> +    qmp_set_io_throttle(&cfg, iothrottle);
> =20
>      if (!throttle_is_valid(&cfg, errp)) {
>          goto out;
> diff --git a/hmp.c b/hmp.c
> index ab407d6..9660373 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1552,20 +1552,29 @@ void hmp_change(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
> =20
> +static void hmp_initialize_io_throttle(IOThrottle *iot, const QDict *qdi=
ct)
> +{
> +    iot->has_id =3D true;
> +    iot->id =3D (char *) qdict_get_str(qdict, "id");
> +    iot->bps =3D qdict_get_int(qdict, "bps");
> +    iot->bps_rd =3D qdict_get_int(qdict, "bps_rd");
> +    iot->bps_wr =3D qdict_get_int(qdict, "bps_wr");
> +    iot->iops =3D qdict_get_int(qdict, "iops");
> +    iot->iops_rd =3D qdict_get_int(qdict, "iops_rd");
> +    iot->iops_wr =3D qdict_get_int(qdict, "iops_wr");
> +}
> +
>  void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
>  {
>      Error *err =3D NULL;
> +    IOThrottle *iothrottle;
>      BlockIOThrottle throttle =3D {
>          .has_device =3D true,
>          .device =3D (char *) qdict_get_str(qdict, "device"),
> -        .bps =3D qdict_get_int(qdict, "bps"),
> -        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
> -        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
> -        .iops =3D qdict_get_int(qdict, "iops"),
> -        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
> -        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
>      };
> =20
> +    iothrottle =3D qapi_BlockIOThrottle_base(&throttle);
> +    hmp_initialize_io_throttle(iothrottle, qdict);
>      qmp_block_set_io_throttle(&throttle, &err);
>      hmp_handle_error(mon, &err);
>  }
> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-opti=
ons.h
> index 9b68eb8..ccf10cc 100644
> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -94,4 +94,6 @@
> =20
>  void parse_io_throttle_options(ThrottleConfig *, QemuOpts *);
> =20
> +void qmp_set_io_throttle(ThrottleConfig *, IOThrottle *);
> +
>  #endif
> diff --git a/util/throttle-options.c b/util/throttle-options.c
> index 02b26b8..ded57bc 100644
> --- a/util/throttle-options.c
> +++ b/util/throttle-options.c
> @@ -49,3 +49,57 @@ void parse_io_throttle_options(ThrottleConfig *throttl=
e_cfg, QemuOpts *opts)
>          qemu_opt_get_number(opts, "throttling.iops-size", 0);
> =20
>  }
> +
> +void qmp_set_io_throttle(ThrottleConfig *cfg, IOThrottle *arg)
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

--Sig_/5x6qqTffPsfsae2Ht69ZwQ4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkUF74ACgkQAvw66wEB28JXfACgg/BujQm40Xt34S3+exrlLNaX
WyUAnRoLkxfLOmhVUpO5ODGizwpjVNy1
=tGyK
-----END PGP SIGNATURE-----

--Sig_/5x6qqTffPsfsae2Ht69ZwQ4--
