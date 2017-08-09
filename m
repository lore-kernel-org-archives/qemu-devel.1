Received: from eggs.gnu.org ([2001:4830:134:3::10]:54920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfMwf-00057l-Nv
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfMwc-0000WG-EF
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:06:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfMwc-0000Vo-4h
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:06:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22F05C00DB9A
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 09:06:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-7-eblake@redhat.com>
Date: Wed, 09 Aug 2017 11:06:20 +0200
In-Reply-To: <20170804012551.2714-7-eblake@redhat.com> (Eric Blake's message
	of "Thu, 3 Aug 2017 20:25:35 -0500")
Message-ID: <87y3qtun3n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 06/22] qobject: Perform %% interpolation
 in qobject_from_jsonf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> We want -Wformat to catch blatant programming errors in format
> strings that we pass to qobject_from_jsonf().  But if someone
> were to pass a JSON string "'%s'" as the format string, gcc would
> insist that it be paired with a char* argument, even though our
> lexer does not recognize % sequences inside a JSON string.  You can
> bypass -Wformat checking by passing the Unicode escape \u0025 for
> %, but who wants to remember to type that?  So the solution is that
> anywhere we are relying on -Wformat checking, the caller should
> pass the usual printf %% escape sequence where a literal % is
> wanted on output.
>
> Note that since % can only appear in JSON inside a string, we don't
> have to teach the lexer how to parse any new % sequences, but instead
> only have to add code to the parser.  Likewise, the parser is still
> where we reject any attempt at mid-string % interpolation other than
> %% (this is only a runtime failure, rather than compile-time), but
> since we already document that qobject_from_jsonf() asserts on invalid
> usage, presumably anyone that is adding a new usage will have tested
> that their usage doesn't always fail.
>
> Simplify qstring_from_escaped_str() while touching it, by using
> bool, a more compact conditional, and qstring_append_chr().
> Likewise, improve the error message when parse_escape() is reached
> without interpolation (for example, if a client sends garbage
> rather than JSON over a QMP connection).
>
> The testsuite additions pass under valgrind, proving that we are
> indeed passing the reference of anything given through %p to the
> returned containing object, even when more than one object is
> interpolated.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qobject/json-lexer.c  |  6 ++++--
>  qobject/json-parser.c | 49 ++++++++++++++++++++++++-------------------------
>  qobject/qjson.c       |  4 ++--
>  tests/check-qjson.c   | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 80 insertions(+), 29 deletions(-)
>
> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
> index b846d2852d..599b7446b7 100644
> --- a/qobject/json-lexer.c
> +++ b/qobject/json-lexer.c
> @@ -32,9 +32,11 @@
>   * Extension for vararg handling in JSON construction, when using
>   * qobject_from_jsonf() instead of qobject_from_json() (this lexer
>   * actually accepts multiple forms of PRId64, but parse_escape() later
> - * filters to only parse the current platform's spelling):
> + * filters to only parse the current platform's spelling; meanwhile,
> + * JSON only allows % inside strings, where the parser handles %%, so
> + * we do not need to lex it here):

The parenthesis is becoming unwieldy.  Turn it into a note...

>   *
> - * %(PRI[du]64|(l|ll)?[ud]|[ipsf])
> + * %(PRI[du]64|(l|ll)?[ud]|[ipsf%])
>   *

... here?

