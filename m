Received: from eggs.gnu.org ([2001:4830:134:3::10]:44378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fE9cU-0003Hu-7n
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fE9cT-0000mp-99
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:29:42 -0400
References: <20180501211336.986372-1-eblake@redhat.com>
	<20180501211336.986372-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cfc9dea1-8a22-9c0e-b194-eb697ca36024@virtuozzo.com>
Date: Thu, 3 May 2018 11:29:30 +0300
MIME-Version: 1.0
In-Reply-To: <20180501211336.986372-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/4] nbd/client: Refactor in preparation
 for more limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, edgar.kaziakhmedov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>

02.05.2018 00:13, Eric Blake wrote:
> The next patch will ask the server for more items of NBD_INFO.
> However, the server is free to respond with INFO items in a
> different order than what we request, so performing any sanity
> checks about constraints that occur between multiple INFO items
> must be done after all items have been received.  Make it easier
> to see that such checks are last by sinking the final processing
> after the while loop, rather than embedded in the NBD_REP_ACK
> processing that occurs textually within the loop before other
> INFO processing.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by:=C2=A0 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   nbd/client.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/nbd/client.c b/nbd/client.c
> index 232ff4f46da..0abb195b856 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -1,5 +1,5 @@
>   /*
> - *  Copyright (C) 2016-2017 Red Hat, Inc.
> + *  Copyright (C) 2016-2018 Red Hat, Inc.
>    *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
>    *
>    *  Network Block Device Client Side
> @@ -365,17 +365,12 @@ static int nbd_opt_go(QIOChannel *ioc, const char *=
wantname,
>
>           if (reply.type =3D=3D NBD_REP_ACK) {
>               /* Server is done sending info and moved into transmission
> -               phase, but make sure it sent flags */
> +               phase */
>               if (len) {
>                   error_setg(errp, "server sent invalid NBD_REP_ACK");
>                   return -1;
>               }
> -            if (!info->flags) {
> -                error_setg(errp, "broken server omitted NBD_INFO_EXPORT"=
);
> -                return -1;
> -            }
> -            trace_nbd_opt_go_success();
> -            return 1;
> +            break;
>           }
>           if (reply.type !=3D NBD_REP_INFO) {
>               error_setg(errp, "unexpected reply type %" PRIu32
> @@ -482,6 +477,14 @@ static int nbd_opt_go(QIOChannel *ioc, const char *w=
antname,
>               break;
>           }
>       }
> +
> +    /* Sanity check that server's responses make sense */
> +    if (!info->flags) {
> +        error_setg(errp, "broken server omitted NBD_INFO_EXPORT");
> +        return -1;
> +    }
> +    trace_nbd_opt_go_success();
> +    return 1;
>   }
>
>   /* Return -1 on failure, 0 if wantname is an available export. */


--=20
Best regards,
Vladimir
