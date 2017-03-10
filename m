Received: from eggs.gnu.org ([2001:4830:134:3::10]:51589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmNhw-0005Dk-Vf
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmNhs-0006R4-3P
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:48:01 -0500
References: <20170307131650.90167-1-pasic@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0bccd267-1c59-09f1-3098-7a74759d00dd@redhat.com>
Date: Fri, 10 Mar 2017 17:47:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170307131650.90167-1-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] virtio-blk: fix race on guest
 notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-stable@nongnu.org



On 07/03/2017 14:16, Halil Pasic wrote:
> The commits 03de2f527 "virtio-blk: do not use vring in dataplane"  and
> 9ffe337c08 "virtio-blk: always use dataplane path if ioeventfd is active"
> changed how notifications are done for virtio-blk substantially. Due to a
> race condition, interrupts are lost when irqfd behind the guest notifier
> is torn down after notify_guest_bh was scheduled but before it actually
> runs.
> 
> Let's fix this by forcing guest notifications before cleaning up the
> irqfd's. Let's also add some explanatory comments.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reported-by: Michael A. Tebolt <miket@us.ibm.com>
> Tested-by: Michael A. Tebolt <miket@us.ibm.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 
> This patch withstood the test case which discovered the problem
> for several days (as reported by Michale Tebolt).
> 
> v1 --> v2:
> * Fixed typo pointed out by Connie
> * Added Tested-by

Hi Halil,

I found a similar issue in NBD.  Can you check if this patch fixes
the virtio-blk issue too?

Thanks,
Paolo

------ 8< ------------

diff --git a/block.c b/block.c
index f293ccb..e159251 100644
--- a/block.c
+++ b/block.c
@@ -4272,8 +4272,15 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
 
 void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
 {
+    AioContext *ctx;
+
     bdrv_drain(bs); /* ensure there are no in-flight requests */
 
+    ctx = bdrv_get_aio_context(bs);
+    while (aio_poll(ctx, false)) {
+        /* wait for all bottom halves to execute */
+    }
+
     bdrv_detach_aio_context(bs);
 
     /* This function executes in the old AioContext so acquire the new one in


> ---
>  hw/block/dataplane/virtio-blk.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
> index 5556f0e..045a580 100644
> --- a/hw/block/dataplane/virtio-blk.c
> +++ b/hw/block/dataplane/virtio-blk.c
> @@ -258,9 +258,16 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
>          virtio_queue_aio_set_host_notifier_handler(vq, s->ctx, NULL);
>      }
>  
> -    /* Drain and switch bs back to the QEMU main loop */
> +    /* Drain and switch bs back to the QEMU main loop. After drain, the
> +     * device will not submit (nor complete) any requests until dataplane
> +     * starts again.
> +     */
>      blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
>  
> +    /* Notify guest before the guest notifiers get cleaned up */
> +    qemu_bh_cancel(s->bh);
> +    notify_guest_bh(s);
> +
>      aio_context_release(s->ctx);
>  
>      for (i = 0; i < nvqs; i++) {
> 
