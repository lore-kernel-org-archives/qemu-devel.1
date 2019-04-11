Received: from eggs.gnu.org ([209.51.188.92]:39129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEchB-0005QT-BO
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEchA-0008Oo-Bf
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:37:01 -0400
Date: Thu, 11 Apr 2019 18:36:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190411183648.34edf4dd.cohuck@redhat.com>
In-Reply-To: <72385d8c-a050-67e7-85cf-bc804f941137@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
	<20190408190747.12e3618b.cohuck@redhat.com>
	<20190410013434.7cea1971@oc2783563651>
	<4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
	<20190411175831.7be345f4@oc2783563651>
	<72385d8c-a050-67e7-85cf-bc804f941137@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 1/6] vfio-ccw: make it safe
 to access channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Thu, 11 Apr 2019 12:25:38 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 4/11/19 11:58 AM, Halil Pasic wrote:
> > On Wed, 10 Apr 2019 22:59:41 -0400
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> r the next release :) It would be one thing less on my plate...  
> >>>>     
> >>>
> >>> Sorry I was not able to spend any significant amount of time on this
> >>> lately.
> >>>
> >>> Gave the combined set (this + Farhans fio-ccw fixes for kernel
> >>> stacktraces v2) it a bit of smoke testing after some minor adjustments
> >>> to make it compile:
> >>>
> >>> --- a/drivers/s390/cio/vfio_ccw_ops.c
> >>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> >>> @@ -13,6 +13,7 @@
> >>>    #include <linux/vfio.h>
> >>>    #include <linux/mdev.h>
> >>>    #include <linux/nospec.h>
> >>> +#include <linux/slab.h>
> >>>    
> >>>    #include "vfio_ccw_private.h"
> >>>
> >>>      
> >>
> >> Hrm...  Taking today's master, and the two series you mention (slight
> >> adjustment to apply patch 3 of Connie's series, because part of it was
> >> split out a few weeks ago), and I don't encounter this.  Tried switching
> >> between SLUB/SLAB, but still compiles fine.  
> > 
> > Let me guess: you have CONFIG_PCI in our .config, right?
> > 
> > In arch/s390/include/asm/pci_io.h we have
> > 
> > #ifndef _ASM_S390_PCI_IO_H
> > #define _ASM_S390_PCI_IO_H
> > 
> > #ifdef CONFIG_PCI
> > 
> > #include <linux/kernel.h>
> > #include <linux/slab.h>
> > 
> > and pci_io.h comes in via
> > 
> > include/linux/vfio.h
> > include/linux/iommu.h
> > include/linux/scatterlist.h
> > arch/s390/include/asm/io.h
> > arch/s390/include/asm/pci_io.h
> > 
> > 
> > Figured it out with help from Farhan. Took me quite some time.  
> 
> That would have been useful information up front.

Indeed. It's trivial to fold that change in, though :) (Should be in
patch 4, if I see it correctly.)
