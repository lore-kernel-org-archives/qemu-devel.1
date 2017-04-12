Received: from eggs.gnu.org ([2001:4830:134:3::10]:57443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cyQfJ-0000gV-TW
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 18:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cyQfI-0004KD-If
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 18:23:05 -0400
Date: Wed, 12 Apr 2017 18:22:51 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170412222251.GB15762@localhost.localdomain>
References: <20170412204641.GA15762@localhost.localdomain>
	<f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
Subject: Re: [Qemu-devel] Regression from 2.8: stuck in bdrv_drain()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com

On Wed, Apr 12, 2017 at 05:38:17PM -0400, John Snow wrote:
> 
> 
> On 04/12/2017 04:46 PM, Jeff Cody wrote:
> > 
> > This occurs on v2.9.0-rc4, but not on v2.8.0.
> > 
> > When running QEMU with an iothread, and then performing a block-mirror, if
> > we do a system-reset after the BLOCK_JOB_READY event has emitted, qemu
> > becomes deadlocked.
> > 
> > The block job is not paused, nor cancelled, so we are stuck in the while
> > loop in block_job_detach_aio_context:
> > 
> > static void block_job_detach_aio_context(void *opaque)
> > {
> >     BlockJob *job = opaque;
> > 
> >     /* In case the job terminates during aio_poll()... */
> >     block_job_ref(job);
> > 
> >     block_job_pause(job);
> > 
> >     while (!job->paused && !job->completed) {
> >         block_job_drain(job);
> >     }
> > 
> 
> Looks like when block_job_drain calls block_job_enter from this context
> (the main thread, since we're trying to do a system_reset...), we cannot
> enter the coroutine because it's the wrong context, so we schedule an
> entry instead with
> 
> aio_co_schedule(ctx, co);
> 
> But that entry never happens, so the job never wakes up and we never
> make enough progress in the coroutine to gracefully pause, so we wedge here.
> 


John Snow and I debugged this some over IRC.  Here is a summary:

Simply put, with iothreads the aio context is different.  When
block_job_detach_aio_context() is called from the main thread via the system
reset (from main_loop_should_exit()), it calls block_job_drain() in a while
loop, with job->busy and job->completed as exit conditions.

block_job_drain() attempts to enter the coroutine (thus allowing job->busy
or job->completed to change).  However, since the aio context is different
with iothreads, we schedule the coroutine entry rather than directly
entering it.

This means the job coroutine is never going to be re-entered, because we are
waiting for it to complete in a while loop from the main thread, which is
blocking the qemu timers which would run the scheduled coroutine... hence,
we become stuck.



> >     block_job_unref(job);
> > }
> > 
> 
> > 
> > Reproducer script and QAPI commands:
> > 
> > # QEMU script:
> > gdb --args /home/user/deploy-${1}/bin/qemu-system-x86_64 -enable-kvm -smp 4 -object iothread,id=iothread0 -drive file=${2},if=none,id=drive-virtio-disk0,aio=native,cache=none,discard=unmap  -device virtio-blk-pci,scsi=off,bus=pci.0,drive=drive-virtio-disk0,id=virtio-disk0,iothread=iothread0 -m 1024 -boot menu=on -qmp stdio -drive file=${3},if=none,id=drive-data-disk0,format=qcow2,cache=none,aio=native,werror=stop,rerror=stop -device virtio-blk-pci,drive=drive-data-disk0,id=data-disk0,iothread=iothread0,bus=pci.0,addr=0x7 
> > 
> > 
> > # QAPI commands:
> > { "execute": "drive-mirror", "arguments": { "device": "drive-data-disk0", "target": "/home/user/sn1", "format": "qcow2", "mode": "absolute-paths", "sync": "full", "speed": 1000000000, "on-source-error": "stop", "on-target-error": "stop" } }
> > 
> > 
> > # after BLOCK_JOB_READY, do system reset
> > { "execute": "system_reset" }
> > 
> > 
> > 
> > 
> > 
> > gbd bt:
> > 
> > (gdb) bt
> > #0  0x0000555555aa79f3 in bdrv_drain_recurse (bs=bs@entry=0x55555783e900) at block/io.c:164
> > #1  0x0000555555aa825d in bdrv_drained_begin (bs=bs@entry=0x55555783e900) at block/io.c:231
> > #2  0x0000555555aa8449 in bdrv_drain (bs=0x55555783e900) at block/io.c:265
> > #3  0x0000555555a9c356 in blk_drain (blk=<optimized out>) at block/block-backend.c:1383
> > #4  0x0000555555aa3cfd in mirror_drain (job=<optimized out>) at block/mirror.c:1000
> > #5  0x0000555555a66e11 in block_job_detach_aio_context (opaque=0x555557a19a40) at blockjob.c:142
> > #6  0x0000555555a62f4d in bdrv_detach_aio_context (bs=bs@entry=0x555557839410) at block.c:4357
> > #7  0x0000555555a63116 in bdrv_set_aio_context (bs=bs@entry=0x555557839410, new_context=new_context@entry=0x55555668bc20) at block.c:4418
> > #8  0x0000555555a9d326 in blk_set_aio_context (blk=0x5555566db520, new_context=0x55555668bc20) at block/block-backend.c:1662
> > #9  0x00005555557e38da in virtio_blk_data_plane_stop (vdev=<optimized out>) at /home/jcody/work/upstream/qemu-kvm/hw/block/dataplane/virtio-blk.c:262
> > #10 0x00005555559f9d5f in virtio_bus_stop_ioeventfd (bus=bus@entry=0x5555583089a8) at hw/virtio/virtio-bus.c:246
> > #11 0x00005555559fa49b in virtio_bus_stop_ioeventfd (bus=bus@entry=0x5555583089a8) at hw/virtio/virtio-bus.c:238
> > #12 0x00005555559f6a18 in virtio_pci_stop_ioeventfd (proxy=0x555558300510) at hw/virtio/virtio-pci.c:348
> > #13 0x00005555559f6a18 in virtio_pci_reset (qdev=<optimized out>) at hw/virtio/virtio-pci.c:1872
> > #14 0x00005555559139a9 in qdev_reset_one (dev=<optimized out>, opaque=<optimized out>) at hw/core/qdev.c:310
> > #15 0x0000555555916738 in qbus_walk_children (bus=0x55555693aa30, pre_devfn=0x0, pre_busfn=0x0, post_devfn=0x5555559139a0 <qdev_reset_one>, post_busfn=0x5555559120f0 <qbus_reset_one>, opaque=0x0) at hw/core/bus.c:59
> > #16 0x0000555555913318 in qdev_walk_children (dev=0x5555569387d0, pre_devfn=0x0, pre_busfn=0x0, post_devfn=0x5555559139a0 <qdev_reset_one>, post_busfn=0x5555559120f0 <qbus_reset_one>, opaque=0x0) at hw/core/qdev.c:617
> > #17 0x0000555555916738 in qbus_walk_children (bus=0x555556756f70, pre_devfn=0x0, pre_busfn=0x0, post_devfn=0x5555559139a0 <qdev_reset_one>, post_busfn=0x5555559120f0 <qbus_reset_one>, opaque=0x0) at hw/core/bus.c:59
> > #18 0x00005555559168ca in qemu_devices_reset () at hw/core/reset.c:69
> > #19 0x000055555581fcbb in pc_machine_reset () at /home/jcody/work/upstream/qemu-kvm/hw/i386/pc.c:2234
> > #20 0x00005555558a4d96 in qemu_system_reset (report=<optimized out>) at vl.c:1697
> > #21 0x000055555577157a in main_loop_should_exit () at vl.c:1865
> > #22 0x000055555577157a in main_loop () at vl.c:1902
> > #23 0x000055555577157a in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4709
> > 
> > 
> > -Jeff
> > 
> 
> Here's a backtrace for an unoptimized build showing all threads:
> 
> https://paste.fedoraproject.org/paste/lLnm8jKeq2wLKF6yEaoEM15M1UNdIGYhyRLivL9gydE=
> 
> 
> --js
