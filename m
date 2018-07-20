Received: from eggs.gnu.org ([2001:4830:134:3::10]:40883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgR6N-0005KG-7A
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fgR6K-00020J-0P
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:49:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fgR6J-000209-Pm
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 04:49:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F06326A98
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 08:49:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
	<20180719184111.5129-11-marcandre.lureau@redhat.com>
Date: Fri, 20 Jul 2018 10:49:21 +0200
In-Reply-To: <20180719184111.5129-11-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Jul 2018 20:41:03 +0200")
Message-ID: <87fu0es35a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/18] qjson: report an error if there
 are multiple results
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

> qobject_from_jsonv() returns a single object. Let's make sure that
> during parsing we don't leak an intermediary object. Instead of
> returning the last object, set a parsing error.
>
> Also, the lexer/parser keeps consuming all the data. There might be an
> error set earlier. Let's keep it and not call json_parser_parse() with
> the remaining data. Eventually, we may teach the message parser to
> stop consuming the data.

Took me a while to figure out what you mean :)

qobject_from_jsonv() feeds a complete string to the JSON parser, with
json_message_parser_feed().  This actually feeds one character after the
other to the lexer, via json_lexer_feed_char().

Whenever a character completes a token, the lexer feeds that token to
the streamer via a callback that is always json_message_process_token().

The attentive reader may wonder what it does with trailing characters
that aren't a complete token.  More on that below.

The streamer accumulates tokens, counting various parenthesis.  When all
counts are zero or any is negative, the group is complete, and is fed to
the parser via another callback.  That callback is parse_json() here.
There are more elsewhere.

The attentive reader may wonder what it does with trailing tokens that
aren't a complete group.  More on that below.

The callbacks all pass the tokens to json_parser_parse() to do the
actual parsing.  Returns the abstract syntax tree as QObject on success.

Note that the callback can be called any number of times.

In my opinion, this is over-engineered and under-thought.  There's more
flexibility than we're using, and the associated complexity breeds bugs.

In particular, parse_json() is wrong:

    s->result =3D json_parser_parse(tokens, s->ap, &s->err);

If the previous call succeeded, we leak its result.  This is the leak
you mentioned.

If any previous call set an error, we pass &s->err pointing to non-null,
which is forbidden.  If json_parser_parse() passed it to error_setg(),
this would crash.  Since it passes it only to error_propagate(), all
errors but the first one are ignored.  Latent crash bug.

If the last call succeeds and any previous call failed, the function
simultaneously succeeds and fails: we return both a result and set an
error.

Let's demonstrate these bugs before we fix them, by inserting the
appended patch before this one.

Are the other callbacks similarly buggy?  Turns out they're okay:

* handle_qmp_command() consumes result and error on each call.

* process_event() does, too.

* qmp_response() treats errors as fatal, and asserts "no previous
  response".

On trailing tokens that don't form a group: they get silently ignored,
as demonstrated by check-qjson test cases unterminated_array(),
unterminated_array_comma(), unterminated_dict(),
unterminated_dict_comma(), all marked BUG.

On trailing characters that don't form a token: they get silently
ignored, as demonstrated by check-qjson test cases
unterminated_string(), unterminated_sq_string(), unterminated_escape(),
all marked BUG, except when they aren't, as in test case
unterminated_literal().

The BUG marks are all gone at the end of this series.  I guess you're
fixing all that :)

