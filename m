Received: from eggs.gnu.org ([2001:4830:134:3::10]:36665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d2rDG-0001BL-9T
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d2rDD-0004Mg-5B
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:32:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d2rDC-0004LW-Sg
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:32:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3P3STWB028543
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 23:32:20 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a1jn2f7pd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 23:32:19 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 24 Apr 2017 21:32:19 -0600
Date: Tue, 25 Apr 2017 11:32:14 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170412052115.101657-1-bjsdjshi@linux.vnet.ibm.com>
	<20170412052115.101657-7-bjsdjshi@linux.vnet.ibm.com>
	<20170424165258.151954f4@w520.home>
	<20170425021022.GE31848@bjsdjshi@linux.vnet.ibm.com>
	<20170424201618.0d3ffd81@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170424201618.0d3ffd81@w520.home>
Message-Id: <20170425033214.GF31848@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 06/13] s390x/css: device support for
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
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com

* Alex Williamson <alex.williamson@redhat.com> [2017-04-24 20:16:18 -0600]:

> On Tue, 25 Apr 2017 10:10:22 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > * Alex Williamson <alex.williamson@redhat.com> [2017-04-24 16:52:58 -0600]:
> > 
> > > On Wed, 12 Apr 2017 07:21:08 +0200
> > > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> > >   
> > > > In order to support subchannels pass-through, we introduce a s390
> > > > subchannel device called "s390-ccw" to hold the real subchannel info.
> > > > The s390-ccw devices inherit from the abstract CcwDevice which connect
> > > > to the existing virtual-css-bus.
> > > > 
> > > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > > ---
> > > >  hw/s390x/Makefile.objs |   1 +
> > > >  hw/s390x/s390-ccw.c    | 134 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  hw/s390x/s390-ccw.h    |  38 ++++++++++++++
> > > >  3 files changed, 173 insertions(+)
> > > >  create mode 100644 hw/s390x/s390-ccw.c
> > > >  create mode 100644 hw/s390x/s390-ccw.h
> > > > 
> > > > diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> > > > index 41ac4ec..72a3d37 100644
> > > > --- a/hw/s390x/Makefile.objs
> > > > +++ b/hw/s390x/Makefile.objs
> > > > @@ -13,3 +13,4 @@ obj-y += ccw-device.o
> > > >  obj-y += s390-pci-bus.o s390-pci-inst.o
> > > >  obj-y += s390-skeys.o
> > > >  obj-$(CONFIG_KVM) += s390-skeys-kvm.o
> > > > +obj-y += s390-ccw.o
> > > > diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> > > > new file mode 100644
> > > > index 0000000..f3d5ed1
> > > > --- /dev/null
> > > > +++ b/hw/s390x/s390-ccw.c
> > > > @@ -0,0 +1,134 @@
> > > > +/*
> > > > + * s390 CCW Assignment Support
> > > > + *
> > > > + * Copyright 2017 IBM Corp
> > > > + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > > + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > > > + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> > > > + *
> > > > + * This work is licensed under the terms of the GNU GPL, version 2
> > > > + * or (at your option) any later version. See the COPYING file in the
> > > > + * top-level directory.
> > > > + */
> > > > +#include "qemu/osdep.h"
> > > > +#include "qapi/error.h"
> > > > +#include "hw/sysbus.h"
> > > > +#include "libgen.h"
> > > > +#include "hw/s390x/css.h"
> > > > +#include "hw/s390x/css-bridge.h"
> > > > +#include "s390-ccw.h"
> > > > +
> > > > +static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
> > > > +                                  char *sysfsdev,
> > > > +                                  Error **errp)
> > > > +{
> > > > +    char dev_path[PATH_MAX], *tmp;
> > > > +    unsigned int cssid, ssid, devid;
> > > > +
> > > > +    if (!sysfsdev) {
> > > > +        error_setg(errp, "No host device provided");
> > > > +        error_append_hint(errp, "Use -vfio-ccw,sysfsdev=PATH_TO_DEVICE\n");  
> > > 
> > > nit, the leading '-' here seems strange, either you're describing
> > > '-device vfio-ccw,...', or only the 'vfio-ccw,...' part.  Maybe I
> > > notice this because sometimes I do accidentally type -vfio-pci instead
> > > of -device vfio-pci.  Thanks,
> > > 
> > > Alex
> > >   
> > Ok. I will change it to:
> > error_append_hint(errp,
> >                   "Use -device vfio-ccw,sysfsdev=PATH_TO_DEVICE\n");
> > 
> > BTW, I learned this from the pci code.
> > hw/vfio/pci.c:2628:
> >             error_append_hint(errp, "Use -vfio-pci,host=DDDD:BB:DD.F "
> >                               "or -vfio-pci,sysfsdev=PATH_TO_DEVICE\n")
> > Welcome a fix to that too?
> 
> Aha, maybe that's where I learned my bad habit.  Yes, please send a
> patch separate from this series.  Thanks,
> 
> Alex
> 
Will do soon. ;>

> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (!realpath(sysfsdev, dev_path)) {
> > > > +        error_setg(errp, "Host device '%s' not found", sysfsdev);
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    cdev->mdevid = g_strdup(basename(dev_path));
> > > > +
> > > > +    tmp = basename(dirname(dev_path));
> > > > +    sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid);
> > > > +
> > > > +    cdev->hostid.cssid = cssid;
> > > > +    cdev->hostid.ssid = ssid;
> > > > +    cdev->hostid.devid = devid;
> > > > +    cdev->hostid.valid = true;
> > > > +}
> > > > +  
> > [...]
> > 
> 

-- 
Dong Jia Shi
