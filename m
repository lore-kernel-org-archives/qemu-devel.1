Received: from eggs.gnu.org ([2001:4830:134:3::10]:58471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhUci-00044q-Go
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 02:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhUcf-0007IE-D6
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 02:47:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fhUcf-0007I8-7x
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 02:47:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF6A38790F
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 06:47:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
	<20180719184111.5129-13-marcandre.lureau@redhat.com>
Date: Mon, 23 Jul 2018 08:47:05 +0200
In-Reply-To: <20180719184111.5129-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Jul 2018 20:41:05 +0200")
Message-ID: <871sbucuty.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/18] qjson: return parsing error if
 unterminated input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qobject/json-streamer.c | 4 +++-
>  qobject/qjson.c         | 5 ++++-
>  tests/check-qjson.c     | 8 ++++----
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> index c51c2021f9..065c551332 100644
> --- a/qobject/json-streamer.c
> +++ b/qobject/json-streamer.c
> @@ -126,7 +126,9 @@ int json_message_parser_feed(JSONMessageParser *parse=
r,
>=20=20
>  int json_message_parser_flush(JSONMessageParser *parser)
>  {
> -    return json_lexer_flush(&parser->lexer);
> +    int ret =3D json_lexer_flush(&parser->lexer);
> +
> +    return ret ?: g_queue_get_length(parser->tokens);
>  }
>=20=20
>  void json_message_parser_destroy(JSONMessageParser *parser)
> diff --git a/qobject/qjson.c b/qobject/qjson.c
> index 01218c9ad6..8afdc1e06a 100644
> --- a/qobject/qjson.c
> +++ b/qobject/qjson.c
> @@ -64,7 +64,10 @@ QObject *qobject_from_jsonv(const char *string, va_lis=
t *ap, Error **errp)
>=20=20
>      json_message_parser_init(&state.parser, parse_json);
>      json_message_parser_feed(&state.parser, string, strlen(string));
> -    json_message_parser_flush(&state.parser);
> +    if (json_message_parser_flush(&state.parser) !=3D 0 &&
> +        !state.err) {
> +        error_setg(&state.err, QERR_JSON_PARSING);
> +    }
>      json_message_parser_destroy(&state.parser);
>=20=20
>      error_propagate(errp, state.err);

Again, this leaves other users broken.  Reproducer for QMP:

    $ echo -e '{ "execute": "qmp_capabilities" }\n{ "execute": "query-name"=
 }\n[' | socat UNIX:/work/armbru/images/test-qmp STDIO
    {"QMP": {"version": {"qemu": {"micro": 90, "minor": 12, "major": 2}, "p=
ackage": "v3.0.0-rc1-21-g975ad3dcf2"}, "capabilities": ["oob"]}}
    {"return": {}}
    {"return": {}}

Note there's no error reported for the last line.

The simplification of the JSON parser I have in mind might make this
easy to fix properly.  I'll look into it.
