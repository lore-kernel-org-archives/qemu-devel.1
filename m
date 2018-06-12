Received: from eggs.gnu.org ([2001:4830:134:3::10]:39525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSrVu-00058q-BK
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSrVt-0003Mo-CT
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:11:42 -0400
References: <20180612172614.60107-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bba5e735-2c16-e6a6-7742-7bc2ddcd0380@redhat.com>
Date: Tue, 12 Jun 2018 18:11:35 -0400
MIME-Version: 1.0
In-Reply-To: <20180612172614.60107-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/qcow2: fix logic around
 dirty_bitmaps_loaded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com



On 06/12/2018 01:26 PM, Vladimir Sementsov-Ogievskiy wrote:
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
>  block/qcow2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6fa5e1d71a..b4216a5830 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1499,7 +1499,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>          {
>              qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
>          }
> -    } else {
> +    } else if (s->nb_bitmaps > 0) {
>          header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
>          s->dirty_bitmaps_loaded = true;
>      }
> @@ -2178,6 +2178,7 @@ static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
>      QDict *options;
>      Error *local_err = NULL;
>      int ret;
> +    bool dirty_bitmaps_loaded = s->dirty_bitmaps_loaded;
>  
>      /*
>       * Backing files are read-only which makes all of their metadata immutable,
> @@ -2190,6 +2191,7 @@ static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
>      qcow2_close(bs);
>  
>      memset(s, 0, sizeof(BDRVQcow2State));
> +    s->dirty_bitmaps_loaded = dirty_bitmaps_loaded;
>      options = qdict_clone_shallow(bs->options);
>  
>      flags &= ~BDRV_O_INACTIVE;
> 

Ah, tch... I didn't realize that invalidate completely wipes the qcow2
metadata.

I guess the other three fields, nb_bitmaps, bitmap_directory_size and
bitmap_directory_offset get initialized again on re-open.

(I suppose this means I need to rethink caching bm_list more carefully,
too...)

I think this looks correct mechanically.
