Received: from eggs.gnu.org ([2001:4830:134:3::10]:52616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dR1Rx-0002Xl-Fk
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dR1Rs-0002AB-O4
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:19:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dR1Rs-00028o-Fr
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:19:24 -0400
Date: Fri, 30 Jun 2017 22:19:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170630220942-mutt-send-email-mst@kernel.org>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
	<20170630020622-mutt-send-email-mst@kernel.org>
	<ec616cb6-f693-76c5-5732-ec6ee7840d9c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec616cb6-f693-76c5-5732-ec6ee7840d9c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/6] q35: add acpi pci hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Fri, Jun 30, 2017 at 10:25:05AM +0300, Marcel Apfelbaum wrote:
> On 30/06/2017 2:17, Michael S. Tsirkin wrote:
> > On Fri, Jun 30, 2017 at 12:55:56AM +0300, Aleksandr Bezzubikov wrote:
> > > The series adds hotplug support to legacy PCI buses for Q35 machines.
> > > The ACPI hotplug code is emitted if at least one legacy pci-bridge is present.
> > > 
> > > This series is mostly based on past Marcel's series
> > > https://lists.gnu.org/archive/html/qemu-devel/2016-05/msg05681.html,
> > > but rebased on current master with some minor changes according to current codebase.
> > > 
> > > ACPI code emission approach used in this series can be called "static",
> > > because it checkswhether a bridge exists only at initial DSDT generation moment.
> > > The main goal is to enable AML PCI hotplug-related code to be generated dynamically.
> > > In other words, the bridge plugged in - a new acpi definition block is
> > > loaded (using LoadTable method).
> > > This is necessary for PCIE-PCI bridge hotplugging feature.
> > 
> 
> Hi Michael,
> Thank you for looking into this.
> 
> > I wonder whether we really need ACPI hotplug.
> > Most modern systems are limited to native PCIE.
> > 
> 
> I was under impression that ACPI hotplug will still remain
> for memory/cpu hotplug, but I might be wrong. If this
> is the case (ACPI hotplug is used for other subsystems),
> I don't see why modern system would disable the PCI APCI hoptplug.
> (I am not saying PCIe hotplug is not preferred.)
> 
> And if the modern systems are limited to native PCIe
> we might have a bigger problem since the QEMU default
> x86 machine is PCI based and we don't have PCIe obviously...
> maybe is this the right time to switch to Q35 as the default machine?
> (I am aware it should be a different discussion)
> 
> 
> > I do understand the need to add PCI devices sometimes,
> > but maybe we can find a way to do this with native hotplug.
> > 
> > For example, how about the following approach
> > 
> > 
> > - PCIE downstream port - X - PCIE-to-PCI bridge - PCI device
> > 
> 
> It can be a solution, yes, but then we would limit (seriously)
> the number of PCI devices we can add. It will not be a problem
> if we will continue to keep Q35 for "modern systems" only machine
> and keep PC around as the default machine. However adding full support
> for pci-bridge will allow us to switch to Q35 and use it
> as the default machine (sometime sooner) since it would
> be easier to map older configurations.

Part of the value from where I stand is dropping support for
a large matrix of configurations, without hurting users.
So we maintain piix but add features to q35 only.

Where are these pci devices coming from that you need such a large
number of them?  Part of the issue is things like sound, but these
aren't even always hotpluggable.

> > 
> > By hotplugging the bridge+device combination into a downstream
> > port (point X) we can potentially make devices enumerate
> > properly.
> > 
> 
> It may work, yes, Alexandr will you be willing to try it?
> 
> > This might cause some issues with IO port assignment (uses 4K
> > io port space due to bridge aperture limitations)
> > but maybe we do not need so many legacy PCI devices -
> > people who do can simply use piix.
> > 
> 
> IO port assignment issue can be solved by using non standard
> IO port space, some OSes can actually deal with it (I think),
> however it will not solve the limitation of the number of
> pci devices we can have, since each device (PCIe or not) will be
> under a different bus we will have 256 PCI devices max.
> We can use multi-functions, but then the hot-plug granularity
> goes away.

That's quite a lot. SRIOV systems sometimes go higher because
people expose each VF as a separate device to the guest,
but these almost always
. are pcie
. have no io space

> > 
> > For this to work we need a way to create bridge instance
> > that is invisible to the guest. There is already a
> > way to do this for multifunction devices:
> > 
> > create bridge in function != 0
> > attach device
> > then create a dummy function 0
> > 
> > Inelegant - it would be cleaner to support this for function 0
> > as well - but should allow you to test the idea directly.
> > 
> 
> The benefit of this project is to  make Q35 a "wider" machine
> that would include all prev QEMU devices and will facilitate
> the transition from the pc to q35 machine.

But it's not a given that it's a win. We carry in a bunch of
crappy half-way supported devices. No way to drop them from piix.

> So for the modern systems not supporting PCI ACPI hotplug
> we don't need pci-bridges anyway, but for the older ones
> the ACPI code of the pci-bridge will be loaded into the
> ACPI namespace only if a pci-bridge is actually hot-plugged.
> 
> That being said, if we decide that q35 will be used for
> modern systems only and the pc machine will remain the
> default for the next years, we may try to bundle
> the pci-bridge with the device/s behind it.
> 
> Thanks,
> Marcel

I'm not sure it matters what the default is, but yea.
Let's look at the big picture, yes we can add a PV interface
and support this, but should we?

> > 
> > 
> > > Aleksandr Bezzubikov (6):
> > >    hw/acpi: remove dead acpi code
> > >    hw/acpi: simplify dsdt building code
> > >    hw/acpi: fix pcihp io initialization
> > >    hw/acpi: prepare pci hotplug IO for ich9
> > >    hw/acpi: extend acpi pci hotplug support for pci express
> > >    hw/ich9: enable acpi pci hotplug
> > > 
> > >   hw/acpi/ich9.c         |  31 +++++++++++++
> > >   hw/i386/acpi-build.c   | 116 ++++++++++++++++++++++++-------------------------
> > >   hw/isa/lpc_ich9.c      |  12 +++++
> > >   include/hw/acpi/ich9.h |   4 ++
> > >   include/hw/i386/pc.h   |   7 ++-
> > >   5 files changed, 111 insertions(+), 59 deletions(-)
> > > 
> > > -- 
> > > 2.7.4
