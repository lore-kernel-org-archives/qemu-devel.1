Received: from eggs.gnu.org ([2001:4830:134:3::10]:49438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5g3L-0006Km-3o
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5g3H-0003sT-UA
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:13:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d5g3H-0003sL-Kf
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:13:47 -0400
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1493735386-39622-3-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4ccaf863-4c73-e168-3c09-c916a6aaa75e@redhat.com>
Date: Tue, 2 May 2017 17:13:43 -0500
MIME-Version: 1.0
In-Reply-To: <1493735386-39622-3-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QcWTXlg5FnTjk5DD9EtoEwMm3uavA2S3r"
Subject: Re: [Qemu-devel] [PATCH v3 2/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QcWTXlg5FnTjk5DD9EtoEwMm3uavA2S3r
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>,
 qemu-devel@nongnu.org
Message-ID: <4ccaf863-4c73-e168-3c09-c916a6aaa75e@redhat.com>
Subject: Re: [PATCH v3 2/4] fsdev: QMP interface for throttling
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1493735386-39622-3-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1493735386-39622-3-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/02/2017 09:29 AM, Pradeep Jagadeesh wrote:
> This patchset enables qmp interfaces for the fsdev
> devices. This provides two interfaces one=20
> for querying info of all the fsdev devices. The second one
> to set the IO limits for the required fsdev device.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---

> +++ b/fsdev/qemu-fsdev-throttle.c
> @@ -29,6 +29,102 @@ static void fsdev_throttle_write_timer_cb(void *opa=
que)
>      qemu_co_enter_next(&fst->throttled_reqs[true]);
>  }
> =20
> +void fsdev_set_io_throttle(IOThrottle *arg, FsThrottle *fst, Error **e=
rrp)
> +{
> +    ThrottleConfig cfg;
> +
> +    throttle_config_init(&cfg);
> +    cfg.buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps;
> +    cfg.buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_rd;
> +    cfg.buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_wr;
> +
> +    cfg.buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops;
> +    cfg.buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_rd;
> +    cfg.buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_wr;
> +
> +    if (arg->has_bps_max) {
> +        cfg.buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_max;
> +    }

Should the bulk of this be replaced by a call to a common IOThrottle
helper function, rather than open-coded duplication?


> +
> +void fsdev_get_io_throttle(FsThrottle *fst, IOThrottle **fs9pcfg,
> +                           char *fsdevice, Error **errp)
> +{
> +
> +    ThrottleConfig cfg =3D fst->cfg;
> +    IOThrottle *fscfg =3D g_malloc0(sizeof(*fscfg));
> +
> +    fscfg->has_id =3D true;
> +    fscfg->id =3D g_strdup(fsdevice);
> +    fscfg->bps =3D cfg.buckets[THROTTLE_BPS_TOTAL].avg;
> +    fscfg->bps_rd =3D cfg.buckets[THROTTLE_BPS_READ].avg;
> +    fscfg->bps_wr =3D cfg.buckets[THROTTLE_BPS_WRITE].avg;

Shouldn't you be setting has_bps, has_bps_rd, has_bps_wr, and so on, to
true?


> +++ b/fsdev/qemu-fsdev-throttle.h
> @@ -19,7 +19,14 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/coroutine.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
>  #include "qemu/throttle.h"
> +#include "qapi/qmp/types.h"
> +#include "qapi-visit.h"
> +#include "qapi/qobject-output-visitor.h"
> +#include "qapi/util.h"
> +#include "qmp-commands.h"
> +#include "qemu/throttle-options.h"
> =20
>  typedef struct FsThrottle {
>      ThrottleState ts;
> @@ -36,4 +43,10 @@ void coroutine_fn fsdev_co_throttle_request(FsThrott=
le *, bool ,
>                                              struct iovec *, int);
> =20
>  void fsdev_throttle_cleanup(FsThrottle *);
> +
> +void fsdev_set_io_throttle(IOThrottle *, FsThrottle *, Error **);

Even though it's not necessary per C, we tend to spell parameter names
in function declarations as it aids legibility.  (Seeing 'Error **' is
weird compared to the usual 'Error **errp')


> @@ -1570,6 +1571,80 @@ void hmp_block_set_io_throttle(Monitor *mon, con=
st QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
> =20
> +#ifdef CONFIG_VIRTFS
> +
> +void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err =3D NULL;
> +    IOThrottle throttle =3D {
> +        .has_id =3D true,
> +        .id =3D (char *) qdict_get_str(qdict, "id"),
> +        .bps =3D qdict_get_int(qdict, "bps"),
> +        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
> +        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
> +        .iops =3D qdict_get_int(qdict, "iops"),
> +        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
> +        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),

Again, don't you need to be setting .has_bps=3Dtrue and so on?


> +++ b/qapi/fsdev.json
> @@ -0,0 +1,84 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# =3D=3D QAPI fsdev definitions
> +##
> +
> +# QAPI common definitions
> +{ 'include': 'iothrottle.json' }
> +
> +##
> +# @fsdev-set-io-throttle:
> +#
> +# Change I/O limits for a 9p/fsdev device.
> +#
> +# I/O limits can be enabled by setting throttle value to non-zero numb=
er.
> +#
> +# I/O limits can be disabled by setting all throttle values to 0.
> +#
> +# Returns: Nothing on success
> +#          If @device is not a valid fsdev device, DeviceNotFound
> +#
> +# Since: 2.10
> +#
> +# Example:
> +#
> +# -> { "execute": "fsdev-set-io-throttle",
> +#      "arguments": { "id": "id0-1-0",
> +#                     "bps": 1000000,
> +#                     "bps_rd": 0,
> +#                     "bps_wr": 0,
> +#                     "iops": 0,
> +#                     "iops_rd": 0,
> +#                     "iops_wr": 0,
> +#                     "bps_max": 8000000,
> +#                     "bps_rd_max": 0,
> +#                     "bps_wr_max": 0,
> +#                     "iops_max": 0,
> +#                     "iops_rd_max": 0,
> +#                     "iops_wr_max": 0,
> +#                     "bps_max_length": 60,
> +#                     "iops_size": 0 } }
> +# <- { "returns": {} }
> +##
> +{ 'command': 'fsdev-set-io-throttle', 'boxed': true,
> +  'data': 'IOThrottle' }

This part looks okay.

> +##
> +# @query-fsdev-io-throttle:
> +#
> +# Returns: a list of @IOThrottle describing io throttle values of each=
 fsdev device
> +#
> +# Since: 2.10
> +#
> +# Example:
> +#
> +# -> { "Execute": "query-fsdev-io-throttle" }
> +# <- { "returns" : [
> +#          {
> +#             "id": "id0-hd0",
> +#              "bps":1000000,
> +#              "bps_rd":0,
> +#              "bps_wr":0,
> +#              "iops":1000000,
> +#              "iops_rd":0,
> +#              "iops_wr":0,
> +#              "bps_max": 8000000,
> +#              "bps_rd_max": 0,
> +#              "bps_wr_max": 0,
> +#              "iops_max": 0,
> +#              "iops_rd_max": 0,
> +#              "iops_wr_max": 0,
> +#              "bps_max_length": 0,
> +#              "bps_rd_max_length": 0,
> +#              "bps_wr_max_length": 0,
> +#              "iops_max_length": 0,
> +#              "iops_rd_max_length": 0,
> +#              "iops_wr_max_length": 0,
> +#              "iops_size": 0
> +#            }
> +#          ]
> +#      }
> +#
> +##
> +{ 'command': 'query-fsdev-io-throttle', 'returns': [ 'IOThrottle' ] }
> +
> diff --git a/qapi/iothrottle.json b/qapi/iothrottle.json
> index 124ab40..698d4bc 100644
> --- a/qapi/iothrottle.json
> +++ b/qapi/iothrottle.json
> @@ -3,6 +3,7 @@
>  ##
>  # =3D=3D QAPI IOThrottle definitions
>  ##
> +##
>  # @IOThrottle:

This looks like a spurious change

>  #
>  # A set of parameters describing iothrottle
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QcWTXlg5FnTjk5DD9EtoEwMm3uavA2S3r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCQSXAAoJEKeha0olJ0Nqfs4H/i75m3OpoMynh538sVlw8Tdw
3a6+j/ukzvXQJN00lVcKzSCsuDy/Y9scsFGKG5tEuXxRpGXcqteH/mqJ5rZhcFk0
dVlZDWhw15IiFaTdcNssMHXPmuQwLIMgA7ZU3eL8to8jT52ololIxuKuDneuID71
g3R62Iq89nvIHJt3xPcGDmAq2t/o+pbnL0CKX3HS1zziT/xZxaG6oqdODGDA6HfE
04EJ6uZnl+lGpOt5/0iEhnLivJ3VE/7DuAiz+uXOAFVc6C+tH2/7rdaoAveEevYA
MaBSRuhS629h9wHvrk/WCHXy6Hnol1pxnaD7goxLNp4r4+juW9XJ5hmeY0o2dHI=
=O2G5
-----END PGP SIGNATURE-----

--QcWTXlg5FnTjk5DD9EtoEwMm3uavA2S3r--
