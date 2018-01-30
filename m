Received: from eggs.gnu.org ([2001:4830:134:3::10]:41555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egYbn-0000mj-Ps
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egYbj-0005Zm-OG
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:18:07 -0500
References: <20180130150435.2553-1-berto@igalia.com>
	<b93f21cf-5cd4-a6d0-7005-e19a3de211c8@redhat.com>
	<w51607juy5j.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <62e23e8c-9873-9fa2-c70f-c823d64f4415@redhat.com>
Date: Tue, 30 Jan 2018 10:17:47 -0600
MIME-Version: 1.0
In-Reply-To: <w51607juy5j.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nY42jLoykiSfXwtULHN1I9rUSwb3ZugVh"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Replace align_offset() with
 ROUND_UP()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nY42jLoykiSfXwtULHN1I9rUSwb3ZugVh
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <62e23e8c-9873-9fa2-c70f-c823d64f4415@redhat.com>
Subject: Re: [PATCH] qcow2: Replace align_offset() with ROUND_UP()
References: <20180130150435.2553-1-berto@igalia.com>
 <b93f21cf-5cd4-a6d0-7005-e19a3de211c8@redhat.com>
 <w51607juy5j.fsf@maestria.local.igalia.com>
In-Reply-To: <w51607juy5j.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 10:08 AM, Alberto Garcia wrote:
> On Tue 30 Jan 2018 05:03:16 PM CET, Eric Blake wrote:
>=20
>>> -    virtual_size =3D align_offset(qemu_opt_get_size_del(opts, BLOCK_=
OPT_SIZE, 0),
>>> +    virtual_size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_=
SIZE, 0),
>>>                                  cluster_size);
>=20
> I just realized that the first parameter here is a function call with
> side effects, it it safe to use ROUND_UP() in this case?
>=20
> #define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))

Oh, good catch.  No, we need a temporary variable to hold the result of
the function call (or we could rewrite ROUND_UP to have evaluate-once
semantics using gcc/clang extensions).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nY42jLoykiSfXwtULHN1I9rUSwb3ZugVh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwmqsACgkQp6FrSiUn
Q2rNVAf+MTaVoqtO7YFnwRt0lt1hmi9PKZfRX3o0GKzjRy+c+JagVf5ObBZuIOjW
FhHFag2ei+zKhL+9abPY+TKwYVMgAYPtsP0w4FJiOjcd1KQpVmOqUxUqLoumXEfj
z20Xn6FNNX9bmOquBPCqPeBAAE7taSIgV8PKbg/34DK3NXvr8mkQbdgDFi0F+W9Q
2U8TLpJ1VFdj+WsvpmTNyL4W3Uby2CuF7g17C1RB5wrlFQva0nfLqlwmL96noiKp
ReNX0q5CHEHTaDZgMkGUVv02cUuB72vEMMIsCFS3DU1fKWVQMOh70/v86H9SdbPi
o9eJDCJMRucB42m8wGy6qm1PllIyew==
=+Ve0
-----END PGP SIGNATURE-----

--nY42jLoykiSfXwtULHN1I9rUSwb3ZugVh--
