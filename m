Received: from eggs.gnu.org ([2001:4830:134:3::10]:53803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fgCHJ-0005ou-4p
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fgCHH-0005Jl-Qa
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:59:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fgCHH-0005JW-HP
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:59:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id c4-v6so8743396wrs.12
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 09:59:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87wotufijf.fsf@dusky.pond.sub.org>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-8-marcandre.lureau@redhat.com>
	<87wotufijf.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Jul 2018 18:59:41 +0200
Message-ID: <CAJ+F1CLZZB4BHp99sG0DFTDWx6=S3tgaDJncwLWXkhiMxqpZRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Hi

On Tue, Jul 17, 2018 at 9:06 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Let's make json_parser_parse_err() suck less, and simplify caller
>> error handling.
>
> Missing:
>
>    * monitor.c handle_qmp_command(): drop workaround
>
>>  * qga/main.c process_event() doesn't need further changes after
>>    previous cleanup.
>
> "Doesn't need further changes" yes, but I think it could use one.
> Consider:
>
>     obj =3D json_parser_parse_err(tokens, NULL, &err);
>     if (err) {
>         goto err;
>     }
>     qdict =3D qobject_to(QDict, obj);
>     if (!qdict) {
>         error_setg(&err, QERR_JSON_PARSING);
>         goto err;
>     }
>
> Before this patch, we get to the error_setg() when
> json_parser_parse_err() fails without setting an error, and when it
> succeeds but returns anything but a dictionary.  QERR_JSON_PARSING is
> appropriate for the first case, but not the second.
>
> This patch removes the first case.  Please improve the error message.
>

ok, replaced with

error_setg(&err, "Input must be a JSON object");

>>  * qobject/json-parser.c json_parser_parse()
>>    Ignores the error.
>
> Stupid wrapper that's used exactly once, in libqtest.c.  Let's use
> json_parser_parse_err() there, and drop the wrapper.  Let's rename
> json_parser_parse_err() to json_parser_parse() then.
>
>>  * qobject/qjson.c qobject_from_jsonv() via parse_json()
>>   - qobject_from_json()
>>     ~ block.c parse_json_filename() - removed workaround
>>     ~ block/rbd.c - abort (generated json - should never fail)
>>     ~ qapi/qobject-input-visitor.c - removed workaround
>>     ~ tests/check-qjson.c - abort, ok
>
> To be precise, we pass &error_abort and either assert or crash when it
> returns null.  Okay.  Same for other instances of "abort, ok" below.
>
> There are a few instances that don't abort.  First one when !utf8_out:
>
>         obj =3D qobject_from_json(json_in, utf8_out ? &error_abort : NULL=
);
>         if (utf8_out) {
>             str =3D qobject_to(QString, obj);
>             g_assert(str);
>             g_assert_cmpstr(qstring_get_str(str), =3D=3D, utf8_out);
>         } else {
>             g_assert(!obj);
>         }
>         qobject_unref(obj);
>
> It ignores the error.  Okay.
>
> Next one:
>
>     static void unterminated_string(void)
>     {
>         Error *err =3D NULL;
>         QObject *obj =3D qobject_from_json("\"abc", &err);
>         g_assert(!err);             /* BUG */
>         g_assert(obj =3D=3D NULL);
>     }
>
> This patch should fix the BUG.  We'll see at [*] below why it doens't.
>
>>     ~ tests/test-visitor-serialization.c - abort, ok
>>
>>   - qobject_from_jsonf()
>
> This is called qobject_from_jsonf_nofail() since commit f3e9cc9f7a1, and
> became the obvious wrapper around qobject_from_vjsonf_nofail() in commit
> 74670550ee0.  Please mention both new names.

Hmm this is not upstream yet :)

> I guess the commit message needs more updates for these recent changes
> below, but I'm glossing over that now, along with much of the patch,
> because I think I've found something more serious, explained at the end
> of the patch.
>
>>     Now dies in error_handle_fatal() instead of the assertion.
>
> Which assertion?  Ah, the one in qobject_from_vjsonf_nofail().
>
> The assertion is now dead, isn't it?

not upstream at least

