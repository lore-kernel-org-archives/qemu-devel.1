Received: from eggs.gnu.org ([2001:4830:134:3::10]:48306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxry6-0003KY-Ku
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxry2-00063o-0m
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:20:10 -0400
References: <20170410150542.30376-1-famz@redhat.com>
	<20170410150542.30376-11-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <835298af-03d2-8a58-ef08-0e51864977f5@redhat.com>
Date: Tue, 11 Apr 2017 17:19:52 +0800
MIME-Version: 1.0
In-Reply-To: <20170410150542.30376-11-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 10/10] block: Fix bdrv_co_flush
 early return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 10/04/2017 23:05, Fam Zheng wrote:
> bdrv_inc_in_flight and bdrv_dec_in_flight are mandatory for
> BDRV_POLL_WHILE to work, even for the shortcut case where flush is
> unnecessary. Move the if block to below bdrv_dec_in_flight, and BTW fix
> the variable declaration position.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/io.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 00e45ca..bae6947 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2278,16 +2278,17 @@ static void coroutine_fn bdrv_flush_co_entry(void *opaque)
>  
>  int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>  {
> -    int ret;
> -
> -    if (!bs || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
> -        bdrv_is_sg(bs)) {
> -        return 0;
> -    }
> +    int current_gen;
> +    int ret = 0;
>  
>      bdrv_inc_in_flight(bs);
>  
> -    int current_gen = bs->write_gen;
> +    if (!bs || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
> +        bdrv_is_sg(bs)) {
> +        goto early_exit;
> +    }
> +
> +    current_gen = bs->write_gen;
>  
>      /* Wait until any previous flushes are completed */
>      while (bs->active_flush_req) {
> @@ -2370,6 +2371,7 @@ out:
>      /* Return value is ignored - it's ok if wait queue is empty */
>      qemu_co_queue_next(&bs->flush_queue);
>  
> +early_exit:
>      bdrv_dec_in_flight(bs);
>      return ret;
>  }
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
