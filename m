Received: from eggs.gnu.org ([2001:4830:134:3::10]:52214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc45-0001Yf-CZ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc41-0000Pq-80
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:16:29 -0400
References: <20170905191114.5959-1-eblake@redhat.com>
	<20170905191114.5959-2-eblake@redhat.com>
	<20170906085024.GB15510@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <586f8b2f-366f-bbf7-c209-12def49d58cc@redhat.com>
Date: Wed, 6 Sep 2017 10:16:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170906085024.GB15510@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fiW6rqqBaEVmE7sLCBgLSoLKSdBeXmw09"
Subject: Re: [Qemu-devel] [PATCH 1/3] io: Yield rather than wait when
 already in coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fiW6rqqBaEVmE7sLCBgLSoLKSdBeXmw09
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-block@nongnu.org
Message-ID: <586f8b2f-366f-bbf7-c209-12def49d58cc@redhat.com>
Subject: Re: [PATCH 1/3] io: Yield rather than wait when already in coroutine
References: <20170905191114.5959-1-eblake@redhat.com>
 <20170905191114.5959-2-eblake@redhat.com> <20170906085024.GB15510@redhat.com>
In-Reply-To: <20170906085024.GB15510@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 03:50 AM, Daniel P. Berrange wrote:
> On Tue, Sep 05, 2017 at 02:11:12PM -0500, Eric Blake wrote:
>> The new qio_channel_{read,write}{,v}_all functions are documented
>> as yielding until data is available.  When used on a blocking
>> channel, this yield is done via qio_channel_wait() which spawns
>> a new coroutine under the hood (so it is the new entry point that
>> yields as needed); but if we are already in a coroutine (at which
>=20
> qio_channel_wait doesn't spawn any coroutine - it simply rnus a
> nested event loop to wait for the channel...
>=20
>> point QIO_CHANNEL_ERR_BLOCK is only possible if we are a
>> non-blocking channel), we want to yield the current coroutine
>> instead of spawning a new one.
>=20
> ...none the less, I think this is ok.

Okay, tweaking the commit message:

    The new qio_channel_{read,write}{,v}_all functions are documented
    as yielding until data is available.  When used on a blocking
    channel, this yield is done via qio_channel_wait() which spawns
    a nested event loop under the hood (so it is that secondary loop
    which yields as needed); but if we are already in a coroutine (at
    which point QIO_CHANNEL_ERR_BLOCK is only possible if we are a
    non-blocking channel), we want to yield the current coroutine
    instead of spawning a nested event loop.

>=20
> Acked-by: Daniel P. Berrange <berrange@redhat.com>
>=20
> Regards,
> Daniel
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fiW6rqqBaEVmE7sLCBgLSoLKSdBeXmw09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwETwACgkQp6FrSiUn
Q2pAsgf/YpidaOzfmZZX29K9mrpV5B0sM9bqQmcxoT/WDy69stkQ6VcLF4oC2apD
fv1YXtg0kDO5PY7WrvfJ18beIZDcNMz7Uy1wPDYM5XwTUpCca1w5floQkJHSxbT5
y8/KS1o/mWbdlWs4Yq7Pe+QKECSrYi1z0HQ7e4YWg3E88zlm0ChhzGH+EBQsyXCj
+RL2FmN3EJEzIHD/Zl+OI2nTGMX0J4Ej+WZ/NVPwg0se75dMe3STj0AuiWqOj6Ci
HgYkleOZtj2D0NueNdjYcNwpO84lpTCafT2z7vmODvRcoL83lX+hi+4Rf1plHCNT
a2ZZvwuizEhR9nD9IA/og5SCS4aArA==
=/993
-----END PGP SIGNATURE-----

--fiW6rqqBaEVmE7sLCBgLSoLKSdBeXmw09--
