Received: from eggs.gnu.org ([2001:4830:134:3::10]:46678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fDXfL-0000fK-Je
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fDXfF-0001Ow-Re
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:58:07 -0400
References: <20180501154654.943782-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6747056a-f73f-273a-3f4f-3cab3081b587@virtuozzo.com>
Date: Tue, 1 May 2018 18:55:18 +0300
MIME-Version: 1.0
In-Reply-To: <20180501154654.943782-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] nbd/client: Fix error messages during
 NBD_INFO_BLOCK_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

01.05.2018 18:46, Eric Blake wrote:
> A missing space makes for poor error messages.  Also, we missed
> diagnosing a server that sends a maximum block size less than
> the minimum.
>
> Fixes: 081dd1fe
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   nbd/client.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/nbd/client.c b/nbd/client.c
> index 7f35b5c3232..7b3caa90ec2 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -436,7 +436,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>               be32_to_cpus(&info->min_block);
>               if (!is_power_of_2(info->min_block)) {
>                   error_setg(errp, "server minimum block size %" PRId32
> -                           "is not a power of two", info->min_block);
> +                           " is not a power of two", info->min_block);
>                   nbd_send_opt_abort(ioc);
>                   return -1;
>               }
> @@ -451,7 +451,7 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>               if (!is_power_of_2(info->opt_block) ||
>                   info->opt_block < info->min_block) {
>                   error_setg(errp, "server preferred block size %" PRId32
> -                           "is not valid", info->opt_block);
> +                           " is not valid", info->opt_block);
>                   nbd_send_opt_abort(ioc);
>                   return -1;
>               }
> @@ -462,6 +462,12 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
>                   return -1;
>               }
>               be32_to_cpus(&info->max_block);
> +            if (info->max_block < info->min_block) {
> +                error_setg(errp, "server maximum block size %" PRId32
> +                           " is not valid", info->max_block);
> +                nbd_send_opt_abort(ioc);
> +                return -1;
> +            }
>               trace_nbd_opt_go_info_block_size(info->min_block, info->opt_block,
>                                                info->max_block);
>               break;


-- 
Best regards,
Vladimir
