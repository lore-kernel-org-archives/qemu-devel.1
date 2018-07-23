Received: from eggs.gnu.org ([2001:4830:134:3::10]:43209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhW0J-0000aV-Hz
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhW0G-0006dm-8B
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:15:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fhW0F-0006cU-UM
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:15:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DD8A401EF01
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 08:15:35 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
	<20180719184111.5129-14-marcandre.lureau@redhat.com>
Date: Mon, 23 Jul 2018 10:15:31 +0200
In-Reply-To: <20180719184111.5129-14-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Jul 2018 20:41:06 +0200")
Message-ID: <877elmbc64.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/18] json-parser: set an error if
 parsing returned NULL
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

> Let's make json_parser_parse_err() suck less, and simplify caller
> error handling.

Let's state what's wrong with it first, like this:

  json_parser_parse_err() returns null on empty input and on parse error.
  In the latter case, it sometimes, but not always sets an error.  This
  sucks.  Fix it to always set an error, and simplify callers.

>  * monitor.c handle_qmp_command(): drop workaround
>
>  * qga/main.c process_event(): improve error report, QERR_JSON_PARSING
>    case is handled by json_parser_parse_err() now.
>
>  * qobject/json-parser.c json_parser_parse(): Ignores the error.
>
>  * qobject/qjson.c qobject_from_jsonv() via parse_json()
>   - qobject_from_json()
>     ~ block.c parse_json_filename() - removed workaround
>     ~ block/rbd.c - abort (generated json - should never fail)

Actually, we improve the failure from "qlist_size() crashes" to "the new
error_setg() aborts".

>     ~ qapi/qobject-input-visitor.c - removed workaround
>     ~ tests/check-qjson.c - assert or crash
>     ~ tests/test-visitor-serialization.c - assert or crash
>
>   - qobject_from_jsonf()
>     Now dies in error_handle_fatal() instead of the assertion.
>     Only used in tests, ok.
>
>   - tests/test-qobject-input-visitor.c
>   - tests/libqtest.c qmp_fd_sendv()
>     Passes &error_abort, does nothing when qobject_from_jsonv() returns
>     null.  The fix makes this catch invalid JSON instead of silently
>     ignoring it.
>
> Update the function documentation for possible return values.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block.c                      |  5 -----
>  monitor.c                    |  4 ----
>  qapi/qobject-input-visitor.c |  5 -----
>  qga/main.c                   |  2 +-
>  qobject/json-parser.c        | 16 +++++++++++++++-
>  5 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/block.c b/block.c
> index a2fe05ea96..42eaa8b7dc 100644
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

Crashes if qobject_from_json() returns null without setting an error,
e.g. when input is empty:

    (gdb) p parse_json_filename("json: ", &error_abort)
    [Thread 0x7fffd5bb8700 (LWP 10318) exited]

    Thread 1 "upstream-qemu" received signal SIGSEGV, Segmentation fault.
    error_vprepend (errp=3D0x555556850110 <error_abort>,=20
        fmt=3D0x555556044a30 "Could not parse the JSON options: ", ap=3D0x7=
fffffffd9b0)
        at /work/armbru/qemu/util/error.c:136
    136	    g_string_append(newmsg, (*errp)->msg);


