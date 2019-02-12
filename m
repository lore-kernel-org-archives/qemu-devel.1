Received: from eggs.gnu.org ([209.51.188.92]:45968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gtQiL-00041Q-EM
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gtQYk-0005o0-R2
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:24:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:18207)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1gtQYe-00029n-K6
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:24:42 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 12 Feb 2019 05:24:25 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B7B50EC@SHSMSX103.ccr.corp.intel.com>
References: <1549945516-25643-1-git-send-email-changpeng.liu@intel.com>
	<20190211232046-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190211232046-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "ldoktor@redhat.com" <ldoktor@redhat.com>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, February 12, 2019 12:31 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: qemu-devel@nongnu.org; stefanha@redhat.com; sgarzare@redhat.com;
> dgilbert@redhat.com; ldoktor@redhat.com
> Subject: Re: [PATCH] virtio-blk: set correct config size for the host dri=
ver
>=20
> On Tue, Feb 12, 2019 at 12:25:16PM +0800, Changpeng Liu wrote:
> > Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features supp=
ort"
> > introduced extra fields to existing struct virtio_blk_config, when
> > migration was executed from older QEMU version to current head, it
> > will break the migration.  While here, set the correct config size
> > when initializing the host driver, for now, discard/write zeroes
> > are not supported by virtio-blk host driver, so set the config
> > size as before, users can change config size when adding the new
> > feature bits support.
> >
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > ---
> >  hw/block/virtio-blk.c          | 15 +++++++++++----
> >  include/hw/virtio/virtio-blk.h |  1 +
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 9a87b3b..fac5d33 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -761,7 +761,7 @@ static void virtio_blk_update_config(VirtIODevice
> *vdev, uint8_t *config)
> >      blkcfg.alignment_offset =3D 0;
> >      blkcfg.wce =3D blk_enable_write_cache(s->blk);
> >      virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
> > -    memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
> > +    memcpy(config, &blkcfg, s->config_size);
> >  }
> >
> >  static void virtio_blk_set_config(VirtIODevice *vdev, const uint8_t *c=
onfig)
> > @@ -769,7 +769,7 @@ static void virtio_blk_set_config(VirtIODevice *vde=
v,
> const uint8_t *config)
> >      VirtIOBlock *s =3D VIRTIO_BLK(vdev);
> >      struct virtio_blk_config blkcfg;
> >
> > -    memcpy(&blkcfg, config, sizeof(blkcfg));
> > +    memcpy(&blkcfg, config, s->config_size);
> >
> >      aio_context_acquire(blk_get_aio_context(s->blk));
> >      blk_set_enable_write_cache(s->blk, blkcfg.wce !=3D 0);
> > @@ -847,6 +847,13 @@ static void virtio_blk_set_status(VirtIODevice *vd=
ev,
> uint8_t status)
> >      }
> >  }
> >
> > +static void virtio_blk_set_config_size(VirtIOBlock *s)
> > +{
> > +    /* VIRTIO_BLK_F_MQ is supported by host driver */
>=20
> It can be disabled though.
It means the host driver can support this feature, users can use it or not.
So the config_size is same with previous old version.
>=20
> It just so happens that only the addition of max_discard_seg
> crosses the next power of 2 boundary.
>=20
>=20
> > +    s->config_size =3D offsetof(struct virtio_blk_config, num_queues) =
+
> > +                     sizeof_field(struct virtio_blk_config, num_queues=
);
> > +}
> > +
> >  static void virtio_blk_save_device(VirtIODevice *vdev, QEMUFile *f)
> >  {
> >      VirtIOBlock *s =3D VIRTIO_BLK(vdev);
> > @@ -952,8 +959,8 @@ static void virtio_blk_device_realize(DeviceState *=
dev,
> Error **errp)
> >          return;
> >      }
> >
> > -    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
> > -                sizeof(struct virtio_blk_config));
> > +    virtio_blk_set_config_size(s);
> > +    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK, s->config_size);
> >
> >      s->blk =3D conf->conf.blk;
> >      s->rq =3D NULL;
> > diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-=
blk.h
> > index 5117431..9181a93 100644
> > --- a/include/hw/virtio/virtio-blk.h
> > +++ b/include/hw/virtio/virtio-blk.h
> > @@ -51,6 +51,7 @@ typedef struct VirtIOBlock {
> >      void *rq;
> >      QEMUBH *bh;
> >      VirtIOBlkConf conf;
> > +    size_t config_size;
> >      unsigned short sector_mask;
> >      bool original_wce;
> >      VMChangeStateEntry *change;
>=20
> Well assuming you are looking for a minimal change,
> go further and drop config_size completely,
> replace with a macro.
OK.
>=20
>=20
> > --
> > 1.9.3
