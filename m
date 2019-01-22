Received: from eggs.gnu.org ([209.51.188.92]:45164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1nj-0007kw-Ou
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1gP-0004xA-Gp
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:26:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gm1gN-0004aU-Ee
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:26:01 -0500
References: <20190122181822.1505-1-peter.maydell@linaro.org>
	<20190122181822.1505-2-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f3c46d12-efb3-7beb-b61a-140c977875af@redhat.com>
Date: Tue, 22 Jan 2019 13:25:41 -0600
MIME-Version: 1.0
In-Reply-To: <20190122181822.1505-2-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2PlEtKU0TR4bmP4XlQrOgWO7LcpKRjWbn"
Subject: Re: [Qemu-devel] [PATCH 1/2] slirp: Avoid marking naturally packed
 structs as QEMU_PACKED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2PlEtKU0TR4bmP4XlQrOgWO7LcpKRjWbn
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 patches@linaro.org
Message-ID: <f3c46d12-efb3-7beb-b61a-140c977875af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] slirp: Avoid marking naturally packed
 structs as QEMU_PACKED
References: <20190122181822.1505-1-peter.maydell@linaro.org>
 <20190122181822.1505-2-peter.maydell@linaro.org>
In-Reply-To: <20190122181822.1505-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/22/19 12:18 PM, Peter Maydell wrote:
> Various ipv6 structs in the slirp headers are marked QEMU_PACKED,
> but they are actually naturally aligned and will have no padding
> in them. Instead of marking them with the 'packed' attribute,
> assert at compile time that they are the size we expect. This
> allows us to take the address of fields within the structs
> without risking undefined behaviour, and suppresses clang
> -Waddress-of-packed-member warnings.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  slirp/ip6.h      | 12 ++++++++++--
>  slirp/ip6_icmp.h | 20 +++++++++++++++-----
>  2 files changed, 25 insertions(+), 7 deletions(-)
>=20

> +/*
> + * We don't want to mark these ip6 structs as packed as they are natur=
ally
> + * correctly aligned; instead assert that there is no stray padding.
> + * If we marked the struct as packed then we would be unable to take
> + * the address of any of the fields in it.
> + */
> +QEMU_BUILD_BUG_ON(sizeof(struct ip6) !=3D 40);
> +QEMU_BUILD_BUG_ON(sizeof(struct ip6_pseudohdr) !=3D 40);

Nice.  (And IIRC, the IPv6 designers tried to pick natural alignments on
purpose)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2PlEtKU0TR4bmP4XlQrOgWO7LcpKRjWbn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHbjUACgkQp6FrSiUn
Q2rL+Qf+KVcUR02ZhX10HjKZLKk75jTxz3xJyZStrJv2yCRIgDXWMxrCTH0IO/PX
3vr5rujeYlev+VoY2SSmZ6BMmMc5k0G58wGRDXqGV5adyzSIlvU0VMdNZ3Bd4crq
ptnX+IqIW2hQ7GTD8rZiH1sTmLhTkKjb5z1/rXYMMFexmNtxUd8iV0UDi7Hjy8BT
mLY/C3oTCtLlVctc7zqqKVi4gCOm8i1Qs2mxy0Izw3jxka0zmAYrTrvklc/ER++K
5jyrQ4HqO9t/v3fvcAyYtVEfsz45S2QaPqKqiZZeEeaEpJmob9Q95IIWGt1ol07P
ptSDS1IrxA0JLew82Nci9Iwr5tfGwQ==
=Nqoj
-----END PGP SIGNATURE-----

--2PlEtKU0TR4bmP4XlQrOgWO7LcpKRjWbn--
