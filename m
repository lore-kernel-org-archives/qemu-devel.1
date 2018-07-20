Received: from eggs.gnu.org ([2001:4830:134:3::10]:48584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgP5h-00009H-83
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgP5e-0003dX-64
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:40:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fgP5d-0003cy-UV
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:40:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5565DE9018
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 06:40:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
	<20180719184111.5129-10-marcandre.lureau@redhat.com>
Date: Fri, 20 Jul 2018 08:40:31 +0200
In-Reply-To: <20180719184111.5129-10-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Jul 2018 20:41:02 +0200")
Message-ID: <87k1pqtnog.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/18] json-parser: further simplify
 freeing JSONParserContext
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

> Use g_queue_free_full() directly.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qobject/json-parser.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 6baf73b4b9..0c0b478149 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -561,11 +561,8 @@ QObject *json_parser_parse(GQueue *tokens, va_list *=
ap, Error **errp)
>=20=20
>      error_propagate(errp, ctxt.err);
>=20=20
> -    while (!g_queue_is_empty(ctxt.buf)) {
> -        parser_context_pop_token(&ctxt);
> -    }
> +    g_queue_free_full(ctxt.buf, g_free);
>      g_free(ctxt.current);
> -    g_queue_free(ctxt.buf);
>=20=20
>      return result;
>  }

Enabled by our recent upgrade to GLib 2.40 (commit e7b3af81).

Dots into JSONParserContext, but it did so before the patch already.
Perhaps turning JSONParserContext into a proper abstract data type would
be slightly cleaner, but it doesn't seem worth the effort.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
