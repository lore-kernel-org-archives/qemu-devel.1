Received: from eggs.gnu.org ([2001:4830:134:3::10]:51613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRiW0-0001My-UZ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRiVw-0001k4-Uy
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:46:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cRiVw-0001jY-Mm
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:46:12 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B357461B91
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 16:46:12 +0000 (UTC)
Date: Thu, 12 Jan 2017 18:46:11 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170112184532-mutt-send-email-mst@kernel.org>
References: <1484137136-8021-1-git-send-email-marcel@redhat.com>
	<20170112173724-mutt-send-email-mst@kernel.org>
	<4e1faa9c-c586-cd85-5642-a337b43d8c25@redhat.com>
	<20170112181422-mutt-send-email-mst@kernel.org>
	<c88fdce9-4dc4-3b4e-321f-76e1f9ba1c3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88fdce9-4dc4-3b4e-321f-76e1f9ba1c3a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 0/3] hw/pcie: Introduce Generic PCI
 Express Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 12, 2017 at 06:23:08PM +0200, Marcel Apfelbaum wrote:
> On 01/12/2017 06:20 PM, Michael S. Tsirkin wrote:
> > On Thu, Jan 12, 2017 at 06:05:20PM +0200, Marcel Apfelbaum wrote:
> > > On 01/12/2017 05:56 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Jan 11, 2017 at 02:18:53PM +0200, Marcel Apfelbaum wrote:
> > > > > v1 -> v2:
> > > > >  - Rebased on master.
> > > > > 
> > > > > The Generic Root Port behaves the same as the
> > > > > Intel's IOH device with id 3420, without having
> > > > > Intel specific attributes.
> > > > > 
> > > > > The device has two purposes:
> > > > >  (1) Can be used on both X86 and ARM machines.
> > > > >  (2) It will allow us to tweak the behaviour
> > > > >     (e.g add vendor-specific PCI capabilities)
> > > > >      - something that obviously cannot be done
> > > > >        on a known device.
> > > > > 
> > > > > Patch 1/3: Introduce a base class for Root Ports - most of the code
> > > > >            is migrated from IOH3420 implementation.
> > > > > Patch 2/3: Derives the IOH3420 from the new base class
> > > > > Patch 3/3: Introduces the generic Root Port.
> > > > > 
> > > > > Tested with Linux and Windows guests only on x86 hosts.
> > > > 
> > > 
> > > Hi Michael,
> > > 
> > > > So I understand how it's helpful to share code
> > > > with an existing bridge, but I worries me that
> > > > you picked up some arbitrary values from the intel chip
> > > > and promote them as a standard pcie thing.
> > > > 
> > > 
> > > I suppose you are referring to the macros, I can duplicate
> > > them, of course.
> > > 
> > > > You want to have e.g. base-pcie-root-port and
> > > > inherit that. Only put really common stuff in there.
> > > > Similar to how we do it in hw/pci/pci_bridge.c
> > > > 
> > > 
> > > So you prefer a different code file for the generic device.
> > > I currently put them both in the same file, I'll split.
> > > 
> > > > 
> > > > Now we do not want to over-engineer, so I understand
> > > > how you might want to say hey I use this option
> > > > and intel does the same so we do not need a flag
> > > > for that now. And that's fine but please add a comment
> > > > to that end.
> > > > 
> > > 
> > > Indeed, I wanted to keep things simple. I'll add a comment
> > > on the functions that are not generic but are the same on
> > > both implementations 'by chance'.
> > > 
> > > > And when you do you will discover there's some stuff you
> > > > might be able to simplify, e.g. I don't yet see why
> > > > you would want AER support there.
> > > > 
> > > 
> > > I am not sure *why not*.
> > > I am 'afraid' people will not use the new port
> > > because of missing features and they can see the AER as one of them.
> > > Do you see a special issue in imitating Intel's behavior on AER?
> > > 
> > > Thanks,
> > > Marcel
> > 
> > Not really, fair enough. Just keep an eye out for caps
> > you don't need. E.g. it's worth considering whether
> > msi-x would be better since then you can just use
> > a fixed vector number without playing tricks like
> > you have to with msi.
> > 
> 
> Sure, thanks for the pointers!
> I suppose I can change later to msi-x in a follow up patch
> to avoid introducing new bugs from the beginning :)
> 
> Thanks,
> Marcel

If I'm right and msix will be less code, that would be a
strage approach imho. But you decide.

> > > > > Marcel Apfelbaum (3):
> > > > >   hw/pcie: Introduce a base class for PCI Express Root Ports
> > > > >   hw/ioh3420: derive from PCI Express Root Port base class
> > > > >   hw/pcie: Introduce Generic PCI Express Root Port
> > > > > 
> > > > >  default-configs/arm-softmmu.mak    |   1 +
> > > > >  default-configs/i386-softmmu.mak   |   1 +
> > > > >  default-configs/x86_64-softmmu.mak |   1 +
> > > > >  hw/pci-bridge/Makefile.objs        |   1 +
> > > > >  hw/pci-bridge/ioh3420.c            | 152 ++-----------------------
> > > > >  hw/pci-bridge/pcie_root_port.c     | 228 +++++++++++++++++++++++++++++++++++++
> > > > >  include/hw/pci/pci.h               |   1 +
> > > > >  include/hw/pci/pcie_port.h         |  18 +++
> > > > >  8 files changed, 258 insertions(+), 145 deletions(-)
> > > > >  create mode 100644 hw/pci-bridge/pcie_root_port.c
> > > > > 
> > > > > --
> > > > > 2.5.5
