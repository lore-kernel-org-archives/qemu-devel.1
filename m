Received: from eggs.gnu.org ([2001:4830:134:3::10]:57147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffKJn-00008L-5V
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 03:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffKJk-0004hN-2o
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 03:22:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffKJj-0004h9-TB
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 03:22:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51BEC805A530
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:22:39 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-9-marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 09:22:37 +0200
In-Reply-To: <20180706121354.2021-9-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 14:13:50 +0200")
Message-ID: <87a7qqfhs2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/12] json-lexer: make it safe to call
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> We can easily avoid the burden of checking if the lexer was
> initialized prior to calling destroy by the caller, let's do it.
>
> This allows simplification in state tracking in later patches of the
> qmp-async RFC series.
>
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

Is this just on general principles[*], or does it enable simplifactions
later in this series?

I asked the same question for its predecessor, and you answered

    It allowed further simplification later in the series. I don't know if
    this is still necessary after the rebase and other changes [...]

Do you have an updated answer?
