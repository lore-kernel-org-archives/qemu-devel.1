Received: from eggs.gnu.org ([2001:4830:134:3::10]:57952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnmV6-0005Ap-VM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnmV3-0006iZ-LR
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:28:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnmV3-0006hp-D9
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:28:29 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 704A880461
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 13:28:29 +0000 (UTC)
References: <20170314132654.6751-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8a5baec-b8c1-cbf7-1495-c38327fc7feb@redhat.com>
Date: Tue, 14 Mar 2017 14:28:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170314132654.6751-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] virtio-scsi: Fix assertion failure
 on dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org



On 14/03/2017 14:26, Fam Zheng wrote:
> After the AioContext lock push down, there is a race between
> virtio_scsi_dataplane_start and those "assert(s->ctx &&
> s->dataplane_started)", because the latter doesn't isn't wrapped in
> aio_context_acquire.
> 
> Reproducer is simply booting a Fedora guest with an empty
> virtio-scsi-dataplane controller:
> 
>     qemu-system-x86_64 \
>       -drive if=none,id=root,format=raw,file=Fedora-Cloud-Base-25-1.3.x86_64.raw \
>       -device virtio-scsi \
>       -device scsi-disk,drive=root,bootindex=1 \
>       -object iothread,id=io \
>       -device virtio-scsi-pci,iothread=io \
>       -net user,hostfwd=tcp::10022-:22 -net nic,model=virtio -m 2048 \
>       --enable-kvm
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/scsi/virtio-scsi-dataplane.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
> index 74c95e0..12b44b7 100644
> --- a/hw/scsi/virtio-scsi-dataplane.c
> +++ b/hw/scsi/virtio-scsi-dataplane.c
> @@ -52,28 +52,40 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
>  static bool virtio_scsi_data_plane_handle_cmd(VirtIODevice *vdev,
>                                                VirtQueue *vq)
>  {
> -    VirtIOSCSI *s = (VirtIOSCSI *)vdev;
> +    bool progress;
> +    VirtIOSCSI *s = VIRTIO_SCSI(vdev);
>  
> +    aio_context_acquire(s->ctx);
>      assert(s->ctx && s->dataplane_started);
> -    return virtio_scsi_handle_cmd_vq(s, vq);
> +    progress = virtio_scsi_handle_cmd_vq(s, vq);
> +    aio_context_release(s->ctx);

Can you use virtio_scsi_acquire/release, and remove it from
virtio_scsi_handle_*_vq?

Paolo

> +    return progress;
>  }
>  
>  static bool virtio_scsi_data_plane_handle_ctrl(VirtIODevice *vdev,
>                                                 VirtQueue *vq)
>  {
> +    bool progress;
>      VirtIOSCSI *s = VIRTIO_SCSI(vdev);
>  
> +    aio_context_acquire(s->ctx);
>      assert(s->ctx && s->dataplane_started);
> -    return virtio_scsi_handle_ctrl_vq(s, vq);
> +    progress = virtio_scsi_handle_ctrl_vq(s, vq);
> +    aio_context_release(s->ctx);
> +    return progress;
>  }
>  
>  static bool virtio_scsi_data_plane_handle_event(VirtIODevice *vdev,
>                                                  VirtQueue *vq)
>  {
> +    bool progress;
>      VirtIOSCSI *s = VIRTIO_SCSI(vdev);
>  
> +    aio_context_acquire(s->ctx);
>      assert(s->ctx && s->dataplane_started);
> -    return virtio_scsi_handle_event_vq(s, vq);
> +    progress = virtio_scsi_handle_event_vq(s, vq);
> +    aio_context_release(s->ctx);
> +    return progress;
>  }
>  
>  static int virtio_scsi_vring_init(VirtIOSCSI *s, VirtQueue *vq, int n,
> 
