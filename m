Received: from eggs.gnu.org ([209.51.188.92]:56630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH3Vi-0004uu-5v
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH3Vh-0004Nh-1K
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:39:14 -0400
Date: Thu, 18 Apr 2019 11:38:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190418113859.00248d07@redhat.com>
In-Reply-To: <89ca3a70-066b-e40e-faaf-39a39ec976bf@de.ibm.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
	<1555334842-195718-6-git-send-email-imammedo@redhat.com>
	<89ca3a70-066b-e40e-faaf-39a39ec976bf@de.ibm.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org

On Tue, 16 Apr 2019 13:09:08 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> This fails with more than 8TB, e.g.  "-m 9T "
> 
> [pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=0, userspace_addr=0x3ffc8500000}) = 0
> [pid 231065] ioctl(10, KVM_SET_USER_MEMORY_REGION, {slot=0, flags=0, guest_phys_addr=0, memory_size=9895604649984, userspace_addr=0x3ffc8500000}) = -1 EINVAL (Invalid argument)
> 
> seems that the 2nd memslot gets the full size (and not 9TB-size of first slot).

it turns out MemoryRegions is rendered correctly in to 2 parts (one per alias),
but follow up flatview_simplify() collapses adjacent ranges back
into big one.

I see 2 ways how to approach it:
 1. 'improve' memory region API, so we could disable merging for
     a specific memory region (i.e. RAM providing memory region)
     (I don't in particular like the idea of twisting this API to serve KVM specific purpose)

 2. hide KVMism in kvm code. Move KVM_SLOT_MAX_BYTES out of s390 machine
    code and handle splitting big chunk into several (upto KVM_SLOT_MAX_BYTES)
    in kvm_set_phys_mem().
    We could add KVMState::max_slot_size which is set only by s390,
    so it won't affect other targets.

Paolo,
 I'd like to get your opinion/suggestion which direction I should look into?
     

 
> On 15.04.19 15:27, Igor Mammedov wrote:
> > s390 was trying to solve limited memslot size issue by abusing
> > memory_region_allocate_system_memory(), which breaks API contract
> > where the function might be called only once.
> > 
> > s390 should have used memory aliases to fragment inital memory into
> > smaller chunks to satisfy KVM's memslot limitation. But its a bit
> > late now, since allocated pieces are transfered in migration stream
> > separately, so it's not possible to just replace broken layout with
> > correct one. Previous patch made MemoryRegion alases migratable and
> > this patch switches to use them to split big initial RAM chunk into
> > smaller pieces up to KVM_SLOT_MAX_BYTES each and registers aliases
> > for migration.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > A don't have access to a suitable system to test it, so I've simulated
> > it with smaller chunks on x84 host. Ping-pong migration between old
> > and new QEMU worked fine.  KVM part should be fine as memslots
> > using mapped MemoryRegions (in this case it would be aliases) as
> > far as I know but is someone could test it on big enough host it
> > would be nice.
> > ---
> >  hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index d11069b..12ca3a9 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -161,20 +161,30 @@ static void virtio_ccw_register_hcalls(void)
> >  static void s390_memory_init(ram_addr_t mem_size)
> >  {
> >      MemoryRegion *sysmem = get_system_memory();
> > +    MemoryRegion *ram = g_new(MemoryRegion, 1);
> >      ram_addr_t chunk, offset = 0;
> >      unsigned int number = 0;
> >      gchar *name;
> >  
> >      /* allocate RAM for core */
> > +    memory_region_allocate_system_memory(ram, NULL, "s390.whole.ram", mem_size);
> > +    /*
> > +     * memory_region_allocate_system_memory() registers allocated RAM for
> > +     * migration, however for compat reasons the RAM should be passed over
> > +     * as RAMBlocks of the size upto KVM_SLOT_MAX_BYTES. So unregister just
> > +     * allocated RAM so it won't be migrated directly. Aliases will take
> > +     * of segmenting RAM into legacy chunks.
> > +     */
> > +    vmstate_unregister_ram(ram, NULL);
> >      name = g_strdup_printf("s390.ram");
> >      while (mem_size) {
> > -        MemoryRegion *ram = g_new(MemoryRegion, 1);
> > -        uint64_t size = mem_size;
> > +        MemoryRegion *alias = g_new(MemoryRegion, 1);
> >  
> >          /* KVM does not allow memslots >= 8 TB */
> > -        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
> > -        memory_region_allocate_system_memory(ram, NULL, name, chunk);
> > -        memory_region_add_subregion(sysmem, offset, ram);
> > +        chunk = MIN(mem_size, KVM_SLOT_MAX_BYTES);
> > +        memory_region_init_alias(alias, NULL, name, ram, offset, chunk);
> > +        vmstate_register_ram_global(alias);
> > +        memory_region_add_subregion(sysmem, offset, alias);
> >          mem_size -= chunk;
> >          offset += chunk;
> >          g_free(name);
> >   
> 
> 
