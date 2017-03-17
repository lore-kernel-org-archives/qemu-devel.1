Received: from eggs.gnu.org ([2001:4830:134:3::10]:42378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cor0g-0001lk-CX
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cor0d-0000oQ-9g
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:29:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cor0d-0000oD-15
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:29:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12F4A7F749
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 12:29:31 +0000 (UTC)
Date: Fri, 17 Mar 2017 20:29:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170317122925.GA26309@lemon.lan>
References: <20170317113353.26297-1-famz@redhat.com>
	<20170317121816.rsvch6lewyr54lwy@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317121816.rsvch6lewyr54lwy@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] virtio: Fix error handling in
 virtio_bus_device_plugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 03/17 13:18, Andrew Jones wrote:
> On Fri, Mar 17, 2017 at 07:33:53PM +0800, Fam Zheng wrote:
> > For one thing we shouldn't continue if an error happened, for the other
> > two steps failing can cause an abort() in error_setg because we reuse
> > the same errp blindly.
> > 
> > Add error handling checks to fix both issues.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  hw/virtio/virtio-bus.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> > index a886011..ef76919 100644
> > --- a/hw/virtio/virtio-bus.c
> > +++ b/hw/virtio/virtio-bus.c
> > @@ -25,6 +25,7 @@
> >  #include "qemu/osdep.h"
> >  #include "hw/hw.h"
> >  #include "qemu/error-report.h"
> > +#include "qapi/error.h"
> >  #include "hw/qdev.h"
> >  #include "hw/virtio/virtio-bus.h"
> >  #include "hw/virtio/virtio.h"
> > @@ -48,21 +49,34 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
> >      VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
> >      VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> >      bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> > +    Error *local_err = NULL;
> >  
> >      DPRINTF("%s: plug device.\n", qbus->name);
> >  
> >      if (klass->pre_plugged != NULL) {
> > -        klass->pre_plugged(qbus->parent, errp);
> > +        klass->pre_plugged(qbus->parent, &local_err);
> > +        if (local_err) {
> > +            error_propagate(errp, local_err);
> > +            return;
> > +        }
> >      }
> >  
> >      /* Get the features of the plugged device. */
> >      assert(vdc->get_features != NULL);
> >      vdev->host_features = vdc->get_features(vdev, vdev->host_features,
> > -                                            errp);
> > +                                            &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> >  
> >      if (klass->device_plugged != NULL) {
> >          klass->device_plugged(qbus->parent, errp);
> 
> Did you intend to change this errp to &local_err, as well? If not,
> then the body of the below hunk is unreachable, as local_err can
> never be non-null there.

Yes, this is an overlook.

Fam

> 
> Thanks,
> drew
> 
> >      }
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> >  
> >      if (klass->get_dma_as != NULL && has_iommu) {
> >          virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
> > -- 
> > 2.9.3
> > 
> > 
