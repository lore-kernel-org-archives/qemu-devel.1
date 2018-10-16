Received: from eggs.gnu.org ([2001:4830:134:3::10]:45686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gCQ4g-0001Ra-Tf
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gCQ4f-0001gu-Nh
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:11:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gCQ4f-0001f3-DL
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:11:53 -0400
Message-ID: <4089265c6ef44f79f0dd67d203f69e5bde9b8d85.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 16 Oct 2018 16:11:48 +0200
In-Reply-To: <967af677f4d0b60bfb201f639ade0b0712e09fc8.camel@redhat.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
	<CAKmqyKNTTu+5KyTMBHw5-+UMa7qnm9EaowxHj8NLxED98m1MKw@mail.gmail.com>
	<d9e6d7979143130092b5b96602885c1acaca9b52.camel@redhat.com>
	<CAKmqyKMTzYswJ74WEOQAQrisCdMDQ9Nf6NMEdUKLcUMCN7XLgg@mail.gmail.com>
	<23d9891ec01bec45b16f89ba1412238be39addf9.camel@redhat.com>
	<CAKmqyKMBxY6j3SwvyYsMVCCeAwKinuVE4+2kbAp6YapBWdKZig@mail.gmail.com>
	<967af677f4d0b60bfb201f639ade0b0712e09fc8.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, "Richard W.M. Jones" <rjones@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, stephen@eideticom.com

On Tue, 2018-10-16 at 09:38 +0200, Andrea Bolognani wrote:
> On Mon, 2018-10-15 at 09:59 -0700, Alistair Francis wrote:
> > On Mon, Oct 15, 2018 at 7:39 AM Andrea Bolognani <abologna@redhat.com> wrote:
> > > One more thing that I forgot to bring up earlier: at the same time
> > > as PCIe support is added, we should also make sure that the
> > > pcie-root-port device is built into the qemu-system-riscv* binaries
> > > by default, as that device being missing will cause PCI-enabled
> > > libvirt guests to fail to start.
> > 
> > We are dong that aren't we?
> 
> Doesn't look that way:
> 
>   $ riscv64-softmmu/qemu-system-riscv64 -device help 2>&1 | head -5
>   Controller/Bridge/Hub devices:
>   name "pci-bridge", bus PCI, desc "Standard PCI Bridge"
>   name "pci-bridge-seat", bus PCI, desc "Standard PCI Bridge (multiseat)"
>   name "vfio-pci-igd-lpc-bridge", bus PCI, desc "VFIO dummy ISA/LPC bridge for IGD assignment"
> 
>   $

Okay, I've (slow) cooked myself a BBL with CONFIG_PCI_HOST_GENERIC=y,
a QEMU with CONFIG_PCIE_PORT=y and a libvirt with RISC-V PCI support.

With all of the above in place, I could finally define a mmio-less
guest which... Failed to boot pretty much right away:

  error: Failed to start domain riscv
  error: internal error: process exited while connecting to monitor:
  2018-10-16T13:32:20.713064Z qemu-system-riscv64: -device
  pcie-root-port,port=0x8,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x1:
  MSI-X is not supported by interrupt controller

Well, okay then. As a second attempt, I manually placed all virtio
devices on pcie.0, overriding libvirt's own address assignment
algorithm and getting rid of pcie-root-ports at the same time. Now
the guest will actually start, but soon enough

  OF: PCI: host bridge /pci@2000000000 ranges:
  OF: PCI:   No bus range found for /pci@2000000000, using [bus 00-ff]
  OF: PCI:   MEM 0x40000000..0x5fffffff -> 0x40000000
  pci-host-generic 2000000000.pci: ECAM area [mem 0x2000000000-0x2003ffffff] can only accommodate [bus 00-3f] (reduced from [bus 00-ff] desired)
  pci-host-generic 2000000000.pci: ECAM at [mem 0x2000000000-0x2003ffffff] for [bus 00-3f]
  pci-host-generic 2000000000.pci: PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [bus 00-ff]
  pci_bus 0000:00: root bus resource [mem 0x40000000-0x5fffffff]
  pci 0000:00:02.0: BAR 6: assigned [mem 0x40000000-0x4003ffff pref]
  pci 0000:00:01.0: BAR 4: assigned [mem 0x40040000-0x40043fff 64bit pref]
  pci 0000:00:02.0: BAR 4: assigned [mem 0x40044000-0x40047fff 64bit pref]
  pci 0000:00:03.0: BAR 4: assigned [mem 0x40048000-0x4004bfff 64bit pref]
  pci 0000:00:04.0: BAR 4: assigned [mem 0x4004c000-0x4004ffff 64bit pref]
  pci 0000:00:01.0: BAR 0: no space for [io  size 0x0040]
  pci 0000:00:01.0: BAR 0: failed to assign [io  size 0x0040]
  pci 0000:00:02.0: BAR 0: no space for [io  size 0x0020]
  pci 0000:00:02.0: BAR 0: failed to assign [io  size 0x0020]
  pci 0000:00:03.0: BAR 0: no space for [io  size 0x0020]
  pci 0000:00:03.0: BAR 0: failed to assign [io  size 0x0020]
  pci 0000:00:04.0: BAR 0: no space for [io  size 0x0020]
  pci 0000:00:04.0: BAR 0: failed to assign [io  size 0x0020]
  virtio-pci 0000:00:01.0: enabling device (0000 -> 0002)
  virtio-pci 0000:00:02.0: enabling device (0000 -> 0002)
  virtio-pci 0000:00:03.0: enabling device (0000 -> 0002)
  virtio-pci 0000:00:04.0: enabling device (0000 -> 0002)

will show up on the console and boot will not progress any further.

I tried making only the disk virtio-pci, leaving all other devices
as virtio-mmio, but that too failed to boot with a similar message
about IO space exaustion. If the network device is the only one
using virtio-pci, though, despite still getting

  pci 0000:00:01.0: BAR 0: no space for [io  size 0x0020]
  pci 0000:00:01.0: BAR 0: failed to assign [io  size 0x0020]

I can get all the way to a prompt, and the device will show up in
the output of lspci:

  00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
	Subsystem: Red Hat, Inc. Device 1100
	Flags: fast devsel
  lspci: Unable to load libkmod resources: error -12

  00:01.0 Ethernet controller: Red Hat, Inc. Virtio network device
	Subsystem: Red Hat, Inc. Device 0001
	Flags: bus master, fast devsel, latency 0, IRQ 1
	I/O ports at <unassigned> [disabled]
	Memory at 40040000 (64-bit, prefetchable) [size=16K]
	[virtual] Expansion ROM at 40000000 [disabled] [size=256K]
	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
	Capabilities: [70] Vendor Specific Information: VirtIO: Notify
	Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
	Capabilities: [50] Vendor Specific Information: VirtIO: ISR
	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
	Kernel driver in use: virtio-pci

So it looks like virtio-pci is not quite usable yet; still, this is
definitely some progress over the status quo! Anyone has any ideas on
how to bridge the gap separating us from a pure virtio-pci RISC-V
guest?

-- 
Andrea Bolognani / Red Hat / Virtualization
