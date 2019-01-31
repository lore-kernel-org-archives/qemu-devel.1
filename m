Received: from eggs.gnu.org ([209.51.188.92]:37914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpJUm-0005qi-BD
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpJUg-0005Ok-LQ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:03:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gpJUd-0005Nh-01
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:03:28 -0500
References: <20190131202637.4062-1-jusual@mail.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d21f68cf-31fa-db62-1d20-66f75e5a05b4@redhat.com>
Date: Thu, 31 Jan 2019 15:03:21 -0600
MIME-Version: 1.0
In-Reply-To: <20190131202637.4062-1-jusual@mail.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UAzAYuQedQK8J7M0BfmSbAKU56Xt3trWq"
Subject: Re: [Qemu-devel] [PATCH] monitor: Add whitelist support for QMP
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org
Cc: Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UAzAYuQedQK8J7M0BfmSbAKU56Xt3trWq
From: Eric Blake <eblake@redhat.com>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org
Cc: Jim Mussared <jim@groklearning.com>,
 =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>,
 Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d21f68cf-31fa-db62-1d20-66f75e5a05b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: Add whitelist support for QMP
 commands
References: <20190131202637.4062-1-jusual@mail.ru>
In-Reply-To: <20190131202637.4062-1-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/31/19 2:26 PM, Julia Suvorova via Qemu-devel wrote:
> The whitelist option allows to run a reduced monitor with a subset of
> QMP commands. This allows the monitor to run in secure mode, which is
> convenient for sending commands via the WebSocket monitor using the
> web UI. This is planned to be done on micro:bit board.
>=20
> The list of allowed commands should be written to a file, one per line.=

> The command line will look like this:
>     -mon chardev_name,mode=3Dcontrol,whitelist=3Dpath_to_file
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---

> =20
> -void monitor_init(Chardev *chr, int flags)
> +static void process_whitelist_file(Monitor *mon, const char *whitelist=
_file)
> +{
> +    char cmd_name[256];
> +    FILE *fd =3D fopen(whitelist_file, "r");

If you use qemu_open() here (followed by fdopen if you still prefer
fscanf over read), then you can support "/dev/fdset/NNN" to
auto-magically support someone passing in the whitelist via an inherited
file descriptor, rather than having to be somewhere on disk that qemu
can directly open().

> +
> +    if (fd =3D=3D NULL) {
> +        error_report("Could not open whitelist file: %s", strerror(err=
no));
> +        exit(1);
> +    }
> +
> +    mon->whitelist =3D g_hash_table_new_full(g_str_hash,
> +                                           g_str_equal,
> +                                           g_free,
> +                                           NULL);
> +
> +    g_hash_table_add(mon->whitelist, g_strdup("qmp_capabilities"));
> +    g_hash_table_add(mon->whitelist, g_strdup("query-commands"));
> +
> +    while (fscanf(fd, "%255s", cmd_name) =3D=3D 1) {

%255s fits your cmd_name array declaration and stops consuming at either
255 bytes or at the first whitespace encountered, but where do you check
for overflow from a file that passes more than 255 non-whitespace bytes
without a newline?  Also, this is a bit sloppy in that it skips all
leading whitespace, rather than ensuring that the user actually passed
newline-separated command names.  Does glib provide any interfaces for
more easily reading in an array of lines from a file?


> +++ b/qemu-options.hx
> @@ -3195,12 +3195,16 @@ Like -qmp but uses pretty JSON formatting.
>  ETEXI
> =20
>  DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
> -    "-mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|off=
]]\n", QEMU_ARCH_ALL)
> +    "-mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|off=
]]" \
> +    "[,whitelist=3Dfile]\n", QEMU_ARCH_ALL)
>  STEXI
> -@item -mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|of=
f]]
> +@item -mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|of=
f]][,whitelist=3D@var{file}]
>  @findex -mon
>  Setup monitor on chardev @var{name}. @code{pretty} turns on JSON prett=
y printing
>  easing human reading and debugging.
> +The @code{whitelist} option disables all commands except those specifi=
ed in
> +@var{file}. The file must contain one command name per line. This opti=
on is only
> +avaliable in 'control' mode.

s/avaliable/available/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--UAzAYuQedQK8J7M0BfmSbAKU56Xt3trWq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxTYpkACgkQp6FrSiUn
Q2oqBwf+IgOKCrKjATETstRRP7uM1ilgTZzQBYeJ2CdI3WOK0JJMrdh7qIQ6wWyp
i/7CxLuvGaqIgjrxDNWS+rRO3uJb1A0/Ti4NX1rhuQszDb/D2XVOlQMlMyXjm3NZ
2Nd7twnmyjaEg6V3BanKscmCWP8x6bLOj/yaJ/n+n5pbsUhQrcTgygCib3nRDLrJ
Odb3AxnELTGr2zMfh+gWrN5IWvicRx8CRP0LZw/+fkvKLGoMNNI8QHE83211sNd+
zl/JOKRqWGM2cWZ9BeAno2VpNpvxSgmeXuWKqodlXBAQq1L3V+XaDAtf6rywVaOc
YSkf9SKSsPsEQ3MnO5j/AsP/oqV57A==
=jU9h
-----END PGP SIGNATURE-----

--UAzAYuQedQK8J7M0BfmSbAKU56Xt3trWq--
