Received: from eggs.gnu.org ([2001:4830:134:3::10]:45098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfSO7-00014s-2j
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfSO1-0000o0-1P
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:55:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfSO0-0000mL-OF
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:55:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F96F31E433
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 14:55:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-14-eblake@redhat.com>
Date: Wed, 09 Aug 2017 16:54:58 +0200
In-Reply-To: <20170804012551.2714-14-eblake@redhat.com> (Eric Blake's message
	of "Thu, 3 Aug 2017 20:25:42 -0500")
Message-ID: <87inhwokot.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 13/22] libqtest: Add qmp_raw()
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

> The majority of calls into libqtest's qmp() and friends are passing
> a JSON object that includes a command name; we can prove this by
> adding an assertion.  The only outlier is qmp-test, which is testing
> appropriate error responses to protocol violations and id support,
> by sending raw strings, where those raw strings don't need
> interpolation anyways.
>
> Adding a new entry-point makes a clean separation of which input
> needs interpolation, so that upcoming patches can refactor qmp()
> to be more like the recent additions to test-qga in taking the
> command name separately from the arguments for an overall
> reduction in testsuite boilerplate.
>
> This change also lets us move the workaround for the QMP parser
> limitation of not ending a parse until } or newline: all calls
> through qmp() are passing an object ending in }, so only the
> few callers of qmp_raw() have to worry about a trailing newline.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h |  8 ++++++++
>  tests/libqtest.c | 13 +++++++------
>  tests/qmp-test.c | 19 ++++++++++++-------
>  3 files changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 33af3ae8ff..917ec5cf92 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -550,6 +550,14 @@ static inline void qtest_end(void)
>  QDict *qmp(const char *fmt, ...);
>
>  /**
> + * qmp_raw:
> + * @msg: Raw QMP message to send to qemu.
> + *
> + * Sends a QMP message to QEMU and returns the response.
> + */
> +QDict *qmp_raw(const char *msg);
> +
> +/**
>   * qmp_async:
>   * @fmt...: QMP message to send to qemu; formats arguments through
>   * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 0fa32928c8..3071be2efb 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -451,7 +451,7 @@ static void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
>      QString *qstr;
>      const char *str;
>
> -    assert(*fmt);
> +    assert(strstr(fmt, "execute"));

I doubt this assertion is worthwhile.

One , qmp_fd_sendv() works just fine whether you include an 'execute' or
not.  Two, there are zillions of other ways to send nonsense with
qmp_fd_sendv().  If you do, your test doesn't work, so you fix it.

Rejecting nonsensical QMP input is QEMU's job, not libqtest's.

>
>      /*
>       * A round trip through QObject is only needed if % interpolation
> @@ -496,11 +496,6 @@ void qmp_fd_send(int fd, const char *msg)
>      }
>      /* Send QMP request */
>      socket_send(fd, msg, strlen(msg));
> -    /*
> -     * BUG: QMP doesn't react to input until it sees a newline, an
> -     * object, or an array.  Work-around: give it a newline.
> -     */
> -    socket_send(fd, "\n", 1);
>  }
>
>  QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
> @@ -899,6 +894,12 @@ QDict *qmp(const char *fmt, ...)
>      return response;
>  }
>
> +QDict *qmp_raw(const char *msg)
> +{
> +    qmp_fd_send(global_qtest->qmp_fd, msg);
> +    return qtest_qmp_receive(global_qtest);
> +}
> +
>  void qmp_async(const char *fmt, ...)
>  {
>      va_list ap;
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index 5d0260b2be..905fb4b3e5 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -44,28 +44,33 @@ static void test_malformed(void)
>  {
>      QDict *resp;
>
> +    /*
> +     * BUG: QMP doesn't react to input until it sees a newline, an
> +     * object, or an array.  Work-around: give it a newline.
> +     */
> +
>      /* Not even a dictionary */
> -    resp = qmp("null");
> +    resp = qmp_raw("null\n");
>      g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>      QDECREF(resp);
>
>      /* No "execute" key */
> -    resp = qmp("{}");
> +    resp = qmp_raw("{}");
>      g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>      QDECREF(resp);
>
>      /* "execute" isn't a string */
> -    resp = qmp("{ 'execute': true }");
> +    resp = qmp_raw("{ 'execute': true }");
>      g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>      QDECREF(resp);
>
>      /* "arguments" isn't a dictionary */
> -    resp = qmp("{ 'execute': 'no-such-cmd', 'arguments': [] }");
> +    resp = qmp_raw("{ 'execute': 'no-such-cmd', 'arguments': [] }");
>      g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>      QDECREF(resp);
>
>      /* extra key */
> -    resp = qmp("{ 'execute': 'no-such-cmd', 'extra': true }");
> +    resp = qmp_raw("{ 'execute': 'no-such-cmd', 'extra': true }");
>      g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>      QDECREF(resp);
>  }
> @@ -114,14 +119,14 @@ static void test_qmp_protocol(void)
>      test_malformed();
>
>      /* Test 'id' */
> -    resp = qmp("{ 'execute': 'query-name', 'id': 'cookie#1' }");
> +    resp = qmp_raw("{ 'execute': 'query-name', 'id': 'cookie#1' }");
>      ret = qdict_get_qdict(resp, "return");
>      g_assert(ret);
>      g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, "cookie#1");
>      QDECREF(resp);
>
>      /* Test command failure with 'id' */
> -    resp = qmp("{ 'execute': 'human-monitor-command', 'id': 2 }");
> +    resp = qmp_raw("{ 'execute': 'human-monitor-command', 'id': 2 }");
>      g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>      g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
>      QDECREF(resp);

I'm afraid I don't like this patch.  All the extra function buys us is
an assertion that isn't even tight, and the lifting of a newline out of
a place where it shouldn't be.
