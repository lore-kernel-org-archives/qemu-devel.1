Received: from eggs.gnu.org ([2001:4830:134:3::10]:38116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ep8bO-0006pg-1W
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ep8bN-0004zO-1r
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 03:21:10 -0500
Date: Fri, 23 Feb 2018 16:20:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180223082044.GB31530@lemon.usersys.redhat.com>
References: <20180220131014.8998-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220131014.8998-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com

On Tue, 02/20 13:10, Stefan Hajnoczi wrote:
> 1. virtio_scsi_handle_cmd_vq() racing with iothread_stop_all() hits the
>    virtio_scsi_ctx_check() assertion failure because the BDS AioContext
>    has been modified by iothread_stop_all().

Does this patch fix the issue completely? IIUC virtio_scsi_handle_cmd can
already be entered at the time of main thread calling virtio_scsi_clear_aio(),
so this race condition still exists:

  main thread                           iothread
-----------------------------------------------------------------------------
  vm_shutdown
    ...
      virtio_bus_stop_ioeventfd
        virtio_scsi_dataplane_stop
                                        aio_poll()
                                          ...
                                            virtio_scsi_data_plane_handle_cmd()
          aio_context_acquire(s->ctx)
                                              virtio_scsi_acquire(s).enter
          virtio_scsi_clear_aio()
          aio_context_release(s->ctx)
                                              virtio_scsi_acquire(s).return
                                              virtio_scsi_handle_cmd_vq()
                                                ...
                                                  virtqueue_pop()

Is it possible that the above virtqueue_pop() still returns one element that was
queued before vm_shutdown() was called?

If so I think we additionally need to an "s->ioeventfd_stopped" flag set in
virtio_scsi_stop_ioeventfd() and check it in
virtio_scsi_data_plane_handle_cmd().

Fam
