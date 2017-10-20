Received: from eggs.gnu.org ([2001:4830:134:3::10]:33863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5caH-00079D-OF
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5caC-00026J-Ql
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:03:53 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-7-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fc70554b-fe64-0b33-af5f-142259d56036@virtuozzo.com>
Date: Fri, 20 Oct 2017 22:03:44 +0300
MIME-Version: 1.0
In-Reply-To: <20171019222637.17890-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 06/11] nbd: Minimal structured read for
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

20.10.2017 01:26, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Minimal implementation of structured read: one structured reply chunk,
> no segmentation.
> Minimal structured error implementation: no text message.
> Support DF flag, but just ignore it, as there is no segmentation any
> way.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v5: correct DF flag spelling, include errname in trace, handle any bogus
> payload from option
> v4: better _DF flag handling, convert errno to wire format, add
> comments and tracing, rework structured error for less churn when adding
> text message later, don't kill connection on redundant client option
> ---
>   nbd/server.c     | 106 +++++++++++++++++++++++++++++++++++++++++++++++++------
>   nbd/trace-events |   2 ++
>   2 files changed, 98 insertions(+), 10 deletions(-)
>
> diff --git a/nbd/server.c b/nbd/server.c
> index b3f7e0b18e..9be93c4a52 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -100,6 +100,8 @@ struct NBDClient {
>       QTAILQ_ENTRY(NBDClient) next;
>       int nb_requests;
>       bool closing;
> +
> +    bool structured_reply;
>   };
>
>   /* That's all folks */
> @@ -754,6 +756,22 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
>                                                        "TLS not configured");
>                   }
>                   break;
> +
> +            case NBD_OPT_STRUCTURED_REPLY:
> +                if (length) {
> +                    ret = nbd_check_zero_length(client, length, option, errp);

here same thing like in previous patch, about success in 
nbd_check_zero_length

> +                } else if (client->structured_reply) {
> +                    ret = nbd_negotiate_send_rep_err(
> +                        client->ioc, NBD_REP_ERR_INVALID, option, errp,
> +                        "structured reply already negotiated");
> +                } else {
> +                    ret = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
> +                                                 option, errp);
> +                }

you've dropped "if (ret < 0) { return ret }", but the following two 
lines should not be
executed if ret < 0.. May be it doesn't matter (we will abort connection 
anyway after switch {}) but
it looks strange.

> +                client->structured_reply = true;
> +                myflags |= NBD_FLAG_SEND_DF;
> +                break;
> +
>               default:
>                   if (nbd_drop(client->ioc, length, errp) < 0) {
>                       return -EIO;
> @@ -1228,6 +1246,60 @@ static int nbd_co_send_simple_reply(NBDClient *client,
>       return nbd_co_send_iov(client, iov, len ? 2 : 1, errp);
>   }

[...]


-- 
Best regards,
Vladimir
