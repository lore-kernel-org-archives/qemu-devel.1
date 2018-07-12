Received: from eggs.gnu.org ([2001:4830:134:3::10]:42711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcI8-0001Zs-Ff
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcI5-0002xC-AL
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:09:56 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcI5-0002wg-55
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:09:53 -0400
Received: by mail-qt0-x243.google.com with SMTP id z8-v6so15649451qto.9
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:09:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-10-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ba8c6e4b-8c1c-52d8-6de4-80478f7f14a8@amsat.org>
Date: Thu, 12 Jul 2018 11:09:40 -0300
MIME-Version: 1.0
In-Reply-To: <20180712111221.20326-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/20] qobject: qobject_from_jsonv() is
 dangerous, hide it away
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 07/12/2018 08:12 AM, Markus Armbruster wrote:
> qobject_from_jsonv() takes ownership of %p arguments.  On failure, we
> can't generally know whether we failed before or after %p, so
> ownership becomes indeterminate.  To avoid leaks, callers passing %p
> must terminate on error, e.g. by passing &error_abort.  Trap for the
> unwary; document and give the function internal linkage.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/qapi/qmp/qjson.h |  2 --
>  qobject/qjson.c          | 13 ++++++++++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
> index 0db121bef9..4a225cf7d1 100644
> --- a/include/qapi/qmp/qjson.h
> +++ b/include/qapi/qmp/qjson.h
> @@ -15,8 +15,6 @@
>  #define QJSON_H
>  
>  QObject *qobject_from_json(const char *string, Error **errp);
> -QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
> -    GCC_FMT_ATTR(1, 0);
>  
>  QObject *qobject_from_vjsonf_nofail(const char *string, va_list)
>      GCC_FMT_ATTR(1, 0);
> diff --git a/qobject/qjson.c b/qobject/qjson.c
> index 2e450231ff..ab4040f235 100644
> --- a/qobject/qjson.c
> +++ b/qobject/qjson.c
> @@ -39,7 +39,18 @@ static void parse_json(JSONMessageParser *parser, GQueue *tokens)
>      s->result = json_parser_parse_err(tokens, s->ap, &s->err);
>  }
>  
> -QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
> +/*
> + * Parse @string as JSON value.
> + * If @ap is non-null, interpolate %-escapes.
> + * Takes ownership of %p arguments.
> + * On success, return the JSON value.
> + * On failure, store an error through @errp and return NULL.
> + * Ownership of %p arguments becomes indeterminate then.  To avoid
> + * leaks, callers passing %p must terminate on error, e.g. by passing
> + * &error_abort.
> + */
> +static QObject *qobject_from_jsonv(const char *string, va_list *ap,
> +                                   Error **errp)
>  {
>      JSONParsingState state = {};
>  
> 
