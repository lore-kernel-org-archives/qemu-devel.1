Received: from eggs.gnu.org ([2001:4830:134:3::10]:37969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fW4I7-00051e-57
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fW4I6-00073G-4I
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:26:43 -0400
References: <20180612172614.60107-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b19ef4df-7280-27ca-cd82-c4de9297a335@virtuozzo.com>
Date: Thu, 21 Jun 2018 21:26:29 +0300
MIME-Version: 1.0
In-Reply-To: <20180612172614.60107-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] drop Re: [PATCH] block/qcow2: fix logic around
 dirty_bitmaps_loaded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

12.06.2018 20:26, Vladimir Sementsov-Ogievskiy wrote:
> First: this variable was introduced to handle reopens. We need it on
> following qcow2_do_open, to don't try loading bitmaps again. So, we are
> fixing qcow2_invalidate_cache().
>
> However, if we fix only qcow2_invalidate_cache, iotest 169 fails on
> case test__persistent__not_migbitmap__online_shared, because on first
> target open, source is not yet closed, and is not yet stored bitmaps,
> so, we are load nothing. And on second open, dirty_bitmaps_loaded is
> already true, but we have no bitmaps to reopen with
> qcow2_reopen_bitmaps_rw_hint(). So, we are fixing qcow2_do_open() too.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/qcow2.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6fa5e1d71a..b4216a5830 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1499,7 +1499,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>           {
>               qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
>           }
> -    } else {
> +    } else if (s->nb_bitmaps > 0) {
>           header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
>           s->dirty_bitmaps_loaded = true;
>       }
> @@ -2178,6 +2178,7 @@ static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
>       QDict *options;
>       Error *local_err = NULL;
>       int ret;
> +    bool dirty_bitmaps_loaded = s->dirty_bitmaps_loaded;
>   
>       /*
>        * Backing files are read-only which makes all of their metadata immutable,
> @@ -2190,6 +2191,7 @@ static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
>       qcow2_close(bs);
>   
>       memset(s, 0, sizeof(BDRVQcow2State));
> +    s->dirty_bitmaps_loaded = dirty_bitmaps_loaded;
>       options = qdict_clone_shallow(bs->options);
>   
>       flags &= ~BDRV_O_INACTIVE;

Drop this, I'll resend better patch.

-- 
Best regards,
Vladimir
