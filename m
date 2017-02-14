Received: from eggs.gnu.org ([2001:4830:134:3::10]:47042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdkbn-0003iM-Gb
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdkbl-00082V-9J
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:25:59 -0500
Date: Tue, 14 Feb 2017 22:25:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170214212546.GE6189@noname.redhat.com>
References: <20170214162012.GC6189@noname.redhat.com>
	<1045307195-43255@kerio.kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045307195-43255@kerio.kamp.de>
Subject: Re: [Qemu-devel] [RFC PATCH V3] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, ct@flyingcircus.io

Am 14.02.2017 um 21:43 hat Peter Lieven geschrieben:
> Von: Kevin Wolf <kwolf@redhat.com>
> An: Peter Lieven <pl@kamp.de>
> Kopie: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>, <mreitz@redhat.com>,
> <ct@flyingcircus.io>
> Gesendet: 14.02.2017 17:20
> Betreff: Re: [RFC PATCH V3] qemu-img: make convert async
> 
> 
>     Am 14.02.2017 um 14:39 hat Peter Lieven geschrieben:
>     > this is something I have been thinking about for almost 2 years now.
>     > we heavily have the following two use cases when using qemu-img convert.
>     >
>     > a) reading from NFS and writing to iSCSI for deploying templates
>     > b) reading from iSCSI and writing to NFS for backups
>     >
>     > In both processes we use libiscsi and libnfs so we have no kernel
>     pagecache.
>     > As qemu-img convert is implemented with sync operations that means we
>     > read one buffer and then write it. No parallelism and each sync request
>     > takes as long as it takes until it is completed.
>     >
>     > This is version 3 of the approach using coroutine worker "threads".
>     >
>     > So far I have the following runtimes when reading an uncompressed QCOW2
>     from
>     > NFS and writing it to iSCSI (raw):
>     >
>     > qemu-img (master)
>     >  nfs -> iscsi 22.8 secs
>     >  nfs -> ram   11.7 secs
>     >  ram -> iscsi 12.3 secs
>     >
>     > qemu-img-async
>     >  nfs -> iscsi 12.3 secs
>     >  nfs -> ram   10.5 secs
>     >  ram -> iscsi 11.7 secs
>     >
>     > Comments appreciated.
>     >
>     > Thank you,
>     > Peter
>     >
>     > Signed-off-by: Peter Lieven <pl@kamp.de>
>     > ---
>     > v2->v3: - updated stats in the commit msg from a host with a better
>     network card
>     >         - only wake up the coroutine that is acutally waiting for a write
>     to complete.
>     >           this was not only overhead, but also breaking at least linux
>     AIO.
>     >         - fix coding style complaints
>     >         - rename some variables and structs
>     >
>     > v1->v2: - using coroutine as worker "threads". [Max]
>     >         - keeping the request queue as otherwise it happens
>     >           that we wait on BLK_ZERO chunks while keeping the write order.
>     >           it also avoids redundant calls to get_block_status and helps
>     >           to skip some conditions for fully allocated imaged (!s->
>     min_sparse)
>     >
>     >  qemu-img.c | 213
>     +++++++++++++++++++++++++++++++++++++++++--------------------
>     >  1 file changed, 145 insertions(+), 68 deletions(-)
>     >
>     > diff --git a/qemu-img.c b/qemu-img.c
>     > index cff22e3..970863f 100644
>     > --- a/qemu-img.c
>     > +++ b/qemu-img.c
>     > @@ -1448,6 +1448,16 @@ enum ImgConvertBlockStatus {
>     >      BLK_BACKING_FILE,
>     >  };
>     >  
>     > +typedef struct ImgConvertRequest {
>     > +    int64_t sector_num;
>     > +    enum ImgConvertBlockStatus status;
>     > +    int nb_sectors;
>     > +    QSIMPLEQ_ENTRY(ImgConvertRequest) next;
>     > +} ImgConvertRequest;
> 
>     If I understand your code correctly, you first go through the image and
>     create an ImgConvertRequest for every chunk with the same allocation
>     status (well, actually not every chunk, but that may be a bug, see
>     below).
> 
>     So let's assume a 1 TB image with every other cluster allocated:
> 
>        1T / (64k * 2) = 8M
> 
>     A list with 8 million entries (requiring 8 million mallocs) feels
>     relatively large. Not counting malloc overhead (which might be
>     considerable here), I think we're at 192 MB memory usage for this case.
>     Not as bad as I was afraid, but not really nice either. And 1 TB isn't
>     even close to the maximum image size.
> 
>     Is it really necessary to create this list at the beginning? Why can't
>     we just get the next chunk as the old code used to?
> 
> 
> In my initial version with AIO invoking convert_iterate_sectors caused
> recursive entries into my queue_fill functions. If I have fixed worker threads
> or only a few coroutines for read/write whatsever this might work without.
> I will have a look. In my test cases I don't have such heavily fragmented
> images. I was at a few hundred entries at most.
> The other issue I feared was that the "cache" in convert_iterate_sectors
> does not work correctly. But if the calls to this function are still in
> increasing
> sector order, it should work.

The only thing that I could possibly imagine is that you could get races
between different reader coroutines. A CoMutex around the call to
convert_iterate_sectors() should fix that.

If you have recursive entries, that looks more like a simple bug,
though.

