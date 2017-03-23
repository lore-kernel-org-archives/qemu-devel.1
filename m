Received: from eggs.gnu.org ([2001:4830:134:3::10]:57725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr40v-0006Sy-Km
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr40s-0003J7-Fl
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:46:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr40s-0003J1-6N
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:46:54 -0400
References: <1490271635-19049-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1490271635-19049-2-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29981b93-8870-eab7-bbc7-263448efb2ab@redhat.com>
Date: Thu, 23 Mar 2017 09:46:51 -0500
MIME-Version: 1.0
In-Reply-To: <1490271635-19049-2-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r4vQ1jiX8DNVUmQL0em4n1vOQjtN0u2EK"
Subject: Re: [Qemu-devel] [PATCH 2/2 v1] throttle: factor out the redundant
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Alberto Garcia <berto@igalia.com>, Jani Kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r4vQ1jiX8DNVUmQL0em4n1vOQjtN0u2EK
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Alberto Garcia <berto@igalia.com>, Jani Kokkonen <jani.kokkonen@huawei.com>,
 qemu-devel@nongnu.org
Message-ID: <29981b93-8870-eab7-bbc7-263448efb2ab@redhat.com>
Subject: Re: [PATCH 2/2 v1] throttle: factor out the redundant code
References: <1490271635-19049-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1490271635-19049-2-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1490271635-19049-2-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 07:20 AM, Pradeep Jagadeesh wrote:
> This patchset removes the throttle redundant code that was present
> in block and fsdev files.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---

I think you want portions of this patch to come first; you want to
refactor out the IOThrottle portion of existing types, and then extend
IOThrottle to be used in more places.

>  blockdev.c                      | 106 ++++----------------------------=
-------
>  fsdev/Makefile.objs             |   1 +
>  fsdev/qemu-fsdev-throttle.c     |  94 +-------------------------------=
--
>  fsdev/qemu-fsdev-throttle.h     |   3 +-
>  hmp.c                           |  39 +++++++--------
>  include/qemu/throttle-options.h |   5 ++
>  qapi/block-core.json            |  76 +---------------------------
>  qapi/iothrottle.json            |   4 +-
>  util/Makefile.objs              |   1 +
>  util/throttle-options.c         | 108 ++++++++++++++++++++++++++++++++=
++++++++
>  10 files changed, 151 insertions(+), 286 deletions(-)
>  create mode 100644 util/throttle-options.c
>=20

> +++ b/fsdev/qemu-fsdev-throttle.c
> @@ -33,56 +33,7 @@ void fsdev_set_io_throttle(IOThrottle *arg, FsThrott=
le *fst, Error **errp)
>  {
>      ThrottleConfig cfg;
> =20
> -    throttle_config_init(&cfg);
> -    cfg.buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps;
> -    cfg.buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_rd;
> -    cfg.buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_wr;
> -

This code was added in the last patch - which makes for a lot of
unnecessary churn.  Again, the best series does refactoring of existing
code first, then adds the new code that takes advantage of the
refactored entry points, so that the new code isn't churning.


> +++ b/hmp.c
> @@ -1554,20 +1554,25 @@ void hmp_change(Monitor *mon, const QDict *qdic=
t)
>      hmp_handle_error(mon, &err);
>  }
> =20
> +static void hmp_initialize_io_throttle(IOThrottle *iot, const QDict *q=
dict)
> +{
> +    iot->has_device =3D true;
> +    iot->device =3D (char *) qdict_get_str(qdict, "device");

Is casting away const going to result in a double free of memory later
on?  Or put another way, should this be a g_strdup'd copy (which you
then have to make sure is not leaked)?

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
> -    BlockIOThrottle throttle =3D {
> -        .has_device =3D true,
> -        .device =3D (char *) qdict_get_str(qdict, "device"),

At any rate, I see it is just code motion.  You are refactoring too much
in one patch here; I'd consider splitting it along the lines of one
patch that adds hmp_initialize_io_throttle; and another patch that adds
parse_io_throttle_options(), so that it's easier to see just one piece
of code motion at a time, rather than trying to track multiple motions
in the same large patch.

> +++ b/qapi/block-core.json
> @@ -1758,86 +1758,14 @@
>  #
>  # A set of parameters describing block throttling.
>  #

> -# @iops_size: an I/O size in bytes (Since 1.7)
> +# @iothrottle: throttle configuration (Since 1.7)

NACK. This is an incompatible change; you are breaking the QMP wire
structure (that is, where I used to pass "arguments":{"device":"foo",
"bps_rd":1, "group":"bar" }, your change would now require me to pass
"arguments":{"iothrottle":{"device":"foo", "bps_rd":1}, "group":"bar"};
the extra nesting is what breaks things).

>  #
>  # @group: throttle group name (Since 2.4)
>  #
>  # Since: 1.1
>  ##
>  { 'struct': 'BlockIOThrottle',
> -  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'i=
nt',
> -            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr=
': 'int',
> -            '*bps_max': 'int', '*bps_rd_max': 'int',
> -            '*bps_wr_max': 'int', '*iops_max': 'int',
> -            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> -            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> -            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> -            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int'=
,
> -            '*iops_size': 'int', '*group': 'str' } }
> +  'data': { '*iothrottle': 'IOThrottle', '*group': 'str' } }

