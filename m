Received: from eggs.gnu.org ([2001:4830:134:3::10]:39360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgCTS-000092-Cq
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgCTO-00009q-Cf
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:07:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dgCTO-00008m-49
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:07:42 -0400
References: <20170811023759.26390-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4015b150-ca85-06a8-d922-80048980559c@redhat.com>
Date: Fri, 11 Aug 2017 11:07:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170811023759.26390-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5FuBF59jhDXHfC3L3RK60oiQuRqQxXK1A"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] Fix NBD client after server
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5FuBF59jhDXHfC3L3RK60oiQuRqQxXK1A
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com
Message-ID: <4015b150-ca85-06a8-d922-80048980559c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] Fix NBD client after server
 error
References: <20170811023759.26390-1-eblake@redhat.com>
In-Reply-To: <20170811023759.26390-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 09:37 PM, Eric Blake wrote:
> Patch 1 is a much smaller patch than Vladimir's attempt [1] at fixing
> the client in the face of a malicious server.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01501.html=

>=20
> Patch 2 is not to be applied; it is a hack for easily creating a
> malicious server; by setting NBD_SERVER_DEBUG to a positive integer,
> the server will intentionally send bad magic when it reaches that
> many replies.
>=20
> I tested using:
>  NBD_SERVER_DEBUG=3D1 ./qemu-nbd -f raw -x foo file
> coupled with
>  qemu-io -c 'r 0 1' -c 'r 0 1' -f raw nbd://localhost:10809/foo
>=20
> Without the patch, the qemu-io client hangs; with the patch, the
> client reports 'read failed: Input/output error' for the first read
> (where the bad server was detected) and 'read failed: Broken pipe'
> for the second (because the client has already dropped the
> connection from the bad server).

I've also confirmed that this is a regression from our 2.8 release
(introduced when 2.9 switched NBD to use coroutines).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5FuBF59jhDXHfC3L3RK60oiQuRqQxXK1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmN1kkACgkQp6FrSiUn
Q2rHFQf8DYQ0xNe8J8w6SxOQezXU3MUj77/Dir2Z7bauqO3tjCUqOS/05UYCZt5X
CpM0Px+7PGZsJ74ogHVzodAogl9SnubaQPqMykZPYlygeDxWt9zfZ4oTE+VYvq7D
PuX30tAcnm67xgMolKjYi6BMetpolhVYALmRmR5Aq2rm1c12VdcKJAF7TVodKgw5
ubUjZ5D5V5zeAEjdLzOoAeR3uKNrqXboJ0sjbTpJHV9lEepis37/oQLIcD50caC8
kV5gIKiYiNw8be50rvBFjreaX1jaxU2VFv79uM50iTN2+gPA8H8zUHEgSkdJ6QVn
WyfcJsWiU+ePyZAQNbOLEbxOcLq/fQ==
=ud7m
-----END PGP SIGNATURE-----

--5FuBF59jhDXHfC3L3RK60oiQuRqQxXK1A--
