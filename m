Received: from eggs.gnu.org ([2001:4830:134:3::10]:51242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu2GG-0001A4-SU
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cu2GF-0005WX-V0
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:31:04 -0400
References: <20170331120431.1767-1-mreitz@redhat.com>
	<20170331120431.1767-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d0d11fc-1849-9acb-fc53-3c46c13878ab@redhat.com>
Date: Fri, 31 Mar 2017 14:30:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170331120431.1767-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7UKK09r1RbAVCjnxTdj5swExJHx3iAD4c"
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] block/curl: Check protocol
 prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7UKK09r1RbAVCjnxTdj5swExJHx3iAD4c
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6d0d11fc-1849-9acb-fc53-3c46c13878ab@redhat.com>
Subject: Re: [PATCH for-2.9 2/2] block/curl: Check protocol prefix
References: <20170331120431.1767-1-mreitz@redhat.com>
 <20170331120431.1767-3-mreitz@redhat.com>
In-Reply-To: <20170331120431.1767-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 07:04 AM, Max Reitz wrote:
> If the user has explicitly specified a block driver and thus a protocol=
,
> we have to make sure the URL's protocol prefix matches. Otherwise the
> latter will silently override the former which might catch some users b=
y
> surprise.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/curl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20

It feels a little bit dirty that we are parsing the URL rather than
having a distinct discriminator, but I'm okay with the approach (with a
distinct discriminator, we would have to reconstruct a URL from the
discriminator + the rest of the server/path information, and that's more
work to libvirt to split a URL into the distinct JSON fields just to
have qemu rebuild a URL).

> +    if (!strstart(file, bs->drv->protocol_name, &protocol_delimiter) |=
|
> +        !strstart(protocol_delimiter, "://", NULL))
> +    {
> +        error_setg(errp, "%s curl driver cannot handle the URL '%s' (d=
oes not "
> +                   "start with '%s://')", bs->drv->protocol_name, file=
,
> +                   bs->drv->protocol_name);

Perhaps splitting the message with an error_append_hint() for the
parenthetical half would also be appropriate, but the line is not too
terribly long so I won't insist on a respin.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7UKK09r1RbAVCjnxTdj5swExJHx3iAD4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3q5vAAoJEKeha0olJ0NqxMEH/As1CqWrqh5oeV4zHnxSY7D1
oKhfiGzcK/rLPS+ViwftvmWututCLmItCTSLiOXkBUcUhdooEBYc7CzkKQE9ZqOG
2JQa9TABKkN211XI8g0PLb8W7mtCZB+i/h+Mayl0Aim7xgdrtOJHJ2T+pshldzra
fLIiVKCt3Qgumz7yaJo/bb+CW6p+lq7e0z22Bx9TOi0Fsr1gS9kWEK0kNB1dOvkk
5CT/mA3XGYj7BFUFLOXeJRAbfv7HJZKVzNR2W5d39HJyl0nEFxPS5SOadJhQ6zO+
/85QB1w64DAs3lLOYFYEvi93wmcemgxRXombwfoAlI+NJUAst0gOeRL0v4v6KrY=
=6aMF
-----END PGP SIGNATURE-----

--7UKK09r1RbAVCjnxTdj5swExJHx3iAD4c--
