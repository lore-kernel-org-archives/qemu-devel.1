Received: from eggs.gnu.org ([2001:4830:134:3::10]:41553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwQeb-0001zS-Qq
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwQea-0004ZJ-Vu
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:58:05 -0400
Date: Fri, 7 Apr 2017 17:57:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170407095753.GA16233@lemon>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170407065414.9143-6-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] coroutine: Explicitly specify
 AioContext when entering coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, 04/07 14:54, Fam Zheng wrote:
> 
>   main loop                                iothread
> -----------------------------------------------------------------------
>   blockdev_snapshot
>     aio_context_acquire(bs->ctx)
>     bdrv_flush(bs)
>       bdrv_co_flush(bs)
>         ...
>         qemu_coroutine_yield(co)
>       BDRV_POLL_WHILE()
>         aio_context_release(bs->ctx)
>                                             aio_context_acquire(bs->ctx)
>                                               ...
>                                                 aio_co_wake(co)
>         aio_poll(qemu_aio_context)              ...
>           co_schedule_bh_cb()                   ...
>             qemu_coroutine_enter(co)            ...
>               /* (A) bdrv_co_flush(bs)              /* (B) I/O on bs */
>                       continues... */
>                                             aio_context_release(bs->ctx)

After talking to Kevin on IRC, this aio_context_acquire() in iothread could be
the one in vq handler:

  main loop                                iothread
-----------------------------------------------------------------------
  blockdev_snapshot
    aio_context_acquire(bs->ctx)
                                           virtio_scsi_data_plane_handle_cmd
    bdrv_drained_begin(bs->ctx)
    bdrv_flush(bs)
      bdrv_co_flush(bs)                      aio_context_acquire(bs->ctx).enter
        ...
        qemu_coroutine_yield(co)
      BDRV_POLL_WHILE()
        aio_context_release(bs->ctx)
                                             aio_context_acquire(bs->ctx).return
                                               ...
                                                 aio_co_wake(co)
        aio_poll(qemu_aio_context)               ...
          co_schedule_bh_cb()                    ...
            qemu_coroutine_enter(co)             ...

              /* (A) bdrv_co_flush(bs)           /* (B) I/O on bs */
                      continues... */
                                             aio_context_release(bs->ctx)
        aio_context_acquire(bs->ctx)

Note that in this special case, bdrv_drained_begin() doesn't do the "release,
poll, acquire" in BDRV_POLL_WHILE, because bs->in_flight == 0. This might be the
root cause of the race?  (Ed's test case showed that apart from vq handlers,
block jobs in the iothread can also trigger the same pattern of race.  For this
part we need John's patches to pause block jobs in bdrv_drained_begin.)

Fam