>          return NULL;
>      }
> diff --git a/monitor.c b/monitor.c
> index 2abb3c2fc7..5a41a230b9 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4114,10 +4114,6 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
>      QMPRequest *req_obj;
>=20=20
>      req =3D json_parser_parse(tokens, NULL, &err);
> -    if (!req && !err) {
> -        /* json_parser_parse() sucks: can fail without setting @err */
> -        error_setg(&err, QERR_JSON_PARSING);
> -    }
>=20=20
>      qdict =3D qobject_to(QDict, req);
>      if (qdict) {

What if json_parser_parse() returns null without setting an error?  It
can when @tokens is null.  Hmm...

    $ gdb --args upstream-qemu -nodefaults -S -display none -qmp stdio
    [...]
    (gdb) r
    [...]
    {"QMP": {"version": {"qemu": {"micro": 90, "minor": 12, "major": 2}, "p=
ackage": "v3.0.0-rc1-23-ga18a0aefe5"}, "capabilities": []}}
    [New Thread 0x7fffd5c38700 (LWP 11878)]
    @
    upstream-qemu: /work/armbru/qemu/monitor.c:4088: monitor_qmp_bh_dispatc=
her: Assertion `req_obj->err' failed.

    Thread 1 "upstream-qemu" received signal SIGABRT, Aborted.
    0x00007fffec607feb in raise () from /lib64/libc.so.6
    [...]
    (gdb) bt
    #0  0x00007fffec607feb in raise () at /lib64/libc.so.6
    #1  0x00007fffec5f25c1 in abort () at /lib64/libc.so.6
    #2  0x00007fffec5f2491 in _nl_load_domain.cold.0 () at /lib64/libc.so.6
    #3  0x00007fffec600752 in  () at /lib64/libc.so.6
    #4  0x0000555555874236 in monitor_qmp_bh_dispatcher (data=3D0x0)
        at /work/armbru/qemu/monitor.c:4088
    [...]

Crash on lexical error.  See review of json_parser_parse() below.

We lack test coverage.  Patch appended.

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

Likewise, what if json_parser_parse() returns null without setting an
error?

> diff --git a/qga/main.c b/qga/main.c
> index 043f7c3ead..9032bb0c7a 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -614,7 +614,7 @@ static void process_event(JSONMessageParser *parser, =
GQueue *tokens)
>      }
>      req =3D qobject_to(QDict, obj);
>      if (!req) {
> -        error_setg(&err, QERR_JSON_PARSING);
> +        error_setg(&err, "Input must be a JSON object");

Commit message explains why this is appropriate.  Good.

>          goto err;
>      }
>      if (!qdict_haskey(req, "execute")) {
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 0c0b478149..c3b0c216cf 100644
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
> @@ -548,6 +549,14 @@ static QObject *parse_value(JSONParserContext *ctxt,=
 va_list *ap)
>      }
>  }
>=20=20
> +/**
> + * json_parser_parse:
> + *
> + * If @tokens is null, return null.
> + * Else if @tokens parse okay, return the parse tree.
> + * Else set an error and return null.
> + *
> + **/

We end doc comments with an unadorned */, in accordance with the GTK-Doc
manual.

The @tokens argument always comes from json_message_process_token():

    out_emit_bad:
        /*
         * Clear out token list and tell the parser to emit an error
         * indication by passing it a NULL list
         */
        json_message_free_tokens(parser);
    out_emit:
        /* send current list of tokens to parser and reset tokenizer */
        parser->brace_count =3D 0;
        parser->bracket_count =3D 0;
        /* parser->emit takes ownership of parser->tokens.  Remove our own
         * reference to parser->tokens before handing it out to parser->emi=
t.
         */
        tokens =3D parser->tokens;
        parser->tokens =3D g_queue_new();
        parser->emit(parser, tokens);

parser->tokens is null exactly when we pass out_emit_bad.

Thus, the intent of null @tokens is to signal a lexical error.

Aside: there's no way to pass information on the error along with this
signal, but that's not this patch's problem.

>  QObject *json_parser_parse(GQueue *tokens, va_list *ap, Error **errp)
>  {
>      JSONParserContext ctxt =3D { .buf =3D tokens };
> @@ -559,7 +568,12 @@ QObject *json_parser_parse(GQueue *tokens, va_list *=
ap, Error **errp)
       QObject *result;

       if (!tokens) {
           return NULL;
       }

This does not match the intent declared in json_message_process_token().

>=20=20
>      result =3D parse_value(&ctxt, ap);
>=20=20
> -    error_propagate(errp, ctxt.err);
> +    if (!result && !ctxt.err) {
> +        /* TODO: improve error reporting */

I'd point out the issue explicitly here: parse_value() can return null
without setting ctxt.err.  No need to make more specific claims.
Although A quick eye over suggests parse_escape() is to blame.

> +        error_setg(errp, QERR_JSON_PARSING);
> +    } else {
> +        error_propagate(errp, ctxt.err);
> +    }
>=20=20
>      g_queue_free_full(ctxt.buf, g_free);
>      g_free(ctxt.current);

I hope the JSON parser simplifications I have in mind will help take
care of this patch's issues, too.


>From f469aabeb5950d4891fbf5fa3a76ea333f540848 Mon Sep 17 00:00:00 2001
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 23 Jul 2018 10:08:29 +0200
Subject: [PATCH] check-qjson: Cover blank and lexically erroneous input

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index d0144ba93c..3acd5a37a3 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1306,8 +1306,27 @@ static void simple_varargs(void)
=20
 static void empty_input(void)
 {
-    const char *empty =3D "";
-    QObject *obj =3D qobject_from_json(empty, &error_abort);
+    QObject *obj =3D qobject_from_json("", &error_abort);
+    g_assert(obj =3D=3D NULL);
+}
+
+static void blank_input(void)
+{
+    QObject *obj =3D qobject_from_json("", &error_abort);
+    g_assert(obj =3D=3D NULL);
+}
+
+static void junk_input(void)
+{
+    Error *err =3D NULL;
+    QObject *obj;
+
+    obj =3D qobject_from_json("@", &err);
+    error_free_or_abort(&err);
+    g_assert(obj =3D=3D NULL);
+
+    obj =3D qobject_from_json("{@", &err);
+    error_free_or_abort(&err);
     g_assert(obj =3D=3D NULL);
 }
=20
@@ -1452,7 +1471,9 @@ int main(int argc, char **argv)
=20
     g_test_add_func("/varargs/simple_varargs", simple_varargs);
=20
-    g_test_add_func("/errors/empty_input", empty_input);
+    g_test_add_func("/errors/empty", empty_input);
+    g_test_add_func("/errors/blank", blank_input);
+    g_test_add_func("/errors/junk", junk_input);
     g_test_add_func("/errors/unterminated/string", unterminated_string);
     g_test_add_func("/errors/unterminated/escape", unterminated_escape);
     g_test_add_func("/errors/unterminated/sq_string", unterminated_sq_stri=
ng);
--=20
2.17.1
