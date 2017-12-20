Received: from eggs.gnu.org ([2001:4830:134:3::10]:41167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRShl-0005m2-AE
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRShi-0007Qn-6w
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:57:53 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:33561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRShh-0007QH-Vx
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:57:50 -0500
Received: by mail-wm0-x22f.google.com with SMTP id g130so13627400wme.0
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 16:57:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1513690383-27269-1-git-send-email-sochin.jiang@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e40b768-3188-21df-cb00-38ec55fda4f8@redhat.com>
Date: Wed, 20 Dec 2017 01:57:44 +0100
MIME-Version: 1.0
In-Reply-To: <1513690383-27269-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: notify guest directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin.jiang@huawei.com>, qemu-devel <qemu-devel@nongnu.org>

On 19/12/2017 14:33, sochin.jiang wrote:
> From: "sochin.jiang" <sochin.jiang@huawei.com>
> 
>  Till now, we've already notify guest as a batch mostly, an
>  extra BH won't decrease guest interrupts much, but cause a
>  significant notification loss. Generally, we could have 15%
>  or so performance lost in single queue IO models, as I tested.

Interesting, this was indeed done to decrease interrupt overhead:

    commit 5b2ffbe4d99843fd8305c573a100047a8c962327
    Author: Ming Lei <tom.leiming@gmail.com>
    Date:   Sat Jul 12 12:08:53 2014 +0800

    virtio-blk: dataplane: notify guest as a batch

    Now requests are submitted as a batch, so it is natural
    to notify guest as a batch too.

    This may suppress interrupt notification to VM a lot:

            - in my test, decreased by ~13K/sec

    Signed-off-by: Ming Lei <ming.lei@canonical.com>
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Can you explain your benchmark setup?

Paolo


> Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
> ---
>  hw/block/dataplane/virtio-blk.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
> index 5556f0e..a261a1d 100644
> --- a/hw/block/dataplane/virtio-blk.c
> +++ b/hw/block/dataplane/virtio-blk.c
> @@ -32,7 +32,6 @@ struct VirtIOBlockDataPlane {
>  
>      VirtIOBlkConf *conf;
>      VirtIODevice *vdev;
> -    QEMUBH *bh;                     /* bh for guest notification */
>      unsigned long *batch_notify_vqs;
>  
>      /* Note that these EventNotifiers are assigned by value.  This is
> @@ -44,14 +43,7 @@ struct VirtIOBlockDataPlane {
>      AioContext *ctx;
>  };
>  
> -/* Raise an interrupt to signal guest, if necessary */
> -void virtio_blk_data_plane_notify(VirtIOBlockDataPlane *s, VirtQueue *vq)
> -{
> -    set_bit(virtio_get_queue_index(vq), s->batch_notify_vqs);
> -    qemu_bh_schedule(s->bh);
> -}
> -
> -static void notify_guest_bh(void *opaque)
> +static void notify_guest(void *opaque)
>  {
>      VirtIOBlockDataPlane *s = opaque;
>      unsigned nvqs = s->conf->num_queues;
> @@ -75,7 +67,12 @@ static void notify_guest_bh(void *opaque)
>      }
>  }
>  
> -/* Context: QEMU global mutex held */
> +/* Raise an interrupt to signal guest, if necessary */
> +void virtio_blk_data_plane_notify(VirtIOBlockDataPlane *s, VirtQueue *vq)
> +{
> +    set_bit(virtio_get_queue_index(vq), s->batch_notify_vqs);
> +    notify_guest(s);
> +}
>  void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
>                                    VirtIOBlockDataPlane **dataplane,
>                                    Error **errp)
> @@ -122,7 +119,6 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
>      } else {
>          s->ctx = qemu_get_aio_context();
>      }
> -    s->bh = aio_bh_new(s->ctx, notify_guest_bh, s);
>      s->batch_notify_vqs = bitmap_new(conf->num_queues);
>  
>      *dataplane = s;
> @@ -140,7 +136,6 @@ void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s)
>      vblk = VIRTIO_BLK(s->vdev);
>      assert(!vblk->dataplane_started);
>      g_free(s->batch_notify_vqs);
> -    qemu_bh_delete(s->bh);
>      if (s->iothread) {
>          object_unref(OBJECT(s->iothread));
>      }
> 
