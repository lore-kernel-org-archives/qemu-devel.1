Received: from eggs.gnu.org ([2001:4830:134:3::10]:52395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g87Ml-0006MV-4k
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g87Mh-0007xh-5v
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:24:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1g87Mg-0007wd-TD
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 13:24:43 -0400
Date: Thu, 4 Oct 2018 13:24:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181004132112-mutt-send-email-mst@kernel.org>
References: <CAEJ3UntstF2hsn11MrcoMqb7_JMOxs9GRiALF==S6o2aMpAAeg@mail.gmail.com>
	<20181004135721.0223f3dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004135721.0223f3dc@redhat.com>
Subject: Re: [Qemu-devel] ACPI PCI hotplug table updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: open sorcerer <0p3n.s0rc3r3r@gmail.com>, qemu-devel@nongnu.org

On Thu, Oct 04, 2018 at 01:57:21PM +0200, Igor Mammedov wrote:
> On Wed, 3 Oct 2018 10:44:20 -0700
> open sorcerer <0p3n.s0rc3r3r@gmail.com> wrote:
> 
> > Hi,
> > 
> > I am digging into an issue where qmp_device_del does not actually delete
> > devices when a guest OS is in prelaunch. This seems to be due to the guest
> > OS not handling ACPI events because it is not currently running. If I
> > assume correctly, qmp should allow you to add/remove devices while the host
> > is down, or if not possible, publish an error message.
> may I ask why one would delete a device at -S pause point, isn't it easier
> to start QEMU without it, to begin with?
> 
> > I think fixing this issue is as simple as making sure that the VM is in a
> > safe state to ignore the hotplug ACPI dance but eject the disk, something
> > like:
> in prelaunch runstate where '-S' option pauses VM, it is practically paused
> at the first instruction to be executed. So device_add at that point is
> considered as hotplug with all actions already executed on hardware level
> (interrupts sent, devices responsible for hotplug handling has changed state).
> So if one wished to delete device at that point, one would have to rollback
> related state changes.
> If one would additionally use -incoming CLI option, it becomes more complicated
> as we might endup in prelaunch runstate with VM in running state
> (see possible transitions in runstate_transitions_def[])
> I'd say prelauch runstate can't be used for removing devices that do not
> support surprise removal (in our case PCI isn't).

I'd say the point is this. In prelaunch guest did not observe any
device state yet, we could make device_add look just like
a non-hotplugged device. And we could make device_del pretend
there was a reset immediately afterwards.

Not sure why it matters to anyone, but it's doable I think.



> > prelaunch, preconfig, shutdown: ignore acpi and deal with cleaning devices
> > other non-running: bubble up error
> > running: default behavior
> > 
> > I was trying to validate that this change would be safe (keep in mind I am
> > learning ACPI in little pieces while digging) using GDB, and code
> > inspection. While stepping through with GDB i noticed that the PCI slots
> > are controlled by memory region and the opaque acpi pci hp state object. I
> > was unable this far to find any code executed that modifies the ACPI tables
> > beyond just the pci hotplug state.
> > 
> > I also tried to test using "while true; do acpidump | md5; sleep 1; done"
> > in the guest OS and then add/remove a virtio-blk-pci device (which
> > exercised the ACPI callbacks via piix4 callbacks). The output of the
> > acpidump -> md5 was consistent during each phase of the data collection
> > which I believe implied that the acpi tables were not modified by the PCI
> > hotplug.
> > 
> > Can someone help me understand:
> > 
> > 1. Are the ACPI tables not modified when doing PCI hotplug?
> > 2. Do the general changes proposed seem safe?
> > 3. Are there resources or documentation I can read to help me understand
> > this problem further? I have skimmed through alot of different documents
> > and watched some youtube videos, but the ACPI documentation is hard to read
> > and sift through and the youtube videos are generally too high level.
> Regarding ACPI based PCI hotplug you can look at
>   docs/specs/acpi_pci_hotplug.txt
>   hw/acpi/pcihp.c
>   ACPI AML part in build_append_pci_bus_devices()
> 
> > 
> > Thanks.
