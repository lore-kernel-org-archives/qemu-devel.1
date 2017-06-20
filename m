Received: from eggs.gnu.org ([2001:4830:134:3::10]:37516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNLMW-0002eV-CI
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNLMT-00024r-6L
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:46:40 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:56664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNLMS-00024k-Sm
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:46:37 -0400
Received: from player789.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 348025EB91
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 17:46:34 +0200 (CEST)
Date: Tue, 20 Jun 2017 17:46:25 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170620174625.5bec73ed@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1497877896-35700-2-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1497877896-35700-2-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/dCcg_3/lgah4LGv0WfF54d3";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v5 1/5] throttle: factor out duplicate code
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
	kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

--Sig_/dCcg_3/lgah4LGv0WfF54d3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jun 2017 09:11:32 -0400
Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patch factor out the duplicate throttle code that was present in
> block and fsdev devices.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---

I guess this patch can be applied right away.

Cc'ing Markus (maintainer of blockdev.c)

>  blockdev.c                      | 44 +-----------------------------------
>  fsdev/qemu-fsdev-throttle.c     | 43 +----------------------------------
>  fsdev/qemu-fsdev-throttle.h     |  1 +
>  include/qemu/throttle-options.h |  4 ++++
>  util/throttle.c                 | 50 +++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 57 insertions(+), 85 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 6472548..5db9e5c 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -386,49 +386,7 @@ static void extract_common_blockdev_options(QemuOpts=
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
> index 7ae4e86..da9c225 100644
> --- a/fsdev/qemu-fsdev-throttle.c
> +++ b/fsdev/qemu-fsdev-throttle.c
> @@ -31,48 +31,7 @@ static void fsdev_throttle_write_timer_cb(void *opaque)
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
> diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
> index e418643..c493e83 100644
> --- a/fsdev/qemu-fsdev-throttle.h
> +++ b/fsdev/qemu-fsdev-throttle.h
> @@ -20,6 +20,7 @@
>  #include "qemu/coroutine.h"
>  #include "qapi/error.h"
>  #include "qemu/throttle.h"
> +#include "qemu/throttle-options.h"
> =20
>  typedef struct FsThrottle {
>      ThrottleState ts;
> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-opti=
ons.h
> index 3133d1c..565553a 100644
> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -10,6 +10,8 @@
>  #ifndef THROTTLE_OPTIONS_H
>  #define THROTTLE_OPTIONS_H
> =20
> +#include "qemu/throttle.h"
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
> diff --git a/util/throttle.c b/util/throttle.c
> index 3570ed2..ebe9dd0 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -514,3 +514,53 @@ void throttle_account(ThrottleState *ts, bool is_wri=
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


--Sig_/dCcg_3/lgah4LGv0WfF54d3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllJQ1EACgkQAvw66wEB28Kp5ACfXbdXqhnJqQ6BYDr2O7Ai1wp+
Ip0AniEkJyLyEQfUeF3dmXBYqNfggzsi
=GN9n
-----END PGP SIGNATURE-----

--Sig_/dCcg_3/lgah4LGv0WfF54d3--
