Received: from eggs.gnu.org ([2001:4830:134:3::10]:45061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d5QAe-00020s-A2
	for qemu-devel@nongnu.org; Tue, 02 May 2017 01:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d5QAb-0003nO-2D
	for qemu-devel@nongnu.org; Tue, 02 May 2017 01:16:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d5QAa-0003mV-QL
	for qemu-devel@nongnu.org; Tue, 02 May 2017 01:16:16 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v425DshN059875
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 01:16:15 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a6bbxumtb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 01:16:13 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 1 May 2017 23:16:13 -0600
Date: Tue, 2 May 2017 13:16:06 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
	<20170428130951.44771-9-bjsdjshi@linux.vnet.ibm.com>
	<0bf0a0d4-9756-cef6-a220-1c6288c08b10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf0a0d4-9756-cef6-a220-1c6288c08b10@redhat.com>
Message-Id: <20170502051606.GD27968@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 08/13] vfio/ccw: get io region info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, agraf@suse.com

* Auger Eric <eric.auger@redhat.com> [2017-05-01 13:08:24 +0200]:

> Hi,
> 
> On 28/04/2017 15:09, Dong Jia Shi wrote:
> > vfio-ccw provides an MMIO region for I/O operations. We fetch its
> > information via ioctls here, then we can use it performing I/O
> > instructions and retrieving I/O results later on.
> > 
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >  hw/vfio/ccw.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > index cd4dfe8..a285b23 100644
> > --- a/hw/vfio/ccw.c
> > +++ b/hw/vfio/ccw.c
> > @@ -12,6 +12,7 @@
> >   */
> >  
> >  #include <linux/vfio.h>
> > +#include <linux/vfio_ccw.h>
> >  #include <sys/ioctl.h>
> >  
> >  #include "qemu/osdep.h"
> > @@ -26,6 +27,9 @@
> >  typedef struct VFIOCCWDevice {
> >      S390CCWDevice cdev;
> >      VFIODevice vdev;
> > +    uint64_t io_region_size;
> > +    uint64_t io_region_offset;
> > +    struct ccw_io_region *io_region;
> >  } VFIOCCWDevice;
> >  
> >  static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> > @@ -50,6 +54,46 @@ static void vfio_ccw_reset(DeviceState *dev)
> >      ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
> >  }
> >  
> > +static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
> > +{
> > +    VFIODevice *vdev = &vcdev->vdev;
> > +    struct vfio_region_info *info;
> > +    int ret;
> > +
> > +    /* Sanity check device */
> > +    if (!(vdev->flags & VFIO_DEVICE_FLAGS_CCW)) {
> > +        error_setg(errp, "vfio: Um, this isn't a vfio-ccw device");
> > +        return;
> > +    }
> > +
> > +    if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
> > +        error_setg(errp, "vfio: Unexpected number of the I/O region %u",
> > +                   vdev->num_regions);
> > +        return;
> > +    }
> > +
> > +    ret = vfio_get_region_info(vdev, VFIO_CCW_CONFIG_REGION_INDEX, &info);
> > +    if (ret) {
> > +        error_setg(errp, "vfio: Error getting config info: %d", ret);
> > +        return;
> > +    }
> > +
> > +    vcdev->io_region_size = info->size;
> > +    if (sizeof(*vcdev->io_region) != vcdev->io_region_size) {
> > +        error_setg(errp, "vfio: Unexpected size of the I/O region");
> g_free(info)
Good catch!

> > +        return;
> > +    }
> > +    vcdev->io_region_offset = info->offset;
> > +    vcdev->io_region = g_malloc0(info->size);
> > +
> > +    g_free(info);
> > +}
> > +
> > +static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
> > +{
> > +    g_free(vcdev->io_region);
> > +}
> > +
> >  static void vfio_put_device(VFIOCCWDevice *vcdev)
> >  {
> >      g_free(vcdev->vdev.name);
> > @@ -126,8 +170,15 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
> >          goto out_device_err;
> >      }
> >  
> > +    vfio_ccw_get_region(vcdev, errp);
> > +    if (*errp) {
> local err?
As replied on the previous thread, ok.

> 
> Thanks
> 
> Eric
> > +        goto out_region_err;
> > +    }
> > +
> >      return;
> >  
> > +out_region_err:
> > +    vfio_put_device(vcdev);
> >  out_device_err:
> >      vfio_ccw_put_group(group);
> >  out_group_err:
> > @@ -144,6 +195,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
> >      S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> >      VFIOGroup *group = vcdev->vdev.group;
> >  
> > +    vfio_ccw_put_region(vcdev);
> >      vfio_put_device(vcdev);
> >      vfio_put_group(group);
> >  
> > 
> 

-- 
Dong Jia Shi
