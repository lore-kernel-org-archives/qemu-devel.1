Received: from eggs.gnu.org ([2001:4830:134:3::10]:58467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eC6bV-00057P-Md
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eC6bU-0001eV-F3
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:19:57 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
Date: Tue, 7 Nov 2017 19:19:41 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] segfault in parallel blockjobs (iotest 30)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Hi,

One more drainage-related thing.
We have recently encountered an issue with parallel block jobs and it's
not quite clear how to fix it properly, so would appreciate your ideas.

The small attached tweak makes iotest 30 (-qcow2 -nocache) fail 10/10
times on my machine.

And while most of the errors are just a desync between qemu and the
test, TestParallelOps is more worrying: qemu segfaults while draining
before reopening the image for the new block-stream job:

> Program received signal SIGSEGV, Segmentation fault.
> bdrv_next (it=it@entry=0x7fffcea39330) at /mnt/code/us-qemu/block/block-backend.c:453
> 453                 bs = it->blk ? blk_bs(it->blk) : NULL;
> (gdb) bt
> #0  bdrv_next (it=it@entry=0x7fffcea39330) at /mnt/code/us-qemu/block/block-backend.c:453
> #1  0x00007f2797ca1bd7 in bdrv_drain_all_begin () at /mnt/code/us-qemu/block/io.c:347
> #2  0x00007f2797c5470e in bdrv_reopen_multiple (ctx=0x7f279904bd40, bs_queue=0x7f2799b9d8d0, 
>     errp=errp@entry=0x7fffcea393e0) at /mnt/code/us-qemu/block.c:2871
> #3  0x00007f2797c548d4 in bdrv_reopen (bs=bs@entry=0x7f27990a0250, bdrv_flags=bdrv_flags@entry=8226, 
>     errp=errp@entry=0x7fffcea394e8) at /mnt/code/us-qemu/block.c:2916
> #4  0x00007f2797ab49bb in stream_start (job_id=job_id@entry=0x7f2799c2bc10 "stream-node6", 
>     bs=bs@entry=0x7f27990a0250, base=base@entry=0x7f27990de250, 
>     backing_file_str=backing_file_str@entry=0x7f2799a0a350 "/vz/anefedov/qemu-build/us/tests/qemu-iotests/scratch/img-4.img", speed=speed@entry=524288, on_error=on_error@entry=BLOCKDEV_ON_ERROR_REPORT, 
>     errp=errp@entry=0x7fffcea394e8) at /mnt/code/us-qemu/block/stream.c:239
> #5  0x00007f2797a86c96 in qmp_block_stream (has_job_id=<optimized out>, 
> [...]
> (gdb) p it->blk
> $1 = (BlockBackend *) 0x9797979797979797


BlockBackend gets deleted by another job's stream_complete(),
deferred to the main loop, so the fact that the job is put to sleep by
bdrv_drain_all_begin() doesn't really stop it from execution.

Looks like the problem is a bit wider though: if I (just for a test)
keep the BlockBackends referenced while iterating in drain_all_begin(),
qemu fails a bit further, when accessing the deleted BlockDriverState
from the apparently obsolete BlockReopenQueue in bdrv_reopen_prepare().


> Program received signal SIGSEGV, Segmentation fault.
> 0x00007f4c66a04420 in find_parent_in_reopen_queue (q=<optimized out>, c=0x7f4c68b365e0)
>     at /mnt/code/us-qemu/block.c:2932
> 2932            QLIST_FOREACH(child, &bs->children, next) {
> (gdb) bt
> #0  0x00007f4c66a04420 in find_parent_in_reopen_queue (q=<optimized out>, c=0x7f4c68b365e0)
>     at /mnt/code/us-qemu/block.c:2932
> #1  bdrv_reopen_perm (shared=0x7f4c69596440, perm=0x7f4c69596438, bs=0x7f4c68abc250, q=0x7f4c696238d0)
>     at /mnt/code/us-qemu/block.c:2951
> #2  bdrv_reopen_prepare (reopen_state=reopen_state@entry=0x7f4c69596428, queue=queue@entry=0x7f4c696238d0, 
>     errp=errp@entry=0x7ffe09fc28d0) at /mnt/code/us-qemu/block.c:3035
> #3  0x00007f4c66a0474f in bdrv_reopen_multiple (ctx=<optimized out>, bs_queue=0x7f4c696238d0, 
>     errp=errp@entry=0x7ffe09fc2920) at /mnt/code/us-qemu/block.c:2875
> #4  0x00007f4c66a048d4 in bdrv_reopen (bs=bs@entry=0x7f4c68abc250, bdrv_flags=bdrv_flags@entry=8226, 
>     errp=errp@entry=0x7ffe09fc2a28) at /mnt/code/us-qemu/block.c:2916
> #5  0x00007f4c668649bb in stream_start (job_id=job_id@entry=0x7f4c68f95fc0 "stream-node6", 
> [...]
> (gdb) p bs
> $1 = (BlockDriverState *) 0x7f4c68b57250
> (gdb) p bs->children
> $2 = {lh_first = 0x6060606060606060}


Does this mean that bdrv_reopen_queue() has to be moved after
bdrv_drain_all_begin() which also has to be taught to suspend the main
loop BHs somehow?


thank you
/Anton

------

diff --git a/block/stream.c b/block/stream.c
index 52d329f..74e980c 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -26,7 +26,7 @@ enum {
       * enough to process multiple clusters in a single call, so that 
populating
       * contiguous regions of the image is efficient.
       */
-    STREAM_BUFFER_SIZE = 512 * 1024, /* in bytes */
+    STREAM_BUFFER_SIZE = 8 * 1024 * 1024, /* in bytes */
  };

  #define SLICE_TIME 100000000ULL /* ns */
