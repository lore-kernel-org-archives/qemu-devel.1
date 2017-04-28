Received: from eggs.gnu.org ([2001:4830:134:3::10]:51989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d45hX-0004wZ-Ew
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d45hT-0006y3-GV
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:12:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d45hT-0006xZ-83
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:12:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3SDA4NU024941
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:12:42 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a3hf68mp9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:12:42 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 28 Apr 2017 09:12:40 -0400
Date: Fri, 28 Apr 2017 21:12:35 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170412052115.101657-1-bjsdjshi@linux.vnet.ibm.com>
	<20170412052115.101657-8-bjsdjshi@linux.vnet.ibm.com>
	<20170424164338.0250f3fa@w520.home>
	<20170424165628.631b0455@w520.home>
	<20170425051519.GH31848@bjsdjshi@linux.vnet.ibm.com>
	<20170426084920.GI31848@bjsdjshi@linux.vnet.ibm.com>
	<20170428130407.7de89e86.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170428130407.7de89e86.cornelia.huck@de.ibm.com>
Message-Id: <20170428131235.GA27565@bjsdjshi@linux.vnet.ibm.com>
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
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com

* Cornelia Huck <cornelia.huck@de.ibm.com> [2017-04-28 13:04:07 +0200]:

> On Wed, 26 Apr 2017 16:49:20 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-04-25 13:15:19 +0800]:
> > 
> > > * Alex Williamson <alex.williamson@redhat.com> [2017-04-24 16:56:28 -0600]:
> > > 
> > > [...]
> > > > > > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > > > > > new file mode 100644
> > > > > > index 0000000..c491bee
> > > > > > --- /dev/null
> > > > > > +++ b/hw/vfio/ccw.c
> > > > > > @@ -0,0 +1,207 @@
> > > > > > +/*
> > > > > > + * vfio based subchannel assignment support
> > > > > > + *
> > > > > > + * Copyright 2017 IBM Corp.
> > > > > > + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > > > > + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > > > > > + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> > > > > > + *
> > > > > > + * This work is licensed under the terms of the GNU GPL, version 2 or(at
> > > > > > + * your option) any version. See the COPYING file in the top-level
> > > > > > + * directory.
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/vfio.h>
> > > > > > +#include <sys/ioctl.h>
> > > > > > +
> > > > > > +#include "qemu/osdep.h"
> > > > > > +#include "qapi/error.h"
> > > > > > +#include "hw/sysbus.h"
> > > > > > +#include "hw/vfio/vfio.h"
> > > > > > +#include "hw/vfio/vfio-common.h"
> > > > > > +#include "hw/s390x/s390-ccw.h"
> > > > > > +#include "hw/s390x/ccw-device.h"
> > > > > > +
> > > > > > +#define TYPE_VFIO_CCW "vfio-ccw"
> > > > > > +typedef struct VFIOCCWDevice {
> > > > > > +    S390CCWDevice cdev;
> > > > > > +    VFIODevice vdev;
> > > > > > +} VFIOCCWDevice;
> > > > > > +
> > > > > > +static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> > > > > > +{
> > > > > > +    vdev->needs_reset = false;
> > > > > > +}
> > > > > > +
> > > > > > +/*
> > > > > > + * We don't need vfio_hot_reset_multi and vfio_eoi operationis for
> > > > 
> > > > One more:
> > > > 
> > > > s/operationis/operations/
> > > > 
> > > Ok.
> > > 
> > 
> > Hi Conny,
> > 
> > I have pulled your cohuck-qemu/s390-next branch, and prepared a new
> > patch set with all of these problems fixed directly on the coressponding
> > commits on it. Fine to send out the new version as that?
> > 
> > Or I should rebase them against the latest master branch?
> 
> As I currently don't have things in my next branch that should interact
> with your changes, either is fine :)
Thanks! :>
I used your branch as the code base and just sent out the v6 patches.

> 
> [I'll take a look at the new version then]

-- 
Dong Jia Shi
