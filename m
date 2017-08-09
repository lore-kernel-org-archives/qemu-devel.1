Received: from eggs.gnu.org ([2001:4830:134:3::10]:34275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfLuL-00066d-Cr
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 04:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfLuG-0007E5-HN
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 04:00:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfLuG-0007Dm-7L
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:59:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-6-eblake@redhat.com>
Date: Wed, 09 Aug 2017 09:59:45 +0200
In-Reply-To: <20170804012551.2714-6-eblake@redhat.com> (Eric Blake's message
	of "Thu, 3 Aug 2017 20:25:34 -0500")
Message-ID: <87k22dw4r2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 05/22] qobject: Simplify
 qobject_from_jsonv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> qobject_from_jsonv() was unusual in that it took a va_list*, instead
> of the more typical va_list; this was so that callers could pass
> NULL to avoid % interpolation.  While this works under the hood, it
> is awkward for callers, so move the magic into qjson.c rather than
> in the public interface, and finally improve the documentation of
> qobject_from_jsonf().
>
> test-qobject-input-visitor.c's visitor_input_test_init_internal()
> was the only caller passing NULL, fix it to instead use a QObject
> created by the various callers, who now use the appropriate form
> of qobject_from_json*() according to whether % interpolation is
> desired.
>
> Once that is done, all remaining callers to qobject_from_jsonv() are
> passing &error_abort; drop this parameter to match the counterpart
> qobject_from_jsonf() which assert()s success instead.  Besides, all
> current callers that need interpolation live in the testsuite, where
> enforcing well-defined input by asserts can help catch typos, and
> where we should not be operating on dynamic untrusted arbitrary
> input in the first place.
>
> Asserting success has another nice benefit: if we pass more than one
> %p, but could return failure, we would have to worry about whether
> all arguments in the va_list had consistent refcount treatment (it
> should be an all-or-none decision on whether each QObject in the
> va_list had its reference count altered - but whichever way we
> prefer, it's a lot of overhead to ensure we do it for everything
> in the va_list even if we failed halfway through).  But now that we
> promise success, we can now easily promise that all %p arguments will
> now be cleaned up when freeing the returned object.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/qapi/qmp/qjson.h           |  2 +-
>  tests/libqtest.c                   | 10 ++------
>  qobject/qjson.c                    | 49 +++++++++++++++++++++++++++++++++++---
>  tests/test-qobject-input-visitor.c | 18 ++++++++------
>  4 files changed, 60 insertions(+), 19 deletions(-)
>
> diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
> index 6e84082d5f..9aacb1ccf6 100644
> --- a/include/qapi/qmp/qjson.h
> +++ b/include/qapi/qmp/qjson.h
> @@ -19,7 +19,7 @@
>
>  QObject *qobject_from_json(const char *string, Error **errp);
>  QObject *qobject_from_jsonf(const char *string, ...) GCC_FMT_ATTR(1, 2);
> -QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
> +QObject *qobject_from_jsonv(const char *string, va_list ap)
>      GCC_FMT_ATTR(1, 0);
>
>  QString *qobject_to_json(const QObject *obj);
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 99a07c246f..cde737ec5a 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -448,7 +448,6 @@ QDict *qtest_qmp_receive(QTestState *s)
>   */
>  void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
>  {
> -    va_list ap_copy;
>      QObject *qobj;
>      int log = getenv("QTEST_LOG") != NULL;
>      QString *qstr;
> @@ -463,13 +462,8 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
>      }
>      assert(*fmt);
>
> -    /* Going through qobject ensures we escape strings properly.
> -     * This seemingly unnecessary copy is required in case va_list
> -     * is an array type.
> -     */
> -    va_copy(ap_copy, ap);
> -    qobj = qobject_from_jsonv(fmt, &ap_copy, &error_abort);
> -    va_end(ap_copy);
> +    /* Going through qobject ensures we escape strings properly. */
> +    qobj = qobject_from_jsonv(fmt, ap);
>      qstr = qobject_to_json(qobj);
>
>      /*

Wait!  Oh, the va_copy() moves iinto qobject_from_jsonv().  Okay, I
guess.

> diff --git a/qobject/qjson.c b/qobject/qjson.c
> index 2e0930884e..210c290aa9 100644
> --- a/qobject/qjson.c
> +++ b/qobject/qjson.c
> @@ -35,7 +35,8 @@ static void parse_json(JSONMessageParser *parser, GQueue *tokens)
>      s->result = json_parser_parse_err(tokens, s->ap, &s->err);
>  }
>
> -QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
> +static QObject *qobject_from_json_internal(const char *string, va_list *ap,
> +                                           Error **errp)
>  {
>      JSONParsingState state = {};
>
> @@ -50,12 +51,31 @@ QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
>      return state.result;
>  }
>
> +/*
> + * Parses JSON input without interpolation.

Imperative mood, please.  Same elsewhere.

Suggest "without interpolation of % sequences".

> + *
> + * Returns a QObject matching the input on success, or NULL with
> + * an error set if the input is not valid JSON.
> + */
>  QObject *qobject_from_json(const char *string, Error **errp)
>  {
> -    return qobject_from_jsonv(string, NULL, errp);
> +    return qobject_from_json_internal(string, NULL, errp);
>  }
>
>  /*
> + * Parses JSON input with interpolation of % sequences.
> + *
> + * The set of sequences recognized is compatible with gcc's -Wformat
> + * warnings, although not all printf sequences are valid.  All use of
> + * % must occur outside JSON strings.
> + *
> + * %i - treat corresponding integer value as JSON bool
> + * %[l[l]]d, %PRId64 - treat sized integer value as signed JSON number
> + * %[l[l]]u, %PRIu64 - treat sized integer value as unsigned JSON number
> + * %f - treat double as JSON number (undefined for inf, NaN)
> + * %s - convert char * into JSON string (adds escapes, outer quotes)
> + * %p - embed QObject, transferring the reference to the returned object
> + *
>   * IMPORTANT: This function aborts on error, thus it must not
>   * be used with untrusted arguments.
>   */

