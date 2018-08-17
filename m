Received: from eggs.gnu.org ([2001:4830:134:3::10]:36053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqiRm-0008RZ-MQ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqiRm-0006yf-0C
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:22:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fqiRl-0006yQ-Qn
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:22:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81FF940676C0
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 17:22:01 +0000 (UTC)
References: <20180815141945.10457-1-armbru@redhat.com>
	<20180815141945.10457-2-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b3f06ed0-34f5-50e5-dcd6-fc3d22327408@redhat.com>
Date: Fri, 17 Aug 2018 19:21:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180815141945.10457-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: eblake@redhat.com, thuth@redhat.com, lvivier@redhat.com

On 15/08/2018 16:19, Markus Armbruster wrote:
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
> atexit() or something.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
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

Queued, thanks.

Paolo
