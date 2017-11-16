Received: from eggs.gnu.org ([2001:4830:134:3::10]:58886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFEgW-0001wQ-Lu
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFEgV-0003WB-MQ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:34:04 -0500
References: <20171113194857.13933-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c844bfa1-d976-07eb-04e5-6dfa54b48635@virtuozzo.com>
Date: Thu, 16 Nov 2017 10:33:49 +0300
MIME-Version: 1.0
In-Reply-To: <20171113194857.13933-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Don't hard-disconnect
 on ESHUTDOWN from server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

13.11.2017 22:48, Eric Blake wrote:
> The NBD spec says that a server may fail any transmission request
> with ESHUTDOWN when it is apparent that no further request from
> the client can be successfully honored.  The client is supposed
> to then initiate a soft shutdown (wait for all remaining in-flight
> requests to be answered, then send NBD_CMD_DISC).  However, since
> qemu's server never uses ESHUTDOWN errors, this code was mostly
> untested since its introduction in commit b6f5d3b5.
>
> More recently, I learned that nbdkit as the NBD server is able to
> send ESHUTDOWN errors, so I finally tested this code, and noticed
> that our client was special-casing ESHUTDOWN to cause a hard
> shutdown (immediate disconnect, with no NBD_CMD_DISC), but only
> if the server sends this error as a simple reply.  Further
> investigation found that commit d2febedb introduced a regression
> where structured replies behave differently than simple replies -
> but that the structured reply behavior is more in line with the
> spec (even if we still lack code in nbd-client.c to properly quit
> sending further requests).  So this patch reverts the portion of
> b6f5d3b5 that introduced an improper hard-disconnect special-case
> at the lower level, and leaves the future enhancement of a nicer
> soft-disconnect at the higher level for another day.
>
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   nbd/client.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/nbd/client.c b/nbd/client.c
> index 4e15fc484d..eea236ca06 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -996,15 +996,9 @@ int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
>           if (ret < 0) {
>               break;
>           }
> -
>           trace_nbd_receive_simple_reply(reply->simple.error,
>                                          nbd_err_lookup(reply->simple.error),
>                                          reply->handle);
> -        if (reply->simple.error == NBD_ESHUTDOWN) {
> -            /* This works even on mingw which lacks a native ESHUTDOWN */
> -            error_setg(errp, "server shutting down");
> -            return -EINVAL;
> -        }
>           break;
>       case NBD_STRUCTURED_REPLY_MAGIC:
>           ret = nbd_receive_structured_reply_chunk(ioc, &reply->structured, errp);


-- 
Best regards,
Vladimir
