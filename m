Received: from eggs.gnu.org ([209.51.188.92]:46952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gt6kt-0001hX-AK
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gt6kr-0001Hz-DR
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:15:55 -0500
Date: Mon, 11 Feb 2019 09:15:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190211091539.465b0f69.cohuck@redhat.com>
In-Reply-To: <dd56798a-e32f-d46f-4a5c-0f8728e64fbd@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
	<e22e1a26-2dd7-cc4c-86cc-2a78adba409f@redhat.com>
	<dd56798a-e32f-d46f-4a5c-0f8728e64fbd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 01/15] s390 vfio-ccw: Add
 bootindex property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Fri, 8 Feb 2019 11:04:29 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 2/6/19 6:30 AM, Thomas Huth wrote:
> > On 2019-01-29 14:29, Jason J. Herne wrote:  

> >> diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
> >> new file mode 100644
> >> index 0000000..a7d699d
> >> --- /dev/null
> >> +++ b/include/hw/s390x/vfio-ccw.h
> >> @@ -0,0 +1,38 @@
> >> +/*
> >> + * vfio based subchannel assignment support
> >> + *
> >> + * Copyright 2018 IBM Corp.
> >> + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> >> + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> >> + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> >> + * your option) any later version. See the COPYING file in the top-level
> >> + * directory.
> >> + */
> >> +
> >> +#ifndef HW_VFIO_CCW_H
> >> +#define HW_VFIO_CCW_H
> >> +
> >> +#include "hw/vfio/vfio-common.h"
> >> +#include "hw/s390x/s390-ccw.h"
> >> +#include "hw/s390x/ccw-device.h"
> >> +
> >> +#define TYPE_VFIO_CCW "vfio-ccw"
> >> +#define VFIO_CCW(obj) \
> >> +        OBJECT_CHECK(VFIOCCWDevice, (obj), TYPE_VFIO_CCW)
> >> +
> >> +  
> > 
> > Remove one empty line, please.
> >   
> >> +#define TYPE_VFIO_CCW "vfio-ccw"
> >> +typedef struct VFIOCCWDevice {
> >> +    S390CCWDevice cdev;
> >> +    VFIODevice vdev;
> >> +    uint64_t io_region_size;
> >> +    uint64_t io_region_offset;
> >> +    struct ccw_io_region *io_region;
> >> +    EventNotifier io_notifier;
> >> +    bool force_orb_pfch;
> >> +    bool warned_orb_pfch;
> >> +} VFIOCCWDevice;  
> > 
> > Do you really need to make the whole structure public here? If not, I
> > think it would be sufficient to only have the "anonymous" typedef here:
> > 
> > typedef struct VFIOCCWDevice VFIOCCWDevice;
> > 
> >   Thomas  
> Perhaps the entire struct is not needed in ipl.c, and we could get by with only the 
> typedef. But then the only thing in vfio-ccw.h will be the one line. Seems a little 
> confusing to me. What do we gain by doing this?

What parts of VFIOCCWDevice are, in general, interesting to other code
parts? I believe most parts are not potentially useful to anything
else...

The ipl code needs this mainly to find out what kind of device it deals
with. Would it make sense to define a helper function instead and keep
the actual definition private to the vfio-ccw code? That also would
make the intention more clear.
