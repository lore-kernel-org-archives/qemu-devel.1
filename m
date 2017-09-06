Received: from eggs.gnu.org ([2001:4830:134:3::10]:46596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpejE-0006Qa-E9
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpej9-00081V-Fp
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:07:08 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpej9-00080W-B2
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:07:03 -0400
Received: by mail-qt0-x244.google.com with SMTP id 7so4345990qtz.3
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 11:07:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170906104043.30745-1-berrange@redhat.com>
	<20170906104043.30745-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0a4175fa-3586-d9ab-addb-736a17c24555@amsat.org>
Date: Wed, 6 Sep 2017 15:06:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170906104043.30745-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] io: include full error message in
 websocket handshake trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Brian Rak <brak@vultr.com>

On 09/06/2017 07:40 AM, Daniel P. Berrange wrote:
> When the websocket handshake fails it is useful to log the real
> error message via the trace points for debugging purposes.
> 
> Fixes bug: #1715186
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   io/channel-websock.c | 7 ++++---
>   io/trace-events      | 2 +-
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index b9cc5a1371..463c04b0aa 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -503,7 +503,7 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
>                               &err);
>   
>       if (ret < 0) {
> -        trace_qio_channel_websock_handshake_fail(ioc);
> +        trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
>           qio_task_set_error(task, err);
>           qio_task_complete(task);
>           return FALSE;
> @@ -512,7 +512,8 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
>       buffer_advance(&wioc->encoutput, ret);
>       if (wioc->encoutput.offset == 0) {
>           if (wioc->io_err) {
> -            trace_qio_channel_websock_handshake_fail(ioc);
> +            trace_qio_channel_websock_handshake_fail(
> +                ioc, error_get_pretty(wioc->io_err));
>               qio_task_set_error(task, wioc->io_err);
>               wioc->io_err = NULL;
>               qio_task_complete(task);
> @@ -543,7 +544,7 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
>            * client connection, as most of the time we have an
>            * HTTP 4xx err response to send instead
>            */
> -        trace_qio_channel_websock_handshake_fail(ioc);
> +        trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
>           qio_task_set_error(task, err);
>           qio_task_complete(task);
>           return FALSE;
> diff --git a/io/trace-events b/io/trace-events
> index 3d233698d0..6459f71f5b 100644
> --- a/io/trace-events
> +++ b/io/trace-events
> @@ -46,7 +46,7 @@ qio_channel_websock_new_server(void *ioc, void *master) "Websock new client ioc=
>   qio_channel_websock_handshake_start(void *ioc) "Websock handshake start ioc=%p"
>   qio_channel_websock_handshake_pending(void *ioc, int status) "Websock handshake pending ioc=%p status=%d"
>   qio_channel_websock_handshake_reply(void *ioc) "Websock handshake reply ioc=%p"
> -qio_channel_websock_handshake_fail(void *ioc) "Websock handshake fail ioc=%p"
> +qio_channel_websock_handshake_fail(void *ioc, const char *msg) "Websock handshake fail ioc=%p err=%s"
>   qio_channel_websock_handshake_complete(void *ioc) "Websock handshake complete ioc=%p"
>   
>   # io/channel-command.c
> 
