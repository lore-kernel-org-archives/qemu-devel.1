Received: from eggs.gnu.org ([2001:4830:134:3::10]:48090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpWyR-000237-VN
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpWyO-0008TA-Rp
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:50:20 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:52347)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpWyO-0008QL-HE
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:50:16 -0400
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id F1EA27B436
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 11:50:08 +0200 (CEST)
Date: Wed, 6 Sep 2017 11:49:59 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170906114959.2c385643@bahia>
In-Reply-To: <1504541267-36954-2-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-2-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/lGkJIbkfQk++llWzauq.u=Z";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v10 1/6] throttle: factor out duplicate code
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

--Sig_/lGkJIbkfQk++llWzauq.u=Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

With this patch applied, we get:

$ git log --no-decorate --oneline include/qemu/throttle-options.h
a54046b857be throttle: factor out duplicate code
a2a7862ca9ab throttle: factor out duplicate code

Maybe better to change the patch title to:

throttle: factor out more duplicate code

On Mon,  4 Sep 2017 12:07:42 -0400
Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patch factor out the duplicate throttle code that was present in

This patch factors out the duplicate throttle code that was still present in

> block and fsdev devices.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

With the above fixed.

Reviewed-by: Greg Kurz <groug@kaod.org>

> ---
>  blockdev.c                      | 44 +----------------------------------
>  fsdev/qemu-fsdev-throttle.c     | 44 ++---------------------------------
>  include/qemu/throttle-options.h |  4 ++++
>  include/qemu/throttle.h         |  4 ++--
>  include/qemu/typedefs.h         |  1 +
>  util/throttle.c                 | 51 +++++++++++++++++++++++++++++++++++=
++++++
>  6 files changed, 61 insertions(+), 87 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 02cd69b..780ae58 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -388,49 +388,7 @@ static void extract_common_blockdev_options(QemuOpts=
 *opts, int *bdrv_flags,
>      }
> =20
>      if (throttle_cfg) {
> -        throttle_config_init(throttle_cfg);
> -        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
> -            qemu_opt_get_number(opts, "throttling.bps-total", 0);
> -        throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =3D
> -            qemu_opt_get_number(opts, "throttling.bps-read", 0);
> -        throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
> -            qemu_opt_get_number(opts, "throttling.bps-write", 0);
> -        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
> -            qemu_opt_get_number(opts, "throttling.iops-total", 0);
> -        throttle_cfg->buckets[THROTTLE_OPS_READ].avg =3D
> -            qemu_opt_get_number(opts, "throttling.iops-read", 0);
> -        throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
> -            qemu_opt_get_number(opts, "throttling.iops-write", 0);
> -
> -        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
> -            qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
> -        throttle_cfg->buckets[THROTTLE_BPS_READ].max  =3D
> -            qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
> -        throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =3D
> -            qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
> -        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
> -            qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
> -        throttle_cfg->buckets[THROTTLE_OPS_READ].max =3D
> -            qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
> -        throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =3D
> -            qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
> -
> -        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
> -            qemu_opt_get_number(opts, "throttling.bps-total-max-length",=
 1);
> -        throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
> -            qemu_opt_get_number(opts, "throttling.bps-read-max-length", =
1);
> -        throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
> -            qemu_opt_get_number(opts, "throttling.bps-write-max-length",=
 1);
> -        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
> -            qemu_opt_get_number(opts, "throttling.iops-total-max-length"=
, 1);
> -        throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
> -            qemu_opt_get_number(opts, "throttling.iops-read-max-length",=
 1);
> -        throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
> -            qemu_opt_get_number(opts, "throttling.iops-write-max-length"=
, 1);
> -
> -        throttle_cfg->op_size =3D
> -            qemu_opt_get_number(opts, "throttling.iops-size", 0);
> -
> +        throttle_parse_options(throttle_cfg, opts);
>          if (!throttle_is_valid(throttle_cfg, errp)) {
>              return;
>          }
> diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
> index 49eebb5..0e6fb86 100644
> --- a/fsdev/qemu-fsdev-throttle.c
> +++ b/fsdev/qemu-fsdev-throttle.c
> @@ -16,6 +16,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu-fsdev-throttle.h"
>  #include "qemu/iov.h"
> +#include "qemu/throttle-options.h"
> =20
>  static void fsdev_throttle_read_timer_cb(void *opaque)
>  {
> @@ -31,48 +32,7 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
> =20
>  void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **=
errp)
>  {
> -    throttle_config_init(&fst->cfg);
> -    fst->cfg.buckets[THROTTLE_BPS_TOTAL].avg =3D
> -        qemu_opt_get_number(opts, "throttling.bps-total", 0);
> -    fst->cfg.buckets[THROTTLE_BPS_READ].avg  =3D
> -        qemu_opt_get_number(opts, "throttling.bps-read", 0);
> -    fst->cfg.buckets[THROTTLE_BPS_WRITE].avg =3D
> -        qemu_opt_get_number(opts, "throttling.bps-write", 0);
> -    fst->cfg.buckets[THROTTLE_OPS_TOTAL].avg =3D
> -        qemu_opt_get_number(opts, "throttling.iops-total", 0);
> -    fst->cfg.buckets[THROTTLE_OPS_READ].avg =3D
> -        qemu_opt_get_number(opts, "throttling.iops-read", 0);
> -    fst->cfg.buckets[THROTTLE_OPS_WRITE].avg =3D
> -        qemu_opt_get_number(opts, "throttling.iops-write", 0);
> -
> -    fst->cfg.buckets[THROTTLE_BPS_TOTAL].max =3D
> -        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
> -    fst->cfg.buckets[THROTTLE_BPS_READ].max  =3D
> -        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
> -    fst->cfg.buckets[THROTTLE_BPS_WRITE].max =3D
> -        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
> -    fst->cfg.buckets[THROTTLE_OPS_TOTAL].max =3D
> -        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
> -    fst->cfg.buckets[THROTTLE_OPS_READ].max =3D
> -        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
> -    fst->cfg.buckets[THROTTLE_OPS_WRITE].max =3D
> -        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
> -
> -    fst->cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =3D
> -        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
> -    fst->cfg.buckets[THROTTLE_BPS_READ].burst_length  =3D
> -        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
> -    fst->cfg.buckets[THROTTLE_BPS_WRITE].burst_length =3D
> -        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
> -    fst->cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =3D
> -        qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
> -    fst->cfg.buckets[THROTTLE_OPS_READ].burst_length =3D
> -        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
> -    fst->cfg.buckets[THROTTLE_OPS_WRITE].burst_length =3D
> -        qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
> -    fst->cfg.op_size =3D
> -        qemu_opt_get_number(opts, "throttling.iops-size", 0);
> -
> +    throttle_parse_options(&fst->cfg, opts);
>      throttle_is_valid(&fst->cfg, errp);
>  }
> =20
> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-opti=
ons.h
> index 3133d1c..f63d38c 100644
> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -10,6 +10,8 @@
>  #ifndef THROTTLE_OPTIONS_H
>  #define THROTTLE_OPTIONS_H
> =20
> +#include "typedefs.h"
> +
>  #define THROTTLE_OPTS \
>            { \
>              .name =3D "throttling.iops-total",\
> @@ -89,4 +91,6 @@
>              .help =3D "when limiting by iops max size of an I/O in bytes=
",\
>          }
> =20
> +void throttle_parse_options(ThrottleConfig *, QemuOpts *);
> +
>  #endif
> diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
> index d056008..75d930c 100644
> --- a/include/qemu/throttle.h
> +++ b/include/qemu/throttle.h
> @@ -89,10 +89,10 @@ typedef struct LeakyBucket {
>   * However it allows to keep the code clean and the bucket field is rese=
t to
>   * zero at the right time.
>   */
> -typedef struct ThrottleConfig {
> +struct ThrottleConfig {
>      LeakyBucket buckets[BUCKETS_COUNT]; /* leaky buckets */
>      uint64_t op_size;         /* size of an operation in bytes */
> -} ThrottleConfig;
> +};
> =20
>  typedef struct ThrottleState {
>      ThrottleConfig cfg;       /* configuration */
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 39bc835..90fe0f9 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -100,6 +100,7 @@ typedef struct uWireSlave uWireSlave;
>  typedef struct VirtIODevice VirtIODevice;
>  typedef struct Visitor Visitor;
>  typedef struct node_info NodeInfo;
> +typedef struct ThrottleConfig ThrottleConfig;
>  typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>  typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
> =20
> diff --git a/util/throttle.c b/util/throttle.c
> index b2a52b8..95c2ecf 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -27,6 +27,7 @@
>  #include "qemu/throttle.h"
>  #include "qemu/timer.h"
>  #include "block/aio.h"
> +#include "qemu/throttle-options.h"
> =20
>  /* This function make a bucket leak
>   *
> @@ -502,3 +503,53 @@ void throttle_account(ThrottleState *ts, bool is_wri=
te, uint64_t size)
>      }
>  }
> =20
> +/* parse the throttle options
> + *
> + * @opts: qemu options
> + * @throttle_cfg: throttle configuration
> + */
> +void throttle_parse_options(ThrottleConfig *throttle_cfg, QemuOpts *opts)
> +{
> +    throttle_config_init(throttle_cfg);
> +    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
> +        qemu_opt_get_number(opts, "throttling.bps-total", 0);
> +    throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =3D
> +        qemu_opt_get_number(opts, "throttling.bps-read", 0);
> +    throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
> +        qemu_opt_get_number(opts, "throttling.bps-write", 0);
> +    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
> +        qemu_opt_get_number(opts, "throttling.iops-total", 0);
> +    throttle_cfg->buckets[THROTTLE_OPS_READ].avg =3D
> +        qemu_opt_get_number(opts, "throttling.iops-read", 0);
> +    throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
> +        qemu_opt_get_number(opts, "throttling.iops-write", 0);
> +
> +    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
> +        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
> +    throttle_cfg->buckets[THROTTLE_BPS_READ].max  =3D
> +        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
> +    throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =3D
> +        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
> +    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
> +        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
> +    throttle_cfg->buckets[THROTTLE_OPS_READ].max =3D
> +        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
> +    throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =3D
> +        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
> +
> +    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
> +        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1);
> +    throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
> +        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
> +    throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
> +        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1);
> +    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
> +        qemu_opt_get_number(opts, "throttling.iops-total-max-length", 1);
> +    throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
> +        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1);
> +    throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
> +        qemu_opt_get_number(opts, "throttling.iops-write-max-length", 1);
> +
> +    throttle_cfg->op_size =3D
> +        qemu_opt_get_number(opts, "throttling.iops-size", 0);
> +}


--Sig_/lGkJIbkfQk++llWzauq.u=Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWa/ExwAKCRAC/DrrAQHb
wsggAJ9Lol48NQlzqfEP4AwF7t+xRnYrKACfX/FUuDs1EvRaI2RJJOZjqhDkliQ=
=880J
-----END PGP SIGNATURE-----

--Sig_/lGkJIbkfQk++llWzauq.u=Z--
