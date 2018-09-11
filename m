Received: from eggs.gnu.org ([2001:4830:134:3::10]:58377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzjPi-0001Wd-M3
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzjPc-00030C-MV
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:13:10 -0400
Date: Tue, 11 Sep 2018 22:12:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911141245.GQ19292@lemon.usersys.redhat.com>
References: <20180910145616.8598-1-famz@redhat.com>
	<20180910145616.8598-3-famz@redhat.com>
	<9f4907a3-e96e-131c-a032-1669d0c09bc8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f4907a3-e96e-131c-a032-1669d0c09bc8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-scsi/virtio-blk: Disable poll
 handlers when stopping vq handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, peterx@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, 09/11 13:32, Paolo Bonzini wrote:
> On 10/09/2018 16:56, Fam Zheng wrote:
> > We have this unwanted call stack:
> > 
> >   > ...
> >   > #13 0x00005586602b7793 in virtio_scsi_handle_cmd_vq
> >   > #14 0x00005586602b8d66 in virtio_scsi_data_plane_handle_cmd
> >   > #15 0x00005586602ddab7 in virtio_queue_notify_aio_vq
> >   > #16 0x00005586602dfc9f in virtio_queue_host_notifier_aio_poll
> >   > #17 0x00005586607885da in run_poll_handlers_once
> >   > #18 0x000055866078880e in try_poll_mode
> >   > #19 0x00005586607888eb in aio_poll
> >   > #20 0x0000558660784561 in aio_wait_bh_oneshot
> >   > #21 0x00005586602b9582 in virtio_scsi_dataplane_stop
> >   > #22 0x00005586605a7110 in virtio_bus_stop_ioeventfd
> >   > #23 0x00005586605a9426 in virtio_pci_stop_ioeventfd
> >   > #24 0x00005586605ab808 in virtio_pci_common_write
> >   > #25 0x0000558660242396 in memory_region_write_accessor
> >   > #26 0x00005586602425ab in access_with_adjusted_size
> >   > #27 0x0000558660245281 in memory_region_dispatch_write
> >   > #28 0x00005586601e008e in flatview_write_continue
> >   > #29 0x00005586601e01d8 in flatview_write
> >   > #30 0x00005586601e04de in address_space_write
> >   > #31 0x00005586601e052f in address_space_rw
> >   > #32 0x00005586602607f2 in kvm_cpu_exec
> >   > #33 0x0000558660227148 in qemu_kvm_cpu_thread_fn
> >   > #34 0x000055866078bde7 in qemu_thread_start
> >   > #35 0x00007f5784906594 in start_thread
> >   > #36 0x00007f5784639e6f in clone
> > 
> > Avoid it with the aio_disable_external/aio_enable_external pair, so that
> > no vq poll handlers can be called in aio_wait_bh_oneshot.
> 
> I don't understand.  We are in the vCPU thread, so not in the
> AioContext's home thread.  Why is aio_wait_bh_oneshot polling rather
> than going through the aio_wait_bh path?

What do you mean by 'aio_wait_bh path'? Here is aio_wait_bh_oneshot:

void aio_wait_bh_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
{
    AioWaitBHData data = {
        .cb = cb,
        .opaque = opaque,
    };

    assert(qemu_get_current_aio_context() == qemu_get_aio_context());

    aio_bh_schedule_oneshot(ctx, aio_wait_bh, &data);
    AIO_WAIT_WHILE(&data.wait, ctx, !data.done);
}

ctx is qemu_aio_context here, so there's no interaction with IOThread. This is
the full backtrace:

https://paste.ubuntu.com/p/Dm7zGzmmRG/

Fam
