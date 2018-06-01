Received: from eggs.gnu.org ([2001:4830:134:3::10]:33417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOiwR-0007V0-Qm
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fOiwN-0001KB-NK
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:13:59 -0400
Date: Fri, 1 Jun 2018 14:13:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180601141341.2d0f7ee0@redhat.com>
In-Reply-To: <451cd080-12ab-42bd-0150-e1dbf0abd859@redhat.com>
References: <20180517081527.14410-1-david@redhat.com>
	<451cd080-12ab-42bd-0150-e1dbf0abd859@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 00/14] MemoryDevice: use
 multi stage hotplug handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 25 May 2018 14:43:39 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 17.05.2018 10:15, David Hildenbrand wrote:
> > We can have devices that need certain other resources that are e.g.
> > system resources managed by the machine. We need a clean way to assign
> > these resources (without violating layers as brought up by Igor).
> > 
> > One example is virtio-mem/virtio-pmem. Both device types need to be
> > assigned some region in guest physical address space. This device memory
> > belongs to the machine and is managed by it. However, virito devices are
> > hotplugged using the hotplug handler their proxy device implements. So we
> > could trigger e.g. a PCI hotplug handler for virtio-pci or a CSS/CCW
> > hotplug handler for virtio-ccw. But definetly not the machine.
> > 
> > Now, we can route other devices through the machine hotplug handler, to
> > properly assign/unassign resources - like a portion in guest physical
> > address space.

To sum up review:
Some comments apply to several patches even though I commented only once.

I'd suggest to restructure and split series into several:
  * unplug cleanups 08/14 & co
  * generic _preplug refactoring so we won't have to go back to that question again
  * extending memory_device interface 11/14 + actual user for the sake of which
    interface is actually extended (virtio-mem)

Also more descriptive commit messages describing why change is done,
current ones look like "Lets do something for some vague reason" to
unaware reviewers, having virtio-mem along with new extensions to
memory_device would be useful here as it could have cross reference
to parts that would need it.

Try to keep patches smaller and doing one thing, we can always squash
them later if it would be better.

I'm sorry if some comments were a bit too much or insisting on things
but I'm trying to keep hotplug infrastructure simple so that later
when someone else comes with related patches, I could easily read it
without studying it from ground up.

PS:
(I'm not a fan of idea to marry virtio device with its own bus plug logic
into bus-less machine hotplug, but I don't have a better suggestion or
time to explore alternatives, so lets do it but keep things manageable)

> > 
> > v3 -> v4:
> > - Removed the s390x bits, will send that out separately (was just a proof
> >   that it works just fine with s390x)
> > - Fixed a typo and reworded a comment
> > 
> > v2 -> v3:
> > - Added "memory-device: introduce separate config option"
> > - Dropped "parent_bus" check from hotplug handler lookup functions
> > - "Handly" -> "Handle" in patch description.
> > 
> > v1 -> v2:
> > - Use multi stage hotplug handler instead of resource handler
> > - MemoryDevices only compiled if necessary (CONFIG_MEM_HOTPLUG)
> > - Prepare PC/SPAPR machines properly for multi stage hotplug handlers
> > - Route SPAPR unplug code via the hotunplug handler
> > - Directly include s390x support. But there are no usable memory devices
> >   yet (well, only my virtio-mem prototype)
> > - Included "memory-device: drop assert related to align and start of address
> >   space"
> > 
> > David Hildenbrand (13):
> >   memory-device: drop assert related to align and start of address space
> >   memory-device: introduce separate config option
> >   pc: prepare for multi stage hotplug handlers
> >   pc: route all memory devices through the machine hotplug handler
> >   spapr: prepare for multi stage hotplug handlers
> >   spapr: route all memory devices through the machine hotplug handler
> >   spapr: handle pc-dimm unplug via hotplug handler chain
> >   spapr: handle cpu core unplug via hotplug handler chain
> >   memory-device: new functions to handle plug/unplug
> >   pc-dimm: implement new memory device functions
> >   memory-device: factor out pre-plug into hotplug handler
> >   memory-device: factor out unplug into hotplug handler
> >   memory-device: factor out plug into hotplug handler
> > 
> > Igor Mammedov (1):
> >   qdev: let machine hotplug handler to override bus hotplug handler
> > 
> >  default-configs/i386-softmmu.mak   |   3 +-
> >  default-configs/ppc64-softmmu.mak  |   3 +-
> >  default-configs/x86_64-softmmu.mak |   3 +-
> >  hw/Makefile.objs                   |   2 +-
> >  hw/core/qdev.c                     |   6 +-
> >  hw/i386/pc.c                       | 102 ++++++++++++++++++++++-------
> >  hw/mem/Makefile.objs               |   4 +-
> >  hw/mem/memory-device.c             | 129 +++++++++++++++++++++++--------------
> >  hw/mem/pc-dimm.c                   |  48 ++++++--------
> >  hw/mem/trace-events                |   4 +-
> >  hw/ppc/spapr.c                     | 129 +++++++++++++++++++++++++++++++------
> >  include/hw/mem/memory-device.h     |  21 ++++--
> >  include/hw/mem/pc-dimm.h           |   3 +-
> >  include/hw/qdev-core.h             |  11 ++++
> >  qapi/misc.json                     |   2 +-
> >  15 files changed, 330 insertions(+), 140 deletions(-)
> >   
> 
> As there was no negative feedback so far, I will go ahead and assume
> that this approach is the right thing to do.
> 
