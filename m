Received: from eggs.gnu.org ([2001:4830:134:3::10]:45219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcOc-0004Gp-RJ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcOX-00084y-Sn
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:16:38 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcOX-00084s-Np
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:16:33 -0400
Received: by mail-qk0-x244.google.com with SMTP id 27-v6so2467600qkv.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:16:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-21-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3fb3a291-7e14-aff4-d44c-856de90ecf44@amsat.org>
Date: Thu, 12 Jul 2018 11:16:25 -0300
MIME-Version: 1.0
In-Reply-To: <20180712111221.20326-21-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 20/20] libqtest: Enable compile-time format
 string checking
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
> qtest_qmp() & friends pass their format string and variable arguments
> to qobject_from_vjsonf_nofail().  Unlike qobject_from_jsonv(), they
> aren't decorated with GCC_FMT_ATTR().  Fix that to get compile-time
> format string checking.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/libqtest.h | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 68b767fc88..087d6793eb 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -81,7 +81,8 @@ void qtest_quit(QTestState *s);
>   *
>   * Sends a QMP message to QEMU and consumes the response.
>   */
> -void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
> +void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...)
> +    GCC_FMT_ATTR(2, 3);
>  
>  /**
>   * qtest_qmp:
> @@ -91,7 +92,8 @@ void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
>   *
>   * Sends a QMP message to QEMU and returns the response.
>   */
> -QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
> +QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
> +    GCC_FMT_ATTR(2, 3);
>  
>  /**
>   * qtest_qmp_send:
> @@ -101,7 +103,8 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
>   *
>   * Sends a QMP message to QEMU and leaves the response in the stream.
>   */
> -void qtest_qmp_send(QTestState *s, const char *fmt, ...);
> +void qtest_qmp_send(QTestState *s, const char *fmt, ...)
> +    GCC_FMT_ATTR(2, 3);
>  
>  /**
>   * qtest_qmpv_discard_response:
> @@ -112,7 +115,8 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...);
>   *
>   * Sends a QMP message to QEMU and consumes the response.
>   */
> -void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
> +void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap)
> +    GCC_FMT_ATTR(2, 0);
>  
>  /**
>   * qtest_qmpv:
> @@ -123,7 +127,8 @@ void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
>   *
>   * Sends a QMP message to QEMU and returns the response.
>   */
> -QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
> +QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
> +    GCC_FMT_ATTR(2, 0);
>  
>  /**
>   * qtest_qmp_vsend:
> @@ -134,7 +139,8 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
>   *
>   * Sends a QMP message to QEMU and leaves the response in the stream.
>   */
> -void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap);
> +void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
> +    GCC_FMT_ATTR(2, 0);
>  
>  /**
>   * qtest_receive:
> @@ -590,7 +596,7 @@ static inline void qtest_end(void)
>   *
>   * Sends a QMP message to QEMU and returns the response.
>   */
> -QDict *qmp(const char *fmt, ...);
> +QDict *qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  
>  /**
>   * qmp_send:
> @@ -599,7 +605,7 @@ QDict *qmp(const char *fmt, ...);
>   *
>   * Sends a QMP message to QEMU and leaves the response in the stream.
>   */
> -void qmp_send(const char *fmt, ...);
> +void qmp_send(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  
>  /**
>   * qmp_discard_response:
> @@ -608,7 +614,7 @@ void qmp_send(const char *fmt, ...);
>   *
>   * Sends a QMP message to QEMU and consumes the response.
>   */
> -void qmp_discard_response(const char *fmt, ...);
> +void qmp_discard_response(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  
>  /**
>   * qmp_receive:
> @@ -967,10 +973,10 @@ static inline int64_t clock_set(int64_t val)
>  }
>  
>  QDict *qmp_fd_receive(int fd);
> -void qmp_fd_vsend(int fd, const char *fmt, va_list ap);
> -void qmp_fd_send(int fd, const char *fmt, ...);
> -QDict *qmp_fdv(int fd, const char *fmt, va_list ap);
> -QDict *qmp_fd(int fd, const char *fmt, ...);
> +void qmp_fd_vsend(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
> +void qmp_fd_send(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
> +QDict *qmp_fdv(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
> +QDict *qmp_fd(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
>  
>  /**
>   * qtest_cb_for_every_machine:
> 
