Received: from eggs.gnu.org ([2001:4830:134:3::10]:56443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d2sp2-0006fJ-FT
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 01:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d2sox-0002rJ-GA
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 01:15:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d2sox-0002r5-7F
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 01:15:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3P5DovQ025626
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 01:15:25 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a1qnwm8ge-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 01:15:25 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 01:15:24 -0400
Date: Tue, 25 Apr 2017 13:15:19 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170412052115.101657-1-bjsdjshi@linux.vnet.ibm.com>
	<20170412052115.101657-8-bjsdjshi@linux.vnet.ibm.com>
	<20170424164338.0250f3fa@w520.home>
	<20170424165628.631b0455@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170424165628.631b0455@w520.home>
Message-Id: <20170425051519.GH31848@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 07/13] vfio/ccw: vfio based subchannel
 passthrough driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com

* Alex Williamson <alex.williamson@redhat.com> [2017-04-24 16:56:28 -0600]:

[...]
> > > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > > new file mode 100644
> > > index 0000000..c491bee
> > > --- /dev/null
> > > +++ b/hw/vfio/ccw.c
> > > @@ -0,0 +1,207 @@
> > > +/*
> > > + * vfio based subchannel assignment support
> > > + *
> > > + * Copyright 2017 IBM Corp.
> > > + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > > + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 or(at
> > > + * your option) any version. See the COPYING file in the top-level
> > > + * directory.
> > > + */
> > > +
> > > +#include <linux/vfio.h>
> > > +#include <sys/ioctl.h>
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qapi/error.h"
> > > +#include "hw/sysbus.h"
> > > +#include "hw/vfio/vfio.h"
> > > +#include "hw/vfio/vfio-common.h"
> > > +#include "hw/s390x/s390-ccw.h"
> > > +#include "hw/s390x/ccw-device.h"
> > > +
> > > +#define TYPE_VFIO_CCW "vfio-ccw"
> > > +typedef struct VFIOCCWDevice {
> > > +    S390CCWDevice cdev;
> > > +    VFIODevice vdev;
> > > +} VFIOCCWDevice;
> > > +
> > > +static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> > > +{
> > > +    vdev->needs_reset = false;
> > > +}
> > > +
> > > +/*
> > > + * We don't need vfio_hot_reset_multi and vfio_eoi operationis for
> 
> One more:
> 
> s/operationis/operations/
> 
Ok.

> > > + * vfio_ccw device now.
> > > + */
> > > +struct VFIODeviceOps vfio_ccw_ops = {
> > > +    .vfio_compute_needs_reset = vfio_ccw_compute_needs_reset,
> > > +};
> > > +
> > > +static void vfio_ccw_reset(DeviceState *dev)
> > > +{
> > > +    CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
> > > +    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
> > > +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> > > +
> > > +    ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
> > > +}
> > > +
> > > +static void vfio_put_device(VFIOCCWDevice *vcdev)
> > > +{
> > > +    g_free(vcdev->vdev.name);
> > > +    vfio_put_base_device(&vcdev->vdev);
> > > +}
> > > +
> > > +static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, char **path,
> > > +                                     Error **errp)
> > > +{
> > > +    struct stat st;
> > > +    int groupid;
> > > +    GError *gerror = NULL;
> > > +
> > > +    /* Check that host subchannel exists. */
> > > +    path[0] = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x",
> > > +                              cdev->hostid.cssid,
> > > +                              cdev->hostid.ssid,
> > > +                              cdev->hostid.devid);
> > > +    if (stat(path[0], &st) < 0) {
> > > +        error_setg(errp, "vfio: no such host subchannel %s", path[0]);
> > > +        return NULL;
> > > +    }
> > > +
> > > +    /* Check that mediated device exists. */
> > > +    path[1] = g_strdup_printf("%s/%s", path[0], cdev->mdevid);
> > > +    if (stat(path[0], &st) < 0) {
> > > +        error_setg(errp, "vfio: no such mediated device %s", path[1]);
> > > +        return NULL;
> > > +    }  
> > 
> > Isn't this all a bit circular since we build the S390CCWDevice based on
> > the sysfsdev mdev path?
> > 
Right! We don't need to verify the existance of the path here again,
since we already did that during the realization of the S390CCWDevice,
which is triggered by calling cdc->realize before vfio_ccw_get_group in
vfio_ccw_realize.

