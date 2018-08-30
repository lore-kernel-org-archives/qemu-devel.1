Received: from eggs.gnu.org ([2001:4830:134:3::10]:39796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvLxn-0001ta-6K
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvLsj-0003LN-IN
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:17:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvLsi-0003Jw-He
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:17:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBFA9804B9F4
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 12:16:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
	<20180829134043.31706-6-marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 14:16:51 +0200
In-Reply-To: <20180829134043.31706-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 29 Aug 2018 15:40:38 +0200")
Message-ID: <87wos83v7w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 05/10] json-lexer: make it safe to call
 destroy multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> We can easily avoid the burden of checking if the lexer was
> initialized prior to calling destroy by the caller, let's do it.
>
> This allows simplification in state tracking in the qmp-async RFC
> series, the patch "qmp: add QmpSession" can call qmp_session_destroy()
> multiple time, which in turns calls json_lexer_destroy().
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qobject/json-lexer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
> index e1745a3d95..39969047f4 100644
> --- a/qobject/json-lexer.c
> +++ b/qobject/json-lexer.c
> @@ -351,5 +351,8 @@ void json_lexer_flush(JSONLexer *lexer)
>=20=20
>  void json_lexer_destroy(JSONLexer *lexer)
>  {
> -    g_string_free(lexer->token, true);
> +    if (lexer->token) {
> +        g_string_free(lexer->token, true);
> +        lexer->token =3D NULL;
> +    }
>  }

Please stick this patch into the series its commit message refers to.
