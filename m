Received: from eggs.gnu.org ([2001:4830:134:3::10]:50306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fAyUU-0001uc-Cx
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fAyUR-0003rO-6H
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:00:18 -0400
Date: Tue, 24 Apr 2018 16:00:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180424160011.47475594@redhat.com>
In-Reply-To: <459116211.21924603.1524497545197.JavaMail.zimbra@redhat.com>
References: <20180420123456.22196-1-david@redhat.com>
	<20180423143147.6b4df2ac@redhat.com>
	<459116211.21924603.1524497545197.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] pc-dimm: factor out MemoryDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Mon, 23 Apr 2018 11:32:25 -0400 (EDT)
Pankaj Gupta <pagupta@redhat.com> wrote:

> Hi Igor,
> 
> >   
> > > Right now we can only map PCDIMM/NVDIMM into guest address space. In the
> > > future, we might want to do the same for virtio devices - e.g.
> > > virtio-pmem or virtio-mem. Especially, they should be able to live side
> > > by side to each other.
> > > 
> > > E.g. the virto based memory devices regions will not be exposed via ACPI
> > > and friends. They will be detected just like other virtio devices and
> > > indicate the applicable memory region. This makes it possible to also use
> > > them on architectures without memory device detection support (e.g. s390x).
> > > 
> > > Let's factor out the memory device code into a MemoryDevice interface.  
> > A couple of high level questions as relevant code is not here:
> > 
> >   1. what would hotplug/unplug call chain look like in case of virtio-pmem
> >   device
> >      (reason I'm asking is that pmem being PCI device would trigger
> >       PCI bus hotplug controller and then it somehow should piggyback
> >       to Machine provided hotplug handlers, so I wonder what kind of
> >       havoc it would cause on hotplug infrastructure)  
> 
> For first phase we are using 'virtio-pmem' as cold added devices. AFAIU
> 'VirtioDeviceClass' being parent class and 'hotplug/unplug' methods implemented 
> for virtio-pmem device. So, pci bus hotplug/unplug should call the corresponding
> functions?
the problem is with trying to use PCI bus based device with bus-less
infrastructure used by (pc|nv)dimms.

The important point which we should not to break here while trying to glue
PCI hotplug handler with machine hotplug handler is:

container MachineState::device_memory is owned by machine and
it's up to machine plug handler (container's owner) to map device's mr
into its address space.
(i.e. nor device's realize nor PCI bus hotplug handler should do it)

Not sure about virtio-mem but if it would use device_memory container,
it should use machine's plug handler.

I don't have out head ideas how to glue it cleanly, may be
MachineState::device_memory is just not right thing to use
for such devices.

> >   2. why not use PCI bar mapping mechanism to do mapping since pmem is PCI
> >   device?  
> 
> I think even we use if as PCI BAR mapping with PCI we still need free guest physical 
> address to provide to VM for mapping the memory range. For that there needs to 
> be coordination between PCDIMM and VIRTIO pci device? Also, if we use RAM from QEMU 
> address space tied to big region(system_memory) memory accounting gets easier and at single place.
if PCI bar mapping is used, then during accounting we would need to
additionally scan system_memory for virtio-pmem device to account
for its memory (not a huge deal as we even differentiate between
pc-dimm and nvdimm when building a list of memory devices so
special casing another device types won't hurt),
at least device management (most complex part) will be governed
by respective subsystem the device belongs to.

> Honestly speaking I don't think there will be much difference between the two approaches? unless
> I am missing something important?
> 
> > 
> >    
> > > v2 -> v3:
> > > - "pc-dimm: factor out MemoryDevice interface"  
> > > --> Lookup both classes when comparing (David Gibson)  
> > > 
> > > v1 -> v2:
> > > - Fix compile issues on ppc (still untested  )
> > > 
> > > 
> > > David Hildenbrand (3):
> > >   pc-dimm: factor out MemoryDevice interface
> > >   machine: make MemoryHotplugState accessible via the machine
> > >   pc-dimm: factor out address space logic into MemoryDevice code
> > > 
> > >  hw/i386/acpi-build.c                         |   3 +-
> > >  hw/i386/pc.c                                 |  24 ++-
> > >  hw/mem/Makefile.objs                         |   1 +
> > >  hw/mem/memory-device.c                       | 282
> > >  +++++++++++++++++++++++++
> > >  hw/mem/pc-dimm.c                             | 304
> > >  +++++++--------------------
> > >  hw/ppc/spapr.c                               |  24 ++-
> > >  hw/ppc/spapr_hcall.c                         |   1 +
> > >  include/hw/boards.h                          |  16 ++
> > >  include/hw/mem/memory-device.h               |  48 +++++
> > >  include/hw/mem/pc-dimm.h                     |  26 +--
> > >  numa.c                                       |   3 +-
> > >  qmp.c                                        |   4 +-
> > >  stubs/Makefile.objs                          |   2 +-
> > >  stubs/{qmp_pc_dimm.c => qmp_memory_device.c} |   4 +-
> > >  14 files changed, 465 insertions(+), 277 deletions(-)
> > >  create mode 100644 hw/mem/memory-device.c
> > >  create mode 100644 include/hw/mem/memory-device.h
> > >  rename stubs/{qmp_pc_dimm.c => qmp_memory_device.c} (61%)
> > >   
> > 
> > 
> >   
