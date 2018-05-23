Received: from eggs.gnu.org ([2001:4830:134:3::10]:52225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fLVDD-0005Pm-13
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fLVD8-0005rW-2v
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:57:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fLVD7-0005rO-Qu
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:57:54 -0400
Date: Wed, 23 May 2018 08:57:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180523085751.1ff46b2e@w520.home>
In-Reply-To: <20180523171028-mutt-send-email-mst@kernel.org>
References: <ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
	<f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
	<20180522234410-mutt-send-email-mst@kernel.org>
	<20180522153659.2e33fbe0@w520.home>
	<20180523004236-mutt-send-email-mst@kernel.org>
	<20180522154741.3939d1e0@w520.home>
	<20180523005048-mutt-send-email-mst@kernel.org>
	<20180522222856.436c2c96@w520.home>
	<20180523171028-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/3] acpi-build: allocate mcfg for multiple
 host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eric Auger <eauger@redhat.com>, Drew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

On Wed, 23 May 2018 17:25:32 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, May 22, 2018 at 10:28:56PM -0600, Alex Williamson wrote:
> > On Wed, 23 May 2018 02:38:52 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Tue, May 22, 2018 at 03:47:41PM -0600, Alex Williamson wrote:  
> > > > On Wed, 23 May 2018 00:44:22 +0300
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >     
> > > > > On Tue, May 22, 2018 at 03:36:59PM -0600, Alex Williamson wrote:    
> > > > > > On Tue, 22 May 2018 23:58:30 +0300
> > > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:       
> > > > > > >
> > > > > > > It's not hard to think of a use-case where >256 devices
> > > > > > > are helpful, for example a nested virt scenario where
> > > > > > > each device is passed on to a different nested guest.
> > > > > > >
> > > > > > > But I think the main feature this is needed for is numa modeling.
> > > > > > > Guests seem to assume a numa node per PCI root, ergo we need more PCI
> > > > > > > roots.      
> > > > > > 
> > > > > > But even if we have NUMA affinity per PCI host bridge, a PCI host
> > > > > > bridge does not necessarily imply a new PCIe domain.      
> > > > > 
> > > > > What are you calling a PCIe domain?    
> > > > 
> > > > Domain/segment
> > > > 
> > > > 0000:00:00.0
> > > > ^^^^ This    
> > > 
> > > Right. So we can thinkably have PCIe root complexes share an ACPI segment.
> > > I don't see what this buys us by itself.  
> > 
> > The ability to define NUMA locality for a PCI sub-hierarchy while
> > maintaining compatibility with non-segment aware OSes (and firmware).  
> 
> Fur sure, but NUMA is a kind of advanced topic, MCFG has been around for
> longer than various NUMA tables. Are there really non-segment aware
> guests that also know how to make use of NUMA?

I can't answer that question, but I assume that multi-segment PCI
support is perhaps not as pervasive as we may think considering hardware
OEMs tend to avoid it for their default configurations with multiple
host bridges.

> > > > Isn't that the only reason we'd need a new MCFG section and the reason
> > > > we're limited to 256 buses?  Thanks,
> > > > 
> > > > Alex    
> > > 
> > > I don't know whether a single MCFG section can describe multiple roots.
> > > I think it would be certainly unusual.  
> > 
> > I'm not sure here if you're referring to the actual MCFG ACPI table or
> > the MMCONFIG range, aka the ECAM.  Neither of these describe PCI host
> > bridges.  The MCFG table can describe one or more ECAM ranges, which
> > provides the ECAM base address, the PCI segment associated with that
> > ECAM and the start and end bus numbers to know the offset and extent of
> > the ECAM range.  PCI host bridges would then theoretically be separate
> > ACPI objects with _SEG and _BBN methods to associate them to the
> > correct ECAM range by segment number and base bus number.  So it seems
> > that tooling exists that an ECAM/MMCONFIG range could be provided per
> > PCI host bridge, even if they exist within the same domain, but in
> > practice what I see on systems I have access to is a single MMCONFIG
> > range supporting all of the host bridges.  It also seems there are
> > numerous ways to describe the MMCONFIG range and I haven't actually
> > found an example that seems to use the MCFG table.  Two have MCFG
> > tables (that don't seem terribly complete) and the kernel claims to
> > find the MMCONFIG via e820, another doesn't even have an MCFG table and
> > the kernel claims to find MMCONFIG via an ACPI motherboard resource.
> > I'm not sure if I can enable PCI segments on anything to see how the
> > firmware changes.  Thanks,
> > 
> > Alex  
> 
> Let me clarify.  So MCFG have base address allocation structures.
> Each maps a segment and a range of bus numbers into memory.
> This structure is what I meant.

Ok, so this is the  ECAM/MMCONFIG range through which we do config
accesses, which is described by MCFG, among other options.

> IIUC you are saying on your systems everything is within a single
> segment, right? Multiple pci hosts map into a single segment?

Yes, for instance a single MMCONFIG range handles bus number ranges
0x00-0x7f within segment 0x0 and the system has host bridges with base
bus numbers of 0x00 and 0x40, each with different NUMA locality.

> If you do this you can do NUMA, but do not gain > 256 devices.

Correct, but let's also clarify that we're not limited to 256 devices,
a segment is limited to 256 buses and each PCIe slot is a bus, so the
limitation is number of hotpluggable slots.  "Devices" implies that it
includes multi-function, ARI, and SR-IOV devices as well, but we can
have 256 of those per bus, we just don't have the desired hotplug
granularity for those.

> Are we are the same page then?

Seems so.  Thanks,

Alex
