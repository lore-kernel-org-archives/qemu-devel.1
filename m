Received: from eggs.gnu.org ([2001:4830:134:3::10]:46498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgOuQ-00048a-Cr
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgOuN-0006gl-9S
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:28:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fgOuN-0006gX-46
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:28:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD0CAB4DF
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 06:28:54 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
	<20180719184111.5129-9-marcandre.lureau@redhat.com>
Date: Fri, 20 Jul 2018 08:28:53 +0200
In-Reply-To: <20180719184111.5129-9-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Jul 2018 20:41:01 +0200")
Message-ID: <87o9f2to7u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/18] json-parser: simplify and avoid
 JSONParserContext allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> parser_context_new/free() are only used from json_parser_parse(). We
> can fold the code there and avoid an allocation altogether.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qobject/json-parser.c | 41 +++++++++--------------------------------
>  1 file changed, 9 insertions(+), 32 deletions(-)
>
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 9a7004e680..6baf73b4b9 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -244,33 +244,6 @@ static JSONToken *parser_context_peek_token(JSONPars=
erContext *ctxt)
>      return g_queue_peek_head(ctxt->buf);
>  }
>=20=20
> -static JSONParserContext *parser_context_new(GQueue *tokens)
> -{
> -    JSONParserContext *ctxt;
> -
> -    if (!tokens) {
> -        return NULL;
> -    }
> -
> -    ctxt =3D g_malloc0(sizeof(JSONParserContext));
> -    ctxt->buf =3D tokens;
> -
> -    return ctxt;
> -}
> -
> -/* to support error propagation, ctxt->err must be freed separately */
> -static void parser_context_free(JSONParserContext *ctxt)
> -{
> -    if (ctxt) {
> -        while (!g_queue_is_empty(ctxt->buf)) {
> -            parser_context_pop_token(ctxt);
> -        }
> -        g_free(ctxt->current);
> -        g_queue_free(ctxt->buf);
> -        g_free(ctxt);
> -    }
> -}
> -
>  /**
>   * Parsing rules
>   */
> @@ -577,18 +550,22 @@ static QObject *parse_value(JSONParserContext *ctxt=
, va_list *ap)
>=20=20
>  QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
>  {
> -    JSONParserContext *ctxt =3D parser_context_new(tokens);
> +    JSONParserContext ctxt =3D { .buf =3D tokens };
>      QObject *result;
>=20=20
> -    if (!ctxt) {
> +    if (!tokens) {
>          return NULL;
>      }
>=20=20
> -    result =3D parse_value(ctxt, ap);
> +    result =3D parse_value(&ctxt, ap);
>=20=20
> -    error_propagate(errp, ctxt->err);
> +    error_propagate(errp, ctxt.err);
>=20=20
> -    parser_context_free(ctxt);
> +    while (!g_queue_is_empty(ctxt.buf)) {
> +        parser_context_pop_token(&ctxt);
> +    }
> +    g_free(ctxt.current);
> +    g_queue_free(ctxt.buf);
>=20=20
>      return result;
>  }

A lovely simplification.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
