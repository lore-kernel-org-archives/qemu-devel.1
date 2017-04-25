Received: from eggs.gnu.org ([2001:4830:134:3::10]:34473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d35jx-0001Ne-Nb
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d35jt-0001IV-KO
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:03:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9415)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d35jt-0001Hd-BW
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:03:05 -0400
References: <e3fd9c8b-8976-eb31-4092-887e94f4a5ae@web.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <130b5ca0-e865-e341-d271-a323a52c9ee9@redhat.com>
Date: Tue, 25 Apr 2017 14:03:00 -0500
MIME-Version: 1.0
In-Reply-To: <e3fd9c8b-8976-eb31-4092-887e94f4a5ae@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XCqL7ucB5VrNt6KMqkU2Fnj2Dgiuri5hJ"
Subject: Re: [Qemu-devel] [PATCH v3] crypto: qcrypto_random_bytes() now
 works on windows w/o any other crypto lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Martin Ijewski <gm.ijewski@web.de>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XCqL7ucB5VrNt6KMqkU2Fnj2Dgiuri5hJ
From: Eric Blake <eblake@redhat.com>
To: Geert Martin Ijewski <gm.ijewski@web.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <130b5ca0-e865-e341-d271-a323a52c9ee9@redhat.com>
Subject: Re: [PATCH v3] crypto: qcrypto_random_bytes() now works on windows
 w/o any other crypto lib
References: <e3fd9c8b-8976-eb31-4092-887e94f4a5ae@web.de>
In-Reply-To: <e3fd9c8b-8976-eb31-4092-887e94f4a5ae@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 12:28 PM, Geert Martin Ijewski wrote:
> If no crypto library is included in the build, QEMU uses
> qcrypto_random_bytes() to generate random data. That function tried to
> open /dev/urandom or /dev/random and if openeing neither file worked it=


s/openeing/opening/
s/opening neither file worked/opening both files failed/

> errored out.
>=20
> Those files obviously do not exist on windows, so there the code uses
> CryptGenRandom().
>=20
> Furthermore there was some refactoring and a new function
> qcrypto_random_init() was introduced. If a proper crypto library (gnutl=
s
> or libgcrypt) is included in the build, this function does nothing. If
> neither is included it initalizes the (platform specific) handles that

s/initalizes/initializes/

> are used by qcrypto_random_bytes().
> Either:
> * a handle to /dev/urandom | /dev/random on unix like systems
> * a handle to a cryptographic service provider on windows
>=20
> Signed-off-by: Geert Martin Ijewski <gm.ijewski@web.de>
> ---

> +int qcrypto_random_init(Error **errp)
> +{
> +#ifdef _WIN32

Weird that you use #ifdef _WIN32 here...


> +int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
> +                         size_t buflen G_GNUC_UNUSED,
> +                         Error **errp)
> +{
> +#ifndef _WIN32

=2E..but #ifndef here. It would be more consistent if all dual-implemente=
d
functions have the #ifdefs in the same order, so that I can focus on
first or second half without having to check sense.


> +++ b/include/crypto/random.h
> @@ -40,5 +40,14 @@ int qcrypto_random_bytes(uint8_t *buf,
>                           size_t buflen,
>                           Error **errp);
>=20
> +/**
> + * qcrypto_random_init:
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Initalizes the handles used by qcrypto_random_bytes

s/Initalizes/Initializes/

> + *
> + * Returns 0 on success, -1 on error
> + */
> +int qcrypto_random_init(Error **errp);
>=20
>  #endif /* QCRYPTO_RANDOM_H */

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XCqL7ucB5VrNt6KMqkU2Fnj2Dgiuri5hJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/51kAAoJEKeha0olJ0NqMhYIAJAUz38qXunZGkh4c4uPGImv
H1u1P99u0GMBh8KVzmATf4dQ9dFv4hrh0xs0ozHbmW9XObkep7j5dGXG0eYOMZJh
sLNEWcfJzyAA5cbZRe6IJKMefV4otCS6jMmKMHdOYYGOyqjADg18RpePU3YY2OKI
CE3T8IWi3xiZv8H/ZQM5NcDE+CRX1tVcCAyuJdbozBOzZrt1EEJ4Uh45RFiBOiXs
yFneH33xM+YqI28ELQwPsZRdX4mIfD6fUFUcKbguDD2KGKaX/HVpg5vyRgYNA0V5
wgWzqa98odZ7OdQiy6FkiFvp56YbrbJJLXTLWRW6+ZYNe3oTqN6q5/2lEtss4Ig=
=AFa7
-----END PGP SIGNATURE-----

--XCqL7ucB5VrNt6KMqkU2Fnj2Dgiuri5hJ--
