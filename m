Received: from eggs.gnu.org ([2001:4830:134:3::10]:35759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g7m1r-0007fA-Ph
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g7m1o-0005K7-Ug
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:37:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1g7m1o-0005J0-Oe
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:37:44 -0400
Date: Wed, 3 Oct 2018 14:37:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181003143448-mutt-send-email-mst@kernel.org>
References: <CAEJ3UntstF2hsn11MrcoMqb7_JMOxs9GRiALF==S6o2aMpAAeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJ3UntstF2hsn11MrcoMqb7_JMOxs9GRiALF==S6o2aMpAAeg@mail.gmail.com>
Subject: Re: [Qemu-devel] ACPI PCI hotplug table updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: open sorcerer <0p3n.s0rc3r3r@gmail.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

On Wed, Oct 03, 2018 at 10:44:20AM -0700, open sorcerer wrote:
> Hi,
> 
> I am digging into an issue where qmp_device_del does not actually delete
> devices when a guest OS is in prelaunch.

What exactly is meant by prelaunch? E.g. is it prelaunch while bios is
doing the pci bus scan?

> This seems to be due to the guest OS
> not handling ACPI events because it is not currently running. If I assume
> correctly, qmp should allow you to add/remove devices while the host is down,
> or if not possible, publish an error message.
> 
> I think fixing this issue is as simple as making sure that the VM is in a safe
> state to ignore the hotplug ACPI dance but eject the disk, something like:
> 
> prelaunch, preconfig, shutdown: ignore acpi and deal with cleaning devices
> other non-running: bubble up error
> running: default behavior
> 
> I was trying to validate that this change would be safe (keep in mind I am
> learning ACPI in little pieces while digging) using GDB, and code inspection.
> While stepping through with GDB i noticed that the PCI slots are controlled by
> memory region and the opaque acpi pci hp state object. I was unable this far to
> find any code executed that modifies the ACPI tables beyond just the pci
> hotplug state.
> 
> I also tried to test using "while true; do acpidump | md5; sleep 1; done" in
> the guest OS and then add/remove a virtio-blk-pci device (which exercised the
> ACPI callbacks via piix4 callbacks). The output of the acpidump -> md5 was
> consistent during each phase of the data collection which I believe implied
> that the acpi tables were not modified by the PCI hotplug.
> 
> Can someone help me understand:
> 
> 1. Are the ACPI tables not modified when doing PCI hotplug?

Yes.

> 2. Do the general changes proposed seem safe?
> 3. Are there resources or documentation I can read to help me understand this
> problem further? I have skimmed through alot of different documents and watched
> some youtube videos, but the ACPI documentation is hard to read and sift
> through and the youtube videos are generally too high level.
> 
> Thanks.
> 

We are generally trying to move away from ACPI hotplug to native
PCIE hotplug. You can read up on that in the pci express spec.

-- 
MST
