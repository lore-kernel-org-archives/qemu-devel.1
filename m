Received: from eggs.gnu.org ([2001:4830:134:3::10]:50271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfQsZ-0003Yv-8x
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfQsU-0000Q6-7w
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:18:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfQsT-0000PZ-Ub
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:18:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00D4E9F25D
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 13:18:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-13-eblake@redhat.com>
Date: Wed, 09 Aug 2017 15:18:22 +0200
In-Reply-To: <20170804012551.2714-13-eblake@redhat.com> (Eric Blake's message
	of "Thu, 3 Aug 2017 20:25:41 -0500")
Message-ID: <87mv78riap.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 12/22] libqtest: Change qmp_fd_send() to
 drop varargs
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

> With the previous commit, no external clients are using qmp_fd()
> or qmp_fd_sendv().  Making qmp_fd_sendv() static lets us refactor
> the public qmp_fd_send() to be the common point where we send a
> fixed string over the wire as well as log that string, while
> qmp_fd_sendv() worries about converting varargs into the final
> string.  Note that the refactoring changes roles: previously,
> qmp_fd_send() deferred to qmp_fd_sendv(); now the call chain is
> in the opposite direction.  Likewise, now that we take a fixed
> string, we no longer have to special case '\xff'.

I'm fine with the reversal of roles.  The name qmp_fd_send() becomes
slightly problematic, though: it's *not* the ... variant of
qmp_fd_sendv(), as is the case for similar pairs of function names.

I wish libqtest's naming would follow libc conventions more closely.
libc: printf() and vprintf(), sprintf() and vsprintf().  libqtest:
qmp_fd_send() and qmp_sendv(), qtest_hmp() and qtest_hmpv(), ...
Exceptions (sort of): socket_send() and socket_sendf(), qtest_sendf().
Not sure this is worth cleaning up now.

If we decice it is, then the name qmp_fd_send() would be fine, because
its va_list buddy would be qmp_fd_vsendf(), and its ... buddy would be
qmp_fd_sendf().

> Add documentation while in the area.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.h | 20 ++++++++++++----
>  tests/libqtest.c | 73 +++++++++++++++++---------------------------------------
>  tests/test-qga.c |  2 --
>  3 files changed, 38 insertions(+), 57 deletions(-)
>
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 38148af66b..33af3ae8ff 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -923,11 +923,23 @@ static inline int64_t clock_set(int64_t val)
>      return qtest_clock_set(global_qtest, val);
>  }
>
> +/**
> + * qmp_fd_receive:
> + * @fd: Socket to read from.
> + *
> + * Read from input until a complete JSON object has been parsed,
> + * returning NULL on errors.
> + */
>  QDict *qmp_fd_receive(int fd);
> -void qmp_fd_sendv(int fd, const char *fmt, va_list ap);
> -void qmp_fd_send(int fd, const char *fmt, ...);
> -QDict *qmp_fdv(int fd, const char *fmt, va_list ap);
> -QDict *qmp_fd(int fd, const char *fmt, ...);
> +
> +/**
> + * qmp_fd_send:
> + * @fd: Socket to write to.
> + * @msg: Fixed string to send.
> + *
> + * Send a message to the destination, without waiting for a reply.
> + */
> +void qmp_fd_send(int fd, const char *msg);
>
>  /**
>   * qtest_cb_for_every_machine:
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index ba09c949dc..0fa32928c8 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -441,26 +441,16 @@ QDict *qtest_qmp_receive(QTestState *s)
>      return qmp_fd_receive(s->qmp_fd);
>  }
>
> -/**
> - * Allow users to send a message without waiting for the reply,
> - * in the case that they choose to discard all replies up until
> - * a particular EVENT is received.
> +/*
> + * Internal code that converts from interpolated JSON into a message
> + * to send over the wire, without waiting for a reply.
>   */

"Internal code that ..." is awkward.  It's static, so of course it's
internal, and of course it's code :)

"Convert from X into Y" sounds odd to my (non-native!) ears.  "Convert
from X to Y" and "convert X into Y" don't.

"Without waiting for a reply" is kind of implied by "send", isn't it?

What about

  /*
   * Send a QMP message with %-interpolation like qobject_from_jsonv().
   */

Add parameter description to taste.  Uglify to conform to GLib
documentation style if you want.

