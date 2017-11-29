Received: from eggs.gnu.org ([2001:4830:134:3::10]:36444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK4li-0002wZ-O0
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK4le-0007PE-R3
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:59:26 -0500
Date: Wed, 29 Nov 2017 16:59:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171129165917.0d163823.cohuck@redhat.com>
In-Reply-To: <77eab778-87d4-c16e-2407-5437f51c4b04@redhat.com>
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-8-david@redhat.com>
	<20171129165049.1c446263.cohuck@redhat.com>
	<77eab778-87d4-c16e-2407-5437f51c4b04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 07/15] s390x: handle exceptions
 during s390_cpu_virt_mem_rw() correctly (TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Wed, 29 Nov 2017 16:54:30 +0100
David Hildenbrand <david@redhat.com> wrote:


> >> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> >> index 31e3f3f415..39da9aeef4 100644
> >> --- a/target/s390x/mmu_helper.c
> >> +++ b/target/s390x/mmu_helper.c
> >> @@ -22,6 +22,7 @@
> >>  #include "internal.h"
> >>  #include "kvm_s390x.h"
> >>  #include "sysemu/kvm.h"
> >> +#include "exec/exec-all.h"
> >>  #include "trace.h"
> >>  #include "hw/s390x/storage-keys.h"
> >>  
> >> @@ -458,7 +459,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
> >>          }
> >>          if (!address_space_access_valid(&address_space_memory, pages[i],
> >>                                          TARGET_PAGE_SIZE, is_write)) {
> >> -            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
> >> +            trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);  
> > 
> > Why did you change this?  
> 
> "For TCG, there was one case where a cpu loop exit was triggered. Fix
> that up."
> 
> Wasn't worth a separate patch :)

Well, maybe it is, to avoid dumb questions :)

> 
> >   
> >>              return -EFAULT;
> >>          }
> >>          addr += TARGET_PAGE_SIZE;
