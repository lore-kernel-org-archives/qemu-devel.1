Received: from eggs.gnu.org ([2001:4830:134:3::10]:59869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cL9-0002OE-39
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cL6-00039l-F3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:59:43 -0400
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-35-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2221fca-f041-c1ac-143e-19fd72b31cd5@redhat.com>
Date: Mon, 9 Oct 2017 12:59:31 -0500
MIME-Version: 1.0
In-Reply-To: <20171006235023.11952-35-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8tBXAeO3PnjU9iuJmtpdCQBTHNugW7QPO"
Subject: Re: [Qemu-devel] [PATCH 34/88] qapi: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8tBXAeO3PnjU9iuJmtpdCQBTHNugW7QPO
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu trival <qemu-trivial@nongnu.org>
Message-ID: <e2221fca-f041-c1ac-143e-19fd72b31cd5@redhat.com>
Subject: Re: [PATCH 34/88] qapi: use g_new() family of functions
References: <20171006235023.11952-1-f4bug@amsat.org>
 <20171006235023.11952-35-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-35-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2017 06:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  qapi/opts-visitor.c           | 2 +-
>  qapi/qapi-clone-visitor.c     | 2 +-
>  qapi/qapi-dealloc-visitor.c   | 2 +-
>  qapi/qobject-output-visitor.c | 2 +-
>  qapi/string-input-visitor.c   | 2 +-
>  qapi/string-output-visitor.c  | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 324b197495..34ac49f3c2 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -539,7 +539,7 @@ opts_visitor_new(const QemuOpts *opts)
>      OptsVisitor *ov;
> =20
>      assert(opts);
> -    ov =3D g_malloc0(sizeof *ov);
> +    ov =3D g_new0(OptsVisitor, 1);

Transformations like this are harder to justify - you have more typing
rather than less, and no change in the amount of type-safety.

If we really want to convert LHS =3D g_malloc0(sizeof(*LHS)), we probably=

ought to have a stronger justification (consistency might be such an
argument, if the entire series is applied and HACKING is updated to
mention our new preferred style, and where the checked-in Coccinelle
script can be easily re-run in the future to catch regressions).

Converting LHS =3D g_malloc0(sizeof(type)) is a no-brainer, because it
DOES add type-safety, and often results in less typing.  But I haven't
looked at your entire series to see which patches fall in the no-brainer
category vs. the weakly-argued consistency category.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8tBXAeO3PnjU9iuJmtpdCQBTHNugW7QPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnbuQMACgkQp6FrSiUn
Q2pYDAf/bNENuoOOlnvpm4CNBPBADhDkXYCmvXGvIZQ1dzExSgvjJBgXudEcN987
1iBAgJSiNYy48BrfGIAklFFeaAm8rEH1EJ1Jziq2aGPvWYYxg7ja01NTqVx3lKfG
jPLbCVcMOkKfYKcdLeaI6KiSACDO5o4KhIOrzYDZALWqktH2kgXjJuDWLVSAdP0+
JgUPKYhuOG35W/qouZUlALkGwZcDqQSSXekmlw6TMdXTxQRqvz1TvSI230Lgy7Sq
Bx4Kw9dymHNfOzDe3CBFMzWUka15aI8mZ1Ef/jebXxaZdOiOtSEPipQ792dyu5IM
67xAaCN9K/G9cCZqay5iaJJa+ezJKw==
=uA/B
-----END PGP SIGNATURE-----

--8tBXAeO3PnjU9iuJmtpdCQBTHNugW7QPO--
