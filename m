Received: from eggs.gnu.org ([209.51.188.92]:53002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gty07-0001DU-PJ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtxzz-0003M6-57
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:07:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gtxzw-0003GH-QO
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:07:03 -0500
Date: Wed, 13 Feb 2019 12:06:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190213120418-mutt-send-email-mst@kernel.org>
References: <1550022537-27565-1-git-send-email-changpeng.liu@intel.com>
	<20190213080143.GE26332@stefanha-x1.localdomain>
	<20190213083227.xkih3ckbtiromd2v@steredhat>
	<20190213121703.zmzpgl4fvvsfg4pf@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213121703.zmzpgl4fvvsfg4pf@steredhat>
Subject: Re: [Qemu-devel] [PATCH v4] virtio-blk: set correct config size for
 the host driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org, ldoktor@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Greg Kurz <groug@kaod.org>

On Wed, Feb 13, 2019 at 01:17:03PM +0100, Stefano Garzarella wrote:
> On Wed, Feb 13, 2019 at 09:32:27AM +0100, Stefano Garzarella wrote:
> > On Wed, Feb 13, 2019 at 04:01:43PM +0800, Stefan Hajnoczi wrote:
> > > On Wed, Feb 13, 2019 at 09:48:57AM +0800, Changpeng Liu wrote:
> > > > Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features
> > > > support" added fields to struct virtio_blk_config. This changes
> > > > the size of the config space and breaks migration from QEMU 3.1
> > > > and older:
> > > > 
> > > > qemu-system-ppc64: get_pci_config_device: Bad config data: i=0x10 read: 41 device: 1 cmask: ff wmask: 80 w1cmask:0
> > > > qemu-system-ppc64: Failed to load PCIDevice:config
> > > > qemu-system-ppc64: Failed to load virtio-blk:virtio
> > > > qemu-system-ppc64: error while loading state for instance 0x0 of device 'pci@800000020000000:01.0/virtio-blk'
> > > > qemu-system-ppc64: load of migration failed: Invalid argument
> > > > 
> > > > Since virtio-blk doesn't support the "discard" and "write zeroes"
> > > > features, it shouldn't even expose the associated fields in the
> > > > config space actually. Just include all fields up to num_queues to
> > > > match QEMU 3.1 and older.
> > > > 
> > > > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > > > ---
> > > >  hw/block/virtio-blk.c | 13 +++++++++----
> > > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > 
> > > Stefano: Please rebase your DISCARD/WRITE_ZEROES series onto this and
> > > check that the config space is correctly sized.  Machine types before
> > > 4.0 shouldn't have these fields so that the config space size remains
> > > unchanged.
> > 
> > Sure!
> > 
> > Since I should set a correct config size checking if new features are
> > enabled or not at runtime, should be better to add a variable and an array
> > of sizes like in virtio-net?
> 
> In my series "[PATCH v4 0/6] virtio-blk: add DISCARD and WRITE_ZEROES"
> I'm adding the host_features field in VirtIOBlock. Then, I could add
> something like the following patch (proof of concept) inspired by the
> virtio-net approach, that would be simplest to maintain when we will add
> new features.
> 
> What do you think?
> 
> Thanks,
> Stefano
> 
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 843bb2bec8..84dcc1406c 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -28,6 +28,51 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
>  
> +/*
> + * Calculate the number of bytes up to and including the given 'field' of
> + * 'container'.
> + */
> +#define endof(container, field) \
> +    (offsetof(container, field) + sizeof_field(container, field))
> +

e.g. virtio.h. just add virtio prefix.

> +typedef struct VirtIOFeature {
> +    uint64_t flags;
> +    size_t end;
> +} VirtIOFeature;
> +
> +static VirtIOFeature feature_sizes[] = {
> +    {.flags = 1ULL << VIRTIO_NET_F_SIZE_MAX,
> +     .end = endof(struct virtio_blk_config, size_max)},
> +    {.flags = 1ULL << VIRTIO_NET_F_SEG_MAX,
> +     .end = endof(struct virtio_blk_config, seg_max)},
> +    {.flags = 1ULL << VIRTIO_NET_F_GEOMETRY,
> +     .end = endof(struct virtio_blk_config, geometry)},
> +    {.flags = 1ULL << VIRTIO_NET_F_BLK_SIZE,
> +     .end = endof(struct virtio_blk_config, blk_size)},
> +    {.flags = 1ULL << VIRTIO_NET_F_TOPOLOGY,
> +     .end = endof(struct virtio_blk_config, opt_io_size)},
> +    {.flags = 1ULL << VIRTIO_NET_F_CONFIG_WCE,
> +     .end = endof(struct virtio_blk_config, wce)},
> +    {.flags = 1ULL << VIRTIO_NET_F_MQ,
> +     .end = endof(struct virtio_blk_config, num_queues)},
> +    {}

All names above with net look wrong to me.

> +};
> +
> +static void virtio_blk_set_config_size(VirtIOBlock *s, uint64_t host_features)
> +{
> +    int i, config_size;
> +
> +    config_size = endof(struct virtio_blk_config, capacity);
> +
> +    for (i = 0; feature_sizes[i].flags != 0; i++) {
> +        if (host_features & feature_sizes[i].flags) {
> +            config_size = MAX(feature_sizes[i].end, config_size);
> +        }
> +    }
> +
> +    s->config_size = config_size;
> +}
> +

Put this in virtio.c maybe? size can be returned.


>  static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
>                                      VirtIOBlockReq *req)
>  {
> @@ -757,7 +802,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>      blkcfg.alignment_offset = 0;
>      blkcfg.wce = blk_enable_write_cache(s->blk);
>      virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
> -    memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
> +    memcpy(config, &blkcfg, s->config_size);
>  }
>  
>  static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
> @@ -765,7 +810,7 @@ static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
>      VirtIOBlock *s = VIRTIO_BLK(vdev);
>      struct virtio_blk_config blkcfg;
>  
> -    memcpy(&blkcfg, config, sizeof(blkcfg));
> +    memcpy(&blkcfg, config, s->config_size);
>  
>      aio_context_acquire(blk_get_aio_context(s->blk));
>      blk_set_enable_write_cache(s->blk, blkcfg.wce != 0);
> @@ -948,8 +993,9 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
> -                sizeof(struct virtio_blk_config));
> +    virtio_blk_set_config_size(s, s->host_features);
> +
> +    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK, s->config_size);
>  
>      s->blk = conf->conf.blk;
>      s->rq = NULL;
