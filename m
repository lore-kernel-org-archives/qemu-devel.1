Received: from eggs.gnu.org ([2001:4830:134:3::10]:49934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dA5eh-0003bw-7F
	for qemu-devel@nongnu.org; Sun, 14 May 2017 22:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dA5ee-0004Kt-4P
	for qemu-devel@nongnu.org; Sun, 14 May 2017 22:22:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dA5ed-0004Je-Qe
	for qemu-devel@nongnu.org; Sun, 14 May 2017 22:22:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4F2Iojt025768
	for <qemu-devel@nongnu.org>; Sun, 14 May 2017 22:22:33 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aedhwvdgn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 14 May 2017 22:22:32 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 14 May 2017 20:22:32 -0600
Date: Mon, 15 May 2017 10:22:26 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-7-bjsdjshi@linux.vnet.ibm.com>
	<20170511151356.78516f2b@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511151356.78516f2b@w520.home>
Message-Id: <20170515022226.GA11226@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 06/13] s390x/css: device support for
 s390-ccw passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, eric.auger@redhat.com

* Alex Williamson <alex.williamson@redhat.com> [2017-05-11 15:13:56 -0600]:

[...]

> > diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> > new file mode 100644
> > index 0000000..b1aadcd
> > --- /dev/null
> > +++ b/hw/s390x/s390-ccw.c
> > @@ -0,0 +1,138 @@
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
> > +        error_setg_errno(errp, errno, "Host device '%s' not found", sysfsdev);
> > +        return;
> > +    }
> > +
> > +    cdev->mdevid = g_strdup(basename(dev_path));
> > +
> > +    tmp = basename(dirname(dev_path));
> > +    sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid);
> 
> 
> Seems like an oversight not to check this return value.
> 
> 
Hi Alex,

As I replied to Eric in v6, this is safe, since the format of the input
is an interface that the kernel provides for the userland program.

Anyway, I will add a check since both of you question it.

> > +
> > +    cdev->hostid.cssid = cssid;
> > +    cdev->hostid.ssid = ssid;
> > +    cdev->hostid.devid = devid;
> > +    cdev->hostid.valid = true;
> > +}
> > +
> 

-- 
Dong Jia Shi