>
>>     Only used in tests, ok.
>>
>>   - tests/test-qobject-input-visitor.c
>>   - tests/libqtest.c qmp_fd_sendv()
>>     Passes &error_abort, does nothing when qobject_from_jsonv() returns
>>     null.  The fix makes this catch invalid JSON instead of silently
>>     ignoring it.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  block.c                      | 5 -----
>>  monitor.c                    | 4 ----
>>  qapi/qobject-input-visitor.c | 5 -----
>>  qobject/json-parser.c        | 8 +++++++-
>>  4 files changed, 7 insertions(+), 15 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index ac8b3a3511..9046d66465 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -1478,11 +1478,6 @@ static QDict *parse_json_filename(const char *fil=
ename, Error **errp)
>>
>>      options_obj =3D qobject_from_json(filename, errp);
>>      if (!options_obj) {
>> -        /* Work around qobject_from_json() lossage TODO fix that */
>> -        if (errp && !*errp) {
>> -            error_setg(errp, "Could not parse the JSON options");
>> -            return NULL;
>> -        }
>>          error_prepend(errp, "Could not parse the JSON options: ");
>>          return NULL;
>>      }
>> diff --git a/monitor.c b/monitor.c
>> index ec40a80d81..a3efe96d1d 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -4112,10 +4112,6 @@ static void handle_qmp_command(JSONMessageParser =
*parser, GQueue *tokens)
>>      QMPRequest *req_obj;
>>
>>      req =3D json_parser_parse_err(tokens, NULL, &err);
>> -    if (!req && !err) {
>> -        /* json_parser_parse_err() sucks: can fail without setting @err=
 */
>> -        error_setg(&err, QERR_JSON_PARSING);
>> -    }
>>
>>      qdict =3D qobject_to(QDict, req);
>>      if (qdict) {
>> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
>> index da57f4cc24..3e88b27f9e 100644
>> --- a/qapi/qobject-input-visitor.c
>> +++ b/qapi/qobject-input-visitor.c
>> @@ -725,11 +725,6 @@ Visitor *qobject_input_visitor_new_str(const char *=
str,
>>      if (is_json) {
>>          obj =3D qobject_from_json(str, errp);
>>          if (!obj) {
>> -            /* Work around qobject_from_json() lossage TODO fix that */
>> -            if (errp && !*errp) {
>> -                error_setg(errp, "JSON parse error");
>> -                return NULL;
>> -            }
>>              return NULL;
>>          }
>>          args =3D qobject_to(QDict, obj);
>> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
>> index a5aa790d62..82c3167629 100644
>> --- a/qobject/json-parser.c
>> +++ b/qobject/json-parser.c
>> @@ -24,6 +24,7 @@
>>  #include "qapi/qmp/json-parser.h"
>>  #include "qapi/qmp/json-lexer.h"
>>  #include "qapi/qmp/json-streamer.h"
>> +#include "qapi/qmp/qerror.h"
>>
>>  typedef struct JSONParserContext
>>  {
>> @@ -591,7 +592,12 @@ QObject *json_parser_parse_err(GQueue *tokens, va_l=
ist *ap, Error **errp)
>    QObject *json_parser_parse_err(GQueue *tokens, va_list *ap, Error **er=
rp)
>    {
>        JSONParserContext *ctxt =3D parser_context_new(tokens);
>        QObject *result;
>
>        if (!ctxt) {
>            return NULL;
>
> [*] Still returns null without setting an error.  Two cases lumped into
> one: "no tokens due to empty input (not an error)", and "no tokens due
> to lexical error".  This is not the spot to distinguish the two, it
> needs to be done in its callers.  I figure the sane contract for

I tried to tackle that in the next iteration, but it's harder than it
looks like somehow ;)

> json_parser_parse_err() would be
>
> * If @tokens is null, return null.
> * Else if @tokens parse okay, return the parse tree.
> * Else set an error and return null.
>
> But then "always set an error if return NULL" is not possible.  Ideas?

That's okay, I'll document the function that way


>
>        }
>>
>>      result =3D parse_value(ctxt, ap);
>>
>> -    error_propagate(errp, ctxt->err);
>> +    if (!result && !ctxt->err) {
>> +        /* TODO: improve error reporting */
>> +        error_setg(errp, QERR_JSON_PARSING);
>> +    } else {
>> +        error_propagate(errp, ctxt->err);
>> +    }
>>
>>      parser_context_free(ctxt);
>



--=20
Marc-Andr=C3=A9 Lureau
