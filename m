Received: from eggs.gnu.org ([2001:4830:134:3::10]:42664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erSBA-0000zL-Il
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erSB7-0003Y4-8N
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:39:40 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1erSB7-0003Xb-19
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:39:37 -0500
Received: by mail-wr0-x242.google.com with SMTP id p104so7427498wrc.12
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:39:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-2-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4fc6fbe7-5b7e-fa04-7f99-9740e00a928a@redhat.com>
Date: Thu, 1 Mar 2018 18:39:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180301084438.13594-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/15] chardev: fix leak in
 tcp_chr_telnet_init_io()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 01/03/2018 09:44, Peter Xu wrote:
> Need to free TCPChardevTelnetInit when session established.
> 
> Since at it, switch to use G_SOURCE_* macros.
> 
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-socket.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index bdd6cff5f6..43a2cc2c1c 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -591,19 +591,23 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
>              ret = 0;
>          } else {
>              tcp_chr_disconnect(init->chr);
> -            return FALSE;
> +            goto end;
>          }
>      }
>      init->buflen -= ret;
>  
>      if (init->buflen == 0) {
>          tcp_chr_connect(init->chr);
> -        return FALSE;
> +        goto end;
>      }
>  
>      memmove(init->buf, init->buf + ret, init->buflen);
>  
> -    return TRUE;
> +    return G_SOURCE_CONTINUE;
> +
> +end:
> +    g_free(init);
> +    return G_SOURCE_REMOVE;
>  }
>  
>  static void tcp_chr_telnet_init(Chardev *chr)
> 

Queued, thanks (but it's okay if you post it again in v3, because I'm
not sure I'll be able to send a pull request tomorrow).

Paolo
