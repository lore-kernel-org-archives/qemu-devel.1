Received: from eggs.gnu.org ([2001:4830:134:3::10]:33453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT8iJ-0007x4-W6
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT8iG-0001BY-Lp
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dT8iG-0001Az-Bx
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:29:04 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <744db82a-aba2-3c1f-2dd5-35fb48f465c6@redhat.com>
Date: Thu, 6 Jul 2017 10:28:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170621153424.16690-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n5JVfkc8TjMIRRqgqTXEc6roUtuCJGOfi"
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
--n5JVfkc8TjMIRRqgqTXEc6roUtuCJGOfi
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <744db82a-aba2-3c1f-2dd5-35fb48f465c6@redhat.com>
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
>=20
> Recompilation with CFLAGS=3D-DDEBUG_NBD is no more needed, furthermore,=

> DEBUG_NBD macro is removed from the code.
>=20

> +++ b/nbd/server.c
> @@ -19,6 +19,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "trace.h"
>  #include "nbd-internal.h"
> =20
>  static int system_errno_to_nbd_errno(int err)
> @@ -138,8 +139,7 @@ static int nbd_negotiate_send_rep_len(QIOChannel *i=
oc, uint32_t type,
>  {
>      uint64_t magic;
> =20
> -    TRACE("Reply opt=3D%" PRIx32 " type=3D%" PRIx32 " len=3D%" PRIu32,=

> -          type, opt, len);
> +    trace_nbd_negotiate_send_rep_len(type, opt, len);

Eww. The old code is backwards (prints "opt=3D<type>, type=3D<opt>").  It=

makes sense to print opt first.

> +# nbd/server.c
> +nbd_negotiate_send_rep_len(uint32_t type, uint32_t opt, uint32_t len) =
"Reply opt=3D%" PRIx32 " type=3D%" PRIx32 " len=3D%" PRIu32

It may also make sense to split the fixup of the backwards printout as a
separate patch, so that it doesn't get lost in the noisse of the bulk
conversion.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--n5JVfkc8TjMIRRqgqTXEc6roUtuCJGOfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXlc2AAoJEKeha0olJ0NqhoIH/AyoGEOF40aR0GgfpL7FeLwG
Ea/NGdAFJqkl7zq6zaBq6UuDBR+Vz2NUV7Z7M3g5efc43/ZKCy8leV+fvdwbY+pI
c8N6rNhFTr+L9oD2NWaH/QDVQnfiQHRtVHZ8Sx2F8PCHPcaTWkhGkCm10pGlt4kR
ythfTPV7eWMWypfCe4BrmfMnOpvstZxjB0Pk5l2DhtNQWpJWmQUnx7zRjEHvpqCd
u7vFCIU3Cy6pAOGvtCsWGESqnOIgowKccI9RjRZzANMOKx3AOkA+QRpErNCR5X1E
1NM3M85XkRF3tPrt3y6gyVwBFn5iLiPFxevDvbL8a/rQ0z3p8QxaNczCQiNrX24=
=StOK
-----END PGP SIGNATURE-----

--n5JVfkc8TjMIRRqgqTXEc6roUtuCJGOfi--
