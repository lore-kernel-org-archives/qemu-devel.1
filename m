Received: from eggs.gnu.org ([2001:4830:134:3::10]:38719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cT2mi-0000fB-Fq
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cT2me-0007fo-GQ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:37:00 -0500
Received: from thoth.sbs.de ([192.35.17.2]:56154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1cT2me-0007f8-37
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:36:56 -0500
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
Date: Mon, 16 Jan 2017 09:36:51 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------7426C019493C3F6254E3C733"
Subject: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Jailhouse <jailhouse-dev@googlegroups.com>

This is a multi-part message in MIME format.
--------------7426C019493C3F6254E3C733
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hi,

some of you may know that we are using a shared memory device similar to
ivshmem in the partitioning hypervisor Jailhouse [1].

We started as being compatible to the original ivshmem that QEMU
implements, but we quickly deviated in some details, and in the recent
months even more. Some of the deviations are related to making the
implementation simpler. The new ivshmem takes <500 LoC - Jailhouse is
aiming at safety critical systems and, therefore, a small code base.
Other changes address deficits in the original design, like missing
life-cycle management.

Now the question is if there is interest in defining a common new
revision of this device and maybe also of some protocols used on top,
such as virtual network links. Ideally, this would enable us to share
Linux drivers. We will definitely go for upstreaming at least a network
driver such as [2], a UIO driver and maybe also a serial port/console.

I've attached a first draft of the specification of our new ivshmem
device. A working implementation can be found in the wip/ivshmem2 branch
of Jailhouse [3], the corresponding ivshmem-net driver in [4].

Deviations from the original design:

- Only two peers per link

  This simplifies the implementation and also the interfaces (think of
  life-cycle management in a multi-peer environment). Moreover, we do
  not have an urgent use case for multiple peers, thus also not
  reference for a protocol that could be used in such setups. If someone
  else happens to share such a protocol, it would be possible to discuss
  potential extensions and their implications.

- Side-band registers to discover and configure share memory regions

  This was one of the first changes: We removed the memory regions from
  the PCI BARs and gave them special configuration space registers. By
  now, these registers are embedded in a PCI capability. The reasons are
  that Jailhouse does not allow to relocate the regions in guest address
  space (but other hypervisors may if they like to) and that we now have
  up to three of them.

- Changed PCI base class code to 0xff (unspecified class)

  This allows us to define our own sub classes and interfaces. That is
  now exploited for specifying the shared memory protocol the two
  connected peers should use. It also allows the Linux drivers to match
  on that.

- INTx interrupts support is back

  This is needed on target platforms without MSI controllers, i.e.
  without the required guest support. Namely some PCI-less ARM SoCs
  required the reintroduction. While doing this, we also took care of
  keeping the MMIO registers free of privileged controls so that a
  guest OS can map them safely into a guest userspace application.

And then there are some extensions of the original ivshmem:

- Multiple shared memory regions, including unidirectional ones

  It is now possible to expose up to three different shared memory
  regions: The first one is read/writable for both sides. The second
  region is read/writable for the local peer and read-only for the
  remote peer (useful for output queues). And the third is read-only
  locally but read/writable remotely (ie. for input queues).
  Unidirectional regions prevent that the receiver of some data can
  interfere with the sender while it is still building the message, a
  property that is not only useful for safety critical communication,
  we are sure.

- Life-cycle management via local and remote state

  Each device can now signal its own state in form of a value to the
  remote side, which triggers an event there. Moreover, state changes
  done by the hypervisor to one peer are signalled to the other side.
  And we introduced a write-to-shared-memory mechanism for the
  respective remote state so that guests do not have to issue an MMIO
  access in order to check the state.

So, this is our proposal. Would be great to hear some opinions if you
see value in adding support for such an "ivshmem 2.0" device to QEMU as
well and expand its ecosystem towards Linux upstream, maybe also DPDK
again. If you see problems in the new design /wrt what QEMU provides so
far with its ivshmem device, let's discuss how to resolve them. Looking
forward to any feedback!

Jan

[1] https://github.com/siemens/jailhouse
[2]
http://git.kiszka.org/?p=linux.git;a=blob;f=drivers/net/ivshmem-net.c;h=0e770ca293a4aca14a55ac0e66871b09c82647af;hb=refs/heads/queues/jailhouse
[3] https://github.com/siemens/jailhouse/commits/wip/ivshmem2
[4]
http://git.kiszka.org/?p=linux.git;a=shortlog;h=refs/heads/queues/jailhouse-ivshmem2

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

--------------7426C019493C3F6254E3C733
Content-Type: text/markdown;
 name="ivshmem-v2-specification.md"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ivshmem-v2-specification.md"

IVSHMEM Device Specification
============================

The Inter-VM Shared Memory device provides the following features to its users:

- Interconnection between two peers

- Up to three shared memory regions per connection

    - one read/writable for both sides

    - two unidirectional, i.e. read/writable for one side and only readable for
      the other

- Event signaling via interrupt to the remote side

- Support for life-cycle management via state value exchange and interrupt
  notification on changes

- Free choice of protocol to be used on top

- Optional protocol type suggestion to both sides

- Unprivileged access to memory-mapped control and status registers feasible

- Discoverable and configurable via standard PCI mechanisms


Provider Model
--------------

In order to provide a consistent link between two peers, two instances of the
IVSHMEM device need to be configured, created and run by the provider according
to the following requirements:

- The instances of the device need to be accessible via PCI programming
  interfaces on both sides.

- If present, the first shared memory region of both devices have to be of the
  same size and have to be backed by the same physical memory.

- If present, the second shared memory region has to be configured to be
  read/writable for the user of the device.

- If present, the third shared memory region has to be configured to be
  read-only for the user of the device.

- If the second shared memory region of one side is present, the third shared
  memory region of the other side needs to be present as well, both regions have
  to be of the size, and both have to be backed by the same physical memory.

- Interrupts events triggered by one side have to be delivered to other side,
  provided the receiving side has enabled the delivery.

- State register changes on one side have to be propagated to the other side.

- The value of the suggested protocol type needs to be identical on both sides.


Programming Model
-----------------

An IVSHMEM device appears as a PCI device to its users. Unless otherwise noted,
it conforms to the PCI Local Bus Specification, Revision 3.0 As such, it is
discoverable via the PCI configuration space and provides a number of standard
and custom PCI configuration registers.

### Configuration Space Registers

#### Header Registers

Offset | Register               | Content
------:|:---------------------- |:-------------------------------------------
   00h | Vendor ID              | 1AF4h
   02h | Device ID              | 1110h
   04h | Command Register       | 0000h on reset, implementing bits 1, 2, 10
   06h | Status Register        | 0010h, static value (bit 3 not implemented)
   08h | Revision ID            | 00h
   09h | Class Code, Interface  | Protocol Revision, see [Protocols](#Protocols)
   0Ah | Class Code, Sub-Class  | Protocol Type, see [Protocols](#Protocols)
   0Bh | Class Code, Base Class | FFh
   0Eh | Header Type            | 00h
   10h | BAR 0 (with BAR 1)     | 64-bit MMIO register region
   18h | BAR 2 (with BAR 3)     | 64-bit MSI-X region
   2Ch | Subsystem Vendor ID    | 1AF4h or provider-specifc value
   2Eh | Subsystem ID           | 1110h or provider-specifc value
   34h | Capability Pointer     | First capability
   3Eh | Interrupt Pin          | 01h-04h, may be 00h if MSI-X is available

Other header registers may not be implemented. If not implemented, they return 0
on read and ignore write accesses.

#### Vendor Specific Capability (ID 09h)

Offset | Register         | Content
------:|:---------------- |:-------------------------------------------------
   00h | ID               | 09h
   01h | Next Capability  | Pointer to next capability or 00h
   02h | Length           | 34h
   03h | Flags            | Bit 0: Enable INTx (0 on reset), Bits 1-7: RsvdZ
   04h | Region Address 0 | 64-bit adddress of read-write region 0
   0Ch | Region Size 0    | 64-bit size of region 0
   14h | Region Address 1 | 64-bit adddress of unidirectional output region 1
   1Ch | Region Size 1    | 64-bit size of region 1
   24h | Region Address 2 | 64-bit adddress of unidirectional input region 2
   2Ch | Region Size 2    | 64-bit size of region 2

All registers are read-only, except for bit 0 of the Flags register and the
Region Address registers under certain conditions.

If an IVSHMEM device supports relocatable shared memory regions, Region Address
registers have to be implemented read-writable if the region has a non-zero
size. The reset value of the Region Address registers is 0 in that case. In
order to define the location of a region in the user's address space, bit 1 on
the Command register has to cleared and the desired address has to written to
the Region Address register.

If an IVSHMEM device does not support relocation of its shared memory regions,
the Region Address register have to implemented read-only. Region Address
registers of regions with non-zero size have to be pre-initialized by the
provide to report the location of the region in the user's address space.

An non-existing shared-memory region has to report 0 in both its Region Address
and Region Size registers, and the Region Address register must be implemented
read-only.

#### MSI-X Capability (ID 11h)

On platform support MSI-X, IVSHMEM has to provide interrupt delivery via this
mechanism. In that case, the legacy INTx delivery mechanism may not be
available, and the Interrupt Pin configuration register returns 0.

The IVSHMEM device has no notion of pending interrupts. Therefore, reading from
the MSI-X Pending Bit Array will always return 0.

The corresponding MSI-X MMIO region is configured via BAR 2.
 

### MMIO Register Region

The IVSHMEM device provider has to ensure that the MMIO register region can be
mapped as one page into the address space of the user. Write accesses to region
offsets that are not backed by registers have to be ignored, read accesses have
to return 0. This enables the user to hand out the complete region, along with
the shared memory regions, to an unprivileged instance.

The region location in the user's physical address space is configured via BAR
0. The following table visualizes the region layout:

Offset | Register
------:|:------------------
   00h | ID
   04h | Doorbell
   08h | Local State
   0Ch | Remote State
   10h | Remote State Write

#### ID Register (Offset 00h)

Read-only register that reports the ID of the device, 0 or 1. It is unique for
each of two connected devices and remains unchanged over the lifetime of an
IVSHMEM device.

#### Doorbell Register (Offset 04h)

Write-only register that triggers an interrupt vector in the remote device if it
is enabled there. The vector number is defined by the value written to the
register. Writing an invalid vector number has no effect.

The behavior on reading from this register is undefined.

#### Local State Register (Offset 08h)

Read/write register that defines the state of the local device. Writing to this
register sets the state and triggers interrupt vector 0 on the remote device.
The user of the remote device can read the value written to this register from
the corresponding Remote State Register or from the shared memory address
defined remotely via the Remote State Write Register.

The value of this register after reset is 0.

#### Remote State Register (Offset 0Ch)

Read-only register that reports the current state of the remote device. If the
remote device is currently not present, 0 is returned.

#### Remote State Write Register (Offset 10h)

This registers controls the writing of remote state changes to a shared memory
region at a defined offset. It enables the user to check its peer state without
issuing a more costly MMIO register access.

The remote state is written once when enabling this feature and then on each
state change of the remote device. If the remote device disappears, 0 is
written.

Bits | Content
----:| -----------
   0 | Enable remote state write
   1 | 0: write to region 0, 1: write to region 1
2-63 | Write offset in selected region


Protocols
---------

The IVSHMEM device shall enable both sides of a connection to agree on the protocol used over the shared memory devices. For that purpose, the sub-class byte of the Class Code register (offset 0Ah) of two connected devices encode a protocol type suggestion for the users. The following type values are defined:

Protocol Type | Description
-------------:| ----------------------
          00h | Undefined type
          01h | Virtual Ethernet
          02h | Virtual serial port
      03h-7Fh | Reserved
      80h-FFh | User-defined protocols

The interface byte of the Class Code register (offset 09h) encodes the revision of the protocol, starting with 0 for the first release.

Details of the protocol are not in the scope of this specification.

--------------7426C019493C3F6254E3C733--
