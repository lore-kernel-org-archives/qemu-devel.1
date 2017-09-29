Received: from eggs.gnu.org ([2001:4830:134:3::10]:36356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dy1FC-0007qz-8b
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dy1FB-0006Jx-2R
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:46:42 -0400
References: <20170928120300.58164-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0213e2d1-1e2c-8b0a-8732-48c41d8a228d@redhat.com>
Date: Fri, 29 Sep 2017 15:46:29 -0400
MIME-Version: 1.0
In-Reply-To: <20170928120300.58164-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/mirror: check backing
 in bdrv_mirror_top_refresh_filename
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, mreitz@redhat.com
List-ID: <qemu-devel.nongnu.org>



On 09/28/2017 08:03 AM, Vladimir Sementsov-Ogievskiy wrote:
> Backing may be zero after failed bdrv_attach_child in
> bdrv_set_backing_hd, which leads to SIGSEGV.
> 

I guess in this case we trust bdrv_set_backing_hd to carry the errp
parameter back to the caller indicating that not only did we fail to set
the new backing_hd, but we've also lost the old one, as evidenced by the
nop-style return in .bdrv_refresh_filename...

so the error case should already be "handled", and this just cleans up a
segfault.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> Hi all.
> 
> We have faced into this SIGSEGV because of image locking:
> trying to call qemu-img commit on locked image leads to the following:
> 
>     Program terminated with signal 11, Segmentation fault.
>     #0  bdrv_mirror_top_refresh_filename (bs=0x5616df9a7400, opts=0x5616df268400)
>         at block/mirror.c:1203
>     1203        bdrv_refresh_filename(bs->backing->bs);
>     
>     (gdb) bt
>     #0  bdrv_mirror_top_refresh_filename (bs=0x5616df9a7400, opts=0x5616df268400)
>         at block/mirror.c:1203
>     #1  0x00005616ddc3d35f in bdrv_refresh_filename (bs=0x5616df9a7400) at block.c:4739
>     #2  0x00005616ddc3d672 in bdrv_set_backing_hd (bs=bs@entry=0x5616df9a7400, 
>         backing_hd=backing_hd@entry=0x5616df25c000, errp=errp@entry=0x7ffff7896a20)
>         at block.c:2035
>     #3  0x00005616ddc3dee3 in bdrv_append (bs_new=bs_new@entry=0x5616df9a7400, 
>         bs_top=bs_top@entry=0x5616df25c000, errp=errp@entry=0x7ffff7896ad8)
>         at block.c:3168
>     #4  0x00005616ddc84e5f in mirror_start_job (
>         job_id=job_id@entry=0x5616ddd16a31 "commit", bs=bs@entry=0x5616df25c000, 
>         creation_flags=creation_flags@entry=0, target=target@entry=0x5616df262800, 
>         replaces=replaces@entry=0x0, speed=speed@entry=0, granularity=65536, 
>         granularity@entry=0, buf_size=16777216, buf_size@entry=0, 
>         backing_mode=backing_mode@entry=MIRROR_LEAVE_BACKING_CHAIN, 
>         on_source_error=on_source_error@entry=BLOCKDEV_ON_ERROR_REPORT, 
>         on_target_error=on_target_error@entry=BLOCKDEV_ON_ERROR_REPORT, 
>         unmap=unmap@entry=true, cb=cb@entry=0x5616ddc35470 <common_block_job_cb>, 
>         opaque=opaque@entry=0x7ffff7896c80, errp=errp@entry=0x7ffff7896bd0, 
>         driver=driver@entry=0x5616ddf8d100 <commit_active_job_driver>, 
>         is_none_mode=is_none_mode@entry=false, base=base@entry=0x5616df262800, 
>         auto_complete=auto_complete@entry=false, 
>         filter_node_name=filter_node_name@entry=0x0) at block/mirror.c:1314
>     #5  0x00005616ddc87580 in commit_active_start (
>         job_id=job_id@entry=0x5616ddd16a31 "commit", bs=bs@entry=0x5616df25c000, 
>         base=base@entry=0x5616df262800, creation_flags=creation_flags@entry=0, 
>         speed=speed@entry=0, on_error=on_error@entry=BLOCKDEV_ON_ERROR_REPORT, 
>         filter_node_name=filter_node_name@entry=0x0, 
>         cb=cb@entry=0x5616ddc35470 <common_block_job_cb>, 
>         opaque=opaque@entry=0x7ffff7896c80, errp=errp@entry=0x7ffff7896c78, 
>         auto_complete=auto_complete@entry=false) at block/mirror.c:1463
>     #6  0x00005616ddc33a68 in img_commit (argc=<optimized out>, argv=<optimized out>)
>         at qemu-img.c:1013
>     #7  0x00005616ddc2fa79 in main (argc=4, argv=0x7ffff7896e00) at qemu-img.c:4548
> 
> 
>     (gdb) p bs->backing
>     $2 = (BdrvChild *) 0x0
>     (gdb) fr 2
>     #2  0x00005616ddc3d672 in bdrv_set_backing_hd (bs=bs@entry=0x5616df9a7400, 
>         backing_hd=backing_hd@entry=0x5616df25c000, errp=errp@entry=0x7ffff7896a20)
>         at block.c:2035
>     2035        bdrv_refresh_filename(bs);
>     (gdb) p *errp
>     $4 = (Error *) 0x5616df1c2660
>     (gdb) p **errp
>     $5 = {msg = 0x5616df2554e0 "Failed to get \"write\" lock", 
>       err_class = ERROR_CLASS_GENERIC_ERROR, 
>       src = 0x5616ddd267fe "block/file-posix.c", 
>       func = 0x5616ddd26fe0 <__func__.27999> "raw_check_lock_bytes", line = 682, 
>       hint = 0x5616df1fe520}
> 
> 
>  block/mirror.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 6f5cb9f26c..351b80ca2c 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1073,6 +1073,11 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
>  
>  static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
>  {
> +    if (bs->backing == NULL) {
> +        /* we can be here after failed bdrv_attach_child in
> +         * bdrv_set_backing_hd */
> +        return;
> +    }
>      bdrv_refresh_filename(bs->backing->bs);
>      pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
>              bs->backing->bs->filename);
> 

Reviewed-by: John Snow <jsnow@redhat.com>
