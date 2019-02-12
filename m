Received: from eggs.gnu.org ([209.51.188.92]:56359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtR1d-0002pO-Ja
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtQpK-0000W0-Ga
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:41:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gtQpI-0000Pg-4G
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:41:49 -0500
Date: Tue, 12 Feb 2019 00:41:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212003454-mutt-send-email-mst@kernel.org>
References: <1549945516-25643-1-git-send-email-changpeng.liu@intel.com>
	<20190211232046-mutt-send-email-mst@kernel.org>
	<FF7FC980937D6342B9D289F5F3C7C2625B7B50EC@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B7B50EC@SHSMSX103.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: set correct config size for
 the host driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "ldoktor@redhat.com" <ldoktor@redhat.com>

On Tue, Feb 12, 2019 at 05:24:25AM +0000, Liu, Changpeng wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Tuesday, February 12, 2019 12:31 PM
> > To: Liu, Changpeng <changpeng.liu@intel.com>
> > Cc: qemu-devel@nongnu.org; stefanha@redhat.com; sgarzare@redhat.com;
> > dgilbert@redhat.com; ldoktor@redhat.com
> > Subject: Re: [PATCH] virtio-blk: set correct config size for the host driver
> > 
> > On Tue, Feb 12, 2019 at 12:25:16PM +0800, Changpeng Liu wrote:
> > > Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features support"
> > > introduced extra fields to existing struct virtio_blk_config, when
> > > migration was executed from older QEMU version to current head, it
> > > will break the migration.  While here, set the correct config size
> > > when initializing the host driver, for now, discard/write zeroes
> > > are not supported by virtio-blk host driver, so set the config
> > > size as before, users can change config size when adding the new
> > > feature bits support.
> > >
> > > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > > ---
> > >  hw/block/virtio-blk.c          | 15 +++++++++++----
> > >  include/hw/virtio/virtio-blk.h |  1 +
> > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > index 9a87b3b..fac5d33 100644
> > > --- a/hw/block/virtio-blk.c
> > > +++ b/hw/block/virtio-blk.c
> > > @@ -761,7 +761,7 @@ static void virtio_blk_update_config(VirtIODevice
> > *vdev, uint8_t *config)
> > >      blkcfg.alignment_offset = 0;
> > >      blkcfg.wce = blk_enable_write_cache(s->blk);
> > >      virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
> > > -    memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
> > > +    memcpy(config, &blkcfg, s->config_size);
> > >  }
> > >
> > >  static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
> > > @@ -769,7 +769,7 @@ static void virtio_blk_set_config(VirtIODevice *vdev,
> > const uint8_t *config)
> > >      VirtIOBlock *s = VIRTIO_BLK(vdev);
> > >      struct virtio_blk_config blkcfg;
> > >
> > > -    memcpy(&blkcfg, config, sizeof(blkcfg));
> > > +    memcpy(&blkcfg, config, s->config_size);
> > >
> > >      aio_context_acquire(blk_get_aio_context(s->blk));
> > >      blk_set_enable_write_cache(s->blk, blkcfg.wce != 0);
> > > @@ -847,6 +847,13 @@ static void virtio_blk_set_status(VirtIODevice *vdev,
> > uint8_t status)
> > >      }
> > >  }
> > >
> > > +static void virtio_blk_set_config_size(VirtIOBlock *s)
> > > +{
> > > +    /* VIRTIO_BLK_F_MQ is supported by host driver */
> > 
> > It can be disabled though.
> It means the host driver can support this feature, users can use it or not.
> So the config_size is same with previous old version.

But MQ didn't exist since creation it was only added in 2016.  For
virtio pci it all just happens to be within same power of 2: between 32
and 64 bytes. It's probably wrong for e.g. s390, and maybe
the difference is harmless.

Besides "host driver" makes no sense.

So something like "include all fields up to num_queues to match
QEMU 4.0 and older".

> > 
> > It just so happens that only the addition of max_discard_seg
> > crosses the next power of 2 boundary.
> > 
> > 
> > > +    s->config_size = offsetof(struct virtio_blk_config, num_queues) +
> > > +                     sizeof_field(struct virtio_blk_config, num_queues);
> > > +}
> > > +
> > >  static void virtio_blk_save_device(VirtIODevice *vdev, QEMUFile *f)
> > >  {
> > >      VirtIOBlock *s = VIRTIO_BLK(vdev);
> > > @@ -952,8 +959,8 @@ static void virtio_blk_device_realize(DeviceState *dev,
> > Error **errp)
> > >          return;
> > >      }
> > >
> > > -    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
> > > -                sizeof(struct virtio_blk_config));
> > > +    virtio_blk_set_config_size(s);
> > > +    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK, s->config_size);
> > >
> > >      s->blk = conf->conf.blk;
> > >      s->rq = NULL;
> > > diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
> > > index 5117431..9181a93 100644
> > > --- a/include/hw/virtio/virtio-blk.h
> > > +++ b/include/hw/virtio/virtio-blk.h
> > > @@ -51,6 +51,7 @@ typedef struct VirtIOBlock {
> > >      void *rq;
> > >      QEMUBH *bh;
> > >      VirtIOBlkConf conf;
> > > +    size_t config_size;
> > >      unsigned short sector_mask;
> > >      bool original_wce;
> > >      VMChangeStateEntry *change;
> > 
> > Well assuming you are looking for a minimal change,
> > go further and drop config_size completely,
> > replace with a macro.
> OK.
> > 
> > 
> > > --
> > > 1.9.3
