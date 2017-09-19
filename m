Received: from eggs.gnu.org ([2001:4830:134:3::10]:37780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duPYd-000861-0f
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duPYa-0007I2-Cv
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:55:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duPYZ-0007H2-TP
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:55:48 -0400
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-6-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <94721733-af41-690f-d17f-dbb3f7c593f5@redhat.com>
Date: Tue, 19 Sep 2017 15:55:41 -0500
MIME-Version: 1.0
In-Reply-To: <1505375436-28439-6-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HGATPHq0biWJaRGaO1ouOuKMJ3uE7d4hL"
Subject: Re: [Qemu-devel] [RFC 05/15] qjson: add "opaque" field to
 JSONMessageParser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HGATPHq0biWJaRGaO1ouOuKMJ3uE7d4hL
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <94721733-af41-690f-d17f-dbb3f7c593f5@redhat.com>
Subject: Re: [RFC 05/15] qjson: add "opaque" field to JSONMessageParser
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
 <1505375436-28439-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-6-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/14/2017 02:50 AM, Peter Xu wrote:
> It'll be passed to emit() as well when it happens.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qapi/qmp/json-streamer.h | 8 ++++++--
>  monitor.c                        | 7 ++++---
>  qga/main.c                       | 5 +++--
>  qobject/json-streamer.c          | 7 +++++--
>  qobject/qjson.c                  | 5 +++--
>  tests/libqtest.c                 | 5 +++--
>  6 files changed, 24 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/qapi/qmp/json-streamer.h b/include/qapi/qmp/json-s=
treamer.h
> index 00d8a23..b83270c 100644
> --- a/include/qapi/qmp/json-streamer.h
> +++ b/include/qapi/qmp/json-streamer.h
> @@ -25,16 +25,20 @@ typedef struct JSONToken {
> =20
>  typedef struct JSONMessageParser
>  {
> -    void (*emit)(struct JSONMessageParser *parser, GQueue *tokens);
> +    void (*emit)(struct JSONMessageParser *parser, GQueue *tokens, voi=
d *opaque);
>      JSONLexer lexer;
>      int brace_count;
>      int bracket_count;
>      GQueue *tokens;
>      uint64_t token_size;
> +    /* To be passed in when emit(). */

Reads awkwardly, better might be: /* Passed to emit() */

I might group void *opaque right next to emit, rather than separated by
the rest of the struct, to make it obvious they are related, at which
point the comment isn't necessary.

> +    void *opaque;
>  } JSONMessageParser;
> =20
>  void json_message_parser_init(JSONMessageParser *parser,
> -                              void (*func)(JSONMessageParser *, GQueue=
 *));
> +                              void (*func)(JSONMessageParser *, GQueue=
 *,
> +                                           void *opaque),

Inconsistent to name only one of the three parameters in the inner
function pointer type for the outer parameter 'func'.  I wonder if a
typedef would make things more legible.

> +                              void *opaque);
> =20

> +++ b/qobject/json-streamer.c
> @@ -102,18 +102,21 @@ out_emit:
>       */
>      tokens =3D parser->tokens;
>      parser->tokens =3D g_queue_new();
> -    parser->emit(parser, tokens);
> +    parser->emit(parser, tokens, parser->opaque);
>      parser->token_size =3D 0;
>  }
> =20
>  void json_message_parser_init(JSONMessageParser *parser,
> -                              void (*func)(JSONMessageParser *, GQueue=
 *))
> +                              void (*func)(JSONMessageParser *,
> +                                           GQueue *, void *opaque),

Again, inconsistent that you named only 1 of the three inner parameters.

Overall, the idea looks reasonable.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HGATPHq0biWJaRGaO1ouOuKMJ3uE7d4hL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBhE0ACgkQp6FrSiUn
Q2qzgwf/cq7+WYZHP/9MsY00sNtXQULi5LpDZeIAxikdko9oZURk5K0ScBcBYxSK
YpvcozYWjySbJ27bGW1D2HHYOnkWsb/Lpn7mqQBG+z2xeJezsp6Hrs5jxJ1e12oh
vX7pIX868YR/UhpKAFxbj6LL1pNRd3bgVhJUCLp9QA3lfBB0llN/5usXu7TpSGOo
Y/Os4KGKCrkyrbRmahzwg6SNrboR7ig7b8XZUZ508wi6GxbKAIof2WwTs6gt5iXV
hWCaKOAHuT+FBGjCplOMdzvImKuyacT4gJUBx8/D7rdC43sY3gWZQso4x8l9M33f
/3YyNBwJXoPI2CpTcID/dIHxQtJuVA==
=+A5H
-----END PGP SIGNATURE-----

--HGATPHq0biWJaRGaO1ouOuKMJ3uE7d4hL--