> > > +
> > > +    /* Get the iommu_group patch as the interim variable. */
> > > +    path[2] = g_strconcat(path[1], "/iommu_group", NULL);
> > > +
> > > +    /* Get the link file path of the device iommu_group. */
> > > +    path[3] = g_file_read_link(path[2], &gerror);
> > > +    if (!path[3]) {
> > > +        error_setg(errp, "vfio: error no iommu_group for subchannel");
> > > +        return NULL;
> > > +    }
> > > +
> > > +    /* Get the device groupid. */
> > > +    if (sscanf(basename(path[3]), "%d", &groupid) != 1) {
> > > +        error_setg(errp, "vfio: error reading %s:%m", path[3]);
> > > +        return NULL;
> > > +    }
> > > +
> > > +    return vfio_get_group(groupid, &address_space_memory, errp);
> > > +}
> > > +
> > > +static void vfio_ccw_put_group(VFIOGroup *group, char **path)
> > > +{
> > > +    g_free(path);
> > > +    vfio_put_group(group);
> > > +}
> > > +
> > > +static void vfio_ccw_realize(DeviceState *dev, Error **errp)
> > > +{
> > > +    VFIODevice *vbasedev;
> > > +    VFIOGroup *group;
> > > +    CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
> > > +    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
> > > +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> > > +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> > > +    char *path[4] = {NULL, NULL, NULL, NULL};  
> > 
> > I don't understand what's happening with 'path' throughout this
> > function.  vfio_ccw_get_group() allocates strings into this array, we
> > only seem to use one in an error path below, it's only freed on an error
> > path and I don't see it getting linked to the VFIOCCWDevice, so it
> > seems to be leaked, and even the g_free() above looks quite a bit
> > suspicious.
This @path, together with the operations on it, must be a leftover of a
previous implementation. I will rewrite these stuff. Thanks for the
catch!

> > 
> > > +
> > > +    /* Call the class init function for subchannel. */
> > > +    if (cdc->realize) {
> > > +        cdc->realize(cdev, vcdev->vdev.sysfsdev, errp);
> > > +        if (*errp) {
> > > +            return;
> > > +        }
> > > +    }
> > > +
> > > +    group = vfio_ccw_get_group(cdev, path, errp);
> > > +    if (!group) {
> > > +        goto out_group_err;
> > > +    }
> > > +
> > > +    vcdev->vdev.ops = &vfio_ccw_ops;
> > > +    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
> > > +    vcdev->vdev.name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
> > > +                                       cdev->hostid.ssid, cdev->hostid.devid);
> > > +    QLIST_FOREACH(vbasedev, &group->device_list, next) {
> > > +        if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
> > > +            error_setg(errp, "vfio: subchannel %s has already been attached",
> > > +                       basename(path[0]));
> > > +            goto out_device_err;
> > > +        }
> > > +    }
> > > +
> > > +    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, errp)) {
> > > +        goto out_device_err;
> > > +    }
> > > +
> > > +    return;
> > > +
> > > +out_device_err:
> > > +    vfio_ccw_put_group(group, path);
> > > +out_group_err:
> > > +    if (cdc->unrealize) {
> > > +        cdc->unrealize(cdev, errp);
> > > +    }
> > > +}
> > > +
> > > +static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
> > > +{
> > > +    CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
> > > +    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
> > > +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> > > +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> > > +    VFIOGroup *group = vcdev->vdev.group;
> > > +
> > > +    if (cdc->unrealize) {
> > > +        cdc->unrealize(cdev, errp);
> > > +    }
> > > +
> > > +    vfio_put_device(vcdev);
> > > +    vfio_put_group(group);
> > > +}  
> > 
> > Doesn't seem to matter here, but I would have expected the
> > cdc->unrealize to occur at the end to unwind the order of the realize
> > function.
Ok! Will do.

> > 
> > > +
[...]

-- 
Dong Jia Shi
