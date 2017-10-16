Received: from eggs.gnu.org ([2001:4830:134:3::10]:57062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e421G-0007Ss-8P
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e421C-0003JM-Bq
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:49:10 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b96907fe-1b3d-8ab9-c4ab-761fe48f26aa@virtuozzo.com>
Date: Mon, 16 Oct 2017 12:49:01 +0300
MIME-Version: 1.0
In-Reply-To: <20171015010131.12172-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 4/8] nbd: Minimal structured read for
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
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

15.10.2017 04:01, Eric Blake wrote:
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
> v4: better _DF flag handling, convert errno to wire format, add
> comments and tracing, rework structured error for less churn when adding
> text message later, don't kill connection on redundant client option
> ---
>   nbd/server.c     | 106 +++++++++++++++++++++++++++++++++++++++++++++++++------
>   nbd/trace-events |   2 ++
>   2 files changed, 98 insertions(+), 10 deletions(-)
>
> diff --git a/nbd/server.c b/nbd/server.c
> index efb6003364..23dc6be708 100644
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
> @@ -762,6 +764,23 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
>                       return ret;
>                   }
>                   break;
> +
> +            case NBD_OPT_STRUCTURED_REPLY:
> +                if (client->structured_reply) {
> +                    ret = nbd_negotiate_send_rep_err(
> +                        client->ioc, NBD_REP_ERR_INVALID, option, errp,
> +                        "structured reply already negotiated");

You were going to send a patch to spec for this..

> +                } else {
> +                    ret = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
> +                                                 option, errp);
> +                }
> +                if (ret < 0) {
> +                    return ret;
> +                }
> +                client->structured_reply = true;
> +                myflags |= NBD_CMD_FLAG_DF;

it should be NBD_FLAG_SEND_DF

[...]

the following looks ok.

-- 
Best regards,
Vladimir
