Received: from eggs.gnu.org ([2001:4830:134:3::10]:40249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fujunkang@gmail.com>) id 1cP2a5-0004zO-BA
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fujunkang@gmail.com>) id 1cP2a3-0007Om-NL
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:35:25 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:35721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fujunkang@gmail.com>) id 1cP2a3-0007OW-Do
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:35:23 -0500
Received: by mail-wj0-x244.google.com with SMTP id hb5so44947535wjc.2
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 23:35:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170103162950.GI14707@stefanha-x1.localdomain>
References: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
	<20170103162950.GI14707@stefanha-x1.localdomain>
From: Junkang Fu <fujunkang@gmail.com>
Date: Thu, 5 Jan 2017 15:35:21 +0800
Message-ID: <CAP8dc_a54HBkCMbVT=EOJyM8acWzVBhyNjY_72zpxvnH7mws6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC]virtio-blk: add disk-name device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org

Thank you. -device virtio-blk-pci,serial=vdabc will solve my problem to
some extent.

2017-01-04 0:29 GMT+08:00 Stefan Hajnoczi <stefanha@gmail.com>:

> On Fri, Dec 30, 2016 at 10:41:35AM +0800, Junkang Fu wrote:
> > From 74e913fc41ea98d1dde692175f1e3fb6729342aa Mon Sep 17 00:00:00 2001
> > From: "junkang.fjk" <junkang.fjk@alibaba-inc.com>
> > Date: Wed, 24 Aug 2016 19:36:53 +0800
> > Subject: [PATCH] virtio-blk: add disk-name device property
> >
> > Current virtio-blk disk name(ex. /dev/vdb) has nothing to do with the
> > target dev
> > name specified in libvirt xml file. For example, we may get disk name
> > /dev/vdb in
> > VM while target dev specified in libvirt xml is vdc. This may lead to a
> > little trouble
> > to find out the relationship between the disk name in VM and somewhere
> out
> > of
> > VM, for example in the control board of Public cloud service providers. I
> > suggest
> > if Qemu could add a VIRTIO_BLK_F_DISK_NAME feature, with
> > VIRTIO_BLK_F_DISK_NAME
> > capable Qemu and virtio-blk frontend drivers, disk name in the vm can be
> > specified
> > as follows:
> >         -device virtio-blk-pci,disk-name=vdabc
>
> Did you try -device virtio-blk-pci,serial=vdabc and
> /dev/disk/by-id/virtio-vdabc inside a Linux guest?
>
> > ---
> >  hw/block/virtio-blk.c                       | 5 +++++
> >  include/hw/virtio/virtio-blk.h              | 1 +
> >  include/standard-headers/linux/virtio_blk.h | 6 ++++++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 331d766..4039fb9 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -716,6 +716,8 @@ static void virtio_blk_update_config(VirtIODevice
> > *vdev, uint8_t *config)
> >      blkcfg.alignment_offset = 0;
> >      blkcfg.wce = blk_enable_write_cache(s->blk);
> >      virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
> > +    if (s->disk_name)
> > +        strncpy((char *)blkcfg.disk_name, s->disk_name, DISK_NAME_LEN);
> >      memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
> >  }
> > @@ -740,6 +742,8 @@ static uint64_t virtio_blk_get_features(VirtIODevice
> > *vdev, uint64_t features,
> >      virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
> >      virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
> >      virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
> > +    virtio_add_feature(&features, VIRTIO_BLK_F_DISK_NAME);
> > +
> >      if (virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
> >          if (s->conf.scsi) {
> >              error_setg(errp, "Please set scsi=off for virtio-blk devices
> > in order to use virtio 1.0");
> > @@ -970,6 +974,7 @@ static Property virtio_blk_properties[] = {
> >      DEFINE_PROP_BIT("request-merging", VirtIOBlock,
> conf.request_merging,
> > 0,
> >                      true),
> >      DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
> > +    DEFINE_PROP_STRING("disk-name", VirtIOBlock, disk_name),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-
> blk.h
> > index 180bd8d..003e810 100644
> > --- a/include/hw/virtio/virtio-blk.h
> > +++ b/include/hw/virtio/virtio-blk.h
> > @@ -56,6 +56,7 @@ typedef struct VirtIOBlock {
> >      bool dataplane_disabled;
> >      bool dataplane_started;
> >      struct VirtIOBlockDataPlane *dataplane;
> > +    char *disk_name;
> >  } VirtIOBlock;
> >
> >  typedef struct VirtIOBlockReq {
> > diff --git a/include/standard-headers/linux/virtio_blk.h
> > b/include/standard-headers/linux/virtio_blk.h
> > index ab16ec5..1f5d89d 100644
> > --- a/include/standard-headers/linux/virtio_blk.h
> > +++ b/include/standard-headers/linux/virtio_blk.h
> > @@ -38,6 +38,7 @@
> >  #define VIRTIO_BLK_F_BLK_SIZE  6   /* Block size of disk is available*/
> >  #define VIRTIO_BLK_F_TOPOLOGY  10  /* Topology information is available
> */
> >  #define VIRTIO_BLK_F_MQ        12  /* support more than one vq */
> > +#define VIRTIO_BLK_F_DISK_NAME  13      /* specify /dev/xxx name */
>
> These bits are defined in the VIRTIO specification.  In addition to
> modifying QEMU and guest drivers you would also need to send a patch to
> the VIRTIO Technical Committee to update the specification:
> https://docs.oasis-open.org/virtio/virtio/v1.0/cs04/
> virtio-v1.0-cs04.html#x1-2050003
>
> >
> >  /* Legacy feature bits */
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> > @@ -51,6 +52,9 @@
> >
> >  #define VIRTIO_BLK_ID_BYTES    20  /* ID string length */
> >
> > +/* micro defined in kernel genhd.h */
> > +#define DISK_NAME_LEN 32
> > +
> >  struct virtio_blk_config {
> >     /* The capacity (in 512-byte sectors). */
> >     uint64_t capacity;
> > @@ -84,6 +88,8 @@ struct virtio_blk_config {
> >
> >     /* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
> >     uint16_t num_queues;
> > +
> > +   uint8_t disk_name[DISK_NAME_LEN];
> >  } QEMU_PACKED;
> >
> >  /*
> > --
> > 1.9.4
>
>
>
