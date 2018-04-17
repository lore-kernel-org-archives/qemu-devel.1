Received: from eggs.gnu.org ([2001:4830:134:3::10]:49059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8WU7-0005rR-UX
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8WU6-0004E2-TF
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:41:47 -0400
References: <20180413192605.2145-1-nirsof@gmail.com>
	<20180413192605.2145-2-nirsof@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab4f8d4f-c451-181e-e8b5-72a9335f988b@redhat.com>
Date: Tue, 17 Apr 2018 14:41:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180413192605.2145-2-nirsof@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VsH95A9d2SEKfqfPiUH6RRIVX1xQSWJbw"
Subject: Re: [Qemu-devel] [PATCH 1/3] nbd: Add option to disallow listing
 exports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VsH95A9d2SEKfqfPiUH6RRIVX1xQSWJbw
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <ab4f8d4f-c451-181e-e8b5-72a9335f988b@redhat.com>
Subject: Re: [PATCH 1/3] nbd: Add option to disallow listing exports
References: <20180413192605.2145-1-nirsof@gmail.com>
 <20180413192605.2145-2-nirsof@gmail.com>
In-Reply-To: <20180413192605.2145-2-nirsof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2018 02:26 PM, Nir Soffer wrote:
> When a management application expose images using qemu-nbd, it needs a
> secure way to allow temporary access to the disk. Using a random export=

> name can solve this problem:
>=20
>     nbd://server:10809/22965f19-9ab5-4d18-94e1-cbeb321fa433

I share Dan's concerns that you are trying to protect information
without requiring TLS.  If you would just use TLS, then only clients
that can authenticate can list the export names; the fact that the name
leaks at all means you aren't using TLS, so you are just as vulnerable
to a man-in-the-middle attack as you are to the information leak.

>=20
> Assuming that the url is passed to the user in a secure way, and the
> user is using TLS to access the image.
>=20
> However, since qemu-nbd implements NBD_OPT_LIST, anyone can easily find=

> the secret export:
>=20
>     $ nbd-client -l server 10809
>     Negotiation: ..
>     22965f19-9ab5-4d18-94e1-cbeb321fa433

If the server requires TLS, then 'nbd-client -l' already cannot list
names without first negotiating TLS (all commands other than
NBD_OPT_STARTTLS are rejected with NBD_REP_ERR_TLS_REQD if the server
required TLS).  Your example is thus invalidating your above assumption
that the user is using TLS.

>=20
> Add a new --nolist option, disabling listing, similar the "allowlist"
> nbd-server configuration option.

This may still make sense to implement, but not necessarily for the
reasons you are giving.


> @@ -86,6 +88,7 @@ static void usage(const char *name)
>  "  -v, --verbose             display extra debugging information\n"
>  "  -x, --export-name=3DNAME    expose export by name\n"
>  "  -D, --description=3DTEXT    with -x, also export a human-readable d=
escription\n"
> +"      --nolist              do not list export\n"

s/export/exports/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VsH95A9d2SEKfqfPiUH6RRIVX1xQSWJbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWTe8ACgkQp6FrSiUn
Q2o6dAgAiudCb0qQF0mN6ZO6U362E9fOHGfogOalINh35e8l3esVCX77cTMCQZm/
7AKKuurMUNI8j/oD0gZHeohY1uXx6tXn5bFJysLm6gPtgVV3XJR91yPqoQ0j6IS5
suf3dr1hSzQ/xkJkt2ZE401YNoCOC0Sjwff1EtY1jcITQYe+2DU0XTLc8c/ZZy9/
DS2cdx+0WcTXuMj5STU3GWAUM8F41kE9gz9eF65n8wgClJa5CXJAF4wE5AbSasHY
qBbXJwZS21xHACUleibk0D3VsoVmMKr36MQ6tJaKfAmZJvS/sDwU5mXLFv+vIUq1
Okz8OQxMWa9iZbMcHu7XiFHh/Jurow==
=EX1m
-----END PGP SIGNATURE-----

--VsH95A9d2SEKfqfPiUH6RRIVX1xQSWJbw--