Use the opportunity to stop shouting IMPORTANT?

> @@ -65,13 +85,36 @@ QObject *qobject_from_jsonf(const char *string, ...)
>      va_list ap;
>
>      va_start(ap, string);
> -    obj = qobject_from_jsonv(string, &ap, &error_abort);
> +    obj = qobject_from_json_internal(string, &ap, &error_abort);
>      va_end(ap);
>
>      assert(obj != NULL);
>      return obj;
>  }
>
> +/*
> + * va_list form of qobject_from_jsonf().
> + *
> + * IMPORTANT: This function aborts on error, thus it must not
> + * be used with untrusted arguments.
> + */
> +QObject *qobject_from_jsonv(const char *string, va_list ap)
> +{
> +    QObject *obj;
> +    va_list ap_copy;
> +
> +    /*
> +     * This seemingly unnecessary copy is required in case va_list
> +     * is an array type.
> +     */

--verbose?

> +    va_copy(ap_copy, ap);
> +    obj = qobject_from_json_internal(string, &ap_copy, &error_abort);
> +    va_end(ap_copy);
> +
> +    assert(obj != NULL);
> +    return obj;
> +}
> +
>  typedef struct ToJsonIterState
>  {
>      int indent;
> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
> index bcf02617dc..a9addd9f98 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -45,13 +45,11 @@ static void visitor_input_teardown(TestInputVisitorData *data,
>     function so that the JSON string used by the tests are kept in the test
>     functions (and not in main()). */
>  static Visitor *visitor_input_test_init_internal(TestInputVisitorData *data,
> -                                                 bool keyval,
> -                                                 const char *json_string,
> -                                                 va_list *ap)
> +                                                 bool keyval, QObject *obj)
>  {
>      visitor_input_teardown(data, NULL);
>
> -    data->obj = qobject_from_jsonv(json_string, ap, &error_abort);
> +    data->obj = obj;
>      g_assert(data->obj);
>
>      if (keyval) {
> @@ -69,10 +67,12 @@ Visitor *visitor_input_test_init_full(TestInputVisitorData *data,
>                                        const char *json_string, ...)
>  {
>      Visitor *v;
> +    QObject *obj;
>      va_list ap;
>
>      va_start(ap, json_string);
> -    v = visitor_input_test_init_internal(data, keyval, json_string, &ap);
> +    obj = qobject_from_jsonv(json_string, ap);
> +    v = visitor_input_test_init_internal(data, keyval, obj);
>      va_end(ap);
>      return v;
>  }
> @@ -82,10 +82,12 @@ Visitor *visitor_input_test_init(TestInputVisitorData *data,
>                                   const char *json_string, ...)
>  {
>      Visitor *v;
> +    QObject *obj;
>      va_list ap;
>
>      va_start(ap, json_string);
> -    v = visitor_input_test_init_internal(data, false, json_string, &ap);
> +    obj = qobject_from_jsonv(json_string, ap);
> +    v = visitor_input_test_init_internal(data, false, obj);
>      va_end(ap);
>      return v;
>  }
> @@ -100,7 +102,9 @@ Visitor *visitor_input_test_init(TestInputVisitorData *data,
>  static Visitor *visitor_input_test_init_raw(TestInputVisitorData *data,
>                                              const char *json_string)
>  {
> -    return visitor_input_test_init_internal(data, false, json_string, NULL);
> +    QObject *obj = qobject_from_json(json_string, &error_abort);
> +
> +    return visitor_input_test_init_internal(data, false, obj);
>  }
>
>  static void test_visitor_in_int(TestInputVisitorData *data,
