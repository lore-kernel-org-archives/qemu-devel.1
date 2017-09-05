Received: from eggs.gnu.org ([2001:4830:134:3::10]:40970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpA3r-0000vD-A1
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpA3m-0002Zp-2t
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpA3l-0002ZT-Q2
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8C084620F
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 09:22:16 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-11-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <172f4b48-f791-2f36-3df5-0a2bd4c859c3@redhat.com>
Date: Tue, 5 Sep 2017 11:22:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-11-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 10/29] libqtest: Topologically sort
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

On 01.09.2017 20:03, Eric Blake wrote:
> Put static functions prior to public ones, in part so that
> improvements to qtest_start() can benefit from the static
> helpers without needing forward references.  Code motion, with
> no semantic change.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqtest.c | 263 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 131 insertions(+), 132 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 438a22678d..5d16351e24 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -49,7 +49,6 @@ static struct sigaction sigact_old;
>      g_assert_cmpint(ret, !=, -1); \
>  } while (0)
> 
> -static int qtest_query_target_endianness(QTestState *s);
> 
>  static int init_socket(const char *socket_path)
>  {
> @@ -128,6 +127,137 @@ static void setup_sigabrt_handler(void)
>      sigaction(SIGABRT, &sigact, &sigact_old);
>  }
> 
> +static void socket_send(int fd, const char *buf, ssize_t size)
> +{
> +    size_t offset;
> +
> +    if (size < 0) {
> +        size = strlen(buf);
> +    }
> +    offset = 0;
> +    while (offset < size) {
> +        ssize_t len;
> +
> +        len = write(fd, buf + offset, size - offset);
> +        if (len == -1 && errno == EINTR) {
> +            continue;
> +        }
> +
> +        g_assert_no_errno(len);
> +        g_assert_cmpint(len, >, 0);
> +
> +        offset += len;
> +    }
> +}
> +
> +static void socket_sendf(int fd, const char *fmt, va_list ap)
> +{
> +    gchar *str = g_strdup_vprintf(fmt, ap);
> +
> +    socket_send(fd, str, -1);
> +    g_free(str);
> +}
> +
> +static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt, ...)
> +{
> +    va_list ap;
> +
> +    va_start(ap, fmt);
> +    socket_sendf(s->fd, fmt, ap);
> +    va_end(ap);
> +}
> +
> +static GString *qtest_recv_line(QTestState *s)
> +{
> +    GString *line;
> +    size_t offset;
> +    char *eol;
> +
> +    while ((eol = strchr(s->rx->str, '\n')) == NULL) {
> +        ssize_t len;
> +        char buffer[1024];
> +
> +        len = read(s->fd, buffer, sizeof(buffer));
> +        if (len == -1 && errno == EINTR) {
> +            continue;
> +        }
> +
> +        if (len == -1 || len == 0) {
> +            fprintf(stderr, "Broken pipe\n");
> +            exit(1);
> +        }
> +
> +        g_string_append_len(s->rx, buffer, len);
> +    }
> +
> +    offset = eol - s->rx->str;
> +    line = g_string_new_len(s->rx->str, offset);
> +    g_string_erase(s->rx, 0, offset + 1);
> +
> +    return line;
> +}
> +
> +static gchar **qtest_rsp(QTestState *s, int expected_args)
> +{
> +    GString *line;
> +    gchar **words;
> +    int i;
> +
> +redo:
> +    line = qtest_recv_line(s);
> +    words = g_strsplit(line->str, " ", 0);
> +    g_string_free(line, TRUE);
> +
> +    if (strcmp(words[0], "IRQ") == 0) {
> +        long irq;
> +        int ret;
> +
> +        g_assert(words[1] != NULL);
> +        g_assert(words[2] != NULL);
> +
> +        ret = qemu_strtol(words[2], NULL, 0, &irq);
> +        g_assert(!ret);
> +        g_assert_cmpint(irq, >=, 0);
> +        g_assert_cmpint(irq, <, MAX_IRQ);
> +
> +        if (strcmp(words[1], "raise") == 0) {
> +            s->irq_level[irq] = true;
> +        } else {
> +            s->irq_level[irq] = false;
> +        }
> +
> +        g_strfreev(words);
> +        goto redo;
> +    }
> +
> +    g_assert(words[0] != NULL);
> +    g_assert_cmpstr(words[0], ==, "OK");
> +
> +    if (expected_args) {
> +        for (i = 0; i < expected_args; i++) {
> +            g_assert(words[i] != NULL);
> +        }
> +    } else {
> +        g_strfreev(words);
> +    }
> +
> +    return words;
> +}
> +
> +static int qtest_query_target_endianness(QTestState *s)
> +{
> +    gchar **args;
> +    int big_endian;
> +
> +    qtest_sendf(s, "endianness\n");
> +    args = qtest_rsp(s, 1);
> +    g_assert(strcmp(args[1], "big") == 0 || strcmp(args[1], "little") == 0);
> +    big_endian = strcmp(args[1], "big") == 0;
> +    g_strfreev(args);
> +
> +    return big_endian;
> +}
> +
>  static void cleanup_sigabrt_handler(void)
>  {
>      sigaction(SIGABRT, &sigact_old, NULL);
> @@ -252,137 +382,6 @@ void qtest_quit(QTestState *s)
>      g_free(s);
>  }
> 
> -static void socket_send(int fd, const char *buf, ssize_t size)
> -{
> -    size_t offset;
> -
> -    if (size < 0) {
> -        size = strlen(buf);
> -    }
> -    offset = 0;
> -    while (offset < size) {
> -        ssize_t len;
> -
> -        len = write(fd, buf + offset, size - offset);
> -        if (len == -1 && errno == EINTR) {
> -            continue;
> -        }
> -
> -        g_assert_no_errno(len);
> -        g_assert_cmpint(len, >, 0);
> -
> -        offset += len;
> -    }
> -}
> -
> -static void socket_sendf(int fd, const char *fmt, va_list ap)
> -{
> -    gchar *str = g_strdup_vprintf(fmt, ap);
> -
> -    socket_send(fd, str, -1);
> -    g_free(str);
> -}
> -
> -static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt, ...)
> -{
> -    va_list ap;
> -
> -    va_start(ap, fmt);
> -    socket_sendf(s->fd, fmt, ap);
> -    va_end(ap);
> -}
> -
> -static GString *qtest_recv_line(QTestState *s)
> -{
> -    GString *line;
> -    size_t offset;
> -    char *eol;
> -
> -    while ((eol = strchr(s->rx->str, '\n')) == NULL) {
> -        ssize_t len;
> -        char buffer[1024];
> -
> -        len = read(s->fd, buffer, sizeof(buffer));
> -        if (len == -1 && errno == EINTR) {
> -            continue;
> -        }
> -
> -        if (len == -1 || len == 0) {
> -            fprintf(stderr, "Broken pipe\n");
> -            exit(1);
> -        }
> -
> -        g_string_append_len(s->rx, buffer, len);
> -    }
> -
> -    offset = eol - s->rx->str;
> -    line = g_string_new_len(s->rx->str, offset);
> -    g_string_erase(s->rx, 0, offset + 1);
> -
> -    return line;
> -}
> -
> -static gchar **qtest_rsp(QTestState *s, int expected_args)
> -{
> -    GString *line;
> -    gchar **words;
> -    int i;
> -
> -redo:
> -    line = qtest_recv_line(s);
> -    words = g_strsplit(line->str, " ", 0);
> -    g_string_free(line, TRUE);
> -
> -    if (strcmp(words[0], "IRQ") == 0) {
> -        long irq;
> -        int ret;
> -
> -        g_assert(words[1] != NULL);
> -        g_assert(words[2] != NULL);
> -
> -        ret = qemu_strtol(words[2], NULL, 0, &irq);
> -        g_assert(!ret);
> -        g_assert_cmpint(irq, >=, 0);
> -        g_assert_cmpint(irq, <, MAX_IRQ);
> -
> -        if (strcmp(words[1], "raise") == 0) {
> -            s->irq_level[irq] = true;
> -        } else {
> -            s->irq_level[irq] = false;
> -        }
> -
> -        g_strfreev(words);
> -        goto redo;
> -    }
> -
> -    g_assert(words[0] != NULL);
> -    g_assert_cmpstr(words[0], ==, "OK");
> -
> -    if (expected_args) {
> -        for (i = 0; i < expected_args; i++) {
> -            g_assert(words[i] != NULL);
> -        }
> -    } else {
> -        g_strfreev(words);
> -    }
> -
> -    return words;
> -}
> -
> -static int qtest_query_target_endianness(QTestState *s)
> -{
> -    gchar **args;
> -    int big_endian;
> -
> -    qtest_sendf(s, "endianness\n");
> -    args = qtest_rsp(s, 1);
> -    g_assert(strcmp(args[1], "big") == 0 || strcmp(args[1], "little") == 0);
> -    big_endian = strcmp(args[1], "big") == 0;
> -    g_strfreev(args);
> -
> -    return big_endian;
> -}
> -
>  typedef struct {
>      JSONMessageParser parser;
>      QDict *response;
> 

That's a *lot* of code motion - just to get rid of one forward
declaration. IMHO getting rid of just one forward declaration does not
justify this code churn. But if we really, really want to get rid of the
forward declaration here, it's maybe better to move the
qtest_init_without_qmp_handshake() and qtest_init() function to the end
of the file instead?

 Thomas
