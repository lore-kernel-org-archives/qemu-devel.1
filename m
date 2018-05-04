Received: from eggs.gnu.org ([2001:4830:134:3::10]:51865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEXWE-0002su-1z
	for qemu-devel@nongnu.org; Fri, 04 May 2018 06:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEXW8-0001fC-2T
	for qemu-devel@nongnu.org; Fri, 04 May 2018 06:00:50 -0400
Date: Fri, 4 May 2018 12:00:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180504120032.73ca4365@redhat.com>
In-Reply-To: <c7873a84-fa46-0a5d-1091-b2bb5688a1b6@redhat.com>
References: <20180503154936.18946-1-david@redhat.com>
	<20180504104907.2c0aebf4@redhat.com>
	<c7873a84-fa46-0a5d-1091-b2bb5688a1b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/8] MemoryDevice: introduce and use
 ResourceHandler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Fri, 4 May 2018 11:19:25 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 04.05.2018 10:49, Igor Mammedov wrote:
> > On Thu,  3 May 2018 17:49:28 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> Hotplug handlers usually have the following tasks:
> >> 1. Allocate some resources for a new device
> >> 2. Make the new device visible for the guest
> >> 3. Notify the guest about the new device
> >>
> >> Hotplug handlers have right now one limitation: They handle their own
> >> context and only care about resources they manage.
> >>
> >> We can have devices that need certain other resources that are e.g.
> >> system resources managed by the machine. We need a clean way to assign
> >> these resources (without violating layers as brought up by Igor).
> >>
> >> One example is virtio-mem/virtio-pmem. Both device types need to be
> >> assigned some region in guest physical address space. This device memory
> >> belongs to the machine and is managed by it. However, virito devices are
> >> hotplugged using the hotplug handler their proxy device implements. So we
> >> could trigger e.g. a PCI hotplug handler for virtio-pci or a CSS/CCW
> >> hotplug handler for virtio-ccw. But definetly not the machine.
> >>
> >> So let's generalize the task of "assigning" resources and use it directly
> >> for memory devices. We now have a clean way to support any kind of memory
> >> device - independent of the underlying device type. Right now, only one
> >> resource handler per device can be supported (in addition to the existing
> >> hotplug handler).  
> > So far I've just skimmed through series and still don't get clear
> > picture if new interface is really needed.
> > I'd like very much to see patches for how virtio-[p]mem in CCW and PCI
> > case would utilize this.  
> 
> Sure, I think you've seen the problematic parts in the latest
> virtio-pmem prototype
> (https://www.spinics.net/lists/linux-mm/msg151081.html).
> 
> There, we do the assignment from the realize function, which you
> described as layer violation. I will ask Pankaj to rebase his work on
> this series.
That's too premature at the moment.

> Until then, I can point you at the current QEMU side prototype of
> virtio-mem. I won't be posting these as patches as there are still many
> things to sort out and clean up. The prototype currently works on x86
> and s390x.
> 
> You can find the latest prototype on github, including patches of this
> series at https://github.com/davidhildenbrand/qemu/tree/virtio-mem
> 
> Interesting patches are:
> - "s390x: inititalize memory region for memory devices"
> -- Provide a region for memory devices just like x86
> - "virtio-mem: paravirtualized memory"
> -- Prototype of virtio-mem.
> - "virtio-ccw: add proxy for virtio-mem"
> -- CCW proxy device for virtio-mem (using the CSS/CCW hotplug handler)
> - "virtio-mem: paravirtualized memory"
> -- PCI proxy device for virtio-mem (using PCI hotplug handler)
> 
> Note how virtio-mem implements the MemoryDevice interface and how
> resource assignments happens without any layer violations (and no
> modifications to any hotplug handler).
Thanks, that should be sufficient to get idea.
I'll look into it and come back here with concrete comments or
suggesting alternative.
