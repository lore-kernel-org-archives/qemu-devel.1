Received: from eggs.gnu.org ([2001:4830:134:3::10]:48336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d5NhT-0003AK-DR
	for qemu-devel@nongnu.org; Mon, 01 May 2017 22:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d5NhQ-0007Ni-90
	for qemu-devel@nongnu.org; Mon, 01 May 2017 22:38:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d5NhQ-0007M4-0Z
	for qemu-devel@nongnu.org; Mon, 01 May 2017 22:38:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v422XnHV027165
	for <qemu-devel@nongnu.org>; Mon, 1 May 2017 22:37:58 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a6facn6yn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 May 2017 22:37:58 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 1 May 2017 22:37:57 -0400
Date: Tue, 2 May 2017 10:37:52 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
	<20170428130951.44771-7-bjsdjshi@linux.vnet.ibm.com>
	<b56e306d-ce61-deff-f0e9-feeae7c3b984@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b56e306d-ce61-deff-f0e9-feeae7c3b984@redhat.com>
Message-Id: <20170502023752.GB27968@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 06/13] s390x/css: device support for
 s390-ccw passthrough
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

* Auger Eric <eric.auger@redhat.com> [2017-05-01 13:08:01 +0200]:

Hi Eric,

[...]
> > diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> > new file mode 100644
> > index 0000000..8b4b9cf
> > --- /dev/null
> > +++ b/hw/s390x/s390-ccw.c
> > @@ -0,0 +1,135 @@
> > +/*
> > + * s390 CCW Assignment Support
> > + *
> > + * Copyright 2017 IBM Corp
> > + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2
> > + * or (at your option) any later version. See the COPYING file in the
> > + * top-level directory.
> > + */
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "hw/sysbus.h"
> > +#include "libgen.h"
> > +#include "hw/s390x/css.h"
> > +#include "hw/s390x/css-bridge.h"
> > +#include "s390-ccw.h"
> > +
> > +static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
> > +                                  char *sysfsdev,
> > +                                  Error **errp)
> > +{
> > +    unsigned int cssid, ssid, devid;
> > +    char dev_path[PATH_MAX] = {0}, *tmp;
> > +
> > +    if (!sysfsdev) {
> > +        error_setg(errp, "No host device provided");
> > +        error_append_hint(errp,
> > +                          "Use -device vfio-ccw,sysfsdev=PATH_TO_DEVICE\n");
> > +        return;
> > +    }
> > +
> > +    if (!realpath(sysfsdev, dev_path)) {
> > +        error_setg(errp, "Host device '%s' not found", sysfsdev);
> nit: error_setg_errno may be used instead.
Ok.

> > +        return;
> > +    }
> > +
> > +    cdev->mdevid = g_strdup(basename(dev_path));
> > +
> > +    tmp = basename(dirname(dev_path));
> > +    sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid);
> I guess this is safe and you don't need to test the operation succeeded?
Yes, it's safe, since the format of the input is an interface that the
kernel provides for the userland program.

> > +
> > +    cdev->hostid.cssid = cssid;
> > +    cdev->hostid.ssid = ssid;
> > +    cdev->hostid.devid = devid;
> > +    cdev->hostid.valid = true;
> > +}
> > +
> > +static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
> > +{
> > +    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
> > +    CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
> > +    DeviceState *parent = DEVICE(ccw_dev);
> > +    BusState *qbus = qdev_get_parent_bus(parent);
> > +    VirtualCssBus *cbus = VIRTUAL_CSS_BUS(qbus);
> > +    SubchDev *sch;
> > +    int ret;
> > +    Error *err = NULL;
> > +
> > +    s390_ccw_get_dev_info(cdev, sysfsdev, errp);
> > +    if (*errp) {
> I was told in the past dereferencing errp is unclean in general because
> callers may pass null to ignore errors, although the qdev core doesn't.
> you may use local err in that case.
Thanks for the reminding. I'm aware of that. ;>

To make the usage of the Error here more consistent, I will use the
local @err, and propagate to @errp once error happens.

> > +        return;
> > +    }
> > +
> > +    sch = css_create_sch(ccw_dev->devno, false, cbus->squash_mcss, errp);
> > +    if (!sch) {
> > +        return;
> > +    }
> > +    sch->driver_data = cdev;
> > +
> > +    ccw_dev->sch = sch;
> > +    ret = css_sch_build_schib(sch, &cdev->hostid);
> > +    if (ret) {
> > +        error_setg(&err, "%s: Failed to build initial schib: %d",
> > +                   __func__, ret);
> > +        goto out_err;
> > +    }
> > +
> > +    ck->realize(ccw_dev, &err);
> > +    if (err) {
> > +        goto out_err;
> > +    }
> > +
> > +    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
> > +                          parent->hotplugged, 1);
> > +    return;
> > +
> > +out_err:
> > +    error_propagate(errp, err);
> > +    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
> > +    ccw_dev->sch = NULL;
> > +    g_free(sch);
> don't you need to free cdev->mdevid too?
Yes, I should do that. Will fix!

> 
> Thanks
> 
> Eric
> > +}
> > +
[...]

-- 
Dong Jia Shi
