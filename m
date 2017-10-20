Received: from eggs.gnu.org ([2001:4830:134:3::10]:37807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5cw5-000844-1Q
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5cw1-0006R3-Rf
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:26:25 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-9-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7573697c-4eb8-2c98-82c3-53a0ab884c65@virtuozzo.com>
Date: Fri, 20 Oct 2017 22:26:18 +0300
MIME-Version: 1.0
In-Reply-To: <20171019222637.17890-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 08/11] nbd/client: refactor
 nbd_receive_starttls
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
> Split out nbd_request_simple_option to be reused for structured reply
> option.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v5: only check length for ACK responses
> v4: reduce redundant traces, typo fix in commit message
> ---
>   nbd/client.c     | 70 ++++++++++++++++++++++++++++++++++++++------------------
>   nbd/trace-events |  4 +---
>   2 files changed, 49 insertions(+), 25 deletions(-)
>
> diff --git a/nbd/client.c b/nbd/client.c
> index 50f36b511e..78a0e9cdc3 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -508,35 +508,61 @@ static int nbd_receive_query_exports(QIOChannel *ioc,
>       }
>   }
>
> +/* nbd_request_simple_option: Send an option request, and parse the reply
> + * return 1 for successful negotiation,
> + *        0 if operation is unsupported,
> + *        -1 with errp set for any other error
> + */
> +static int nbd_request_simple_option(QIOChannel *ioc, int opt, Error **errp)
> +{
> +    nbd_opt_reply reply;
> +    int error;
> +
> +    if (nbd_send_option_request(ioc, opt, 0, NULL, errp) < 0) {
> +        return -1;
> +    }
> +
> +    if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
> +        return -1;
> +    }
> +    error = nbd_handle_reply_err(ioc, &reply, errp);
> +    if (error <= 0) {
> +        return error;
> +    }
> +
> +    if (reply.type != NBD_REP_ACK) {
> +        error_setg(errp, "Server rejected request for option %d (%s) "

Looks like now it is not rejected (nbd_handle_reply_err return >0 only 
for successful replies), but it should be
Server replied ... with unexpected reply ...

with that fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>




-- 
Best regards,
Vladimir
