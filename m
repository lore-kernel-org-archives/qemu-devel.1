Received: from eggs.gnu.org ([2001:4830:134:3::10]:50187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d8SLu-0003Ts-HD
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d8SLo-0002vX-12
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:12:30 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:58188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d8SLn-0002tP-Np
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:12:23 -0400
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2979B3C617
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 16:12:12 +0200 (CEST)
Date: Wed, 10 May 2017 16:12:01 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170510161201.387edc47@bahia.kaod.org>
In-Reply-To: <1494405683-20877-2-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1494405683-20877-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1494405683-20877-2-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/ZuKP.wvtl8B+.xw34NiqJ17";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 1/4] throttle: factor out duplicate code
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

--Sig_/ZuKP.wvtl8B+.xw34NiqJ17
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 May 2017 04:41:20 -0400
Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patch factor out the duplicate throttle code that was present in
> block and fsdev devices.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---
>  blockdev.c                      | 44 +----------------------------------
>  fsdev/qemu-fsdev-throttle.c     | 43 +---------------------------------
>  fsdev/qemu-fsdev-throttle.h     |  1 +
>  include/qemu/throttle-options.h |  5 ++++
>  util/Makefile.objs              |  1 +
>  util/throttle-options.c         | 51 +++++++++++++++++++++++++++++++++++=
++++++
>  6 files changed, 60 insertions(+), 85 deletions(-)
>  create mode 100644 util/throttle-options.c
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 6428206..a0eb2ed 100644
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
> +        parse_io_throttle_options(throttle_cfg, opts);
>          if (!throttle_is_valid(throttle_cfg, errp)) {
>              return;
>          }
> diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
> index 7ae4e86..db386a7 100644
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
> +    parse_io_throttle_options(&fst->cfg, opts);
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
> index 3133d1c..9b68eb8 100644
> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -10,6 +10,9 @@
>  #ifndef THROTTLE_OPTIONS_H
>  #define THROTTLE_OPTIONS_H
> =20
> +#include "qemu/throttle.h"
> +#include "qmp-commands.h"

I believe we don't need qmp-commands.h here

> +
>  #define THROTTLE_OPTS \
>            { \
>              .name =3D "throttling.iops-total",\
> @@ -89,4 +92,6 @@
>              .help =3D "when limiting by iops max size of an I/O in bytes=
",\
>          }
> =20
> +void parse_io_throttle_options(ThrottleConfig *, QemuOpts *);

Maybe rename to throttle_parse_options() to follow the naming scheme used
in the throttle infrastructure ?

> +
>  #endif
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index c6205eb..7119ce0 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -43,3 +43,4 @@ util-obj-y +=3D qdist.o
>  util-obj-y +=3D qht.o
>  util-obj-y +=3D range.o
>  util-obj-y +=3D systemd.o
> +util-obj-y +=3D throttle-options.o
> diff --git a/util/throttle-options.c b/util/throttle-options.c
> new file mode 100644
> index 0000000..02b26b8
> --- /dev/null
> +++ b/util/throttle-options.c
> @@ -0,0 +1,51 @@
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/throttle-options.h"
> +#include "qemu/iov.h"
> +
> +void parse_io_throttle_options(ThrottleConfig *throttle_cfg, QemuOpts *o=
pts)
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
> +
> +}

Isn't it a bit overkill to introduce a new file for a single function ?
Maybe you could simply move this to util/throttle.c ?

--Sig_/ZuKP.wvtl8B+.xw34NiqJ17
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkTH7IACgkQAvw66wEB28K4TQCfbcQSWiWdtzEmWhK5AIOHc77G
EWIAn01a8uLk81ACMBOg97UmKC3x31Cn
=JZOZ
-----END PGP SIGNATURE-----

--Sig_/ZuKP.wvtl8B+.xw34NiqJ17--
