Received: from eggs.gnu.org ([209.51.188.92]:59700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gziVr-0002pH-4l
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gziVo-0002fl-Ve
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:47:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1gziVm-0002c3-LB
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:47:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id w17so25911076wrn.12
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 05:47:36 -0800 (PST)
References: <20190227165212.34901-1-slp@redhat.com>
	<20190227173714.GA6276@localhost.localdomain>
	<20190228150119.c77xcmrp4ogg32eu@dritchie>
	<20190228155053.GB5563@linux.fritz.box>
	<20190228170436.mifnzx6agowzxyq3@dritchie>
	<20190228172202.GC5563@linux.fritz.box>
	<20190228183637.f7v6phv3kqtin3ps@dritchie>
	<20190301114426.GA5861@localhost.localdomain>
From: Sergio Lopez <slp@redhat.com>
In-reply-to: <20190301114426.GA5861@localhost.localdomain>
Date: Fri, 01 Mar 2019 14:47:32 +0100
Message-ID: <87lg1yogej.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: dataplane: release AioContext
 before blk_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


Kevin Wolf writes:

> Am 28.02.2019 um 19:36 hat Sergio Lopez geschrieben:
>> On Thu, Feb 28, 2019 at 06:22:02PM +0100, Kevin Wolf wrote:
>> > Am 28.02.2019 um 18:04 hat Sergio Lopez geschrieben:
>> > > On Thu, Feb 28, 2019 at 04:50:53PM +0100, Kevin Wolf wrote:
>> > > > Am 28.02.2019 um 16:01 hat Sergio Lopez geschrieben:
>> > > > > On Wed, Feb 27, 2019 at 06:37:14PM +0100, Kevin Wolf wrote:
>> > > > > > Am 27.02.2019 um 17:52 hat Sergio Lopez geschrieben:
>> > > > > > > Stopping the dataplane requires calling to blk_set_aio_context, which
>> > > > > > > may need to wait for a running job to be completed or paused.
>> > > > > > > 
>> > > > > > > As stopping the dataplane is something that can be triggered from a vcpu
>> > > > > > > thread (due to the Guest requesting to stop the device), while the job
>> > > > > > > itself may be managed by an iothread, holding the AioContext will lead
>> > > > > > > to a deadlock, where the first one is waiting for the job to pause or
>> > > > > > > finish, while the second can't make any progress as it's waiting for the
>> > > > > > > AioContext to be released:
>> > > > > > > 
>> > > > > > >  Thread 6 (LWP 90472)
>> > > > > > >  #0  0x000055a6f8497aee in blk_root_drained_end
>> > > > > > >  #1  0x000055a6f84a7926 in bdrv_parent_drained_end
>> > > > > > >  #2  0x000055a6f84a799f in bdrv_do_drained_end
>> > > > > > >  #3  0x000055a6f84a82ab in bdrv_drained_end
>> > > > > > >  #4  0x000055a6f8498be8 in blk_drain
>> > > > > > >  #5  0x000055a6f84a22cd in mirror_drain
>> > > > > > >  #6  0x000055a6f8457708 in block_job_detach_aio_context
>> > > > > > >  #7  0x000055a6f84538f1 in bdrv_detach_aio_context
>> > > > > > >  #8  0x000055a6f8453a96 in bdrv_set_aio_context
>> > > > > > >  #9  0x000055a6f84999f8 in blk_set_aio_context
>> > > > > > >  #10 0x000055a6f81802c8 in virtio_blk_data_plane_stop
>> > > > > > >  #11 0x000055a6f83cfc95 in virtio_bus_stop_ioeventfd
>> > > > > > >  #12 0x000055a6f83d1f81 in virtio_pci_common_write
>> > > > > > >  #13 0x000055a6f83d1f81 in virtio_pci_common_write
>> > > > > > >  #14 0x000055a6f8148d62 in memory_region_write_accessor
>> > > > > > >  #15 0x000055a6f81459c9 in access_with_adjusted_size
>> > > > > > >  #16 0x000055a6f814a608 in memory_region_dispatch_write
>> > > > > > >  #17 0x000055a6f80f1f98 in flatview_write_continue
>> > > > > > >  #18 0x000055a6f80f214f in flatview_write
>> > > > > > >  #19 0x000055a6f80f6a7b in address_space_write
>> > > > > > >  #20 0x000055a6f80f6b15 in address_space_rw
>> > > > > > >  #21 0x000055a6f815da08 in kvm_cpu_exec
>> > > > > > >  #22 0x000055a6f8132fee in qemu_kvm_cpu_thread_fn
>> > > > > > >  #23 0x000055a6f8551306 in qemu_thread_start
>> > > > > > >  #24 0x00007f9bdf5b9dd5 in start_thread
>> > > > > > >  #25 0x00007f9bdf2e2ead in clone
>> > > > > > > 
>> > > > > > >  Thread 8 (LWP 90467)
>> > > > > > >  #0  0x00007f9bdf5c04ed in __lll_lock_wait
>> > > > > > >  #1  0x00007f9bdf5bbde6 in _L_lock_941
>> > > > > > >  #2  0x00007f9bdf5bbcdf in __GI___pthread_mutex_lock
>> > > > > > >  #3  0x000055a6f8551447 in qemu_mutex_lock_impl
>> > > > > > >  #4  0x000055a6f854be77 in co_schedule_bh_cb
>> > > > > > >  #5  0x000055a6f854b781 in aio_bh_poll
>> > > > > > >  #6  0x000055a6f854b781 in aio_bh_poll
>> > > > > > >  #7  0x000055a6f854f01b in aio_poll
>> > > > > > >  #8  0x000055a6f825a488 in iothread_run
>> > > > > > >  #9  0x000055a6f8551306 in qemu_thread_start
>> > > > > > >  #10 0x00007f9bdf5b9dd5 in start_thread
>> > > > > > >  #11 0x00007f9bdf2e2ead in clone
>> > > > > > > 
>> > > > > > >  (gdb) thread 8
>> > > > > > >  [Switching to thread 8 (Thread 0x7f9bd6dae700 (LWP 90467))]
>> > > > > > >  #3  0x000055a6f8551447 in qemu_mutex_lock_impl (mutex=0x55a6fac8fea0,
>> > > > > > >      file=0x55a6f8730c3f "util/async.c", line=511) at util/qemu-thread-posix.c:66
>> > > > > > >  66	    err = pthread_mutex_lock(&mutex->lock);
>> > > > > > >  (gdb) up 3
>> > > > > > >  #3  0x000055a6f8551447 in qemu_mutex_lock_impl (mutex=0x55a6fac8fea0,
>> > > > > > >      file=0x55a6f8730c3f "util/async.c", line=511) at util/qemu-thread-posix.c:66
>> > > > > > >  66	    err = pthread_mutex_lock(&mutex->lock);
>> > > > > > >  (gdb) p mutex.lock.__data.__owner
>> > > > > > >  $6 = 90472
>> > > > > > > 
>> > > > > > > Signed-off-by: Sergio Lopez <slp@redhat.com>
>> > > > > > > ---
>> > > > > > >  hw/block/dataplane/virtio-blk.c | 3 +--
>> > > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
>> > > > > > > 
>> > > > > > > diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
>> > > > > > > index 8c37bd314a..358e6ae89b 100644
>> > > > > > > --- a/hw/block/dataplane/virtio-blk.c
>> > > > > > > +++ b/hw/block/dataplane/virtio-blk.c
>> > > > > > > @@ -280,12 +280,11 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
>> > > > > > >  
>> > > > > > >      aio_context_acquire(s->ctx);
>> > > > > > >      aio_wait_bh_oneshot(s->ctx, virtio_blk_data_plane_stop_bh, s);
>> > > > > > > +    aio_context_release(s->ctx);
>> > > > > > >  
>> > > > > > >      /* Drain and switch bs back to the QEMU main loop */
>> > > > > > >      blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
>> > > > > > >  
>> > > > > > > -    aio_context_release(s->ctx);
>> > > > > > > -
>> > > > > > 
>> > > > > > blk_set_aio_context() requires that the caller hold the lock for the
>> > > > > > source context, so I'm afraid this is wrong.
>> > > > > 
>> > > > > TBH, I was quite sure this patch was wrong myself, but I thought it was
>> > > > > still a good way to illustrate the issue.
>> > > > > 
>> > > > > > However, I think the problem might already be fixed with my "block: Use
>> > > > > > normal drain for bdrv_set_aio_context()" (contained in a pull request,
>> > > > > > which isn't merged yet), which makes bdrv_set_aio_context() use a real
>> > > > > > drain operation. This way, the requests of the mirror jobs should be
>> > > > > > already drained before we even call into block_job_detach_aio_context().
>> > > > > > 
>> > > > > > Can you give this a try and see whether it fixes your problem?
>> > > > > 
>> > > > > I've applied your patchset to my local copy, but it doesn't fix the
>> > > > > issue.
>> > > > > 
>> > > > > The problem is the coroutine is already scheduled to be run in the
>> > > > > iothread context, which means job->busy == true, so we can't switch to
>> > > > > it from any other place.
>> > > > 
>> > > > I still don't understand this because with job->paused == true the
>> > > > hanging loop wouldn't even be started. And after bdrv_drained_begin()
>> > > > returns, all jobs that use the node in question should be paused (see
>> > > > child_job_drained_begin/poll).
>> > > > 
>> > > > So somehow that drain (called in bdrv_set_aio_context()) doesn't seem to
>> > > > fully do what it is supposed to do?
>> > > 
>> > > IIUC, child_job_drained_begin() requests the job to be paused (something
>> > > that block_job_detach_aio_context() also does), but we don't get to
>> > > child_job_drained_poll() as bdrv_parent_drained_begin_single() is called
>> > > with "poll == false" by bdrv_parent_drained_begin().
>> > > 
>> > > But even if we did, that probably won't help in some scenarios, as
>> > > mirror's drained_poll implementation just checks if there are in_flight
>> > > requests, so it might happen that BDRV_POLL_WHILE returns without having
>> > > called aio_wait() a single time.
>> > > 
>> > > In other words, I think the drain code makes sure there aren't any
>> > > in_flight requests in the chain, but doesn't provide by itself a
>> > > guarantee that the jobs have been paused.
>> > 
>> > Yes, seems this is what it does. But I think that's not enough because
>> > if the job isn't paused, it can still issue new requests.
>> > 
>> > I'm not sure whether mirror_drained_poll() or child_job_drained_poll()
>> > is to blame, but the logic is wrong there: We should only return that
>> > the job is quiescent when it has reached a pause point _and_
>> > s->in_flight == 0.
>> 
>> If we expect this to be the case even when
>> bdrv_parent_drained_begin_single() is called from
>> bdrv_parent_drained_begin() with poll == false, then we need to make the
>> job_pause() at child_job_drained_begin() to take effect immeditaly,
>> probaly putting an AIO_WAIT_WHILE afterwards.
>
> .drained_begin callbacks must not call AIO_WAIT_WHILE (or any kind of
> aio_poll()) because that could run callbacks that change the graph,
> which would mess with the drained_begin recursion.
>
> The design of drain after my recent fixes is that .drained_begin does
> whatever is needed to initiate tbat things can become quiescent, and
> then there is only a single AIO_WAIT_WHILE() at the top level which
> recursively calls .drained_poll callbacks to check whether we need to
> wait longer (and which may not make further aio_poll() calls either).
>
> This way, graph changes can never occur during a recursion.
>
> bdrv_parent_drained_begin_single) is only called with poll == false if
> we know that the caller will already poll.

Makes sense, thanks for the explanation.

>> Otherwise, we can simply add an extra condition at
>> child_job_drained_poll(), before the drv->drained_poll(), to return
>> true if the job isn't yet paused.
>
> Yes, I think something like this is this right fix.

Fixing this has uncovered another issue also triggered by issuing
'block_commit' and 'device_del' consecutively. At the end, mirror_run()
calls to bdrv_drained_begin(), which is scheduled of later (via
bdrv_co_yield_to_drain()) as the mirror job is running in a coroutine.

At the same time, the Guest requests the device to be unplugged, which
leads to blk_unref()->blk_drain()->bdrv_do_drained_begin(). When the
latter reaches BDRV_POLL_WHILE, the bdrv_drained_begin scheduled above
is run, which also runs BDRV_POLL_WHILE, leading to the thread getting
stuck in aio_poll().

Is it really safe scheduling a bdrv_drained_begin() with poll == true?

Thanks,
Sergio (slp).
