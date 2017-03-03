Received: from eggs.gnu.org ([2001:4830:134:3::10]:49436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmlF-00029J-Al
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmlA-00019u-Fq
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:56:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjmlA-00019m-6j
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:56:36 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A5443A76BE
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 12:56:36 +0000 (UTC)
References: <1488531980-13235-1-git-send-email-jasowang@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac184515-683c-afe0-2597-283abc2f895c@redhat.com>
Date: Fri, 3 Mar 2017 13:56:33 +0100
MIME-Version: 1.0
In-Reply-To: <1488531980-13235-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virito: unbreak virtio device behinds
 IOMMU with region cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
Cc: peterx@redhat.com, marcel@redhat.com



On 03/03/2017 10:06, Jason Wang wrote:
> Commit c611c76417f5 ("virtio: add MemoryListener to cache ring
> translations") registers a memory listener to dma_as. This may not
> work when IOMMU is enabled: dma_as(bus_master_as) were correctly
> initialized in pcibus_machine_done() after virtio_realize() where we
> try to register listener and initialize address space cache.
> 
> Fixing this by:
> 
> - delay the listener register to status set
> - reset dma_as before trying to initialize address spaces to make sure
>   it works even IOMMU were created after virtio device
> 
> Fixes: c611c76417f5 ("virtio: add MemoryListener to cache ring translations")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

For virtio 0.9 it is valid to use the virtio device while the status is 0.

You can add a function virtio_set_dma_as to generic virtio that does a
MemoryListener unregister+register, then PCI can call it when the
AddressSpace is ready.

Paolo

> ---
>  hw/virtio/virtio.c         | 29 ++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio.h |  1 +
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 23483c7..179030c 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1084,9 +1084,22 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
>              }
>          }
>      }
> +
> +    virtio_device_reset_dma_as(vdev);
> +
> +    if (val == (VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER)) {
> +        memory_listener_unregister(&vdev->listener);
> +        memory_listener_register(&vdev->listener, vdev->dma_as);
> +    }
> +
>      if (k->set_status) {
>          k->set_status(vdev, val);
>      }
> +
> +    if (val == 0) {
> +        memory_listener_unregister(&vdev->listener);
> +    }
> +
>      vdev->status = val;
>      return 0;
>  }
> @@ -2402,7 +2415,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>      }
>  
>      vdev->listener.commit = virtio_memory_listener_commit;
> -    memory_listener_register(&vdev->listener, vdev->dma_as);
>  }
>  
>  static void virtio_device_unrealize(DeviceState *dev, Error **errp)
> @@ -2576,6 +2588,21 @@ bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
>      return virtio_bus_ioeventfd_enabled(vbus);
>  }
>  
> +void virtio_device_reset_dma_as(VirtIODevice *vdev)
> +{
> +    DeviceState *qdev = DEVICE(vdev);
> +    BusState *qbus = BUS(qdev_get_parent_bus(qdev));
> +    VirtioBusState *bus = VIRTIO_BUS(qbus);
> +    VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
> +    bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> +
> +    if (klass->get_dma_as != NULL && has_iommu) {
> +        vdev->dma_as = klass->get_dma_as(qbus->parent);
> +    } else {
> +        vdev->dma_as = &address_space_memory;
> +    }
> +}
> +
>  static const TypeInfo virtio_device_info = {
>      .name = TYPE_VIRTIO_DEVICE,
>      .parent = TYPE_DEVICE,
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 15efcf2..f7e0b4a 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -289,6 +289,7 @@ void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
>                                                  VirtIOHandleAIOOutput handle_output);
>  VirtQueue *virtio_vector_first_queue(VirtIODevice *vdev, uint16_t vector);
>  VirtQueue *virtio_vector_next_queue(VirtQueue *vq);
> +void virtio_device_reset_dma_as(VirtIODevice *vdev);
>  
>  static inline void virtio_add_feature(uint64_t *features, unsigned int fbit)
>  {
> 
