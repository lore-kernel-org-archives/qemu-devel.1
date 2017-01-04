Received: from eggs.gnu.org ([2001:4830:134:3::10]:47706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOtbO-0000oy-C3
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOtbL-0005pe-8f
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:00:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOtbL-0005nd-0Q
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 17:00:07 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D72F58FD09
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 22:00:06 +0000 (UTC)
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-13-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1abe545e-a9a3-e14e-5fe1-0490c86ad0ba@redhat.com>
Date: Wed, 4 Jan 2017 16:00:03 -0600
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-13-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JPRhhuXicl9tkQu2duJOd09havTRPCHnN"
Subject: Re: [Qemu-devel] [PATCH 12/54] spice-char: improve error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JPRhhuXicl9tkQu2duJOd09havTRPCHnN
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <1abe545e-a9a3-e14e-5fe1-0490c86ad0ba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/54] spice-char: improve error reporting
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
 <20161212224325.20790-13-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> Set errp to report errors up.
>=20
> Use error_report() to give hints about parameters on the right monitor,=

> instead of a direct fprintf() call.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  spice-qemu-char.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>=20

And it's shorter!  I like it.

> @@ -302,8 +286,13 @@ static Chardev *qemu_chr_open_spice_vmc(const Char=
Driver *driver,
>          }
>      }
>      if (*psubtype =3D=3D NULL) {
> -        fprintf(stderr, "spice-qemu-char: unsupported type: %s\n", typ=
e);
> -        print_allowed_subtypes();
> +        char *subtypes =3D g_strjoinv(", ",
> +            (gchar **)spice_server_char_device_recognized_subtypes());=

> +
> +        error_setg(errp, "unsupported type name: %s", type);
> +        error_report("allowed spice char type names: %s", subtypes);

However, I'm not sure if error_setg() followed by error_report() is
correct; should you be using error_append_hint() instead?  Markus?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JPRhhuXicl9tkQu2duJOd09havTRPCHnN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbXBjAAoJEKeha0olJ0Nq2OwH/1jKjNMKDon1P15iPXvY0XkU
SpcCJ5S+zIT78vYbxI/Kok+ZplppjJYnOXW85EENZlnwEFeb4VD23kD7hWcV9LVP
5Opdglb7TKsxBZmTqvx/GxNfK8iABcBzEO56d20vqLPPVbm8QJxsc35hwaCqHmCQ
/i63KaFiOA3+dO8ibMBycz7lS22HexzGNzbV1tfVEr9TJgR6hw+rpHkBbSJfc5r1
kWtHnlkpv/SqE+TySPs8GcSz0uFxUvKFyNG9f265/uHRBUH7K8anLWWJOE89l92u
Z9zVZkhdvtpv6OqjZylNIqsCwQg9gQo3ixVwo+IllhxawYz9iY34AAClbsISZxM=
=E41f
-----END PGP SIGNATURE-----

--JPRhhuXicl9tkQu2duJOd09havTRPCHnN--
