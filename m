Received: from eggs.gnu.org ([2001:4830:134:3::10]:40367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dajSo-0001dq-UP
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dajSn-0006Su-Tg
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:08:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dajSn-0006SZ-Kz
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:08:29 -0400
References: <1501148776-16890-1-git-send-email-armbru@redhat.com>
	<1501148776-16890-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64dcfbc8-e542-a18c-a247-9171feb127c6@redhat.com>
Date: Thu, 27 Jul 2017 09:08:26 -0500
MIME-Version: 1.0
In-Reply-To: <1501148776-16890-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SwFaEeLhbF1Wr3ExUTuvRtfpEF3NwDpca"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] host-utils: Proactively fix
 pow2floor(), switch to unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SwFaEeLhbF1Wr3ExUTuvRtfpEF3NwDpca
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <64dcfbc8-e542-a18c-a247-9171feb127c6@redhat.com>
Subject: Re: [PATCH v2 2/3] host-utils: Proactively fix pow2floor(), switch to
 unsigned
References: <1501148776-16890-1-git-send-email-armbru@redhat.com>
 <1501148776-16890-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1501148776-16890-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 04:46 AM, Markus Armbruster wrote:
> The function's stated contract is simple enough: "round down to the
> nearest power of 2".  Suggests the domain is the representable numbers
>> =3D 1, because that's the smallest power of two.

Mail quoting gives an interesting rendering of this line; I had to do a
double-take to realize your text is correct.

>=20
> Fix by switching from int64_t to uint64_t and amending the contract to
> map zero to zero.

I like it.  And your proof of auditing callers helps.

> ---
>  include/qemu/host-utils.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> index 95cf4f4..6c6005f 100644
> --- a/include/qemu/host-utils.h
> +++ b/include/qemu/host-utils.h
> @@ -369,13 +369,16 @@ static inline bool is_power_of_2(uint64_t value)
>      return !(value & (value - 1));
>  }
> =20
> -/* round down to the nearest power of 2*/
> -static inline int64_t pow2floor(int64_t value)
> +/**
> + * Return @value rounded down to the nearest power of two or zero.
> + */
> +static inline uint64_t pow2floor(uint64_t value)
>  {
> -    if (!is_power_of_2(value)) {
> -        value =3D 0x8000000000000000ULL >> clz64(value);
> +    if (!value) {
> +        /* Avoid undefined shift by 64 */
> +        return 0;
>      }
> -    return value;
> +    return 0x8000000000000000ull >> clz64(value);
>  }

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SwFaEeLhbF1Wr3ExUTuvRtfpEF3NwDpca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll589oACgkQp6FrSiUn
Q2rthAf+Ksl7IcKdSuRZxx13noBvnIaD9SMnzeK98gpEouLvm1VdzaMXo9pW1fR0
dy1t7cKnJCIPYN4izs1DmFTSvPn5ARp/agDYN5TMKExO9A+vtLI6PbqILjcZQbuH
Uu+pf3/ljqb6tN5JQtA5Ko5DgD6bx+FD3H+YfRfwd3PW+kkiLwuWd/7wkR0nTWAP
sT7B15SNamiP3ycOA3DhHYurTDMXcTLrU1p/YENevo+rJ5+5gAe2EpUUBdwYG+1J
V/t4rOCXkF8Li6GJLV6A3d0NstCKd4b14dwqx4U7ULtXC3fI/UgpIRPRutYaOZmH
wH2kFI4MhvxZcRLrtSoRoUBSIEFCSQ==
=OLo0
-----END PGP SIGNATURE-----

--SwFaEeLhbF1Wr3ExUTuvRtfpEF3NwDpca--
