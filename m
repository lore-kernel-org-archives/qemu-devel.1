Received: from eggs.gnu.org ([2001:4830:134:3::10]:36083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ct8bA-0001mE-EE
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ct8b7-0001OJ-6y
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:04:56 -0400
References: <20170328090530.20052-1-aik@ozlabs.ru>
	<20170328090530.20052-2-aik@ozlabs.ru>
	<20170328114829.25656146@t450s.home>
	<8f7ad62d-0d1c-e917-5b87-f913dab6bb97@ozlabs.ru>
	<20170328210410.3d6cb5d8@t450s.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c5842ea-3c9f-94ee-27db-e1ee6ae3a449@redhat.com>
Date: Wed, 29 Mar 2017 10:04:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170328210410.3d6cb5d8@t450s.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 1/3] memory: Add get_fd() hook for
 IOMMU MR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>



On 29/03/2017 05:04, Alex Williamson wrote:
>>> What if we used this as a prototype:
>>>
>>> int (*get_fd)(IOMMUFdType type, MemoryRegion *iommu);
>>>
>>> And then we defined:
>>>
>>> typedef enum {
>>>     SPAPR_IOMMU_TABLE_FD = 0,
>>> } IOMMUFdType;  
>>
>> Where do I put this enum definition? include/exec/memory.h? It does not
>> have any mention of any platform yet...
>  
> I would assume memory.h, yes.  It seems like the enum is just an
> abstraction, what does "get fd" mean generically to an IOMMU
> MemoryRegion?  How can anyone else ever implement that callback if the
> initial user is assuming that the returned fd is a specific, yet
> unspecified type.  If the API is "give me an fd for this type of thing"
> then the IOMMU driver can either provide it or indicate that type is not
> supported.  There's really no platform knowledge at the memory API
> level, it's just a type of thing that means something to the driver
> providing the MemoryRegionIOMMUOps and the caller.

I think we should move to a QOM hierarchy like

   AbstractMemoryRegion
      MemoryRegion                  << adds MemoryRegionOps
      IOMMUMemoryRegion             << adds MemoryRegionIOMMUOps
        sPAPR_IOMMUMemoryRegion     << adds get_fd

but for now I'm okay with Alex's proposal.

Paolo
