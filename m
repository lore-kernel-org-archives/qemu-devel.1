Received: from eggs.gnu.org ([209.51.188.92]:33783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtybL-0001sp-04
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtybD-0000Wy-4g
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:45:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gtyb7-0000SS-Ku
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:45:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id f16so3355678wmh.4
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 09:45:24 -0800 (PST)
Date: Wed, 13 Feb 2019 18:45:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <CAGxU2F7Pn2N4fxr54jg4fUsNNT2Yo-OR10XHqfCLKv=BhQUCBQ@mail.gmail.com>
References: <1550022537-27565-1-git-send-email-changpeng.liu@intel.com>
	<20190213080143.GE26332@stefanha-x1.localdomain>
	<20190213083227.xkih3ckbtiromd2v@steredhat>
	<20190213121703.zmzpgl4fvvsfg4pf@steredhat>
	<20190213120418-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213120418-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Changpeng Liu <changpeng.liu@intel.com>, qemu devel list <qemu-devel@nongnu.org>, Lukas Doktor <ldoktor@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

On Wed, Feb 13, 2019 at 6:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Feb 13, 2019 at 01:17:03PM +0100, Stefano Garzarella wrote:
> >
> > In my series "[PATCH v4 0/6] virtio-blk: add DISCARD and WRITE_ZEROES"
> > I'm adding the host_features field in VirtIOBlock. Then, I could add
> > something like the following patch (proof of concept) inspired by the
> > virtio-net approach, that would be simplest to maintain when we will add
> > new features.
> >
> > What do you think?
> >
> > Thanks,
> > Stefano
> >
> >
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 843bb2bec8..84dcc1406c 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -28,6 +28,51 @@
> >  #include "hw/virtio/virtio-bus.h"
> >  #include "hw/virtio/virtio-access.h"
> >
> > +/*
> > + * Calculate the number of bytes up to and including the given 'field' of
> > + * 'container'.
> > + */
> > +#define endof(container, field) \
> > +    (offsetof(container, field) + sizeof_field(container, field))
> > +
>
> e.g. virtio.h. just add virtio prefix.

Make sense, maybe also the VirtIOFeature defined below can go in virtio.h.

>
> > +typedef struct VirtIOFeature {
> > +    uint64_t flags;
> > +    size_t end;
> > +} VirtIOFeature;
> > +
> > +static VirtIOFeature feature_sizes[] = {
> > +    {.flags = 1ULL << VIRTIO_NET_F_SIZE_MAX,
> > +     .end = endof(struct virtio_blk_config, size_max)},
> > +    {.flags = 1ULL << VIRTIO_NET_F_SEG_MAX,
> > +     .end = endof(struct virtio_blk_config, seg_max)},
> > +    {.flags = 1ULL << VIRTIO_NET_F_GEOMETRY,
> > +     .end = endof(struct virtio_blk_config, geometry)},
> > +    {.flags = 1ULL << VIRTIO_NET_F_BLK_SIZE,
> > +     .end = endof(struct virtio_blk_config, blk_size)},
> > +    {.flags = 1ULL << VIRTIO_NET_F_TOPOLOGY,
> > +     .end = endof(struct virtio_blk_config, opt_io_size)},
> > +    {.flags = 1ULL << VIRTIO_NET_F_CONFIG_WCE,
> > +     .end = endof(struct virtio_blk_config, wce)},
> > +    {.flags = 1ULL << VIRTIO_NET_F_MQ,
> > +     .end = endof(struct virtio_blk_config, num_queues)},
> > +    {}
>
> All names above with net look wrong to me.

Yes, they are wrong :) s/NET/BLK

I'm not sure if using the feature_sizes array the migration works well.
I mean if we have QEMU 3.1 with a single queue and we want to migrate to
QEMU 4.0 with a single queue, the config_size could be different,
because VIRTIO_NET_F_MQ is not set in the host_features.

Maybe we should initialize a config_size to the VIRTIO_BLK_CFG_SIZE macro
defined by Changpeng and then use the feature_sizes arrays only for the
new features (i.e.  discard, write_zeroes)

What do you think?

>
> > +};
> > +
> > +static void virtio_blk_set_config_size(VirtIOBlock *s, uint64_t host_features)
> > +{
> > +    int i, config_size;
> > +
> > +    config_size = endof(struct virtio_blk_config, capacity);
> > +
> > +    for (i = 0; feature_sizes[i].flags != 0; i++) {
> > +        if (host_features & feature_sizes[i].flags) {
> > +            config_size = MAX(feature_sizes[i].end, config_size);
> > +        }
> > +    }
> > +
> > +    s->config_size = config_size;
> > +}
> > +
>
> Put this in virtio.c maybe? size can be returned.

Do you want to reuse it also in virtio-net?
I should add some parameters (feature_sizes pointer and len), but I
think can work.

Thanks,
Stefano
