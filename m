Received: from eggs.gnu.org ([209.51.188.92]:33365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gtjOz-0003oq-EL
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 20:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gtjOy-0004Au-EG
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 20:31:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:39509)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1gtjOy-0004A4-4R
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 20:31:52 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Wed, 13 Feb 2019 01:31:47 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B7B57C7@SHSMSX103.ccr.corp.intel.com>
References: <1549984789-26997-1-git-send-email-changpeng.liu@intel.com>
	<20190212101028-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190212101028-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] virtio-blk: set correct config size for
 the host driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "ldoktor@redhat.com" <ldoktor@redhat.com>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, February 12, 2019 11:11 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: qemu-devel@nongnu.org; stefanha@redhat.com; sgarzare@redhat.com;
> dgilbert@redhat.com; ldoktor@redhat.com
> Subject: Re: [PATCH v3] virtio-blk: set correct config size for the host =
driver
>=20
> On Tue, Feb 12, 2019 at 11:19:49PM +0800, Changpeng Liu wrote:
> > Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features
> > support" added fields to struct virtio_blk_config. This changes
> > the size of the config space and breaks migration from QEMU 3.1
> > and older:
> >
> > qemu-system-ppc64: get_pci_config_device: Bad config data: i=3D0x10 rea=
d: 41
> device: 1 cmask: ff wmask: 80 w1cmask:0
> > qemu-system-ppc64: Failed to load PCIDevice:config
> > qemu-system-ppc64: Failed to load virtio-blk:virtio
> > qemu-system-ppc64: error while loading state for instance 0x0 of device
> 'pci@800000020000000:01.0/virtio-blk'
> > qemu-system-ppc64: load of migration failed: Invalid argument
> >
> > Since virtio-blk doesn't support the "discard" and "write zeroes"
> > features, it shouldn't even expose the associated fields in the
> > config space actually. Just include all fields up to num_queues to
> > match QEMU 3.1 and older.
> >
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
>=20
> OK almost.
>=20
> > ---
> >  hw/block/virtio-blk.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 9a87b3b..0ff5315 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -28,6 +28,10 @@
> >  #include "hw/virtio/virtio-bus.h"
> >  #include "hw/virtio/virtio-access.h"
> >
> > +/* We don't support discard yet, hide associated config fields. */
> > +#define VIRTIO_BLK_CFG_SIZE offsetof(struct virtio_blk_config, \
> > +                                     max_discard_sectors)
> > +
> >  static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
> >                                      VirtIOBlockReq *req)
> >  {
> > @@ -761,7 +765,9 @@ static void virtio_blk_update_config(VirtIODevice
> *vdev, uint8_t *config)
> >      blkcfg.alignment_offset =3D 0;
> >      blkcfg.wce =3D blk_enable_write_cache(s->blk);
> >      virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
> > -    memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
> > +    memcpy(config, &blkcfg, VIRTIO_BLK_CFG_SIZE);
> > +    QEMU_BUILD_BUG_ON(VIRTIO_BLK_CFG_SIZE > sizeof(struct
> virtio_blk_config));
> > +
>=20
> Oh probably sizeof blkcfg here, right?
> Also we don't need the empty line here.
Ok, removed the empty line and use sizeof(blkcfg) instead with v4.
>=20
> >  }
> >
> >  static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *c=
onfig)
> > @@ -769,7 +775,8 @@ static void virtio_blk_set_config(VirtIODevice *vde=
v,
> const uint8_t *config)
> >      VirtIOBlock *s =3D VIRTIO_BLK(vdev);
> >      struct virtio_blk_config blkcfg;
> >
> > -    memcpy(&blkcfg, config, sizeof(blkcfg));
> > +    memcpy(&blkcfg, config, VIRTIO_BLK_CFG_SIZE);
> > +    QEMU_BUILD_BUG_ON(VIRTIO_BLK_CFG_SIZE > sizeof(blkcfg));
> >
> >      aio_context_acquire(blk_get_aio_context(s->blk));
> >      blk_set_enable_write_cache(s->blk, blkcfg.wce !=3D 0);
> > @@ -952,8 +959,7 @@ static void virtio_blk_device_realize(DeviceState *=
dev,
> Error **errp)
> >          return;
> >      }
> >
> > -    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
> > -                sizeof(struct virtio_blk_config));
> > +    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK, VIRTIO_BLK_CFG_SI=
ZE);
> >
> >      s->blk =3D conf->conf.blk;
> >      s->rq =3D NULL;
> > --
> > 1.9.3
