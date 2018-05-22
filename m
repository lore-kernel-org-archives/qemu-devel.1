Received: from eggs.gnu.org ([2001:4830:134:3::10]:33259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fL9Ho-0003VK-6x
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fL9Hm-0007eE-Rq
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:33:16 -0400
References: <20180501211336.986372-1-eblake@redhat.com>
	<20180501211336.986372-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0df1a90d-bcca-ac1e-0f17-b982faefc253@virtuozzo.com>
Date: Tue, 22 May 2018 18:33:00 +0300
MIME-Version: 1.0
In-Reply-To: <20180501211336.986372-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/4] nbd/client: Support requests of
 additional block sizing info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, edgar.kaziakhmedov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

02.05.2018 00:13, Eric Blake wrote:
> The NBD spec is clarifying [1] that a server may want to advertise
> different limits for READ/WRITE (in our case, 32M) than for
> TRIM/ZERO (in our case, nearly 4G).  Implement the client
> side support for these alternate limits, by always requesting
> the new information (a compliant server must ignore the
> request if it is unknown), and by validating anything reported
> by the server before populating the block layer limits.
>
> [1] https://lists.debian.org/nbd/2018/03/msg00048.html
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
>
> The given URL for the NBD spec was v3; it will change to be a v4
> version of that patch in part to point back to this qemu commit
> as a proof of implementation.
> ---
>   include/block/nbd.h |   4 ++
>   block/nbd.c         |  15 ++++++-
>   nbd/client.c        | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>   nbd/trace-events    |   2 +
>   4 files changed, 131 insertions(+), 6 deletions(-)
>
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index cbf51628f78..90ddef32bb3 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -270,6 +270,10 @@ struct NBDExportInfo {
>       uint32_t min_block;
>       uint32_t opt_block;
>       uint32_t max_block;
> +    uint32_t min_trim;
> +    uint32_t max_trim;
> +    uint32_t min_zero;
> +    uint32_t max_zero;
>
>       uint32_t meta_base_allocation_id;
>   };
> diff --git a/block/nbd.c b/block/nbd.c
> index 1e2b3ba2d3b..823d10b251d 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -478,8 +478,19 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
>       uint32_t max = MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_block);
>
>       bs->bl.request_alignment = min ? min : BDRV_SECTOR_SIZE;
> -    bs->bl.max_pdiscard = max;
> -    bs->bl.max_pwrite_zeroes = max;
> +    if (s->info.max_trim) {
> +        bs->bl.max_pdiscard = MIN(s->info.max_trim, BDRV_REQUEST_MAX_BYTES);
> +    } else {
> +        bs->bl.max_pdiscard = max;
> +    }
> +    bs->bl.pdiscard_alignment = s->info.min_trim;
> +    if (s->info.max_zero) {
> +        bs->bl.max_pwrite_zeroes = MIN(s->info.max_zero,
> +                                       BDRV_REQUEST_MAX_BYTES);
> +    } else {
> +        bs->bl.max_pwrite_zeroes = max;
> +    }
> +    bs->bl.pwrite_zeroes_alignment = s->info.min_zero;
>       bs->bl.max_transfer = max;

Should not max_transfer be updated too? Looks like it limits all 
requests, is it right?

Best regards,
Vladimir
