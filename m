Received: from eggs.gnu.org ([209.51.188.92]:55747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjUTE-00052I-SW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjUSw-0005RZ-38
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:33:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gjUSs-0005OU-CS
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:33:38 -0500
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8dc5ad30-f15c-e2a0-b0bc-9af7a07854dd@redhat.com>
Date: Tue, 15 Jan 2019 13:33:25 -0600
MIME-Version: 1.0
In-Reply-To: <20190115145256.9593-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nciPBoyQUG9H8qc5xdRFP00gmaFWoRYq2"
Subject: Re: [Qemu-devel] [PATCH 04/12] chardev: remove many local variables
 in qemu_chr_parse_socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nciPBoyQUG9H8qc5xdRFP00gmaFWoRYq2
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yongji Xie <elohimes@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <8dc5ad30-f15c-e2a0-b0bc-9af7a07854dd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/12] chardev: remove many local variables
 in qemu_chr_parse_socket
References: <20190115145256.9593-1-berrange@redhat.com>
 <20190115145256.9593-5-berrange@redhat.com>
In-Reply-To: <20190115145256.9593-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding Markus in relation to a QemuOpts observation]

On 1/15/19 8:52 AM, Daniel P. Berrang=C3=A9 wrote:
> Now that all validation is separated off into a separate method,
> we can directly populate the ChardevSocket struct from the
> QemuOpts values, avoiding many local variables.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>=20

> @@ -1216,26 +1208,30 @@ static void qemu_chr_parse_socket(QemuOpts *opt=
s, ChardevBackend *backend,
>      sock =3D backend->u.socket.data =3D g_new0(ChardevSocket, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
> =20
> -    sock->has_nodelay =3D true;
> -    sock->nodelay =3D do_nodelay;
> +    sock->has_nodelay =3D qemu_opt_get(opts, "delay");
> +    sock->nodelay =3D !qemu_opt_get_bool(opts, "delay", true);

Unrelated to this patch, but my recent proposal to make QemuOpts be a
bit more typesafe:

https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02042.html

does not like users calling qemu_opt_get() of an option that has an
integer default (as opposed to a string default), even if the only
reason the caller was doing it was to learn if the option is present.  I
wonder if we should introduce

bool qemu_opt_has(QemuOpts *opts, const char *name)

and then replace existing callers which merely call qemu_opt_get() to
learn whether an optional option was present/defaulted but without
caring about its string value.  I also wonder if Coccinelle can be
employed to determine which callers fit that bill (that is, detect when
a const char * result is ignored or solely used in a bool context, vs.
when it is actually used as a string parameter to another function
and/or saved in a const char * variable).

Now, on to actual review,

> +    /*
> +     * We have different default to QMP for 'server', hence
> +     * we can't just check for existance of 'server'

s/existance/existence/

> +     */
>      sock->has_server =3D true;
> -    sock->server =3D is_listen;
> -    sock->has_telnet =3D true;
> -    sock->telnet =3D is_telnet;
> -    sock->has_tn3270 =3D true;
> -    sock->tn3270 =3D is_tn3270;
> -    sock->has_websocket =3D true;
> -    sock->websocket =3D is_websock;
> +    sock->server =3D qemu_opt_get_bool(opts, "server", false);
> +    sock->has_telnet =3D qemu_opt_get(opts, "telnet");
> +    sock->telnet =3D qemu_opt_get_bool(opts, "telnet", false);
> +    sock->has_tn3270 =3D qemu_opt_get(opts, "tn3270");
> +    sock->tn3270 =3D qemu_opt_get_bool(opts, "tn3270", false);
> +    sock->has_websocket =3D qemu_opt_get(opts, "websocket");
> +    sock->websocket =3D qemu_opt_get_bool(opts, "websocket", false);
>      /*
>       * We have different default to QMP for 'wait' when 'server'
>       * is set, hence we can't just check for existance of 'wait'

but then again, you were copy-pasting an existing typo.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nciPBoyQUG9H8qc5xdRFP00gmaFWoRYq2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw+NYUACgkQp6FrSiUn
Q2qRVgf+OVlsVnPmoUDHp0cVuaijeqLzNrljtMKhEm8iKASnYpL6Q3S1E8/2Dv59
4rfMpzpp1d61ZpkSZniuy7qKv9yVhJFnEOTR1G49OdGGseAPbzSt/v0gXO9UeD42
e7RaVciQn1Gl6qJSNpWMCbGEz6bEW4mftqcok7I/BH9LUcoF7KVoOBRo4NBckUgA
HBKX2n9qeD5RGWijZ38wXh6nWRl1S8dUQY62N53GB/EZnk9wE/EvN5hc5NL7ubkc
LuoBkvDyOV6ZboPr5GL1z69aYsuv1CpC/kGTJetHYbTGQHlHeXv2JFmiMEbgwY/C
6pZHzIToJv91v6SqQVJivJ+f5YbzWQ==
=hWvC
-----END PGP SIGNATURE-----

--nciPBoyQUG9H8qc5xdRFP00gmaFWoRYq2--
