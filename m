Received: from eggs.gnu.org ([2001:4830:134:3::10]:46178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dO4tv-0007zh-6e
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dO4to-00030i-Ok
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:24:11 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:50547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dO4to-0002zl-E2
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:24:04 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 1440B10C50D
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 18:24:03 +0200 (CEST)
Date: Thu, 22 Jun 2017 18:23:53 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170622182353.25b3109b@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <87shisgk96.fsf@dusky.pond.sub.org>
References: <1497877896-35700-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1497877896-35700-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<87shisgk96.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/YzCw1YkDq+473fX510vhIAp";
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

--Sig_/YzCw1YkDq+473fX510vhIAp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Jun 2017 16:38:45 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Pradeep Jagadeesh <pradeepkiruvale@gmail.com> writes:
>=20
> > This patch factor out the duplicate throttle code that was present in
> > block and fsdev devices.
> >
> > Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> > ---
> >  blockdev.c                      | 44 +--------------------------------=
---
> >  fsdev/qemu-fsdev-throttle.c     | 43 +--------------------------------=
--
> >  fsdev/qemu-fsdev-throttle.h     |  1 +
> >  include/qemu/throttle-options.h |  4 ++++
> >  util/throttle.c                 | 50 +++++++++++++++++++++++++++++++++=
++++++++
> >  5 files changed, 57 insertions(+), 85 deletions(-)
> >
> > diff --git a/blockdev.c b/blockdev.c
> > index 6472548..5db9e5c 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -386,49 +386,7 @@ static void extract_common_blockdev_options(QemuOp=
ts *opts, int *bdrv_flags,
> >      }
> > =20
> >      if (throttle_cfg) {
> > -        throttle_config_init(throttle_cfg);
> > -        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
> > -            qemu_opt_get_number(opts, "throttling.bps-total", 0);
> > -        throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =3D
> > -            qemu_opt_get_number(opts, "throttling.bps-read", 0);
> > -        throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
> > -            qemu_opt_get_number(opts, "throttling.bps-write", 0);
> > -        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
> > -            qemu_opt_get_number(opts, "throttling.iops-total", 0);
> > -        throttle_cfg->buckets[THROTTLE_OPS_READ].avg =3D
> > -            qemu_opt_get_number(opts, "throttling.iops-read", 0);
> > -        throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
> > -            qemu_opt_get_number(opts, "throttling.iops-write", 0);
> > -
> > -        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
> > -            qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
> > -        throttle_cfg->buckets[THROTTLE_BPS_READ].max  =3D
> > -            qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
> > -        throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =3D
> > -            qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
> > -        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
> > -            qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
> > -        throttle_cfg->buckets[THROTTLE_OPS_READ].max =3D
> > -            qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
> > -        throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =3D
> > -            qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
> > -
> > -        throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
> > -            qemu_opt_get_number(opts, "throttling.bps-total-max-length=
", 1);
> > -        throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
> > -            qemu_opt_get_number(opts, "throttling.bps-read-max-length"=
, 1);
> > -        throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
> > -            qemu_opt_get_number(opts, "throttling.bps-write-max-length=
", 1);
> > -        throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
> > -            qemu_opt_get_number(opts, "throttling.iops-total-max-lengt=
h", 1);
> > -        throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
> > -            qemu_opt_get_number(opts, "throttling.iops-read-max-length=
", 1);
> > -        throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
> > -            qemu_opt_get_number(opts, "throttling.iops-write-max-lengt=
h", 1);
> > -
> > -        throttle_cfg->op_size =3D
> > -            qemu_opt_get_number(opts, "throttling.iops-size", 0);
> > -
> > +        throttle_parse_options(throttle_cfg, opts);
> >          if (!throttle_is_valid(throttle_cfg, errp)) {
> >              return;
> >          }
> > diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
> > index 7ae4e86..da9c225 100644
> > --- a/fsdev/qemu-fsdev-throttle.c
> > +++ b/fsdev/qemu-fsdev-throttle.c
> > @@ -31,48 +31,7 @@ static void fsdev_throttle_write_timer_cb(void *opaq=
ue)
> > =20
> >  void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error =
**errp)
> >  {
> > -    throttle_config_init(&fst->cfg);
> > -    fst->cfg.buckets[THROTTLE_BPS_TOTAL].avg =3D
> > -        qemu_opt_get_number(opts, "throttling.bps-total", 0);
> > -    fst->cfg.buckets[THROTTLE_BPS_READ].avg  =3D
> > -        qemu_opt_get_number(opts, "throttling.bps-read", 0);
> > -    fst->cfg.buckets[THROTTLE_BPS_WRITE].avg =3D
> > -        qemu_opt_get_number(opts, "throttling.bps-write", 0);
> > -    fst->cfg.buckets[THROTTLE_OPS_TOTAL].avg =3D
> > -        qemu_opt_get_number(opts, "throttling.iops-total", 0);
> > -    fst->cfg.buckets[THROTTLE_OPS_READ].avg =3D
> > -        qemu_opt_get_number(opts, "throttling.iops-read", 0);
> > -    fst->cfg.buckets[THROTTLE_OPS_WRITE].avg =3D
> > -        qemu_opt_get_number(opts, "throttling.iops-write", 0);
> > -
> > -    fst->cfg.buckets[THROTTLE_BPS_TOTAL].max =3D
> > -        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
> > -    fst->cfg.buckets[THROTTLE_BPS_READ].max  =3D
> > -        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
> > -    fst->cfg.buckets[THROTTLE_BPS_WRITE].max =3D
> > -        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
> > -    fst->cfg.buckets[THROTTLE_OPS_TOTAL].max =3D
> > -        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
> > -    fst->cfg.buckets[THROTTLE_OPS_READ].max =3D
> > -        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
> > -    fst->cfg.buckets[THROTTLE_OPS_WRITE].max =3D
> > -        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
> > -
> > -    fst->cfg.buckets[THROTTLE_BPS_TOTAL].burst_length =3D
> > -        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1=
);
> > -    fst->cfg.buckets[THROTTLE_BPS_READ].burst_length  =3D
> > -        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
> > -    fst->cfg.buckets[THROTTLE_BPS_WRITE].burst_length =3D
> > -        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1=
);
> > -    fst->cfg.buckets[THROTTLE_OPS_TOTAL].burst_length =3D
> > -        qemu_opt_get_number(opts, "throttling.iops-total-max-length", =
1);
> > -    fst->cfg.buckets[THROTTLE_OPS_READ].burst_length =3D
> > -        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1=
);
> > -    fst->cfg.buckets[THROTTLE_OPS_WRITE].burst_length =3D
> > -        qemu_opt_get_number(opts, "throttling.iops-write-max-length", =
1);
> > -    fst->cfg.op_size =3D
> > -        qemu_opt_get_number(opts, "throttling.iops-size", 0);
> > -
> > +    throttle_parse_options(&fst->cfg, opts);
> >      throttle_is_valid(&fst->cfg, errp);
> >  }
> > =20
> > diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
> > index e418643..c493e83 100644
> > --- a/fsdev/qemu-fsdev-throttle.h
> > +++ b/fsdev/qemu-fsdev-throttle.h
> > @@ -20,6 +20,7 @@
> >  #include "qemu/coroutine.h"
> >  #include "qapi/error.h"
> >  #include "qemu/throttle.h"
> > +#include "qemu/throttle-options.h" =20
>=20
> Why?
>=20

Yeah, looking at the previous hunk, I guess it should rather go to
fsdev/qemu-fsdev-throttle.c.

> > =20
> >  typedef struct FsThrottle {
> >      ThrottleState ts;
> > diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-op=
tions.h
> > index 3133d1c..565553a 100644
> > --- a/include/qemu/throttle-options.h
> > +++ b/include/qemu/throttle-options.h
> > @@ -10,6 +10,8 @@
> >  #ifndef THROTTLE_OPTIONS_H
> >  #define THROTTLE_OPTIONS_H
> > =20
> > +#include "qemu/throttle.h"
> > + =20
>=20
> Let's avoid this include: move the ThrottleConfig typedef to
> qemu/typedefs.h.
>=20
> >  #define THROTTLE_OPTS \
> >            { \
> >              .name =3D "throttling.iops-total",\
> > @@ -89,4 +91,6 @@
> >              .help =3D "when limiting by iops max size of an I/O in byt=
es",\
> >          }
> > =20
> > +void throttle_parse_options(ThrottleConfig *, QemuOpts *);
> > +
> >  #endif
> > diff --git a/util/throttle.c b/util/throttle.c
> > index 3570ed2..ebe9dd0 100644
> > --- a/util/throttle.c
> > +++ b/util/throttle.c
> > @@ -514,3 +514,53 @@ void throttle_account(ThrottleState *ts, bool is_w=
rite, uint64_t size)
> >      }
> >  }
> > =20
> > +/* parse the throttle options
> > + *
> > + * @opts: qemu options
> > + * @throttle_cfg: throttle configuration
> > + */
> > +void throttle_parse_options(ThrottleConfig *throttle_cfg, QemuOpts *op=
ts)
> > +{
> > +    throttle_config_init(throttle_cfg);
> > +    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].avg =3D
> > +        qemu_opt_get_number(opts, "throttling.bps-total", 0);
> > +    throttle_cfg->buckets[THROTTLE_BPS_READ].avg  =3D
> > +        qemu_opt_get_number(opts, "throttling.bps-read", 0);
> > +    throttle_cfg->buckets[THROTTLE_BPS_WRITE].avg =3D
> > +        qemu_opt_get_number(opts, "throttling.bps-write", 0);
> > +    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].avg =3D
> > +        qemu_opt_get_number(opts, "throttling.iops-total", 0);
> > +    throttle_cfg->buckets[THROTTLE_OPS_READ].avg =3D
> > +        qemu_opt_get_number(opts, "throttling.iops-read", 0);
> > +    throttle_cfg->buckets[THROTTLE_OPS_WRITE].avg =3D
> > +        qemu_opt_get_number(opts, "throttling.iops-write", 0);
> > +
> > +    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].max =3D
> > +        qemu_opt_get_number(opts, "throttling.bps-total-max", 0);
> > +    throttle_cfg->buckets[THROTTLE_BPS_READ].max  =3D
> > +        qemu_opt_get_number(opts, "throttling.bps-read-max", 0);
> > +    throttle_cfg->buckets[THROTTLE_BPS_WRITE].max =3D
> > +        qemu_opt_get_number(opts, "throttling.bps-write-max", 0);
> > +    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].max =3D
> > +        qemu_opt_get_number(opts, "throttling.iops-total-max", 0);
> > +    throttle_cfg->buckets[THROTTLE_OPS_READ].max =3D
> > +        qemu_opt_get_number(opts, "throttling.iops-read-max", 0);
> > +    throttle_cfg->buckets[THROTTLE_OPS_WRITE].max =3D
> > +        qemu_opt_get_number(opts, "throttling.iops-write-max", 0);
> > +
> > +    throttle_cfg->buckets[THROTTLE_BPS_TOTAL].burst_length =3D
> > +        qemu_opt_get_number(opts, "throttling.bps-total-max-length", 1=
);
> > +    throttle_cfg->buckets[THROTTLE_BPS_READ].burst_length  =3D
> > +        qemu_opt_get_number(opts, "throttling.bps-read-max-length", 1);
> > +    throttle_cfg->buckets[THROTTLE_BPS_WRITE].burst_length =3D
> > +        qemu_opt_get_number(opts, "throttling.bps-write-max-length", 1=
);
> > +    throttle_cfg->buckets[THROTTLE_OPS_TOTAL].burst_length =3D
> > +        qemu_opt_get_number(opts, "throttling.iops-total-max-length", =
1);
> > +    throttle_cfg->buckets[THROTTLE_OPS_READ].burst_length =3D
> > +        qemu_opt_get_number(opts, "throttling.iops-read-max-length", 1=
);
> > +    throttle_cfg->buckets[THROTTLE_OPS_WRITE].burst_length =3D
> > +        qemu_opt_get_number(opts, "throttling.iops-write-max-length", =
1);
> > +
> > +    throttle_cfg->op_size =3D
> > +        qemu_opt_get_number(opts, "throttling.iops-size", 0);
> > +} =20
>=20
> Looks good otherwise.


--Sig_/YzCw1YkDq+473fX510vhIAp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllL7xkACgkQAvw66wEB28KpYQCgpv9r/PiAJjnKd/dTNXT4QKTJ
MeMAniq/dvPLe08WVH7B6C75zNbzkBRb
=WFEo
-----END PGP SIGNATURE-----

--Sig_/YzCw1YkDq+473fX510vhIAp--