What you REALLY want is a compatible change, namely:

{ 'struct': 'BlockIOThrottle', 'base': 'IOThrottle',
  'data': { '*group': 'str' } }

which says that all fields of IOThrottle are inherited at the same level
as the additional field 'group'.

For that matter, are you sure that 'group' is the only field that should
not be directly in IOThrottle, or should 'device' also be specific to
BlockIOThrottle (I'm not sure whether you were actually using 'device'
in the fsdev case, or if 'id' was sufficient).

> =20
>  ##
>  # @block-stream:
> diff --git a/qapi/iothrottle.json b/qapi/iothrottle.json
> index f7b615d..58f4520 100644
> --- a/qapi/iothrottle.json
> +++ b/qapi/iothrottle.json
> @@ -14,6 +14,8 @@
>  #
>  # @device: Block device name
>  #
> +# @id: The name or QOM path of the guest device (since: 2.8)
> +#

You've missed 2.8 by a long shot.  Oh - this is an argument that it is
'id' (and not 'device') that does not belong here, but should be placed
alongside 'group' in the BlockIOThrottle subtype.

>  # @bps: total throughput limit in bytes per second
>  #
>  # @bps_rd: read throughput limit in bytes per second
> @@ -80,7 +82,7 @@
>  # Since: 2.10
>  ##
>  { 'struct': 'IOThrottle',
> -  'data': { '*device': 'str', 'bps': 'int', 'bps_rd': 'int',
> +  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'i=
nt',
>              'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr=
': 'int',
>              '*bps_max': 'int', '*bps_rd_max': 'int',
>              '*bps_wr_max': 'int', '*iops_max': 'int',


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--r4vQ1jiX8DNVUmQL0em4n1vOQjtN0u2EK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY09/bAAoJEKeha0olJ0NqHXkH/jBJPfw1gIugUr+w35ir5Q2X
hzKCzMWrvVwMAJ0T8EYI0y2ayPbC0Ec8nFFb4w//hIXoi+wVy+kI3JSgPjptYQt0
Bh22dpBbPvxA0Vfy9PuNEzw/B6v8WobuY4jaykJBykw34AWUWS32KZHch2I+iA+/
G1VGp0hB00Q03Jfyq3Ta52SDw2UA3gK7ihFHkWRidd/KWnAzAd41JCzqgCFFOgn8
3CZ+bwlrPMXk0O3mHUdXu/eFodM+1F61ay+Ck7QDmFpL7tRcAnS+BBZcQLx+qFvT
zvQelP7dQEcgQ+pGBxPV5EufWXuvJxHI3ClvQTFn+uZiKc4Ld3sxsPD6XrCngQ4=
=UBxY
-----END PGP SIGNATURE-----

--r4vQ1jiX8DNVUmQL0em4n1vOQjtN0u2EK--
