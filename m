Received: from eggs.gnu.org ([2001:4830:134:3::10]:40115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsS50-0000rL-8o
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsS4t-0007DZ-AC
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:13:10 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:33348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsS4t-0007Bp-0c
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:13:03 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 98775ABF9E
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 13:13:00 +0200 (CEST)
Date: Thu, 14 Sep 2017 13:12:51 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170914131251.0881b755@bahia.lan>
In-Reply-To: <1505385610-35529-2-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1505385610-35529-2-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/2t04RV.kNT/ZyDmpOLnaVAU";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v11 1/6] throttle: factor out duplicate code
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

--Sig_/2t04RV.kNT/ZyDmpOLnaVAU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Sep 2017 06:40:05 -0400
Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patch factors out the duplicate throttle code that was still
> present in block and fsdev devices.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>

I see you took my remarks into account, except for the patch title
which is still the very same as commit:

a2a7862ca9ab throttle: factor out duplicate code

:-\

> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  blockdev.c                      | 44 +---------------------------------
>  fsdev/qemu-fsdev-throttle.c     | 44 ++--------------------------------
>  include/qemu/throttle-options.h |  3 +++
>  include/qemu/throttle.h         |  4 ++--
>  include/qemu/typedefs.h         |  1 +
>  util/throttle.c                 | 52 +++++++++++++++++++++++++++++++++++=
++++++
>  6 files changed, 61 insertions(+), 87 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 56a6b24..9d33c25 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -387,49 +387,7 @@ static void extract_common_blockdev_options(QemuOpts=
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
> index 3528a8f..9709dcd 100644
> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -9,6 +9,7 @@
>   */
>  #ifndef THROTTLE_OPTIONS_H
>  #define THROTTLE_OPTIONS_H
> +#include "typedefs.h"
> =20
>  #define QEMU_OPT_IOPS_TOTAL "iops-total"
>  #define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
> @@ -111,4 +112,6 @@
>              .help =3D "when limiting by iops max size of an I/O in bytes=
",\
>          }
> =20
> +void throttle_parse_options(ThrottleConfig *, QemuOpts *);
> +
>  #endif
> diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
> index 8c93237..b6ebc6d 100644
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
> index 06bf916..9ef28c4 100644
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
> @@ -635,3 +636,54 @@ void throttle_config_to_limits(ThrottleConfig *cfg, =
ThrottleLimits *var)
>      var->has_iops_write_max_length =3D true;
>      var->has_iops_size =3D true;
>  }
> +
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


--Sig_/2t04RV.kNT/ZyDmpOLnaVAU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbpkMwAKCRAC/DrrAQHb
wtdFAJ9JUuu/6tqiLQD9NMHEBgDzUCIGDACeNHJWL1R3NTFX9swAe10eJmttGXw=
=M2p6
-----END PGP SIGNATURE-----

--Sig_/2t04RV.kNT/ZyDmpOLnaVAU--
