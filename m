Received: from eggs.gnu.org ([209.51.188.92]:35248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1hEe77-0000WH-0K
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1hEe75-0007J9-Sg
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:07:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41840
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1hEe74-0007IC-GG
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:07:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BI4IY9108035
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 14:07:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rt95emmqr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 14:07:49 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 11 Apr 2019 19:07:47 +0100
Date: Thu, 11 Apr 2019 20:07:42 +0200
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190411183648.34edf4dd.cohuck@redhat.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
	<20190408190747.12e3618b.cohuck@redhat.com>
	<20190410013434.7cea1971@oc2783563651>
	<4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
	<20190411175831.7be345f4@oc2783563651>
	<72385d8c-a050-67e7-85cf-bc804f941137@linux.ibm.com>
	<20190411183648.34edf4dd.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190411200742.19b7c476@oc2783563651>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Thu, 11 Apr 2019 18:36:48 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 11 Apr 2019 12:25:38 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
> 
> > On 4/11/19 11:58 AM, Halil Pasic wrote:
> > > On Wed, 10 Apr 2019 22:59:41 -0400
> > > Eric Farman <farman@linux.ibm.com> wrote:
> > >   
> > >> r the next release :) It would be one thing less on my plate...  
> > >>>>     
> > >>>
> > >>> Sorry I was not able to spend any significant amount of time on this
> > >>> lately.
> > >>>
> > >>> Gave the combined set (this + Farhans fio-ccw fixes for kernel
> > >>> stacktraces v2) it a bit of smoke testing after some minor adjustments
> > >>> to make it compile:
> > >>>
> > >>> --- a/drivers/s390/cio/vfio_ccw_ops.c
> > >>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> > >>> @@ -13,6 +13,7 @@
> > >>>    #include <linux/vfio.h>
> > >>>    #include <linux/mdev.h>
> > >>>    #include <linux/nospec.h>
> > >>> +#include <linux/slab.h>
> > >>>    
> > >>>    #include "vfio_ccw_private.h"
> > >>>
> > >>>      
> > >>
> > >> Hrm...  Taking today's master, and the two series you mention (slight
> > >> adjustment to apply patch 3 of Connie's series, because part of it was
> > >> split out a few weeks ago), and I don't encounter this.  Tried switching
> > >> between SLUB/SLAB, but still compiles fine.  
> > > 
> > > Let me guess: you have CONFIG_PCI in our .config, right?
> > > 
> > > In arch/s390/include/asm/pci_io.h we have
> > > 
> > > #ifndef _ASM_S390_PCI_IO_H
> > > #define _ASM_S390_PCI_IO_H
> > > 
> > > #ifdef CONFIG_PCI
> > > 
> > > #include <linux/kernel.h>
> > > #include <linux/slab.h>
> > > 
> > > and pci_io.h comes in via
> > > 
> > > include/linux/vfio.h
> > > include/linux/iommu.h
> > > include/linux/scatterlist.h
> > > arch/s390/include/asm/io.h
> > > arch/s390/include/asm/pci_io.h
> > > 
> > > 
> > > Figured it out with help from Farhan. Took me quite some time.  
> > 
> > That would have been useful information up front.
> 
> Indeed. It's trivial to fold that change in, though :) (Should be in
> patch 4, if I see it correctly.)
> 

#4 vfio-ccw: add capabilities chain it is!

Cheers,
Halil
