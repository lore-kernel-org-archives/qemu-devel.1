Received: from eggs.gnu.org ([2001:4830:134:3::10]:58445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gIcJe-0003oH-5S
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gIcJT-0004ny-E4
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:28:52 -0400
Date: Fri, 2 Nov 2018 12:28:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181102122231-mutt-send-email-mst@kernel.org>
References: <20181024101930.20674-1-david@redhat.com>
	<20181024101930.20674-3-david@redhat.com>
	<20181101151034.4eb1618c@redhat.com>
	<85802555-0f27-847d-22a9-e87ce2e5df55@redhat.com>
	<20181102140032.43f6c93c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102140032.43f6c93c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/7] pcihp: overwrite hotplug handler
 recursively from the start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org, Libvirt <libvir-list@redhat.com>

On Fri, Nov 02, 2018 at 02:00:32PM +0100, Igor Mammedov wrote:
> On Fri, 2 Nov 2018 12:43:10 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
> > On 01.11.18 15:10, Igor Mammedov wrote:
> > > On Wed, 24 Oct 2018 12:19:25 +0200
> > > David Hildenbrand <david@redhat.com> wrote:
> > >   
> > >> For now, the hotplug handler is not called for devices that are
> > >> being cold plugged. The hotplug handler is setup when the machine
> > >> initialization is fully done. Only bridges that were cold plugged are
> > >> considered.
> > >>
> > >> Set the hotplug handler for the root piix bus directly when realizing.
> > >> Overwrite the hotplug handler of bridges when hotplugging/coldplugging
> > >> them.
> > >>
> > >> This will now make sure that the ACPI PCI hotplug handler is also called
> > >> for cold-plugged devices (also on bridges) and for bridges that were
> > >> hotplugged.
> > >>
> > >> When trying to hotplug a device to a hotplugged bridge, we now correctly
> > >> get the error message
> > >>  "Unsupported bus. Bus doesn't have property 'acpi-pcihp-bsel' set"
> > >> Insted of going via the standard PCI hotplug handler.  
> > > Erroring out is probably not ok, since it can break existing setups
> > > where SHPC hotplugging to hotplugged bridge was working just fine before.  
> > 
> > The question is if it actually was supposed (and eventually did) work.
> I think it works now, it's QEMU 'ACPI hotplug hack' (which exists for
> the sake of Windows) limitation. We weren't able to dynamically add
> ACPI description for hotplugged bridge, so it was using native hotplug.
> Now theoretically we can load tables dynamically but that, would add
> maintenance nightmare (versioned tables) and would be harder to debug.
> I'd rather not go that direction and keep current limited version,
> suggesting users to use native hotplug if guest is capable.

Well a bunch of tables need to be dynamic, and generating them from ACPI
isn't a significant step up from generating them in the BIOS which did
create huge headaches, for many reasons but in particular because we
need to add custom interfaces for every little thing we are adding.
By comparison dynamic loading is a single interface and we can
ship any AML code we want across it.

So I'm working on a limited form of dynamic loading with versioning and
I don't necessarily agree it has to be a nightmare, but yes it does need
to be limited very carefully. Implementing bridge hotplug there
isn't in scope for me at this point.

> > If this was the expected behavior (mixing hotplug types), then the
> > necessary change to this patch would boil down to checking if the bridge
> > it hot or coldplugged.
> > 
> > > 
> > > Marcel/Michael what's your take on this change in behaviour?
> > > CCing libvirt in case they are doing this stuff
> > >   
> > 
> > Indeed, it would be nice to know if this was actually supposed to work
> > like this (coldplugged bridges using ACPI hotplug and hotplugged bridges
> > using SHPC hotplug).
> > 
> > 
