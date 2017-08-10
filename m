Received: from eggs.gnu.org ([2001:4830:134:3::10]:43792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsIs-0000Pd-NC
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsIr-0002Qp-GP
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:35:30 -0400
References: <20170810160451.32723-1-berrange@redhat.com>
	<20170810160451.32723-9-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9553758-f0b3-f8c8-2457-41c389203602@redhat.com>
Date: Thu, 10 Aug 2017 13:35:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170810160451.32723-9-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1lOF6gkovOxguoSTIFs1Wbq8th1axjEOX"
Subject: Re: [Qemu-devel] [PATCH 8/8] sockets: fix parsing of ipv4/ipv6 opts
 in parse_socket_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1lOF6gkovOxguoSTIFs1Wbq8th1axjEOX
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org
Message-ID: <a9553758-f0b3-f8c8-2457-41c389203602@redhat.com>
Subject: Re: [PATCH 8/8] sockets: fix parsing of ipv4/ipv6 opts in
 parse_socket_addr
References: <20170810160451.32723-1-berrange@redhat.com>
 <20170810160451.32723-9-berrange@redhat.com>
In-Reply-To: <20170810160451.32723-9-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 11:04 AM, Daniel P. Berrange wrote:
> The inet_parse() function looks for 'ipv4' and 'ipv6'
> flags, but only treats them as bare bool flags. The normal
> QemuOpts parsing would allow on/off values to be set too.
>=20
> This updated inet_parse() so that its handling of the

s/updated/updates/ ?

> 'ipv4' and 'ipv6' flags matches that done by QemuOpts.

Do we have a regression compared to any previous version, such that this
patch might be considered 2.10 material?  Offhand, though, I think it's
fine as the end of your series, waiting for 2.11.

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/test-sockets-proto.c | 13 -------------
>  util/qemu-sockets.c        | 36 ++++++++++++++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 17 deletions(-)
>=20

> +++ b/util/qemu-sockets.c
> @@ -616,6 +616,25 @@ err:
>  }
> =20
>  /* compatibility wrapper */
> +static int inet_parse_flag(const char *flagname, const char *optstr, b=
ool *val,
> +                           Error **errp)
> +{
> +    char *end;
> +    size_t len;
> +
> +    end =3D strstr(optstr, ",");

Do we need to check that we are not landing on a ',,' escape that would
make QemuOpts behave differently?  [That is, ipv4=3Don,,garbage should be=

parsed as setting ipv4 to 'on,garbage' (which is not valid), and NOT
setting 'ipv4=3Don' followed by the 'garbage' or ',garbage' key - while
the key named 'garbage' would fail, there might be other key names where
the distinction matters for catching command line typos]

But if this is unrelated to QemuOpts escape parsing, it seems okay.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1lOF6gkovOxguoSTIFs1Wbq8th1axjEOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMp2QACgkQp6FrSiUn
Q2rTNQf/YGVJsMWSQZBFY26WU+lJKLsttFFuF58uO5GiAkjAP33G/5pTd4QRh+za
Pg6ZHdSC59MTMcN2YYdQmYFDMv3/SQWqhtNucQDZHJGuV4BqnAMYrQ0ydxj2ZARp
IXYrLpql9KSghsOyx9SmKdkGiz249u4vCjcPHYhjbBm1aQzbodjkB4GWr4rlonVR
PW+Q8h5TEbg3AX4WVctWamQ6j9BiSFvscZzbkeOStfFpQp27gYcb+wwi95cC9a36
WnWq8IMXjgFlfTIyOHUZUpGR+5h5bzyQ0e4FdmfG8qH2sWN4BsE9HKG9vpw8fJlz
ct5cAHSb9LiXT4L2le7DB+9WKI6Z9Q==
=n1ni
-----END PGP SIGNATURE-----

--1lOF6gkovOxguoSTIFs1Wbq8th1axjEOX--
