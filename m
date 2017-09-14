Received: from eggs.gnu.org ([2001:4830:134:3::10]:37974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsSoX-0003bJ-Bi
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsSoR-0008PP-Py
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:00:13 -0400
References: <20170913210343.19078-1-eblake@redhat.com>
	<d40b4b1a-76ca-f438-e1d9-e079dc08724c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2e7ed9d-079f-1e1b-5d02-2f1ca3a6bb01@redhat.com>
Date: Thu, 14 Sep 2017 06:59:56 -0500
MIME-Version: 1.0
In-Reply-To: <d40b4b1a-76ca-f438-e1d9-e079dc08724c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e6Otqh2PxBt7bNaBD2LcppXn2oBMabqRc"
Subject: Re: [Qemu-devel] [PATCH] osdep: Fix ROUND_UP(64-bit, 32-bit)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e6Otqh2PxBt7bNaBD2LcppXn2oBMabqRc
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org
Message-ID: <f2e7ed9d-079f-1e1b-5d02-2f1ca3a6bb01@redhat.com>
Subject: Re: [PATCH] osdep: Fix ROUND_UP(64-bit, 32-bit)
References: <20170913210343.19078-1-eblake@redhat.com>
 <d40b4b1a-76ca-f438-e1d9-e079dc08724c@redhat.com>
In-Reply-To: <d40b4b1a-76ca-f438-e1d9-e079dc08724c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/14/2017 03:44 AM, Laszlo Ersek wrote:
> On 09/13/17 23:03, Eric Blake wrote:
>> When using bit-wise operations that exploit the power-of-two
>> nature of the second argument of ROUND_UP(), we still need to
>> ensure that the mask is as wide as the first argument (done
>> by using addition of 0 to force proper arithmetic promotion).
>> Unpatched, ROUND_UP(2ULL*1024*1024*1024*1024, 512) produces 0,
>> instead of the intended 2TiB.
>>
>> Broken since its introduction in commit 292c8e50 (v1.5.0).
>>
>> CC: qemu-trivial@nongnu.org
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> +#define ROUND_UP(n, d) (((n) + (d) - 1) & -((n) - (n) + (d)))
>>  #endif
>=20
> Another way to widen the mask as necessary would be:
>=20
>   (((n) + (d) - 1) & -(0 ? (n) : (d)))

Oh, I like that even better!


>>  #ifndef DIV_ROUND_UP
>> -#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
>> +#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
>>  #endif
>=20
> This looks like an independent whitespace fix; should it be in this pat=
ch?

checkpatch complained about the pre-patch spacing in ROUND_UP, and
DIV_ROUND_UP had the same issue 2 lines later.  But you're right that
it's not strictly necessary (or that I should at least call it out in
the commit message).

v2 coming up.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--e6Otqh2PxBt7bNaBD2LcppXn2oBMabqRc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm6bzwACgkQp6FrSiUn
Q2p47AgAqxYNwOt3lbRFfBwiWvtB4351ecUG2hDZzuuB+3TJaa9+mGetllDF0a5u
xgIIgn+piIeeCZSqLDpzu7g1PIBQZx2Fn3O1q5kUx+VSzP9jJqw6dOMzkfDfAUvR
yc06qV2acYtmo5e+JIHNCLSXoysQbHWPtG8uwYyCV4+95tr+Nu+Z9F559zTt4geG
rljhYpf3Gh5+XW99yPc9U66bYqa0A3U4gZwn+YBECEkQBx0jC8VALLU9TefU7lkE
k9uPgU5RcyA5Ys0HmhWtNHc6QL0wPnKk/c+jueIB47FOJgOYEJDsnLuWS+llRdZv
nafvV9ih1opMkfcMzH6PdgM/lQ0osQ==
=6MbZ
-----END PGP SIGNATURE-----

--e6Otqh2PxBt7bNaBD2LcppXn2oBMabqRc--