Note that these "trailing characters / tokens are silently ignored" bugs
*do* affect the other callbacks.  Reproducer for handle_qmp_command():

    $ echo -e '{ "execute": "qmp_capabilities" }\n{ "execute": "query-name"=
 }\n"unterminated' | socat UNIX:test-qmp STDIO
    {"QMP": {"version": {"qemu": {"micro": 90, "minor": 12, "major": 2}, "p=
ackage": "v3.0.0-rc1-20-g6a024cd461"}, "capabilities": ["oob"]}}
    {"return": {}}
    {"return": {}}

Note there's no error reported for the last line.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qobject/qjson.c     | 16 +++++++++++++++-
>  tests/check-qjson.c | 11 +++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/qobject/qjson.c b/qobject/qjson.c
> index ee04e61096..8a9d116150 100644
> --- a/qobject/qjson.c
> +++ b/qobject/qjson.c
> @@ -22,6 +22,7 @@
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qnum.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qapi/qmp/qerror.h"
>  #include "qemu/unicode.h"
>=20=20
>  typedef struct JSONParsingState
> @@ -36,7 +37,20 @@ static void parse_json(JSONMessageParser *parser, GQue=
ue *tokens)
>  {
>      JSONParsingState *s =3D container_of(parser, JSONParsingState, parse=
r);
>=20=20
> -    s->result =3D json_parser_parse(tokens, s->ap, &s->err);
> +    if (s->result || s->err) {
> +        if (s->result) {
> +            qobject_unref(s->result);
> +            s->result =3D NULL;
> +            if (!s->err) {

Conditional is necessary because a previous call to json_parser_parse()
could have set s->err already.  Without it, error_setg() would fail the
assertion in error_setv() then.  Subtle.

> +                error_setg(&s->err, QERR_JSON_PARSING);

Hmm.  Is this really "Invalid JSON syntax"?  In a way, it is, because
RFC 7159 defines JSON-text as a single value.  Still, a friendlier error
message like "Expecting at most one JSON value" woun't hurt.

What if !tokens?  That shouldn't be an error.

> +            }
> +        }
> +        if (tokens) {
> +            g_queue_free_full(tokens, g_free);

g_queue_free_full(NULL, ...) doesn't work?!?  That would be lame.

> +        }
> +    } else {
> +        s->result =3D json_parser_parse(tokens, s->ap, &s->err);
> +    }
>  }

What about this:

       JSONParsingState *s =3D container_of(parser, JSONParsingState, parse=
r);
       Error *err =3D NULL;

       if (!tokens) {
           return;
       }
       if (s->result || s->err) {
           if (s->result) {
               qobject_unref(s->result);
               s->result =3D NULL;
               error_setg(&err, "Expecting at most one JSON value");
           }
           g_queue_free_full(tokens, g_free);
       } else {
           s->result =3D json_parser_parse(tokens, s->ap, &err);
       }
       error_propagate(&s->err, err);
       assert(!s->result !=3D !s->err);

>=20=20
>  QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **err=
p)
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index da582df3e9..7d3547e0cc 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -1417,6 +1417,16 @@ static void limits_nesting(void)
>      g_assert(obj =3D=3D NULL);
>  }
>=20=20
> +static void multiple_objects(void)
> +{
> +    Error *err =3D NULL;
> +    QObject *obj;
> +
> +    obj =3D qobject_from_json("{} {}", &err);
> +    g_assert(obj =3D=3D NULL);
> +    error_free_or_abort(&err);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -1454,6 +1464,7 @@ int main(int argc, char **argv)
>      g_test_add_func("/errors/invalid_dict_comma", invalid_dict_comma);
>      g_test_add_func("/errors/unterminated/literal", unterminated_literal=
);
>      g_test_add_func("/errors/limits/nesting", limits_nesting);
> +    g_test_add_func("/errors/multiple_objects", multiple_objects);
>=20=20
>      return g_test_run();
>  }

>From 18064b774ea7a79a9dbabe5cf75458f0326070d5 Mon Sep 17 00:00:00 2001
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 20 Jul 2018 10:22:41 +0200
Subject: [PATCH] check-qjson: Cover multiple JSON objects in same string

qobject_from_json() & friends misbehave when the JSON text has more
than one JSON value.  Add test coverage to demonstrate the bugs.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index da582df3e9..c5fd439263 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1417,6 +1417,25 @@ static void limits_nesting(void)
     g_assert(obj =3D=3D NULL);
 }
=20
+static void multiple_objects(void)
+{
+    Error *err =3D NULL;
+    QObject *obj;
+
+    /* BUG this leaks the syntax tree for "false" */
+    obj =3D qobject_from_json("false true", &err);
+    g_assert(qbool_get_bool(qobject_to(QBool, obj)));
+    g_assert(!err);
+    qobject_unref(obj);
+
+    /* BUG simultaneously succeeds and fails */
+    /* BUG calls json_parser_parse() with errp pointing to non-null */
+    obj =3D qobject_from_json("} true", &err);
+    g_assert(qbool_get_bool(qobject_to(QBool, obj)));
+    error_free_or_abort(&err);
+    qobject_unref(obj);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -1454,6 +1473,7 @@ int main(int argc, char **argv)
     g_test_add_func("/errors/invalid_dict_comma", invalid_dict_comma);
     g_test_add_func("/errors/unterminated/literal", unterminated_literal);
     g_test_add_func("/errors/limits/nesting", limits_nesting);
+    g_test_add_func("/errors/multiple_objects", multiple_objects);
=20
     return g_test_run();
 }
--=20
2.17.1
