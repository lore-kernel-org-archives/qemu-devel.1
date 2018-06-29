Received: from eggs.gnu.org ([2001:4830:134:3::10]:51289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYvlO-0000AR-II
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYvlN-00044q-HZ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:56:46 -0400
Date: Fri, 29 Jun 2018 17:56:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180629175641.13a2a747@redhat.com>
In-Reply-To: <94085ac5-0242-1cb5-065a-7e50183792bd@redhat.com>
References: <20180628121417.1980-1-david@redhat.com>
	<20180628121417.1980-3-david@redhat.com>
	<20180629164903.1630ea28@redhat.com>
	<94085ac5-0242-1cb5-065a-7e50183792bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] util/oslib-win32: indicate
 alignment for qemu_anon_ram_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>

On Fri, 29 Jun 2018 17:39:10 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 29.06.2018 16:49, Igor Mammedov wrote:
> > On Thu, 28 Jun 2018 14:14:15 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> Let's set the alignment just like for the posix variant. This will
> >> implicitly set the alignment of the underlying memory region and
> >> therefore make memory_region_get_alignment(mr) return something > 0 for
> >> all memory backends applicable to PCDIMM/NVDIMM.
> >>
> >> This will allow us to drop special handling in pc.c for
> >> memory_region_get_alignment(mr) == 0, as we can then assume that it is
> >> always set (and AFAICS >= getpagesize()).
> >>
> >> For pc in pc_memory_plug(), under Windows TARGET_PAGE_SIZE == getpagesize(),
> >> therefore alignment of DIMMs will not change, and therefore also not the
> >> guest physical memory layout.  
> > why not use QEMU_VMALLOC_ALIGN for consistency (on win => getpagesize())
> > instead of TARGET_PAGE_SIZE like linux allocator does?  
> 
> Sure we can do that, I wanted to match here exactly what has been
> written in the comment.
> 
> > 
> > Also looking at FIXME comment it notes that VirtualAlloc might have 64K
> > alignment (though I haven't found it in VirtualAlloc manual).
> > If that's true then we might need set *align to it to avoid auto-picked
> > address overlap with previous allocation (not really sure about it).  
> 
> "To determine the size of a page and the allocation granularity on the
> host computer, use the GetSystemInfo" [1]
> 
> "The size of the region, in bytes. If the lpAddress parameter is NULL,
> this value is rounded up to the next page boundary. " [1]
> 
> Historically, this seems to be 64k. But it will always be at least 4k
> (page size). So what we could do is query the actual allocation granularity:
> 
> int get_allocation_granularity(void) {
> 	SYSTEM_INFO system_info;
> 
> 	GetSystemInfo(&system_info);
> 	return system_info.dwAllocationGranularity
> }
> 
> 
> "dwAllocationGranularity: The granularity for the starting address at
> which virtual memory can be allocated. For more information, see
> VirtualAlloc." [2]
> 
> What do you think?
maybe do following:

    *align = MAX(get_allocation_granularity(), getpagesize())

> 
> > 
> >   
> >> For spapr in spapr_memory_plug(), an alignment of 0 would have been used  
> > note that align == 0 would lead to crash where QEMU_ALIGN_UP() is used,
> > so we don't care to keep it compatible (the same like in commit 92a37a04d)  
> 
> Good point!
> 
> [1]
> https://msdn.microsoft.com/en-us/library/windows/desktop/aa366887(v=vs.85).aspx
> [2]
> https://msdn.microsoft.com/en-us/library/windows/desktop/ms724958(v=vs.85).aspx
> 
