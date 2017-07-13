Received: from eggs.gnu.org ([2001:4830:134:3::10]:37084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVeOG-0004by-PK
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVeOC-0003Vj-RM
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:42:48 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVeOC-0003VB-L2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:42:44 -0400
Received: by mail-wm0-f46.google.com with SMTP id w126so24020855wme.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:42:44 -0700 (PDT)
References: <20170704064347.7022-1-famz@redhat.com>
	<20170704064347.7022-7-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e4168ac-896b-1927-a98e-839d3b99cacc@redhat.com>
Date: Thu, 13 Jul 2017 15:42:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170704064347.7022-7-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/20] virtio-blk: Convert to
 DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

On 04/07/2017 08:43, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/block/dataplane/virtio-blk.c | 2 +-
>  hw/block/virtio-blk.c           | 5 +----
>  hw/s390x/virtio-ccw.c           | 2 --
>  hw/virtio/virtio-pci.c          | 2 --
>  include/hw/virtio/virtio-blk.h  | 3 ++-
>  5 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
> index 5556f0e..6fdc6f6 100644
> --- a/hw/block/dataplane/virtio-blk.c
> +++ b/hw/block/dataplane/virtio-blk.c
> @@ -116,7 +116,7 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
>      s->conf = conf;
>  
>      if (conf->iothread) {
> -        s->iothread = conf->iothread;
> +        s->iothread = IOTHREAD(conf->iothread);
>          object_ref(OBJECT(s->iothread));
>          s->ctx = iothread_get_aio_context(s->iothread);
>      } else {
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index c0bd247..8146306 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -983,10 +983,6 @@ static void virtio_blk_instance_init(Object *obj)
>  {
>      VirtIOBlock *s = VIRTIO_BLK(obj);
>  
> -    object_property_add_link(obj, "iothread", TYPE_IOTHREAD,
> -                             (Object **)&s->conf.iothread,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
>      device_add_bootindex_property(obj, &s->conf.conf.bootindex,
>                                    "bootindex", "/disk@0,0",
>                                    DEVICE(obj), NULL);
> @@ -1014,6 +1010,7 @@ static Property virtio_blk_properties[] = {
>      DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
>                      true),
>      DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
> +    DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 90d37cb..a17ce84 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -789,8 +789,6 @@ static void virtio_ccw_blk_instance_init(Object *obj)
>  
>      virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>                                  TYPE_VIRTIO_BLK);
> -    object_property_add_alias(obj, "iothread", OBJECT(&dev->vdev),"iothread",
> -                              &error_abort);
>      object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
>                                "bootindex", &error_abort);
>  }
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 301920e..984baf8 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1996,8 +1996,6 @@ static void virtio_blk_pci_instance_init(Object *obj)
>  
>      virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>                                  TYPE_VIRTIO_BLK);
> -    object_property_add_alias(obj, "iothread", OBJECT(&dev->vdev),"iothread",
> -                              &error_abort);
>      object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
>                                "bootindex", &error_abort);
>  }
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
> index d3c8a6f..2452074 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -33,7 +33,8 @@ struct virtio_blk_inhdr
>  struct VirtIOBlkConf
>  {
>      BlockConf conf;
> -    IOThread *iothread;
> +    /* IOThread pointer to be filled by link property */
> +    Object *iothread;

Is this necessary?  Can we instead add a type argument to the
DEFINE_PROP_LINK macro, or just cast something to void*?

I understand this means the series risks missing 2.10 (but I can send a
second pull request just for it tomorrow too).

Paolo

>      char *serial;
>      uint32_t scsi;
>      uint32_t config_wce;
> 
