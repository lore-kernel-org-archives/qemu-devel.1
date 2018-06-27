Received: from eggs.gnu.org ([2001:4830:134:3::10]:37161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fY9Ck-0003XQ-VS
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fY9Cg-0005ni-SW
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:05:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fY9Cg-0005n8-K7
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:05:42 -0400
Date: Wed, 27 Jun 2018 08:05:41 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <410633343.46328776.1530101141460.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180627112741.GH30628@redhat.com>
References: <20180627112520.26085-1-pagupta@redhat.com>
	<20180627112741.GH30628@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] virtio-rng: process pending requests
 when driver is ready
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?Q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: amit@kernel.org, stefanha@redhat.com, qemu-devel@nongnu.org, slopezpa@redhat.com, mst@redhat.com


> 
> On Wed, Jun 27, 2018 at 04:55:20PM +0530, Pankaj Gupta wrote:
> >  virtio-rng device causing old guest kernels(2.6.32) to hang on latest
> >  qemu.
> >  The driver attempts to read from the virtio-rng device too early in it's
> >  initialization. Qemu detects guest is not ready and returns, resulting in
> >  hang.
> 
> Presumably this all worked previously at some point, so do you know what
> change in QEMU has caused a regression in this regard.

Latest qemu(2.x) has this issue with older guest kernel(2.6.32) versions.
But it does work properly with upstream guest kernel because the way virtio-rng
driver is reworked, it sends request to virtio-rng driver when(before) there is 
read call. 

If guest driver is ready when it notifies qemu this works fine. There are number
of changes in guest virtio/driver code infrastructure as well as qemu side, I don't 
know exact commit after which this stopped working for older guest kernels. 
 
Thanks,
Pankaj

> 
> > 
> >  Fix is to handle pending request when guest is running and driver status
> >  is
> >  set to 'VIRTIO_CONFIG_S_DRIVER_OK'.
> > 
> > Reported-by: Sergio lopez <slopezpa@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> > v1->v2: Update new status value early only for virtio-rng (Stefan)
> > 
> >  hw/virtio/virtio-rng.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> > index 289bbcac03..855f1b41d1 100644
> > --- a/hw/virtio/virtio-rng.c
> > +++ b/hw/virtio/virtio-rng.c
> > @@ -156,6 +156,19 @@ static void check_rate_limit(void *opaque)
> >      vrng->activate_timer = true;
> >  }
> >  
> > +static void virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
> > +{
> > +    VirtIORNG *vrng = VIRTIO_RNG(vdev);
> > +
> > +    if (!vdev->vm_running) {
> > +        return;
> > +    }
> > +    vdev->status = status;
> > +
> > +    /* Something changed, try to process buffers */
> > +    virtio_rng_process(vrng);
> > +}
> > +
> >  static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
> >  {
> >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > @@ -261,6 +274,7 @@ static void virtio_rng_class_init(ObjectClass *klass,
> > void *data)
> >      vdc->realize = virtio_rng_device_realize;
> >      vdc->unrealize = virtio_rng_device_unrealize;
> >      vdc->get_features = get_features;
> > +    vdc->set_status = virtio_rng_set_status;
> >  }
> >  
> >  static const TypeInfo virtio_rng_info = {
> > --
> > 2.14.3
> > 
> > 
> 
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange
> |:|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com
> |:|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange
> |:|
> 
> 