> -void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
> +static void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
>  {
>      QObject *qobj = NULL;
> -    int log = getenv("QTEST_LOG") != NULL;
>      QString *qstr;
>      const char *str;
>
> -    /* qobject_from_jsonv() silently eats leading 0xff as invalid
> -     * JSON, but we want to test sending them over the wire to force
> -     * resyncs */
> -    if (*fmt == '\377') {
> -        socket_send(fd, fmt, 1);
> -        assert(!fmt[1]);
> -        return;
> -    }
>      assert(*fmt);

Is this assertion (still) useful?  Why can't we leave the job to
qobject_from_jsonv()?

>
>      /*
> @@ -468,25 +458,17 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
>       * is used.  We interpolate through QObject rather than sprintf in
>       * order to escape strings properly.
>       */
> -    if (strchr(fmt, '%')) {
> -        qobj = qobject_from_jsonv(fmt, ap);
> -        qstr = qobject_to_json(qobj);
> -    } else {
> -        qstr = qstring_from_str(fmt);
> +    if (!strchr(fmt, '%')) {
> +        qmp_fd_send(fd, fmt);
> +        return;
>      }
>
> -    /*
> -     * BUG: QMP doesn't react to input until it sees a newline, an
> -     * object, or an array.  Work-around: give it a newline.
> -     */
> -    qstring_append_chr(qstr, '\n');
> +    qobj = qobject_from_jsonv(fmt, ap);
> +    qstr = qobject_to_json(qobj);
>      str = qstring_get_str(qstr);
>
> -    if (log) {
> -        fprintf(stderr, "%s", str);
> -    }
>      /* Send QMP request */
> -    socket_send(fd, str, qstring_get_length(qstr));
> +    qmp_fd_send(fd, str);
>
>      QDECREF(qstr);
>      qobject_decref(qobj);
> @@ -497,13 +479,6 @@ void qtest_async_qmpv(QTestState *s, const char *fmt, va_list ap)
>      qmp_fd_sendv(s->qmp_fd, fmt, ap);
>  }
>
> -QDict *qmp_fdv(int fd, const char *fmt, va_list ap)
> -{
> -    qmp_fd_sendv(fd, fmt, ap);
> -
> -    return qmp_fd_receive(fd);
> -}
> -
>  QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
>  {
>      qtest_async_qmpv(s, fmt, ap);
> @@ -512,24 +487,20 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
>      return qtest_qmp_receive(s);
>  }
>
> -QDict *qmp_fd(int fd, const char *fmt, ...)
> +void qmp_fd_send(int fd, const char *msg)
>  {
> -    va_list ap;
> -    QDict *response;
> +    int log = getenv("QTEST_LOG") != NULL;
>
> -    va_start(ap, fmt);
> -    response = qmp_fdv(fd, fmt, ap);
> -    va_end(ap);
> -    return response;
> -}
> -
> -void qmp_fd_send(int fd, const char *fmt, ...)
> -{
> -    va_list ap;
> -
> -    va_start(ap, fmt);
> -    qmp_fd_sendv(fd, fmt, ap);
> -    va_end(ap);
> +    if (log) {
> +        fprintf(stderr, "%s\n", msg);
> +    }
> +    /* Send QMP request */
> +    socket_send(fd, msg, strlen(msg));
> +    /*
> +     * BUG: QMP doesn't react to input until it sees a newline, an
> +     * object, or an array.  Work-around: give it a newline.
> +     */
> +    socket_send(fd, "\n", 1);

Hmm.

Before this series, qmp_fd_sendv() first parses @fmt with
%-interpolation from @ap, then converts the result back to JSON text.
Any newlines are lost, so we have to append one.

PATCH 10 adds a shortcut when @fmt doesn't contain '%'.  Newlines are
not lost in that case.  We add one anyway.  Ugh.

This patch drops the non-shortcut case.

I think qmp_fd_send() should send exactly @msg, and the newline
appending should move to qmp_fd_sendv(), where the newline loss now
happens.

>  }
>
>  QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index 839481e49b..ae0da6c9ac 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -122,9 +122,7 @@ static void GCC_FMT_ATTR(3, 0) qga_sendv(const TestFixture *fixture,
>      QString *qstr = qobject_to_json(obj);
>      const char *str;
>
> -    qstring_append_chr(qstr, '\n');

Was appending a newline necessary before this patch?

It will be if you change qmp_fd_send() as I proposed.

>      str = qstring_get_str(qstr);
> -    assert(!strchr(str, '%'));
>      qmp_fd_send(fixture->fd, str);
>      QDECREF(qstr);
>      qobject_decref(obj);
