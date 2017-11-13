Received: from eggs.gnu.org ([2001:4830:134:3::10]:44650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEGjB-0000ez-Gi
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEGjA-00058d-BR
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:32:49 -0500
References: <20171113152424.25381-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be69fe36-58f2-1164-5bcd-823df74ae769@redhat.com>
Date: Mon, 13 Nov 2017 09:32:38 -0600
MIME-Version: 1.0
In-Reply-To: <20171113152424.25381-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="judsBsCXtrJWg2CQiqEpPNC6LWAEeouTS"
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Use error_prepend()
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-stable@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--judsBsCXtrJWg2CQiqEpPNC6LWAEeouTS
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com,
 qemu-stable@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <be69fe36-58f2-1164-5bcd-823df74ae769@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Use error_prepend()
 correctly
References: <20171113152424.25381-1-eblake@redhat.com>
In-Reply-To: <20171113152424.25381-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding Markus as error maintainer]

On 11/13/2017 09:24 AM, Eric Blake wrote:
> When using error prepend(), it is necessary to end with a space
> in the format string; otherwise, messages come out incorrectly,
> such as when connecting to a socket that hangs up immediately:
>=20
> can't open device nbd://localhost:10809/: Failed to read dataUnexpected=
 end-of-file before all bytes were read
>=20
> Originally botched in commit e44ed99d, then several more instances
> added in the meantime.
>=20
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/client.c | 50 ++++++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index 1880103d2a..4e15fc484d 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -79,12 +79,12 @@ static int nbd_send_option_request(QIOChannel *ioc,=
 uint32_t opt,
>      stl_be_p(&req.length, len);
>=20
>      if (nbd_write(ioc, &req, sizeof(req), errp) < 0) {
> -        error_prepend(errp, "Failed to send option request header");
> +        error_prepend(errp, "Failed to send option request header: ");=


A quick grep of the tree noticed that most (all?) error_prepend()
callers use trailing ": " in their format string.  Should we refactor
that to be done automatically by error_prepend() itself, rather than at
every callsite?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--judsBsCXtrJWg2CQiqEpPNC6LWAEeouTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJuxcACgkQp6FrSiUn
Q2ojeQf/XYwONoN5HALanjhHHqYzVAbw0be6iBGOc9U0M1ZjO77teblI9aC9m8lg
jm7xkSfMc1xFsi450kwvTo3lzv3dkMt6xFsFMQL3UF5AIrtc2upQ6scSW7q2Zy2R
f6VFKCshAUeFNjI8ssxd2L4PXdjI5S+NE6Tmj+8NjwRrkYFmG/V9Zy9SAztvhrPC
3NqjA/8tK06XVzxa73RjRrQhTSd7vkGI6p/kglyLSklLavmm2Ka2NVUp0hu5o6mB
UM3VoHWxCVjejBFhWvVbWScHzF+X3BPd5CcTYZHSJMXlfHZWyqgNFU6w6VsN1pbf
+LqUaXFq0oZjINabVopq+U9FxsO3lg==
=Y3SC
-----END PGP SIGNATURE-----

--judsBsCXtrJWg2CQiqEpPNC6LWAEeouTS--
