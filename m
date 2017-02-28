Received: from eggs.gnu.org ([2001:4830:134:3::10]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciqpt-00057s-G9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciqpq-0007C1-CX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:05:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciqpq-0007BS-35
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:05:34 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A5BAC05678E
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 23:05:34 +0000 (UTC)
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-9-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c63c603-2c2f-2118-d55b-30706e79cbf8@redhat.com>
Date: Tue, 28 Feb 2017 17:05:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-9-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QSfmcrwIhO8qiV6D5b7I5JdEs1x7hfqd2"
Subject: Re: [Qemu-devel] [PATCH v2 08/30] tests: fix q35-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QSfmcrwIhO8qiV6D5b7I5JdEs1x7hfqd2
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <9c63c603-2c2f-2118-d55b-30706e79cbf8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/30] tests: fix q35-test leaks
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
 <20170221141451.28305-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 08:14 AM, Marc-Andr=C3=A9 Lureau wrote:
> Spotted by ASAN.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/q35-test.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/q35-test.c b/tests/q35-test.c
> index 763fe3d6ae..e010d781e7 100644
> --- a/tests/q35-test.c
> +++ b/tests/q35-test.c
> @@ -71,6 +71,9 @@ static void test_smram_lock(void)
>      g_assert(smram_test_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN) =3D=3D=
 false);
>      smram_set_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN, true);
>      g_assert(smram_test_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN) =3D=3D=
 true);
> +
> +    qpci_free_pc(pcibus);
> +    g_free(pcidev);

I might have cleaned pcidev first (reverse order cleanup, since it was
initialized after pcibus), but I don't see any use-after-free problems
in your choice of order.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--QSfmcrwIhO8qiV6D5b7I5JdEs1x7hfqd2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtgI7AAoJEKeha0olJ0NqTFIIAJoWTXm/+OnyRd8lFJGKppQX
lhXUEgMBZaLNcAfSNi+Z/ExpLPvP1V4/W9izE8HMIc/uxjrmEXm6vhcCLcuXKO0p
H/a40jeklMVdr7KCpKhYohU8C9P8IE53fMzZKr39qonj88iESc7l/EwqCgO+blXk
M1MDMf8IYturP2TOu6cJWARZ9MVgi/CyiveL+0oVaOkmhcu8VqU9IvPrPcsNgSa/
wHowpAE7FscHVC4QZAR2zQK0ojgEZMhPkT37nioNath/9QODDJHlor9so8YZlLy4
5qQ1fTYParny9ZNWyoBmhbXxfDPNmsq6TSZ+fxdo2peQVXaJowIuhdoM+PxtZ5s=
=1Dlm
-----END PGP SIGNATURE-----

--QSfmcrwIhO8qiV6D5b7I5JdEs1x7hfqd2--