>     > @@ -1544,11 +1561,13 @@ static int convert_iteration_sectors
>     (ImgConvertState *s, int64_t sector_num)
>     >      return n;
>     >  }
>     >  
>     > -static int convert_read(ImgConvertState *s, int64_t sector_num, int
>     nb_sectors,
>     > -                        uint8_t *buf)
>     > +static int convert_co_read(ImgConvertState *s, ImgConvertRequest *req,
>     > +                           uint8_t *buf, QEMUIOVector *qiov)
> 
>     This is a weird interface: You want to get a created, but empty qiov
>     from the caller. There's no real point in that. The traditional approch
>     is having a struct iovec on the stack here locally and then using
>     qemu_iovec_init_external().
> 
> 
> The idea was to avoid the qemu_iovec every time because this involves a malloc,
> but I admit its not nice. Maybe I find a better approach.

qemu_iovec_init_external() doesn't involve a malloc.

>     > -static int convert_do_copy(ImgConvertState *s)
>     > +static void convert_co_do_copy(void *opaque)
>     >  {
>     > +    ImgConvertState *s = opaque;
>     >      uint8_t *buf = NULL;
>     > -    int64_t sector_num, allocated_done;
>     > +    int ret, i;
>     > +    ImgConvertRequest *req, *next_req;
>     > +    QEMUIOVector qiov;
>     > +    int index = -1;
>     > +
>     > +    for (i = 0; i < NUM_COROUTINES; i++) {
>     > +        if (s->co[i] == qemu_coroutine_self()) {
>     > +            index = i;
>     > +            break;
>     > +        }
>     > +    }
>     > +    assert(index >= 0);
>     > +
>     > +    qemu_iovec_init(&qiov, 1);
>     > +    buf = blk_blockalign(s->target, s->buf_sectors * BDRV_SECTOR_SIZE);
>     > +
>     > +    while (s->ret == -EINPROGRESS && (req = QSIMPLEQ_FIRST(&s->queue)))
>     {
>     > +        QSIMPLEQ_REMOVE_HEAD(&s->queue, next);
>     > +        next_req = QSIMPLEQ_FIRST(&s->queue);
>     > +
>     > +        s->allocated_done += req->nb_sectors;
>     > +        qemu_progress_print(100.0 * s->allocated_done / s->
>     allocated_sectors,
>     > +                            0);
>     > +
>     > +        if (req->status == BLK_DATA) {
>     > +            ret = convert_co_read(s, req, buf, &qiov);
>     > +            if (ret < 0) {
>     > +                error_report("error while reading sector %" PRId64
>     > +                             ": %s", req->sector_num, strerror(-ret));
>     > +                s->ret = ret;
>     > +                goto out;
>     > +            }
>     > +        }
>     > +
>     > +        /* keep writes in order */
>     > +        while (s->wr_offs != req->sector_num) {
>     > +            if (s->ret != -EINPROGRESS) {
>     > +                goto out;
>     > +            }
>     > +            s->wait_sector_num[index] = req->sector_num;
>     > +            qemu_coroutine_yield();
>     > +        }
>     > +        s->wait_sector_num[index] = -1;
> 
>     Okay, so may this is the most important part of the patch.
> 
>     If we need to keep writes in order, we can only have a single coroutine
>     that is currently writing. Then how likely is it that more than one
>     other coroutine could actually be reading at the same time rather than
>     just waiting for the current writer to be finished?
> 
>     My assumption is that it effectively degenerates to exactly one reader
>     and one writer, which means that we don't actually need a command line
>     option to configure the number of coroutines, and that our default of 8
>     is already higher than useful.
> 
> 
> I will check the result for 4 and 2 coroutines. My observation or fear was
> that a read and write that are effectively no-ops (BLK_ZERO with s->
> has_zero_init)
> could block the queue and avoid to read ahead.

BLK_ZERO isn't a big problem because the read for those is as cheap as
the write, but BLK_DATA with an all-zero block that is then detected and
discarded could indeed result in this scenario.

>     The big question is then if the code could become simpler if we can
>     assume exactly two coroutines. Possibly even not two coroutines that do
>     the same thing, but one that reads and another one that writes,
>     coordinated with the usual coroutine locking mechanisms. (I haven't
>     thought enough about it to be sure that it would be an improvement, but
>     it doesn't feel too unlikely.)
> 
>     On the other hand, if keeping writes in order is only actually needed in
>     specific cases, other cases could benefit from actual parallelism, even
>     though this is not implemented in this patch.
> 
> 
> I tried to disable it. It has had no influence for my test scenario. But with
> the current approach such a switch as well as a switch to define the number
> of workers could easily be implemented. Having multiple readers (and maybe
> writers)
> should increase performance if there is latency involved.

Quite possibly, yes.

> Before I rewrite everything I would propose to try to change the code
> to avoid to build the request queue upfront and analyze what a change in number
> of coroutines has in the current and the version without request queue?

Sounds good to me.

> If we would have a read and a write coroutine and maybe a third (to
> calculate the request size with convert_iterate_sectors) my idea would
> be to have a limited request queue.  That is passed from coroutine to
> coroutine.

Not sure if having a separate coroutine for convert_iterate_sectors() is
actually worth it, but otherwise this sounds a lot better than building
the whole request queue upfront.

> sth like:
>  queue 1: free request object
>  fifo queue 2: request objects ready for reading
>  fifo queue 3: request objects ready for writing.
> 
> The first coroutine would fetch the a free request object and calculate
> nb_sectors and status and
> put it into queue 2.
> Then the reader coroutine would fetch the next read object in order and perform
> the read. Once
> finisched it puts the object into the queue 3.
> Then the writer coroutine handles the write and when the write is finished it
> puts it back into
> into the freelist (queue 1).

And with this design, you could still increase the number of worker
coroutines, so that's good.

You still need to compare whether having separate reader and writer
coroutines really simplifies the code compared to worker coroutines that
do all of it, but I think you'll quickly notice.

Kevin
