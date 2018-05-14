Received: from eggs.gnu.org ([2001:4830:134:3::10]:34449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fIMW2-0005tn-Rv
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fIMVy-0007Xd-S0
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:04:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fIMVy-0007Qa-KM
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:04:22 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4EN3nEn078094
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 19:04:20 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hyj5hk4bx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 19:04:19 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Mon, 14 May 2018 19:04:18 -0400
Date: Mon, 14 May 2018 20:04:08 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180511131953.12905-1-david@redhat.com>
	<20180511131953.12905-17-david@redhat.com>
	<20180511183405.GA19020@kermit-br-ibm-com>
	<20180511184356.GN13350@localhost.localdomain>
	<da24d0d8-2fde-989e-e760-ba853c5f9c80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da24d0d8-2fde-989e-e760-ba853c5f9c80@redhat.com>
Message-Id: <20180514230408.GA12837@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 16/17] s390x: initialize
 memory region for memory devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Richard Henderson <rth@twiddle.net>

On Sat, May 12, 2018 at 09:53:54AM +0200, David Hildenbrand wrote:
> On 11.05.2018 20:43, Eduardo Habkost wrote:
> > On Fri, May 11, 2018 at 03:34:05PM -0300, Murilo Opsfelder Araujo wrote:
> >> On Fri, May 11, 2018 at 03:19:52PM +0200, David Hildenbrand wrote:
> >>> While s390x has no real interface for communicating devices mapped into
> >>> the physical address space of the guest, paravirtualized devices can
> >>> easily expose the applicable address range themselves.
> >>>
> >>> So let's use the difference between maxram_size and ram_size as the size
> >>> for our hotplug memory area (just as on other architectures).
> >>>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>>  hw/s390x/s390-virtio-ccw.c | 28 ++++++++++++++++++++++++++--
> >>>  1 file changed, 26 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >>> index ee0a2b124f..09b755282b 100644
> >>> --- a/hw/s390x/s390-virtio-ccw.c
> >>> +++ b/hw/s390x/s390-virtio-ccw.c
> >>> @@ -157,9 +157,11 @@ static void virtio_ccw_register_hcalls(void)
> >>>  #define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
> >>>  #define SEG_MSK (~0xfffffULL)
> >>>  #define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
> >>> -static void s390_memory_init(ram_addr_t mem_size)
> >>> +static void s390_memory_init(MachineState *machine)
> >>>  {
> >>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
> >>>      MemoryRegion *sysmem = get_system_memory();
> >>> +    ram_addr_t mem_size = machine->ram_size;
> >>>      ram_addr_t chunk, offset = 0;
> >>>      unsigned int number = 0;
> >>>      gchar *name;
> >>> @@ -181,6 +183,28 @@ static void s390_memory_init(ram_addr_t mem_size)
> >>>      }
> >>>      g_free(name);
> >>>  
> >>> +    /* always allocate the device memory information */
> >>> +    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
> >>
> >> Is there any QEMU guideline/preference/recommendation in using g_new0
> >> vs. g_malloc0?
> >>
> >> I recall Paolo suggesting g_new0 instead of g_malloc0 in another patch:
> >>
> >>   http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg02372.html
> > 
> 
> This patch comes unmodified from my same queue, therefore the code looks
> identical :)
> 
> > I don't see any reason to not use g_new0() instead of
> > g_malloc0(sizeof(...)), as it's more readable.
> 
> I clearly favor g_malloc over g_new (except for arrays) for two simple
> reasons
> 
> 1. No need to specify the type. Impossible to specify the wrong type.
> Easy to rename types.
> 
> 2. Every C developer should be able to understand what g_malloc() does.
> This is not true for g_new. Especially as it might look strange for C++
> developers (new vs. new[] - why don't we have g_new() vs. g_new_array())
> 
> I am a simple man, I prefer functions with one parameter if only one
> parameter is needed :)
> 
> > 
> > But I don't think it's a problem that should block the patch from
> > being merged.  We have hundreds of g_malloc*(sizeof(...)) calls
> > in the tree.
> 
> I assume there are a lot of hard feelings about this. I will continue
> using g_malloc() for scalars until the last user is removed from the
> QEMU source code. Or there is a coding style statement about it (haven't
> found one) ... or people start to curse me when I send patches :)

Having g_malloc() for scalars and g_new() for arrays makes sense.

I understand and agree that using g_malloc() should not be a blocker for
a patch, as Eduardo stated.

Looking at the history, there are quite a few patches replacing
g_malloc*() by g_new*() because "is safer against overflow" (see commit
071d4054770205ddb8a58a9e2735069d8fe52af1 as an example):

    git log --oneline --grep=g_new

Perhaps we just need to update "3. Low level memory management" section
in HACKING file describing the situations where g_new() is preferred vs.
g_malloc() and vice-versa; and use the agreed criteria to ack/nack
patches.

-- 
Murilo
