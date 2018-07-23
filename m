Received: from eggs.gnu.org ([2001:4830:134:3::10]:57860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhUWI-0002IF-BF
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 02:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhUWF-0004up-8h
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 02:40:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fhUWF-0004ug-31
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 02:40:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DBAD401EF01
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 06:40:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
	<20180719184111.5129-12-marcandre.lureau@redhat.com>
Date: Mon, 23 Jul 2018 08:40:28 +0200
In-Reply-To: <20180719184111.5129-12-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Jul 2018 20:41:04 +0200")
Message-ID: <876016cv4z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/18] qjson: report error on
 unterminated string
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

> An unterminated string will make parser emit an error (tokens =3D=3D
> NULL). Let's report it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qobject/qjson.c     | 3 +++
>  tests/check-qjson.c | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/qobject/qjson.c b/qobject/qjson.c
> index 8a9d116150..01218c9ad6 100644
> --- a/qobject/qjson.c
> +++ b/qobject/qjson.c
> @@ -37,6 +37,9 @@ static void parse_json(JSONMessageParser *parser, GQueu=
e *tokens)
>  {
>      JSONParsingState *s =3D container_of(parser, JSONParsingState, parse=
r);
>=20=20
> +    if (!tokens && !s->err) {
> +        error_setg(&s->err, QERR_JSON_PARSING);
> +    }
>      if (s->result || s->err) {
>          if (s->result) {
>              qobject_unref(s->result);

This doesn't fix the JSON parser, it "fixes" one of its users!  Other
users remain broken.  Reproducer for QMP (already mentioned in my review
of the previous patch):

    $ echo -e '{ "execute": "qmp_capabilities" }\n{ "execute": "query-name"=
 }\n"unterminated' | socat UNIX:test-qmp STDIO
    {"QMP": {"version": {"qemu": {"micro": 90, "minor": 12, "major": 2}, "p=
ackage": "v3.0.0-rc1-20-g6a024cd461"}, "capabilities": ["oob"]}}
    {"return": {}}
    {"return": {}}

Note there's no error reported for the last line.

The simplification of the JSON parser I have in mind might make this
easy to fix properly.  I'll look into it.

[...]
