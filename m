Received: from eggs.gnu.org ([209.51.188.92]:57259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH5jY-0001dJ-Jw
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH5jQ-0005dm-KE
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:01:38 -0400
Date: Thu, 18 Apr 2019 14:01:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190418140116.19596c6d@redhat.com>
In-Reply-To: <93d242cb-dcc4-a65d-a7c7-7232dd16a2f2@redhat.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-6-git-send-email-imammedo@redhat.com>
	<89ca3a70-066b-e40e-faaf-39a39ec976bf@de.ibm.com>
	<20190418113859.00248d07@redhat.com>
	<93d242cb-dcc4-a65d-a7c7-7232dd16a2f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/5] s390: do not call
 memory_region_allocate_system_memory() multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org

On Thu, 18 Apr 2019 13:24:43 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 18.04.19 11:38, Igor Mammedov wrote:
> > On Tue, 16 Apr 2019 13:09:08 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> This fails with more than 8TB, e.g.  "-m 9T "
> >>
> >> [pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=0, userspace_addr=0x3ffc8500000}) = 0
> >> [pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=9895604649984, userspace_addr=0x3ffc8500000}) = -1 EINVAL (Invalid argument)
> >>
> >> seems that the 2nd memslot gets the full size (and not 9TB-size of first slot).  
> > 
> > it turns out MemoryRegions is rendered correctly in to 2 parts (one per alias),
> > but follow up flatview_simplify() collapses adjacent ranges back
> > into big one.  
> 
> That sounds dangerous. Imagine doing that at runtime (e.g. hotplugging a
> DIMM), the kvm memory slot would temporarily be deleted to insert the
> new, bigger one. Guest would crash. This could happen if backing memory
> of two DIMMs would by pure luck be allocated side by side in user space.
> 

not sure I fully get your concerns, but if you look at can_merge()
it ensures that ranges belong to the same MemoryRegion.

It's hard for me to say if flatview_simplify() works as designed,
MemoryRegion code is quite complicated so I'd deffer to Paolo's
opinion.
