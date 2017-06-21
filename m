Received: from eggs.gnu.org ([2001:4830:134:3::10]:51011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNcR5-0005HF-F1
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNcR0-0005ak-Uc
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:00:31 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:40463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNcR0-0005Zw-Kj
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:00:26 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 8455C108779
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 12:00:23 +0200 (CEST)
Date: Wed, 21 Jun 2017 12:00:14 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170621120014.77c2c03d@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <e44687fa-cc7a-8299-6abe-84ee59b9380e@huawei.com>
References: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1497877896-35700-4-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170620180516.143c5359@bahia.lab.toulouse-stg.fr.ibm.com>
	<e44687fa-cc7a-8299-6abe-84ee59b9380e@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/BI6Eu/W=a8GKnu5k_pwMATG";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v5 3/5] qmp: refactor duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

--Sig_/BI6Eu/W=a8GKnu5k_pwMATG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Jun 2017 10:34:42 +0200
Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> wrote:

> On 6/20/2017 6:05 PM, Greg Kurz wrote:
> > On Mon, 19 Jun 2017 09:11:34 -0400
> > Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:
> > =20
> >> This patch factor out the duplicate qmp throttle interface code
> >> that was present in both block and fsdev device files.
> >> =20
> >
> > The text is obviously wrong. I don't see any duplicate code below. =20
> OK, I will fix this.
> >
> > It is more something like: let's factor out the code that will be used
> > by the existing QMP throttling API for block devices and the future
> > QMP throttling API for fs devices.
> >
> > Please move the HMP part to another patch, as asked during v4 review. =
=20
> I have moved the hmp patches for the fsdev into a separate patch. Do you=
=20
> want me to push this also into a separate patch?

Yes. These changes aren't related and theoretically belong to separate
sub-maintainer trees.

> >
> > Also, blockdev.c and hmp.c do have maintainers. You should Cc: them each
> > time because they know better than me and even if these patches are car=
ried
> > through my tree, I won't do it without an ack from them. =20
>=20
> OK, I will add them next time on.
>=20
> -Pradeep
>=20
> > Cc'ing Markus for blockdev.c and David for hmp.c.
> > =20
> >> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> >> ---
> >>  blockdev.c                      | 53 +++-----------------------------=
----
> >>  hmp.c                           | 21 ++++++++++-----
> >>  include/qemu/throttle-options.h |  3 +++
> >>  util/throttle.c                 | 60 ++++++++++++++++++++++++++++++++=
+++++++++
> >>  4 files changed, 81 insertions(+), 56 deletions(-)
> >>
> >> diff --git a/blockdev.c b/blockdev.c
> >> index 5db9e5c..3d06e9e 100644
> >> --- a/blockdev.c
> >> +++ b/blockdev.c
> >> @@ -2593,6 +2593,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *=
arg, Error **errp)
> >>      BlockDriverState *bs;
> >>      BlockBackend *blk;
> >>      AioContext *aio_context;
> >> +    IOThrottle *iothrottle;
> >>
> >>      blk =3D qmp_get_blk(arg->has_device ? arg->device : NULL,
> >>                        arg->has_id ? arg->id : NULL,
> >> @@ -2610,56 +2611,8 @@ void qmp_block_set_io_throttle(BlockIOThrottle =
*arg, Error **errp)
> >>          goto out;
> >>      }
> >>
> >> -    throttle_config_init(&cfg);
> >> -    cfg.buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps;
> >> -    cfg.buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_rd;
> >> -    cfg.buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_wr;
> >> -
> >> -    cfg.buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops;
> >> -    cfg.buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_rd;
> >> -    cfg.buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_wr;
> >> -
> >> -    if (arg->has_bps_max) {
> >> -        cfg.buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_max;
> >> -    }
> >> -    if (arg->has_bps_rd_max) {
> >> -        cfg.buckets[THROTTLE_BPS_READ].max =3D arg->bps_rd_max;
> >> -    }
> >> -    if (arg->has_bps_wr_max) {
> >> -        cfg.buckets[THROTTLE_BPS_WRITE].max =3D arg->bps_wr_max;
> >> -    }
> >> -    if (arg->has_iops_max) {
> >> -        cfg.buckets[THROTTLE_OPS_TOTAL].max =3D arg->iops_max;
> >> -    }
> >> -    if (arg->has_iops_rd_max) {
> >> -        cfg.buckets[THROTTLE_OPS_READ].max =3D arg->iops_rd_max;
> >> -    }
> >> -    if (arg->has_iops_wr_max) {
> >> -        cfg.buckets[THROTTLE_OPS_WRITE].max =3D arg->iops_wr_max;
> >> -    }
> >> -
> >> -    if (arg->has_bps_max_length) {
> >> -        cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =3D arg->bps_max=
_length;
> >> -    }
> >> -    if (arg->has_bps_rd_max_length) {
> >> -        cfg.buckets[THROTTLE_BPS_READ].burst_length =3D arg->bps_rd_m=
ax_length;
> >> -    }
> >> -    if (arg->has_bps_wr_max_length) {
> >> -        cfg.buckets[THROTTLE_BPS_WRITE].burst_length =3D arg->bps_wr_=
max_length;
> >> -    }
> >> -    if (arg->has_iops_max_length) {
> >> -        cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =3D arg->iops_ma=
x_length;
> >> -    }
> >> -    if (arg->has_iops_rd_max_length) {
> >> -        cfg.buckets[THROTTLE_OPS_READ].burst_length =3D arg->iops_rd_=
max_length;
> >> -    }
> >> -    if (arg->has_iops_wr_max_length) {
> >> -        cfg.buckets[THROTTLE_OPS_WRITE].burst_length =3D arg->iops_wr=
_max_length;
> >> -    }
> >> -
> >> -    if (arg->has_iops_size) {
> >> -        cfg.op_size =3D arg->iops_size;
> >> -    }
> >> +    iothrottle =3D qapi_BlockIOThrottle_base(arg);
> >> +    throttle_set_io_limits(&cfg, iothrottle);
> >>
> >>      if (!throttle_is_valid(&cfg, errp)) {
> >>          goto out;
> >> diff --git a/hmp.c b/hmp.c
> >> index 8c72c58..220d301 100644
> >> --- a/hmp.c
> >> +++ b/hmp.c
> >> @@ -1749,20 +1749,29 @@ void hmp_change(Monitor *mon, const QDict *qdi=
ct)
> >>      hmp_handle_error(mon, &err);
> >>  }
> >>
> >> +static void hmp_initialize_io_throttle(IOThrottle *iot, const QDict *=
qdict)
> >> +{
> >> +    iot->has_id =3D true;
> >> +    iot->id =3D (char *) qdict_get_str(qdict, "id");
> >> +    iot->bps =3D qdict_get_int(qdict, "bps");
> >> +    iot->bps_rd =3D qdict_get_int(qdict, "bps_rd");
> >> +    iot->bps_wr =3D qdict_get_int(qdict, "bps_wr");
> >> +    iot->iops =3D qdict_get_int(qdict, "iops");
> >> +    iot->iops_rd =3D qdict_get_int(qdict, "iops_rd");
> >> +    iot->iops_wr =3D qdict_get_int(qdict, "iops_wr");
> >> +}
> >> +
> >>  void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
> >>  {
> >>      Error *err =3D NULL;
> >> +    IOThrottle *iothrottle;
> >>      BlockIOThrottle throttle =3D {
> >>          .has_device =3D true,
> >>          .device =3D (char *) qdict_get_str(qdict, "device"),
> >> -        .bps =3D qdict_get_int(qdict, "bps"),
> >> -        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
> >> -        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
> >> -        .iops =3D qdict_get_int(qdict, "iops"),
> >> -        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
> >> -        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
> >>      };
> >>
> >> +    iothrottle =3D qapi_BlockIOThrottle_base(&throttle);
> >> +    hmp_initialize_io_throttle(iothrottle, qdict);
> >>      qmp_block_set_io_throttle(&throttle, &err);
> >>      hmp_handle_error(mon, &err);
> >>  }
> >> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-o=
ptions.h
> >> index 565553a..e94ea39 100644
> >> --- a/include/qemu/throttle-options.h
> >> +++ b/include/qemu/throttle-options.h
> >> @@ -11,6 +11,7 @@
> >>  #define THROTTLE_OPTIONS_H
> >>
> >>  #include "qemu/throttle.h"
> >> +#include "qmp-commands.h"
> >>
> >>  #define THROTTLE_OPTS \
> >>            { \
> >> @@ -93,4 +94,6 @@
> >>
> >>  void throttle_parse_options(ThrottleConfig *, QemuOpts *);
> >>
> >> +void throttle_set_io_limits(ThrottleConfig *, IOThrottle *);
> >> +
> >>  #endif
> >> diff --git a/util/throttle.c b/util/throttle.c
> >> index ebe9dd0..2cf9ec5 100644
> >> --- a/util/throttle.c
> >> +++ b/util/throttle.c
> >> @@ -27,6 +27,7 @@
> >>  #include "qemu/throttle.h"
> >>  #include "qemu/timer.h"
> >>  #include "block/aio.h"
> >> +#include "qemu/throttle-options.h"
> >>
> >>  /* This function make a bucket leak
> >>   *
> >> @@ -564,3 +565,62 @@ void throttle_parse_options(ThrottleConfig *throt=
tle_cfg, QemuOpts *opts)
> >>      throttle_cfg->op_size =3D
> >>          qemu_opt_get_number(opts, "throttling.iops-size", 0);
> >>  }
> >> +
> >> +/* set the throttle limits
> >> + *
> >> + * @arg: iothrottle limits
> >> + * @cfg: throttle configuration
> >> + */
> >> +void throttle_set_io_limits(ThrottleConfig *cfg, IOThrottle *arg)
> >> +{
> >> +    throttle_config_init(cfg);
> >> +    cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps;
> >> +    cfg->buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_rd;
> >> +    cfg->buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_wr;
> >> +
> >> +    cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops;
> >> +    cfg->buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_rd;
> >> +    cfg->buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_wr;
> >> +
> >> +    if (arg->has_bps_max) {
> >> +        cfg->buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_max;
> >> +    }
> >> +    if (arg->has_bps_rd_max) {
> >> +        cfg->buckets[THROTTLE_BPS_READ].max =3D arg->bps_rd_max;
> >> +    }
> >> +    if (arg->has_bps_wr_max) {
> >> +        cfg->buckets[THROTTLE_BPS_WRITE].max =3D arg->bps_wr_max;
> >> +    }
> >> +    if (arg->has_iops_max) {
> >> +        cfg->buckets[THROTTLE_OPS_TOTAL].max =3D arg->iops_max;
> >> +    }
> >> +    if (arg->has_iops_rd_max) {
> >> +        cfg->buckets[THROTTLE_OPS_READ].max =3D arg->iops_rd_max;
> >> +    }
> >> +    if (arg->has_iops_wr_max) {
> >> +        cfg->buckets[THROTTLE_OPS_WRITE].max =3D arg->iops_wr_max;
> >> +    }
> >> +
> >> +    if (arg->has_bps_max_length) {
> >> +        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D arg->bps_ma=
x_length;
> >> +    }
> >> +    if (arg->has_bps_rd_max_length) {
> >> +        cfg->buckets[THROTTLE_BPS_READ].burst_length =3D arg->bps_rd_=
max_length;
> >> +    }
> >> +    if (arg->has_bps_wr_max_length) {
> >> +        cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D arg->bps_wr=
_max_length;
> >> +    }
> >> +    if (arg->has_iops_max_length) {
> >> +        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D arg->iops_m=
ax_length;
> >> +    }
> >> +    if (arg->has_iops_rd_max_length) {
> >> +        cfg->buckets[THROTTLE_OPS_READ].burst_length =3D arg->iops_rd=
_max_length;
> >> +    }
> >> +    if (arg->has_iops_wr_max_length) {
> >> +        cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D arg->iops_w=
r_max_length;
> >> +    }
> >> +
> >> +    if (arg->has_iops_size) {
> >> +        cfg->op_size =3D arg->iops_size;
> >> +    }
> >> +} =20
> > =20
>=20


--Sig_/BI6Eu/W=a8GKnu5k_pwMATG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllKQ64ACgkQAvw66wEB28Ki1ACdGA8if1voHx5dl6YgeJ1ptj2U
oRYAmwZBv6mMr7Ux+BRT6dzddZmnR+v4
=ATZw
-----END PGP SIGNATURE-----

--Sig_/BI6Eu/W=a8GKnu5k_pwMATG--
