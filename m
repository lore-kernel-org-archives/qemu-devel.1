Received: from eggs.gnu.org ([209.51.188.92]:53081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjm6o-0001tQ-Jl
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjm6n-0001fD-QB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:23:58 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-6-eblake@redhat.com>
	<acc77355-221d-0497-4b14-6b3c1bb79c7d@virtuozzo.com>
	<f42d51fa-1268-0abf-11b8-7661655e995d@redhat.com>
	<205453e1-a4b3-6296-e4e9-92337ba83eb3@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29fc3dc8-db53-e6be-6915-7626ef8f63ce@redhat.com>
Date: Wed, 16 Jan 2019 08:23:52 -0600
MIME-Version: 1.0
In-Reply-To: <205453e1-a4b3-6296-e4e9-92337ba83eb3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LEE4BIv08HxABOrB3cKYGcic0wjXamwTt"
Subject: Re: [Qemu-devel] [PATCH v3 05/19] nbd/server: Favor [u]int64_t over
 off_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LEE4BIv08HxABOrB3cKYGcic0wjXamwTt
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <29fc3dc8-db53-e6be-6915-7626ef8f63ce@redhat.com>
Subject: Re: [PATCH v3 05/19] nbd/server: Favor [u]int64_t over off_t
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-6-eblake@redhat.com>
 <acc77355-221d-0497-4b14-6b3c1bb79c7d@virtuozzo.com>
 <f42d51fa-1268-0abf-11b8-7661655e995d@redhat.com>
 <205453e1-a4b3-6296-e4e9-92337ba83eb3@virtuozzo.com>
In-Reply-To: <205453e1-a4b3-6296-e4e9-92337ba83eb3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/16/19 2:23 AM, Vladimir Sementsov-Ogievskiy wrote:

>=20
> Interesting, decided to search a bit, about don't we have an overflow,
> when adding request.offset to exp.dev_offset and found in nbd_co_receiv=
e_request:
>=20
>      if (request->from > client->exp->size ||
>          request->from + request->len > client->exp->size) {

uint64_t + uint32_t > uint64_t

>=20
> shouldn't it be
>=20
>      if (request->from > client->exp->size ||
>          request->len > client->exp->size - request->from) {
>=20
> to avoid overflow?

You are correct that the canonical way to check for overflow is to
compare against subtraction, rather than do addition before compare.
But we got lucky: even though client->exp->size is uint64_t, in practice
it can only represent at most off_t (remember, off_t is signed), so the
first leg of the branch proves that request->from fits in 63 bits, and
thus the second is performing 63-bit + 32-bit which can be at most 64
bits, and therefore does not overflow.  Still, I might rewrite it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--LEE4BIv08HxABOrB3cKYGcic0wjXamwTt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/PngACgkQp6FrSiUn
Q2oynQf/YLTFKQb1yWZBU2VuD3Yo3QtVRzxWrzl3oV2C0zQC4VgrwdmA8cWNTyt9
DDvFqVaAJ1CGt0iCmWcGHAEdwlpU5LpYVOakPRU16LWxTcONek6rj+jXGCWl5yX1
rZ7I7Go48La90KuvjVNcS6Kb/ZfTqreBA2jBnvr3/VJWkhYWsoLXwQLnZk5XU1hP
bFBgfiqLnA+CwuqnMCXRum2tE/0MFCyZgFhYdi+/rD/Lk/kKZTyuvalidKgxNw6Z
hfjSua0n1Z6PhBuoYNDnAxQTAW6wBO9M40yLHOo2NmTRRNxAhiPp8u15r3GBzzKH
x+ZXkAwoN+EG+c1ARHuBBlHRActFSw==
=w1H6
-----END PGP SIGNATURE-----

--LEE4BIv08HxABOrB3cKYGcic0wjXamwTt--
