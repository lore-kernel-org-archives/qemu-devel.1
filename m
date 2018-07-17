Received: from eggs.gnu.org ([2001:4830:134:3::10]:54759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffK3u-0005Hd-Gp
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 03:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffK3r-0005uX-BC
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 03:06:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffK3r-0005u5-4L
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 03:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF9FB401EF05
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:06:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-8-marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 09:06:12 +0200
In-Reply-To: <20180706121354.2021-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 14:13:49 +0200")
Message-ID: <87wotufijf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/12] json-parser: always set an error if
 return NULL
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

> Let's make json_parser_parse_err() suck less, and simplify caller
> error handling.

Missing:

   * monitor.c handle_qmp_command(): drop workaround

>  * qga/main.c process_event() doesn't need further changes after
>    previous cleanup.

"Doesn't need further changes" yes, but I think it could use one.
Consider:

    obj =3D json_parser_parse_err(tokens, NULL, &err);
    if (err) {
        goto err;
    }
    qdict =3D qobject_to(QDict, obj);
    if (!qdict) {
        error_setg(&err, QERR_JSON_PARSING);
        goto err;
    }

Before this patch, we get to the error_setg() when
json_parser_parse_err() fails without setting an error, and when it
succeeds but returns anything but a dictionary.  QERR_JSON_PARSING is
appropriate for the first case, but not the second.

This patch removes the first case.  Please improve the error message.

>  * qobject/json-parser.c json_parser_parse()
>    Ignores the error.

Stupid wrapper that's used exactly once, in libqtest.c.  Let's use
json_parser_parse_err() there, and drop the wrapper.  Let's rename
json_parser_parse_err() to json_parser_parse() then.

>  * qobject/qjson.c qobject_from_jsonv() via parse_json()
>   - qobject_from_json()
>     ~ block.c parse_json_filename() - removed workaround
>     ~ block/rbd.c - abort (generated json - should never fail)
>     ~ qapi/qobject-input-visitor.c - removed workaround
>     ~ tests/check-qjson.c - abort, ok

To be precise, we pass &error_abort and either assert or crash when it
returns null.  Okay.  Same for other instances of "abort, ok" below.

There are a few instances that don't abort.  First one when !utf8_out:

        obj =3D qobject_from_json(json_in, utf8_out ? &error_abort : NULL);
        if (utf8_out) {
            str =3D qobject_to(QString, obj);
            g_assert(str);
            g_assert_cmpstr(qstring_get_str(str), =3D=3D, utf8_out);
        } else {
            g_assert(!obj);
        }
        qobject_unref(obj);

It ignores the error.  Okay.

Next one:

    static void unterminated_string(void)
    {
        Error *err =3D NULL;
        QObject *obj =3D qobject_from_json("\"abc", &err);
        g_assert(!err);             /* BUG */
        g_assert(obj =3D=3D NULL);
    }

This patch should fix the BUG.  We'll see at [*] below why it doens't.

>     ~ tests/test-visitor-serialization.c - abort, ok
>
>   - qobject_from_jsonf()

This is called qobject_from_jsonf_nofail() since commit f3e9cc9f7a1, and
became the obvious wrapper around qobject_from_vjsonf_nofail() in commit
74670550ee0.  Please mention both new names.

I guess the commit message needs more updates for these recent changes
below, but I'm glossing over that now, along with much of the patch,
because I think I've found something more serious, explained at the end
of the patch.

>     Now dies in error_handle_fatal() instead of the assertion.

Which assertion?  Ah, the one in qobject_from_vjsonf_nofail().

The assertion is now dead, isn't it?

>     Only used in tests, ok.
>
>   - tests/test-qobject-input-visitor.c
>   - tests/libqtest.c qmp_fd_sendv()
>     Passes &error_abort, does nothing when qobject_from_jsonv() returns
>     null.  The fix makes this catch invalid JSON instead of silently
>     ignoring it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block.c                      | 5 -----
>  monitor.c                    | 4 ----
>  qapi/qobject-input-visitor.c | 5 -----
>  qobject/json-parser.c        | 8 +++++++-
>  4 files changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/block.c b/block.c
> index ac8b3a3511..9046d66465 100644
> --- a/block.c
> +++ b/block.c
> @@ -1478,11 +1478,6 @@ static QDict *parse_json_filename(const char *file=
name, Error **errp)
>=20=20
>      options_obj =3D qobject_from_json(filename, errp);
>      if (!options_obj) {
> -        /* Work around qobject_from_json() lossage TODO fix that */
> -        if (errp && !*errp) {
> -            error_setg(errp, "Could not parse the JSON options");
> -            return NULL;
> -        }
>          error_prepend(errp, "Could not parse the JSON options: ");
>          return NULL;
>      }
> diff --git a/monitor.c b/monitor.c
> index ec40a80d81..a3efe96d1d 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4112,10 +4112,6 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
>      QMPRequest *req_obj;
>=20=20
>      req =3D json_parser_parse_err(tokens, NULL, &err);
> -    if (!req && !err) {
> -        /* json_parser_parse_err() sucks: can fail without setting @err =
*/
> -        error_setg(&err, QERR_JSON_PARSING);
> -    }
>=20=20
>      qdict =3D qobject_to(QDict, req);
>      if (qdict) {
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index da57f4cc24..3e88b27f9e 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -725,11 +725,6 @@ Visitor *qobject_input_visitor_new_str(const char *s=
tr,
>      if (is_json) {
>          obj =3D qobject_from_json(str, errp);
>          if (!obj) {
> -            /* Work around qobject_from_json() lossage TODO fix that */
> -            if (errp && !*errp) {
> -                error_setg(errp, "JSON parse error");
> -                return NULL;
> -            }
>              return NULL;
>          }
>          args =3D qobject_to(QDict, obj);
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index a5aa790d62..82c3167629 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -24,6 +24,7 @@
>  #include "qapi/qmp/json-parser.h"
>  #include "qapi/qmp/json-lexer.h"
>  #include "qapi/qmp/json-streamer.h"
> +#include "qapi/qmp/qerror.h"
>=20=20
>  typedef struct JSONParserContext
>  {
> @@ -591,7 +592,12 @@ QObject *json_parser_parse_err(GQueue *tokens, va_li=
st *ap, Error **errp)
   QObject *json_parser_parse_err(GQueue *tokens, va_list *ap, Error **errp)
   {
       JSONParserContext *ctxt =3D parser_context_new(tokens);
       QObject *result;

       if (!ctxt) {
           return NULL;

[*] Still returns null without setting an error.  Two cases lumped into
one: "no tokens due to empty input (not an error)", and "no tokens due
to lexical error".  This is not the spot to distinguish the two, it
needs to be done in its callers.  I figure the sane contract for
json_parser_parse_err() would be

* If @tokens is null, return null.
* Else if @tokens parse okay, return the parse tree.
* Else set an error and return null.

But then "always set an error if return NULL" is not possible.  Ideas?

       }
>=20=20
>      result =3D parse_value(ctxt, ap);
>=20=20
> -    error_propagate(errp, ctxt->err);
> +    if (!result && !ctxt->err) {
> +        /* TODO: improve error reporting */
> +        error_setg(errp, QERR_JSON_PARSING);
> +    } else {
> +        error_propagate(errp, ctxt->err);
> +    }
>=20=20
>      parser_context_free(ctxt);
