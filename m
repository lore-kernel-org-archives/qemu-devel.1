Received: from eggs.gnu.org ([2001:4830:134:3::10]:59294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnjaI-0006kS-Qh
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnjaF-0005A7-P1
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:58:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnjaF-00059r-JX
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:58:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E53EC40241C8
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 11:58:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
	<20180719184111.5129-15-marcandre.lureau@redhat.com>
Date: Thu, 09 Aug 2018 13:58:22 +0200
In-Reply-To: <20180719184111.5129-15-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Jul 2018 20:41:07 +0200")
Message-ID: <87sh3niwf5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/18] json-lexer: make it safe to call
 multiple times
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

> We can easily avoid the burden of checking if the lexer was
> initialized prior to calling destroy by the caller, let's do it.
>
> This allows simplification in state tracking in later patches of the
> qmp-async RFC series.

Please include the patch in that series, where I can see its utility.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qobject/json-lexer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
> index 980ba159d6..0eaba43a2c 100644
> --- a/qobject/json-lexer.c
> +++ b/qobject/json-lexer.c
> @@ -386,5 +386,8 @@ int json_lexer_flush(JSONLexer *lexer)
>=20=20
>  void json_lexer_destroy(JSONLexer *lexer)
>  {
> -    g_string_free(lexer->token, true);
> +    if (lexer->token) {
> +        g_string_free(lexer->token, true);
> +        lexer->token =3D NULL;
> +    }
>  }
