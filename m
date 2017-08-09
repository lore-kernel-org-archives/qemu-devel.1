Received: from eggs.gnu.org ([2001:4830:134:3::10]:60033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfSi3-0000fh-29
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfSi1-0005Mz-86
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:15:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-15-eblake@redhat.com>
Date: Wed, 09 Aug 2017 17:15:26 +0200
In-Reply-To: <20170804012551.2714-15-eblake@redhat.com> (Eric Blake's message
	of "Thu, 3 Aug 2017 20:25:43 -0500")
Message-ID: <87d184ojqp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 14/22] libqtest: Separate
 qmp_discard_response() from command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> Upcoming patches will be adding new convenience methods for
> constructing QMP commands.  But making every variation of sending
> support every variation of response handling becomes unwieldy;
> it's easier to specify that discarding a JSON response is
> unassociated with sending the command, where qmp_async() already
> fits the bill for sending a command without tying up a reference
> to the response.
>
> Doing this renders qtest_qmp[v]_discard_response() unused.
>
> Bonus: gets rid of a non-literal format string, which is a step
> towards compile-time format string checking without triggering
> -Wformat-nonliteral.

Where?  (I'm feeling lazy today)

>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h               | 27 ++-------------------------
>  tests/libqtest.c               | 30 ++++++------------------------
>  tests/ahci-test.c              | 20 ++++++++++----------
>  tests/boot-order-test.c        |  2 +-
>  tests/drive_del-test.c         |  5 +++--
>  tests/fdc-test.c               | 11 ++++++-----
>  tests/ide-test.c               |  5 ++---
>  tests/postcopy-test.c          |  3 ++-
>  tests/test-filter-mirror.c     |  3 ++-
>  tests/test-filter-redirector.c |  6 ++++--
>  tests/virtio-blk-test.c        | 21 ++++++++++++---------
>  11 files changed, 50 insertions(+), 83 deletions(-)
>
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 917ec5cf92..6bae0223aa 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -48,16 +48,6 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
>  void qtest_quit(QTestState *s);
>
>  /**
> - * qtest_qmp_discard_response:
> - * @s: #QTestState instance to operate on.
> - * @fmt...: QMP message to send to qemu; formats arguments through
> - * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
> - *
> - * Sends a QMP message to QEMU and consumes the response.
> - */
> -void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
> -
> -/**
>   * qtest_qmp:
>   * @s: #QTestState instance to operate on.
>   * @fmt...: QMP message to send to qemu; formats arguments through
> @@ -78,17 +68,6 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
>  void qtest_async_qmp(QTestState *s, const char *fmt, ...);
>
>  /**
> - * qtest_qmpv_discard_response:
> - * @s: #QTestState instance to operate on.
> - * @fmt: QMP message to send to QEMU; formats arguments through
> - * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
> - * @ap: QMP message arguments
> - *
> - * Sends a QMP message to QEMU and consumes the response.
> - */
> -void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
> -
> -/**
>   * qtest_qmpv:
>   * @s: #QTestState instance to operate on.
>   * @fmt: QMP message to send to QEMU; formats arguments through
> @@ -568,12 +547,10 @@ void qmp_async(const char *fmt, ...);
>
>  /**
>   * qmp_discard_response:
> - * @fmt...: QMP message to send to qemu; formats arguments through
> - * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
>   *
> - * Sends a QMP message to QEMU and consumes the response.
> + * Read and discard a QMP response, typically after qmp_async().
>   */
> -void qmp_discard_response(const char *fmt, ...);
> +void qmp_discard_response(void);
>
>  /**
>   * qmp_receive:
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 3071be2efb..f9781d67f5 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -235,7 +235,8 @@ QTestState *qtest_init(const char *extra_args)
>      /* Read the QMP greeting and then do the handshake */
>      greeting = qtest_qmp_receive(s);
>      QDECREF(greeting);
> -    qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");
> +    greeting = qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }");
> +    QDECREF(greeting);

Here, you replace

       qtest_qmp_discard_response(ARGS...);

effectively by

       QDECREF(qtest_qmp(ARGS...));

which is how qtest_qmp_discard_response() does its job before this
patch.  Okay.

>
>      return s;
>  }
> @@ -518,23 +519,6 @@ void qtest_async_qmp(QTestState *s, const char *fmt, ...)
>      va_end(ap);
>  }
>
> -void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap)
> -{
> -    QDict *response = qtest_qmpv(s, fmt, ap);
> -    QDECREF(response);
> -}
> -
> -void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...)
> -{
> -    va_list ap;
> -    QDict *response;
> -
> -    va_start(ap, fmt);
> -    response = qtest_qmpv(s, fmt, ap);
> -    va_end(ap);
> -    QDECREF(response);
> -}
> -
>  QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
>  {
>      QDict *response;
> @@ -909,14 +893,12 @@ void qmp_async(const char *fmt, ...)
>      va_end(ap);
>  }
>
> -void qmp_discard_response(const char *fmt, ...)
> +void qmp_discard_response(void)
>  {
> -    va_list ap;
> -
> -    va_start(ap, fmt);
> -    qtest_qmpv_discard_response(global_qtest, fmt, ap);
> -    va_end(ap);
> +    QDict *response = qtest_qmp_receive(global_qtest);
> +    QDECREF(response);
>  }
> +
>  char *hmp(const char *fmt, ...)
>  {
>      va_list ap;
> diff --git a/tests/ahci-test.c b/tests/ahci-test.c
> index 999121bb7c..9460843a9f 100644
> --- a/tests/ahci-test.c
> +++ b/tests/ahci-test.c
> @@ -1596,8 +1596,9 @@ static void test_atapi_tray(void)
>      rsp = qmp_receive();
>      QDECREF(rsp);
>
> -    qmp_discard_response("{'execute': 'x-blockdev-remove-medium', "
> -                         "'arguments': {'device': 'drive0'}}");
> +    qmp_async("{'execute': 'x-blockdev-remove-medium', "
> +              "'arguments': {'device': 'drive0'}}");
> +    qmp_discard_response();

Here, you replace the same pattern (less the QTestState argument) by

       qmp_async(F, ...);
       qmp_discard_response();

Also okay.  But why two ways to do the same things?

Apropos QTestState argument: do we have a test with more than one state,
or is having two versions of every function just "avoiding global state
is virtuous" self-flagellation?

>
>      /* Test the tray without a medium */
>      ahci_atapi_load(ahci, port);
[...]
