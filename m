Received: from eggs.gnu.org ([2001:4830:134:3::10]:35313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvOrt-0005O6-AE
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvOrq-0002D4-8t
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:51:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cvOrp-0002Co-WC
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:51:30 -0400
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<20170403130041.GD5036@noname.str.redhat.com>
	<20170403135012.GY26598@andariel.pipo.sk>
	<20170404121624.GA4536@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0563cea6-064b-5151-f23b-74fa394242c1@redhat.com>
Date: Tue, 4 Apr 2017 08:51:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170404121624.GA4536@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Jh8pEP7viTUV3LhNXdVoSP4iEJFgeTqmq"
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jh8pEP7viTUV3LhNXdVoSP4iEJFgeTqmq
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alexandru Avadanii <Alexandru.Avadanii@enea.com>,
 Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 svc-armband <armband@enea.com>
Message-ID: <0563cea6-064b-5151-f23b-74fa394242c1@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
 <9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
 <20170403081542.GA5036@noname.str.redhat.com>
 <33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
 <20170403130041.GD5036@noname.str.redhat.com>
 <20170403135012.GY26598@andariel.pipo.sk>
 <20170404121624.GA4536@noname.str.redhat.com>
In-Reply-To: <20170404121624.GA4536@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/04/2017 07:16 AM, Kevin Wolf wrote:

>=20
> Now the big question is how to implement this. Just not requesting the
> write permission initially if runstate_check(RUN_STATE_INMIGRATE) is
> easy. But we need to find a place to actually request it later, after
> the mirror has completed, and before the VM is running.
>=20
> My first thought was that we could add a VMChangeStateHandler and just
> request the permission in there. However, requesting the permission can=

> fail (e.g. because the NBD server hasn't been shut down) and we can't
> let a state transition fail from a VMChangeStateHandler.
>=20
> Maybe the next best thing we could do is to have a BlockDevOps callback=

> for invalidate_cache/inactivate and get the permissions there. This one=

> could return an error, which would be passed up the stack and eventuall=
y
> cause qmp_cont() to fail (i.e. it would refuse to resume the VM). This
> sounds workable to me.

Having 'cont' refuse when write permissions can't be grabbed after all
sounds reasonable (assuming, of course, that the common case is that the
invalidate_cache/inactivate call that triggers the callback will
normally succeed, because it means the source is now done and the
destination _should_ be able to get write access at that point).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Jh8pEP7viTUV3LhNXdVoSP4iEJFgeTqmq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY46TcAAoJEKeha0olJ0NqvRAIAJBWrVWoRwNiuOZrEnKdGK91
YXpqg4fIZZkXP5OQrUTrLRF1a58wHH4qnq3xLOh9AVXS/GuzUVFKPyR5XvYOk7e9
eSionmtO9TB1PBJrw1pwwQO+2SymDiK0VqRhcnW/f12IF6QFu8LGbS/C6hHUXB7J
bgv821qyUSP/klZq8ZNlHUPJwsSUYDbSCMw8DdpkaMrieaWWL+LXZRxCNdPXdqB+
cEpjrRQswzR7yIr5xxtPSpB1rnt/H/9hU0E0pIAhnhR5ulMZ2pyrtU5y9Fci8V10
GLcP2u2PFdMNANuua9LpKxoNa9mOhn8zKpTbfSFwKWQqgDsWBqqs9lV7BP8dqtk=
=en1I
-----END PGP SIGNATURE-----

--Jh8pEP7viTUV3LhNXdVoSP4iEJFgeTqmq--
