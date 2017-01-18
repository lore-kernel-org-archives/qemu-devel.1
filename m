Received: from eggs.gnu.org ([2001:4830:134:3::10]:46247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cTj9e-0002V7-5g
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 00:51:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cTj9b-0005yj-2t
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 00:51:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cTj9a-0005yY-PC
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 00:51:27 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0I5mwg0137327
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 00:51:24 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 282135ajvu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 00:51:24 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 18 Jan 2017 00:51:23 -0500
Date: Wed, 18 Jan 2017 13:51:16 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112072513.98411-9-bjsdjshi@linux.vnet.ibm.com>
	<20170117154934.568c6ea3@t450s.home>
	<20170118052256.GP30301@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118052256.GP30301@bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170118055116.GQ30301@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 08/12] vfio/ccw: get io region info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-01-18 13:22:56 +0800]:

> * Alex Williamson <alex.williamson@redhat.com> [2017-01-17 15:49:34 -0700]:
> 
> > On Thu, 12 Jan 2017 08:25:09 +0100
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> > 
> > > vfio-ccw provides an MMIO region for I/O operations. We fetch its
> > > information via ioctls here, then we can use it performing I/O
> > > instructions and retrieving I/O results later on.
> > > 
> > > Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > > ---
> > >  hw/vfio/ccw.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 52 insertions(+)
> > > 
> > > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > > index 881010b..93394c2 100644
> > > --- a/hw/vfio/ccw.c
> > > +++ b/hw/vfio/ccw.c
> > > @@ -21,11 +21,15 @@
> > >  #include "hw/vfio/vfio-common.h"
> > >  #include "hw/s390x/s390-ccw.h"
> > >  #include "hw/s390x/ccw-device.h"
> > > +#include "standard-headers/asm-s390/vfio_ccw.h"
> > >  
> > >  #define TYPE_VFIO_CCW "vfio-ccw"
> > >  typedef struct VFIOCCWDevice {
> > >      S390CCWDevice cdev;
> > >      VFIODevice vdev;
> > > +    uint64_t io_region_size;
> > > +    uint64_t io_region_offset;
> > > +    struct ccw_io_region *io_region;
> > >  } VFIOCCWDevice;
> > >  
> > >  static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> > > @@ -50,6 +54,46 @@ static void vfio_ccw_reset(DeviceState *dev)
> > >      ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
> > >  }
> > >  
> > > +static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
> > > +{
> > > +    VFIODevice *vdev = &vcdev->vdev;
> > > +    struct vfio_region_info *info;
> > > +    int ret;
> > > +
> > > +    /* Sanity check device */
> > > +    if (!(vdev->flags & VFIO_DEVICE_FLAGS_CCW)) {
> > > +        error_setg(errp, "vfio: Um, this isn't a vfio-ccw device");
> > > +        return;
> > > +    }
> > > +
> > > +    if (vdev->num_regions != VFIO_CCW_NUM_REGIONS) {
> > > +        error_setg(errp, "vfio: Unexpected number of the I/O region %u",
> > > +                   vdev->num_regions);
> > > +        return;
> > > +    }
> > 
> > I think you want < here, not !=, otherwise you we can never add another
> > region to describe something new on a vfio-ccw device without breaking
> > this code.  You've defined in the uapi that region index zero is always
> > VFIO_CCW_CONFIG_REGION_INDEX and this code only depends on that, no
> > matter what additional regions might be added.  That's done below.
> > 
> Right! Thanks for pointing out. I will fix.
> 
Let me make it clear. I will change it to:
    if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
        ... ...
    }

> > > +
> > > +    ret = vfio_get_region_info(vdev, VFIO_CCW_CONFIG_REGION_INDEX, &info);
> > > +    if (ret) {
> > > +        error_setg(errp, "vfio: Error getting config info: %d", ret);
> > > +        return;
> > > +    }
> > > +
> > > +    vcdev->io_region_size = info->size;
> > > +    if (sizeof(*vcdev->io_region) != vcdev->io_region_size) {
> > > +        error_setg(errp, "vfio: Unexpected size of the I/O region");
> > > +        return;
> > > +    }
> > > +    vcdev->io_region_offset = info->offset;
> > > +    vcdev->io_region = g_malloc0(info->size);
> > > +
> > > +    g_free(info);
> > > +}
> > > +
> > > +static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
> > > +{
> > > +    g_free(vcdev->io_region);
> > > +}
> > > +
> > >  static void vfio_put_device(VFIOCCWDevice *vcdev)
> > >  {
> > >      g_free(vcdev->vdev.name);
> > > @@ -144,8 +188,15 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
> > >          goto out_device_err;
> > >      }
> > >  
> > > +    vfio_ccw_get_region(vcdev, errp);
> > > +    if (*errp) {
> > > +        goto out_region_err;
> > > +    }
> > > +
> > >      return;
> > >  
> > > +out_region_err:
> > > +    vfio_put_device(vcdev);
> > >  out_device_err:
> > >      vfio_ccw_put_group(group, path);
> > >  out_group_err:
> > > @@ -166,6 +217,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
> > >          cdc->unrealize(cdev, errp);
> > >      }
> > >  
> > > +    vfio_ccw_put_region(vcdev);
> > >      vfio_put_device(vcdev);
> > >      vfio_put_group(group);
> > >  }
> > 
> 
> -- 
> Dong Jia

-- 
Dong Jia
