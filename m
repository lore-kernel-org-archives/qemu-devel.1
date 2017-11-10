Received: from eggs.gnu.org ([2001:4830:134:3::10]:34984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCzB3-0001jE-Io
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 21:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCzB2-0001kc-1g
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 21:36:17 -0500
Date: Fri, 10 Nov 2017 10:36:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171110023604.GA4849@lemon>
References: <92c47a3f-92a6-4f3a-505f-dc278604a671@redhat.com>
	<20171109042137.GA13786@lemon>
	<67bb3458-80da-beda-eec1-c08168837832@redhat.com>
	<20171109152856.GA3661@lemon>
	<e4207841-1ae5-af2e-b7ef-14412202b75a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4207841-1ae5-af2e-b7ef-14412202b75a@redhat.com>
Subject: Re: [Qemu-devel] Intermittent hang of iotest 194 (bdrv_drain_all
 after non-shared storage migration)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 11/09 20:31, Max Reitz wrote:
> On 2017-11-09 16:30, Fam Zheng wrote:
> > On Thu, 11/09 16:14, Max Reitz wrote:
> >> On 2017-11-09 05:21, Fam Zheng wrote:
> >>> On Thu, 11/09 01:48, Max Reitz wrote:
> >>>> Hi,
> >>>>
> >>>> More exciting news from the bdrv_drain() front!
> >>>>
> >>>> I've noticed in the past that iotest 194 sometimes hangs.  I usually run
> >>>> the tests on tmpfs, but I've just now verified that it happens on my SSD
> >>>> just as well.
> >>>>
> >>>> So the reproducer is a plain:
> >>>>
> >>>> while ./check -raw 194; do; done
> >>>
> >>> I cannot produce it on my machine.
> >>
> >> Hm, too bad.  I see it both on my work laptop (with Fedora) and my
> >> desktop (with Arch)...
> >>
> >>>> (No difference between raw or qcow2, though.)
> >>>>
> >>>> And then, after a couple of runs (or a couple ten), it will just hang.
> >>>> The reason is that the source VM lingers around and doesn't quit
> >>>> voluntarily -- the test itself was successful, but it just can't exit.
> >>>>
> >>>> If you force it to exit by killing the VM (e.g. through pkill -11 qemu),
> >>>> this is the backtrace:
> >>>>
> >>>> #0  0x00007f7cfc297e06 in ppoll () at /lib64/libc.so.6
> >>>> #1  0x0000563b846bcac9 in ppoll (__ss=0x0, __timeout=0x0,
> >>>> __nfds=<optimized out>, __fds=<optimized out>) at
> >>>> /usr/include/bits/poll2.h:77
> >>>
> >>> Looking at the 0 timeout it seems we are in the aio_poll(ctx, blocking=false);
> >>> branches of BDRV_POLL_WHILE? Is it a busy loop? If so I wonder what is making
> >>> progress and causing the return value to be true in aio_poll().
> >>>
> >>>> #2  0x0000563b846bcac9 in qemu_poll_ns (fds=<optimized out>,
> >>>> nfds=<optimized out>, timeout=<optimized out>) at util/qemu-timer.c:322
> >>>> #3  0x0000563b846be711 in aio_poll (ctx=ctx@entry=0x563b856e3e80,
> >>>> blocking=<optimized out>) at util/aio-posix.c:629
> >>>> #4  0x0000563b8463afa4 in bdrv_drain_recurse
> >>>> (bs=bs@entry=0x563b865568a0, begin=begin@entry=true) at block/io.c:201
> >>>> #5  0x0000563b8463baff in bdrv_drain_all_begin () at block/io.c:381
> >>>> #6  0x0000563b8463bc99 in bdrv_drain_all () at block/io.c:411
> >>>> #7  0x0000563b8459888b in block_migration_cleanup (opaque=<optimized
> >>>> out>) at migration/block.c:714
> >>>> #8  0x0000563b845883be in qemu_savevm_state_cleanup () at
> >>>> migration/savevm.c:1251
> >>>> #9  0x0000563b845811fd in migration_thread (opaque=0x563b856f1da0) at
> >>>> migration/migration.c:2298
> >>>> #10 0x00007f7cfc56f36d in start_thread () at /lib64/libpthread.so.0
> >>>> #11 0x00007f7cfc2a3e1f in clone () at /lib64/libc.so.6
> >>>>
> >>>>
> >>>> And when you make bdrv_drain_all_begin() print what we are trying to
> >>>> drain, you can see that it's the format node (managed by the "raw"
> >>>> driver in this case).
> >>>
> >>> So what is the value of bs->in_flight?
> >>
> >> gdb:
> >>> (gdb) print bs->in_flight 
> >>> $3 = 2307492233
> >>
> >> "That's weird, why would it..."
> >>
> >>> (gdb) print *bs
> >>> $4 = {open_flags = -1202160144, read_only = 161, encrypted = 85, sg = false, probed = false, force_share = 96, implicit = 159, drv = 0x0, opaque = 0x0, aio_context = 0x8989898989898989, aio_notifiers = {lh_first = 0x8989898989898989}, 
> >>>   walking_aio_notifiers = 137, filename = '\211' <repeats 4096 times>, backing_file = '\211' <repeats 4096 times>, backing_format = '\211' <repeats 16 times>, full_open_options = 0x8989898989898989, 
> >>>   exact_filename = '\211' <repeats 4096 times>, backing = 0x8989898989898989, file = 0x8989898989898989, bl = {request_alignment = 2307492233, max_pdiscard = -1987475063, pdiscard_alignment = 2307492233, 
> >>>     max_pwrite_zeroes = -1987475063, pwrite_zeroes_alignment = 2307492233, opt_transfer = 2307492233, max_transfer = 2307492233, min_mem_alignment = 9910603678816504201, opt_mem_alignment = 9910603678816504201, max_iov = -1987475063}, 
> >>>   supported_write_flags = 2307492233, supported_zero_flags = 2307492233, node_name = '\211' <repeats 32 times>, node_list = {tqe_next = 0x8989898989898989, tqe_prev = 0x8989898989898989}, bs_list = {tqe_next = 0x8989898989898989, 
> >>>     tqe_prev = 0x8989898989898989}, monitor_list = {tqe_next = 0x8989898989898989, tqe_prev = 0x8989898989898989}, refcnt = -1987475063, op_blockers = {{lh_first = 0x8989898989898989} <repeats 16 times>}, job = 0x8989898989898989, 
> >>>   inherits_from = 0x8989898989898989, children = {lh_first = 0x8989898989898989}, parents = {lh_first = 0x8989898989898989}, options = 0x8989898989898989, explicit_options = 0x8989898989898989, detect_zeroes = 2307492233, 
> >>>   backing_blocker = 0x8989898989898989, total_sectors = -8536140394893047415, before_write_notifiers = {notifiers = {lh_first = 0x8989898989898989}}, write_threshold_offset = 9910603678816504201, write_threshold_notifier = {notify = 
> >>>     0x8989898989898989, node = {le_next = 0x8989898989898989, le_prev = 0x8989898989898989}}, dirty_bitmap_mutex = {lock = {__data = {__lock = -1987475063, __count = 2307492233, __owner = -1987475063, __nusers = 2307492233, 
> >>>         __kind = -1987475063, __spins = -30327, __elision = -30327, __list = {__prev = 0x8989898989898989, __next = 0x8989898989898989}}, __size = '\211' <repeats 40 times>, __align = -8536140394893047415}, initialized = 137}, 
> >>>   dirty_bitmaps = {lh_first = 0x8989898989898989}, wr_highest_offset = {value = 9910603678816504201}, copy_on_read = -1987475063, in_flight = 2307492233, serialising_in_flight = 2307492233, wakeup = 137, io_plugged = 2307492233, 
> >>>   enable_write_cache = -1987475063, quiesce_counter = -1987475063, write_gen = 2307492233, reqs_lock = {locked = 2307492233, ctx = 0x8989898989898989, from_push = {slh_first = 0x8989898989898989}, to_pop = {
> >>>       slh_first = 0x8989898989898989}, handoff = 2307492233, sequence = 2307492233, holder = 0x8989898989898989}, tracked_requests = {lh_first = 0x8989898989898989}, flush_queue = {entries = {sqh_first = 0x8989898989898989, 
> >>>       sqh_last = 0x8989898989898989}}, active_flush_req = 160, flushed_gen = 0}
> >> "Oh."
> >>
> >> *sigh*
> >>
> >> OK, I'll look into it...
> > 
> > OK, I'll let you.. Just one more thing: could it relate to the use-after-free
> > bug reported on block_job_defer_to_main_loop()?
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01144.html
> 
> Thanks for the heads-up; I think it's a different issue, though.
> 
> What appears to be happening is that the mirror job completes and then
> drains its BDS.  While that is happening, a bdrv_drain_all() comes in
> from block_migration_cleanup().
> 
> That now tries to drain the mirror node.  However, that node cannot be
> drained until the job is truly gone now, so that is what's happening:
> mirror_exit() is called, it cleans up, destroys the mirror node, and
> returns.
> 
> Now bdrv_drain_all() can go on, specifically the BDRV_POLL_WHILE() on
> the mirror node.  However, oops, that node is gone now...  So that's
> where the issue seems to be. :-/
> 
> Maybe all that we need to do is wrap the bdrv_drain_recurse() call in
> bdrv_drain_all_begin() in a bdrv_ref()/bdrv_unref() pair?  Having run
> 194 for a couple of minutes, that seems to indeed work -- until it dies
> because of an invalid BB pointer in bdrv_next().  I guess that is
> because bdrv_next() does not guard against deleted BDSs.
> 
> Copying all BDS into an own list (in both bdrv_drain_all_begin() and
> bdrv_drain_all_end()), with a strong reference to every single one, and
> then draining them really seems to work, though.  (Survived 9000
> iterations, that seems good enough for something that usually fails
> after, like, 5.)

Yes, that makes sense. I'm curious if the patch in

https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01649.html

would also work?

Fam
