Received: from eggs.gnu.org ([2001:4830:134:3::10]:52041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1co6io-0004tG-48
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1co6im-0007I4-VC
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:04:02 -0400
Date: Wed, 15 Mar 2017 12:03:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170315110351.GG4030@noname.str.redhat.com>
References: <20170314171120.80741-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314171120.80741-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] blk: fix aio context loss on media change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

Am 14.03.2017 um 18:11 hat Vladimir Sementsov-Ogievskiy geschrieben:
> If we have separate iothread for cdrom, we lose connection to it on
> qmp_blockdev_change_medium, as aio_context is on bds which is dropped
> and switched with new one.
> 
> As an example result, after such media change we have crash on
> virtio_scsi_ctx_check: Assertion `blk_get_aio_context(d->conf.blk) == s->ctx' failed.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> Hi all!
> 
> We've faced into this assert, and there some kind of fix. I don't sure that
> such fix doesn't break some conceptions, in this case, I hope, someone will
> propose a true-way solution.

The "true way" would be proper AioContext management in the sense that
all users of a BDS can specify a specific AioContext that they need and
if they all agree, callbacks are invoked to change everyone to that
AioContext. If they conflict, attaching the new user would have to error
out.

But we discussed this earlier, and while I'm not completely sure any
more about the details, I seem to remeber that Paolo said something
along the lines that AioContext is going away anyway and building the
code for proper management would be wasted time.

Stefan, Paolo, do you remember the details why we didn't even do a
simple fix like the one below? I think there were some patches on the
list, no?

Kevin

> ======
> Also, on master branch I can't reproduce it as vm crashed earlier, without any
> eject/change, on assert(s->ctx && s->dataplane_started) in
> virtio_scsi_data_plane_handle_ctrl(). It looks like race with
> virtio_scsi_dataplane_start(), and for test (to reproduce assert described above),
> I've "fixed" it with just:
> 
> @@ -63,6 +63,7 @@ static bool virtio_scsi_data_plane_handle_ctrl(VirtIODevice *vdev,
>  {
>      VirtIOSCSI *s = VIRTIO_SCSI(vdev);
>  
> +    sleep(10);
>      assert(s->ctx && s->dataplane_started);
>      return virtio_scsi_handle_ctrl_vq(s, vq);
>  }
> 
> This race is not reproduced for me in our 2.6 based branch.
> 
>  block/block-backend.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 5742c09c2c..6d5044228e 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -65,6 +65,8 @@ struct BlockBackend {
>      bool allow_write_beyond_eof;
>  
>      NotifierList remove_bs_notifiers, insert_bs_notifiers;
> +
> +    AioContext *aio_context;
>  };
>  
>  typedef struct BlockBackendAIOCB {
> @@ -559,6 +561,10 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
>      }
>      bdrv_ref(bs);
>  
> +    if (blk->aio_context != NULL) {
> +        bdrv_set_aio_context(bs, blk->aio_context);
> +    }
> +
>      notifier_list_notify(&blk->insert_bs_notifiers, blk);
>      if (blk->public.throttle_state) {
>          throttle_timers_attach_aio_context(
> @@ -1607,6 +1613,7 @@ void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
>  {
>      BlockDriverState *bs = blk_bs(blk);
>  
> +    blk->aio_context = new_context;
>      if (bs) {
>          if (blk->public.throttle_state) {
>              throttle_timers_detach_aio_context(&blk->public.throttle_timers);
> -- 
> 2.11.1
> 