>   */
>
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index 388aa7a386..daafe77a0c 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -120,25 +120,21 @@ static int hex2decimal(char ch)
>   *      \n
>   *      \r
>   *      \t
> - *      \u four-hex-digits 
> + *      \u four-hex-digits
> + *
> + * Additionally, if @percent is true, all % in @token must be doubled,
> + * replaced by a single % will be in the result; this allows -Wformat
> + * processing of qobject_from_jsonf().
>   */
>  static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
> -                                         JSONToken *token)
> +                                         JSONToken *token, bool percent)
>  {
>      const char *ptr = token->str;
>      QString *str;
> -    int double_quote = 1;
> -
> -    if (*ptr == '"') {
> -        double_quote = 1;
> -    } else {
> -        double_quote = 0;
> -    }
> -    ptr++;
> +    bool double_quote = *ptr++ == '"';
>
>      str = qstring_new();
> -    while (*ptr && 
> -           ((double_quote && *ptr != '"') || (!double_quote && *ptr != '\''))) {
> +    while (*ptr && *ptr != "'\""[double_quote]) {

Simpler:

       bool quote = *ptr++;

and then

       while (*ptr && *ptr != quote) {

Have you considered splitting the patch into one to simplify, and one to
implement %%?

>          if (*ptr == '\\') {
>              ptr++;
>
> @@ -205,12 +201,13 @@ static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
>                  goto out;
>              }
>          } else {
> -            char dummy[2];
> -
> -            dummy[0] = *ptr++;
> -            dummy[1] = 0;
> -
> -            qstring_append(str, dummy);
> +            if (*ptr == '%' && percent) {
> +                if (*++ptr != '%') {
> +                    parse_error(ctxt, token, "invalid %% sequence in string");
> +                    goto out;
> +                }
> +            }
> +            qstring_append_chr(str, *ptr++);
>          }
>      }
>
> @@ -455,13 +452,15 @@ static QObject *parse_escape(JSONParserContext *ctxt, va_list *ap)
>  {
>      JSONToken *token;
>
> -    if (ap == NULL) {
> -        return NULL;
> -    }
> -
>      token = parser_context_pop_token(ctxt);
>      assert(token && token->type == JSON_ESCAPE);
>
> +    if (ap == NULL) {
> +        parse_error(ctxt, token, "escape parsing for '%s' not requested",
> +                    token->str);
> +        return NULL;
> +    }
> +

When I manage to fat-finger a '%' into my QMP input, I now get this
error message instead of "Invalid JSON syntax".  Makes me go "what is
escape parsing, and how do I request it?"  Not an improvement, I'm
afraid.

>      if (!strcmp(token->str, "%p")) {
>          return va_arg(*ap, QObject *);
>      } else if (!strcmp(token->str, "%i")) {
> @@ -490,7 +489,7 @@ static QObject *parse_escape(JSONParserContext *ctxt, va_list *ap)
>      return NULL;
>  }
>
> -static QObject *parse_literal(JSONParserContext *ctxt)
> +static QObject *parse_literal(JSONParserContext *ctxt, bool percent)

Let's make it take va_list *ap instead, for symmetry with the other
parse_FOO().

>  {
>      JSONToken *token;
>
> @@ -499,7 +498,7 @@ static QObject *parse_literal(JSONParserContext *ctxt)
>
>      switch (token->type) {
>      case JSON_STRING:
> -        return QOBJECT(qstring_from_escaped_str(ctxt, token));
> +        return QOBJECT(qstring_from_escaped_str(ctxt, token, percent));
>      case JSON_INTEGER: {
>          /*
>           * Represent JSON_INTEGER as QNUM_I64 if possible, else as
> @@ -562,7 +561,7 @@ static QObject *parse_value(JSONParserContext *ctxt, va_list *ap)
>      case JSON_INTEGER:
>      case JSON_FLOAT:
>      case JSON_STRING:
> -        return parse_literal(ctxt);
> +        return parse_literal(ctxt, ap);
>      case JSON_KEYWORD:
>          return parse_keyword(ctxt);
>      default:
> diff --git a/qobject/qjson.c b/qobject/qjson.c
> index 210c290aa9..2244292d1a 100644
> --- a/qobject/qjson.c
> +++ b/qobject/qjson.c
> @@ -66,8 +66,7 @@ QObject *qobject_from_json(const char *string, Error **errp)
>   * Parses JSON input with interpolation of % sequences.
>   *
>   * The set of sequences recognized is compatible with gcc's -Wformat
> - * warnings, although not all printf sequences are valid.  All use of
> - * % must occur outside JSON strings.
> + * warnings, although not all printf sequences are valid.

Keep the "All use of %" sentence, but add ", except %% must occcur only
within JSON strings".

>   *
>   * %i - treat corresponding integer value as JSON bool
>   * %[l[l]]d, %PRId64 - treat sized integer value as signed JSON number
> @@ -75,6 +74,7 @@ QObject *qobject_from_json(const char *string, Error **errp)
>   * %f - treat double as JSON number (undefined for inf, NaN)
>   * %s - convert char * into JSON string (adds escapes, outer quotes)
>   * %p - embed QObject, transferring the reference to the returned object
> + * %% - literal %, usable only within JSON string

No need to repeat "only within JSON strings" then.

>   *
>   * IMPORTANT: This function aborts on error, thus it must not
>   * be used with untrusted arguments.
> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index 1ad1f41a52..31815b2d04 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -1408,6 +1408,55 @@ static void empty_input(void)
>      g_assert(obj == NULL);
>  }
>
> +static void percent_and_vararg(void)
> +{
> +    QObject *obj;
> +    QString *str;
> +    QList *list;
> +    Error *err = NULL;
> +
> +    /* Use of % escapes requires vararg form */
> +    obj = qobject_from_json("%d", &err);

Since %d is not recognized, this is a lexical error.  Okay.

> +    error_free_or_abort(&err);
> +    g_assert(!obj);
> +
> +    /* In normal form, % in strings is literal */
> +    obj = qobject_from_json("'%% %s \\u0025d'", &error_abort);
> +    str = qobject_to_qstring(obj);
> +    g_assert_cmpstr(qstring_get_str(str), ==, "%% %s %d");
> +    qobject_decref(obj);
> +
> +    /*
> +     * In vararg form, % in strings must be escaped (via the normal
> +     * printf-escaping, or via a \u escape).  The returned value now
> +     * owns references to any %p counterpart.
> +     */
> +    obj = qobject_from_jsonf("[ %p, '%% \\u0025s', %p ]",
> +                             qstring_from_str("one"),
> +                             qstring_from_str("three"));
> +    list = qobject_to_qlist(obj);
> +    str = qobject_to_qstring(qlist_pop(list));
> +    g_assert_cmpstr(qstring_get_str(str), ==, "one");
> +    QDECREF(str);
> +    str = qobject_to_qstring(qlist_pop(list));
> +    g_assert_cmpstr(qstring_get_str(str), ==, "% %s");
> +    QDECREF(str);
> +    str = qobject_to_qstring(qlist_pop(list));
> +    g_assert_cmpstr(qstring_get_str(str), ==, "three");
> +    QDECREF(str);
> +    g_assert(qlist_empty(list));
> +    qobject_decref(obj);

I get what you mean by "vararg form" and "normal form", but I'm afraid
it's less than obvious for the uninitiated.  What about

       /*
        * Check qobject_from_json() does not interpolate %
        */

       /* outside JSON string */
       obj = qobject_from_json("%d", &err);
       error_free_or_abort(&err);
       g_assert(!obj);

       /* within JSON string */
       obj = qobject_from_json("'%% %s \\u0025d'", &error_abort);
       str = qobject_to_qstring(obj);
       g_assert_cmpstr(qstring_get_str(str), ==, "%% %s %d");
       qobject_decref(obj);

       /*
        * Check how qobject_from_jsonf() interpolates %
        */

       obj = qobject_from_jsonf("[ %p, '%% \\u0025s', %p ]",
                                qstring_from_str("one"),
                                qstring_from_str("three"));

> +
> +    /* The following intentionally cause assertion failures */
> +
> +    /* In vararg form, %% must occur in strings */
> +    /* qobject_from_jsonf("%%"); */
> +    /* qobject_from_jsonf("{%%}"); */
> +
> +    /* In vararg form, strings must not use % except for %% */
> +    /* qobject_from_jsonf("'%s'", "unpaired"); */

Could use g_test_trap_subprocess().  Not sure it's worth the bother.

I hate code in comments.  Better:

       /* The following intentionally cause assertion failures */
   #if 0
       /* In vararg form, %% must occur in strings */
       qobject_from_jsonf("%%");
       qobject_from_jsonf("{%%}");

       /* In vararg form, strings must not use % except for %% */
       qobject_from_jsonf("'%s'", "unpaired");
   #endif

> +}
> +
>  static void unterminated_string(void)
>  {
>      Error *err = NULL;
> @@ -1540,6 +1589,7 @@ int main(int argc, char **argv)
>      g_test_add_func("/varargs/simple_varargs", simple_varargs);
>
>      g_test_add_func("/errors/empty_input", empty_input);
> +    g_test_add_func("/errors/percent_and_vararg", percent_and_vararg);
>      g_test_add_func("/errors/unterminated/string", unterminated_string);
>      g_test_add_func("/errors/unterminated/escape", unterminated_escape);
>      g_test_add_func("/errors/unterminated/sq_string", unterminated_sq_string);
