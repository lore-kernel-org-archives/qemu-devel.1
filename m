Received: from eggs.gnu.org ([2001:4830:134:3::10]:39023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQfoH-000105-AU
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQfoD-0002gb-55
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:13:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQfoC-0002gE-RY
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:13:01 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac4e0a9b-1846-86b2-1e78-f8ae6a61c3ec@redhat.com>
Date: Thu, 29 Jun 2017 15:12:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170621153424.16690-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DqVaLrph7xmqWR15Xjc1Gf8iKodQw6O6s"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] nbd: use generic trace subsystem
 instead of TRACE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DqVaLrph7xmqWR15Xjc1Gf8iKodQw6O6s
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <ac4e0a9b-1846-86b2-1e78-f8ae6a61c3ec@redhat.com>
Subject: Re: [PATCH v2 6/6] nbd: use generic trace subsystem instead of TRACE
 macro
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> Starting from this patch to enable traces use -trace option of qemu or
> -T, --trace option of qemu-img, qemu-io and qemu-nbd. For qemu traces
> also can be managed by qmp commands trace-event-{get,set}-state.

Maybe:

Let NBD use the trace mechanisms already present in qemu. Now you can
use the -trace optino of qemu, or the -T/--trace option of qemu-img,
qemu-io, and qemu-nbd, to select nbd traces.  For qemu, the QMP commands
trace-event-{get,set}-state can also toggle tracing on the fly.

I also mentioned in v1 that an actual command line example might be
helpful (for example, is it qemu-nbd --trace "nbd_*" to get ALL nbd
traces enabled?)

>=20
> Recompilation with CFLAGS=3D-DDEBUG_NBD is no more needed, furthermore,=

> DEBUG_NBD macro is removed from the code.

Yay!

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


> @@ -462,7 +460,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
> =20
>      memcpy(&nbd_magic, buf, 8);
>      nbd_magic =3D be64_to_cpu(nbd_magic);
> -    TRACE("Magic is 0x%" PRIx64, nbd_magic);
> +    trace_nbd_receive_negotiate_magic(nbd_magic);

Might be some churn based on the resolution to 5/6.

> =20
>      if (memcmp(buf, "NBDMAGIC", 8) !=3D 0) {
>          error_setg(errp, "Invalid magic received");
> @@ -474,7 +472,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const ch=
ar *name, uint16_t *flags,
>          goto fail;
>      }
>      magic =3D be64_to_cpu(magic);
> -    TRACE("Magic is 0x%" PRIx64, magic);
> +    trace_nbd_receive_negotiate_magic2(magic);

I'm not sure you need two different trace functions, since the message
is identical.  I'd just have trace_nbd_receive_magic(magic) and use that
at both call sites.

But overall worth having, even if we fine-tune it later.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DqVaLrph7xmqWR15Xjc1Gf8iKodQw6O6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVV9GAAoJEKeha0olJ0NqnYQH/29th8T2TV2JNJbBdn5DOp2V
TOWvqLJIqdZCGfzn9MQqAzboGM3EWAa2Jx+i1z/ihazHYA5SUAQbbcMhDBmjShDc
GDQqMpBZ+pOf6hvRu+z59/r2tjKHSBahQHPXQ2YedbdEFBNV6XYDfIkTGXrTonsq
HtalvT/raH5gCFjbzSHTqbOrwdfzg9rBS3EZiLO7P65i163CGcwmx6hUHf4McnBO
HctxJQW1C7dfAdmrCXAQfroAWMkZOgb4NoyavpSQqoPiOv0+fmHcjJkJgEnjmbhr
jBJqYTRhd10SOZkbsClCIkIeLLsF+2nryQfqzBJd/K3igftJaM3Zzkcvq1N2090=
=itIb
-----END PGP SIGNATURE-----

--DqVaLrph7xmqWR15Xjc1Gf8iKodQw6O6s--
