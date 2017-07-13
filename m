Received: from eggs.gnu.org ([2001:4830:134:3::10]:59797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVczR-00075Z-1R
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVczL-0000ah-Uz
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:13:04 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d06a924b-63c8-5133-f601-a7d2e58c6a56@virtuozzo.com>
Date: Thu, 13 Jul 2017 15:12:58 +0300
MIME-Version: 1.0
In-Reply-To: <20170707203049.534-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 2/9] nbd: Don't bother tracing an
 NBD_OPT_ABORT response failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org

07.07.2017 23:30, Eric Blake wrote:
> We really don't care if our spec-compliant reply to NBD_OPT_ABORT
> was received, so shave off some lines of code by not even tracing it.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v5: new patch
> ---
>   nbd/server.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/nbd/server.c b/nbd/server.c
> index 9b0c588..e15385b 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -376,7 +376,6 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
>   {
>       uint32_t flags;
>       bool fixedNewstyle = false;
> -    Error *local_err = NULL;
>
>       /* Client sends:
>           [ 0 ..   3]   client flags
> @@ -479,7 +478,9 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
>                   if (ret < 0) {
>                       return ret;
>                   }
> -                /* Let the client keep trying, unless they asked to quit */
> +                /* Let the client keep trying, unless they asked to
> +                 * quit. In this mode, we've already sent an error, so
> +                 * we can't ack the abort.  */
>                   if (option == NBD_OPT_ABORT) {
>                       return 1;
>                   }
> @@ -498,15 +499,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
>                   /* NBD spec says we must try to reply before
>                    * disconnecting, but that we must also tolerate
>                    * guests that don't wait for our reply. */
> -                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, option,
> -                                       &local_err);
> -
> -                if (local_err != NULL) {
> -                    const char *error = error_get_pretty(local_err);
> -                    trace_nbd_opt_abort_reply_failed(error);

Looks like you forgot to drop this trace from nbd/trace-events

> -                    error_free(local_err);
> -                }
> -
> +                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, option, NULL);
>                   return 1;
>
>               case NBD_OPT_EXPORT_NAME:


-- 
Best regards,
Vladimir
