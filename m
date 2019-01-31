Received: from eggs.gnu.org ([209.51.188.92]:53340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gpEaZ-0001Cf-B3
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gpEaU-0003MF-VL
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:49:12 -0500
Date: Thu, 31 Jan 2019 15:40:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190131154038.GH2870@work-vm>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-3-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131151914.164903-3-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] virtio-blk: add "discard-wzeroes"
 boolean property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

* Stefano Garzarella (sgarzare@redhat.com) wrote:
> In order to avoid migration issues, we enable DISCARD and
> WRITE ZEROES features only for machine type >= 4.0
> 
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  hw/block/virtio-blk.c          | 2 ++
>  hw/core/machine.c              | 1 +
>  include/hw/virtio/virtio-blk.h | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 8a6754d9a2..542ec52536 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1026,6 +1026,8 @@ static Property virtio_blk_properties[] = {
>      DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
>      DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
>                       IOThread *),
> +    DEFINE_PROP_BIT("discard-wzeroes", VirtIOBlock, conf.discard_wzeroes, 0,
> +                     true),

I think that's OK, but do you really want a DEFINE_PROP_BOOL and
a bool discard_wzeroes?
I think DEFINE_PROP_BIT is mostly used for a flag word where each
property is one more bit in the field.

Dave

>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 2629515363..ce98857af0 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -30,6 +30,7 @@ GlobalProperty hw_compat_3_1[] = {
>      { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "true" },
>      { "tpm-crb", "ppi", "false" },
>      { "tpm-tis", "ppi", "false" },
> +    { "virtio-blk-device", "discard-wzeroes", "false" },
>  };
>  const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
>  
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
> index 5117431d96..c336afb4cd 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -40,6 +40,7 @@ struct VirtIOBlkConf
>      uint32_t request_merging;
>      uint16_t num_queues;
>      uint16_t queue_size;
> +    uint32_t discard_wzeroes;
>  };
>  
>  struct VirtIOBlockDataPlane;
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
