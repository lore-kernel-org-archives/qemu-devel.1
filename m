Received: from eggs.gnu.org ([209.51.188.92]:60764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwXvA-0003GN-86
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwXv4-0000w0-Uz
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:52:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwXv4-0000ll-2e
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 14:52:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so27534534wrg.1
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 11:52:37 -0800 (PST)
References: <20190220182543.10623-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f304df7c-e0ba-042d-4ef7-d6492cb77569@redhat.com>
Date: Wed, 20 Feb 2019 20:52:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190220182543.10623-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] io: fix handling of EOF / error conditions
 in websock GSource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Hi Daniel,

On 2/20/19 7:25 PM, Daniel P. Berrangé wrote:
> We were never reporting the G_IO_HUP event when an end of file was hit
> on the websocket channel.
> 
> We also ddn't report G_IO_ERR when we hit a fatal error processing the

"didn't report"

> websocket protocol.
> 
> The latter in particular meant that the chardev code would not notice
> when an eof/error was encountered on the websocket channel, unless the
> guest OS happened to trigger a write operation.
> 
> This meant that once the first client had quit, the chardev would never
> listen to accept a new client.
> 
> Fixes launchpad bug 1816819
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  io/channel-websock.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index dc43dc6bb9..fc4c3dcaa5 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -1225,12 +1225,18 @@ qio_channel_websock_source_check(GSource *source)
>      QIOChannelWebsockSource *wsource = (QIOChannelWebsockSource *)source;
>      GIOCondition cond = 0;
>  
> -    if (wsource->wioc->rawinput.offset || wsource->wioc->io_eof) {
> +    if (wsource->wioc->rawinput.offset) {
>          cond |= G_IO_IN;
>      }
>      if (wsource->wioc->encoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
>          cond |= G_IO_OUT;
>      }
> +    if (wsource->wioc->io_eof) {
> +        cond |= G_IO_IN | G_IO_HUP;

Shouldn't this be:

           cond |= G_IO_HUP;

> +    }
> +    if (wsource->wioc->io_err) {
> +        cond |= G_IO_IN | G_IO_ERR;

Ditto:

           cond |= G_IO_ERR;

> +    }
>  
>      return cond & wsource->condition;
>  }
> 
