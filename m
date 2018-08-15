Received: from eggs.gnu.org ([2001:4830:134:3::10]:43168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpx2d-0002qN-5d
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpx2Z-0000wg-3T
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:44:55 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:38482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fpx2Y-0000ux-MP
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:44:50 -0400
Received: by mail-ua1-x944.google.com with SMTP id o11-v6so1471887uak.5
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:44:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180815141945.10457-1-armbru@redhat.com>
	<20180815141945.10457-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <95680fcb-9c9a-cc9a-3a15-ec208046a20a@amsat.org>
Date: Wed, 15 Aug 2018 11:44:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180815141945.10457-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/1] libqtest: Improve error reporting for
 bad read from QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com

On 08/15/2018 11:19 AM, Markus Armbruster wrote:
> When read() from the qtest socket or the QMP socket fails or EOFs, we
> report "Broken pipe" and exit(1).  This commonly happens when QEMU
> crashes.  It also happens when QEMU refuses to run because the test
> passed it bad arguments.  Sadly, we neglect to report either.
> 
> Improve this by calling abort() instead of exit(1), so kill_qemu()
> runs, and reports how QEMU died.  This improves error reporting to
> something like
> 
>     /x86_64/device/introspect/list: Broken pipe
>     tests/libqtest.c:129: kill_qemu() detected QEMU death from signal 6 (Aborted) (dumped core)
> 
> Three exit() remain in libqtest.c:
> 
> * In qmp_response(), when we can't parse a QMP reply read from the QMP
>   socket.  Change to abort() for consistency.
> 
> * In qtest_qemu_binary(), when QTEST_QEMU_BINARY isn't in the
>   environment.  This can only happen before we start QEMU.  Leave
>   alone.
> 
> * In qtest_init_without_qmp_handshake(), when the fork()ed child fails
>   to execlp().  Leave alone.
> 
> exit() elsewhere are unlikely due to QEMU dying on us.  If that should
> turn out to be wrong, we can move kill_qemu() from the abrt handler to

"abort handler"?

> atexit() or something.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/libqtest.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index b703fca26d..852ccff1ce 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -367,7 +367,7 @@ static GString *qtest_recv_line(QTestState *s)
>  
>          if (len == -1 || len == 0) {
>              fprintf(stderr, "Broken pipe\n");
> -            exit(1);
> +            abort();
>          }
>  
>          g_string_append_len(s->rx, buffer, len);
> @@ -454,7 +454,7 @@ static void qmp_response(JSONMessageParser *parser, GQueue *tokens)
>      obj = json_parser_parse(tokens, NULL);
>      if (!obj) {
>          fprintf(stderr, "QMP JSON response parsing failed\n");
> -        exit(1);
> +        abort();
>      }
>  
>      g_assert(!qmp->response);
> @@ -480,7 +480,7 @@ QDict *qmp_fd_receive(int fd)
>  
>          if (len == -1 || len == 0) {
>              fprintf(stderr, "Broken pipe\n");
> -            exit(1);
> +            abort();
>          }
>  
>          if (log) {
> 
