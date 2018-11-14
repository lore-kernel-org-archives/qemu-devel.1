Received: from eggs.gnu.org ([2001:4830:134:3::10]:41353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMuxm-0002oS-6y
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMuxi-0006c9-Ul
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:12:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMuxi-0006bI-OP
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:12:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id f19-v6so13527738wmb.0
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:12:06 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-11-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <712fa2ca-6f20-9de5-5e1d-e2dcf5cb115f@redhat.com>
Date: Wed, 14 Nov 2018 14:12:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181114123643.24091-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 10/41] slirp: remove PROBE_CONN
 dead-code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

On 14/11/18 13:36, Marc-André Lureau wrote:
> Nobody cares for over 14y. Somebody can revert or rewrite if
> interested by that.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   slirp/slirp_config.h |  4 ----
>   slirp/slirp.c        | 41 -----------------------------------------
>   2 files changed, 45 deletions(-)
> 
> diff --git a/slirp/slirp_config.h b/slirp/slirp_config.h
> index c59f655207..721667e3ef 100644
> --- a/slirp/slirp_config.h
> +++ b/slirp/slirp_config.h
> @@ -2,10 +2,6 @@
>    * User definable configuration options
>    */
>   
> -/* Define if you want the connection to be probed */
> -/* XXX Not working yet, so ignore this for now */
> -#undef PROBE_CONN
> -
>   /* Define to 1 if you want KEEPALIVE timers */
>   #define DO_KEEPALIVE 0
>   
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 979495e88b..2d32debf2a 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -699,47 +699,6 @@ void slirp_pollfds_poll(GArray *pollfds, int select_error)
>                           }
>                       }
>                   }
> -
> -                /*
> -                 * Probe a still-connecting, non-blocking socket
> -                 * to check if it's still alive
> -                 */
> -#ifdef PROBE_CONN
> -                if (so->so_state & SS_ISFCONNECTING) {
> -                    ret = qemu_recv(so->s, &ret, 0, 0);
> -
> -                    if (ret < 0) {
> -                        /* XXX */
> -                        if (errno == EAGAIN || errno == EWOULDBLOCK ||
> -                            errno == EINPROGRESS || errno == ENOTCONN) {
> -                            continue; /* Still connecting, continue */
> -                        }
> -
> -                        /* else failed */
> -                        so->so_state &= SS_PERSISTENT_MASK;
> -                        so->so_state |= SS_NOFDREF;
> -
> -                        /* tcp_input will take care of it */
> -                    } else {
> -                        ret = send(so->s, &ret, 0, 0);
> -                        if (ret < 0) {
> -                            /* XXX */
> -                            if (errno == EAGAIN || errno == EWOULDBLOCK ||
> -                                errno == EINPROGRESS || errno == ENOTCONN) {
> -                                continue;
> -                            }
> -                            /* else failed */
> -                            so->so_state &= SS_PERSISTENT_MASK;
> -                            so->so_state |= SS_NOFDREF;
> -                        } else {
> -                            so->so_state &= ~SS_ISFCONNECTING;
> -                        }
> -
> -                    }
> -                    tcp_input((struct mbuf *)NULL, sizeof(struct ip), so,
> -                              so->so_ffamily);
> -                } /* SS_ISFCONNECTING */
> -#endif
>               }
>   
>               /*
> 
