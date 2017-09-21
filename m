Received: from eggs.gnu.org ([2001:4830:134:3::10]:43039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv2Co-00075X-3A
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv2Ci-00045V-2e
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:11:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dv2Ch-00044y-Q8
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:11:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3F694E4C2
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 14:11:46 +0000 (UTC)
References: <1505975754-21555-1-git-send-email-peterx@redhat.com>
	<1505975754-21555-4-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f64bbc56-4f0d-7cc0-b62c-23045f33ad78@redhat.com>
Date: Thu, 21 Sep 2017 16:11:33 +0200
MIME-Version: 1.0
In-Reply-To: <1505975754-21555-4-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] chardev: use per-dev context for
 io_add_watch_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 21/09/2017 08:35, Peter Xu wrote:
> It was only passed in by chr_update_read_handlers().  However when
> reconnect, we'll lose that context information.  So if a chardev was
> running on another context (rather than the default context, the NULL
> pointer), it'll switch back to the default context if reconnection
> happens.  But, it should really stick to the old context.
> 
> Convert all the callers of io_add_watch_poll() to use the internally
> cached gcontext.  Then the context should be able to survive even after
> reconnections.

Why keep the argument then?

Thanks,

Paolo

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-fd.c     | 2 +-
>  chardev/char-pty.c    | 2 +-
>  chardev/char-socket.c | 4 ++--
>  chardev/char-udp.c    | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/chardev/char-fd.c b/chardev/char-fd.c
> index 6a62a54..09fbb07 100644
> --- a/chardev/char-fd.c
> +++ b/chardev/char-fd.c
> @@ -94,7 +94,7 @@ static void fd_chr_update_read_handler(Chardev *chr,
>          chr->gsource = io_add_watch_poll(chr, s->ioc_in,
>                                             fd_chr_read_poll,
>                                             fd_chr_read, chr,
> -                                           context);
> +                                           chr->gcontext);
>      }
>  }
>  
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index e5d20a0..d239c04 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -219,7 +219,7 @@ static void pty_chr_state(Chardev *chr, int connected)
>              chr->gsource = io_add_watch_poll(chr, s->ioc,
>                                                 pty_chr_read_poll,
>                                                 pty_chr_read,
> -                                               chr, NULL);
> +                                               chr, chr->gcontext);
>          }
>      }
>  }
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 1ae730a..ee71cbe 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -516,7 +516,7 @@ static void tcp_chr_connect(void *opaque)
>          chr->gsource = io_add_watch_poll(chr, s->ioc,
>                                             tcp_chr_read_poll,
>                                             tcp_chr_read,
> -                                           chr, NULL);
> +                                           chr, chr->gcontext);
>      }
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
> @@ -535,7 +535,7 @@ static void tcp_chr_update_read_handler(Chardev *chr,
>          chr->gsource = io_add_watch_poll(chr, s->ioc,
>                                             tcp_chr_read_poll,
>                                             tcp_chr_read, chr,
> -                                           context);
> +                                           chr->gcontext);
>      }
>  }
>  
> diff --git a/chardev/char-udp.c b/chardev/char-udp.c
> index 4ee11d3..106dee1 100644
> --- a/chardev/char-udp.c
> +++ b/chardev/char-udp.c
> @@ -110,7 +110,7 @@ static void udp_chr_update_read_handler(Chardev *chr,
>          chr->gsource = io_add_watch_poll(chr, s->ioc,
>                                             udp_chr_read_poll,
>                                             udp_chr_read, chr,
> -                                           context);
> +                                           chr->gcontext);
>      }
>  }
>  
> 
