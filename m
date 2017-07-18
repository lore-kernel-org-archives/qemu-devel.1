Received: from eggs.gnu.org ([2001:4830:134:3::10]:46645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXaI0-0001NC-B8
	for Qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXaHx-0000E6-4w
	for Qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:44:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXaHw-0000DW-Qo
	for Qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:44:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E96F7CB9E
	for <Qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:44:15 +0000 (UTC)
Received: from [10.10.120.160] (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 08BA86031C
	for <Qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:44:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc356364-fde1-bf49-d922-719847f8b152@redhat.com>
Date: Tue, 18 Jul 2017 16:44:13 -0500
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vTh8IbNhmudJJMrwKjEsucO1f2lHOACmi"
Subject: [Qemu-devel] understanding qemu devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vTh8IbNhmudJJMrwKjEsucO1f2lHOACmi
From: Eric Blake <eblake@redhat.com>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>
Message-ID: <bc356364-fde1-bf49-d922-719847f8b152@redhat.com>
Subject: understanding qemu devices
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Based on an IRC conversation today, here's some notes that may help
newcomers understand what is actually happening with qemu devices.  The
initial question was how does a guest mount a qcow2 file (the poster was
wondering if it was a loop or FUSE filesystem) - does it mean the guest
has to understand qcow2?

(Hopefully, someone with more experience with good documentation layouts
and time might be willing to take this and further enhance it into a
nice part of the qemu.org website.)

With qemu, one thing to remember is that we are trying to emulate what
an OS would see on bare-metal hardware.  All bare-metal machines are
basically giant memory maps, where software poking at a particular
address will have a particular side effect (the most common side effect
is, of course, accessing memory; but other common regions in memory
include the register banks for controlling particular pieces of
hardware, like the hard drive or a network card, or even the CPU
itself).  The end-goal of emulation is to allow a user-space program,
using only normal memory accesses, to manage all of the side-effects
that a guest OS is expecting.

As an implementation detail, some hardware, like x86, actually has two
memory spaces, where I/O space uses different assembly codes than
normal; qemu has to emulate these alternative accesses.  Similarly, many
modern hardware is so complex that the CPU itself provides both
specialized assembly instructions and a bank of registers within the
memory map (a classic example being the management of the MMU, or
separation between Ring 0 kernel code and Ring 3 userspace code - if
that's not crazy enough, there's nested virtualization).  With certain
hardware, we have virtualization hooks where the CPU itself makes it
easy to trap on just the problematic assembly instructions (those that
access I/O space or CPU internal registers, and therefore require side
effects different than a normal memory access), so that the guest just
executes the same assembly sequence as on bare metal, but that execution
then causes a trap to let user-space qemu then react to the instructions
using just its normal user-space memory accesses before returning
control to the guest.  This is the kvm accelerator, and can let a guest
run nearly as fast as bare metal, where the slowdowns are caused by each
trap from guest back to qemu (a vmexit) to handle a difficult assembly
instruction or memory address.  Qemu also supports a TCG accelerator,
which takes the guest assembly instructions and compiles it on the fly
into comparable host instructions or calls to host helper routines (not
as fast, but results in qemu being able to do cross-hardware emulation).

The next thing to realize is what is happening when an OS is accessing
various hardware resources.  For example, most OS ship with a driver
that knows how to manage an IDE disk - the driver is merely software
that is programmed to make specific I/O requests to a specific subset of
the memory map (wherever the IDE bus lives, as hard-coded by the
hardware board designers), in order to make the disk drive hardware then
obey commands to copy data from memory to persistent storage (writing to
disk) or from persistent storage to memory (reading from the disk).
When you first buy bare-metal hardware, your disk is uninitialized; you
install the OS that uses the driver to make enough bare-metal accesses
to the IDE hardware portion of the memory map to then turn the disk into
a set of partitions and filesystems on top of those partitions.

So, how does qemu emulate this? In the big memory map it provides to the
guest, it emulates an IDE disk at the same address as bare-metal would.
When the guest OS driver issues particular memory writes to the IDE
control registers in order to copy data from memory to persistent
storage, qemu traps on those writes (whether via kvm hypervisor assist,
or by noticing during TCG translation that the addresses being accessed
are special), and emulates the same side effects by issuing host
commands to copy the specified guest memory into host storage.  On the
host side, the easiest way to emulate persistent storage is via treating
a file in the host filesystem as raw data (a 1:1 mapping of offsets in
the host file to disk offsets being accessed by the guest driver), but
qemu actually has the ability to glue together a lot of different host
formats (raw, qcow2, qed, vhdx, ...) and protocols (file system, block
device, NBD, sheepdog, gluster, ...) where any combination of host
format and protocol can serve as the backend that is then tied to the
qemu emulation providing the guest device.

Thus, when you tell qemu to use a host qcow2 file, the guest does not
have to know qcow2, but merely has its normal driver make the same
register reads and writes as it would on bare metal, which cause vmexits
into qemu code, then qemu maps those accesses into reads and writes in
the appropriate offsets of the qcow2 file.  When you first install the
guest, all the guest sees is a blank uninitialized linear disk
(regardless of whether that disk is linear in the host, as in raw
format, or optimized for random access, as in the qcow2 format); it is
up to the guest OS to decide how to partition its view of the hardware
and install filesystems on top of that, and qemu does not care what
filesystems the guest is using, only what pattern of raw disk I/O
register control sequences are issued.

The next thing to realize is that emulating IDE is not always the most
efficient.  Every time the guest writes to the control registers, it has
to go through special handling, and vmexits slow down emulation.  One
way to speed this up is through paravirtualization, or cooperation
between the guest and host.  The qemu developers have produced a
specification for a set of hardware registers and the behavior for those
registers which are designed to result in the minimum number of vmexits
possible while still accomplishing what a hard disk must do, namely,
transferring data between normal guest memory and persistent storage.
This specification is called virtio; using it requires installation of a
virtio driver in the guest.  While there is no known hardware that
follows the same register layout as virtio, the concept is the same: a
virtio disk behaves like a memory-mapped register bank, where the guest
OS driver then knows what sequence of register commands to write into
that bank to cause data to be copied in and out of other guest memory.
Much of the speedups in virtio come by its design - the guest sets aside
a portion of regular memory for the bulk of its command queue, and only
has to kick a single register to then tell qemu to read the command
queue (fewer mapped register accesses mean fewer vmexits), coupled with
handshaking guarantees that the guest driver won't be changing the
normal memory while qemu is acting on it.

In a similar vein, many OS have support for a number of network cards, a
common example being the e1000 card on the PCI bus.  On bare metal, an
OS will probe PCI space, see that a bank of registers with the signature
for e1000 is populated, and load the driver that then knows what
register sequences to write in order to let the hardware card transfer
network traffic in and out of the guest.  So qemu has, as one of its
many network card emulations, an e1000 device, which is mapped to the
same guest memory region as a real one would live on bare metal.  And
once again, the e1000 register layout tends to require a lot of register
writes (and thus vmexits) for the amount of work the hardware performs,
so the qemu developers have added the virtio-net card (a PCI hardware
specification, although no bare-metal hardware exists that actually
implements it), such that installing a virtio-net driver in the guest OS
can then minimize the number of vmexits while still getting the same
side-effects of sending network traffic.  If you tell qemu to start a
guest with a virtio-net card, then the guest OS will probe PCI space and
see a bank of registers with the virtio-net signature, and load the
appropriate driver like it would for any other PCI hardware.

In summary, even though qemu was first written as a way of emulating
hardware memory maps in order to virtualize a guest OS, it turns out
that the fastest virtualization also depends on virtual hardware: a
memory map of registers with particular documented side effects that has
no bare-metal counterpart.  And at the end of the day, all
virtualization really means is running a particular set of assembly
instructions (the guest OS) to manipulate locations within a giant
memory map for causing a particular set of side effects, where qemu is
just a user-space application providing a memory map and mimicking the
same side effects you would get when executing those guest instructions
on the appropriate bare metal hardware.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vTh8IbNhmudJJMrwKjEsucO1f2lHOACmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllugS0ACgkQp6FrSiUn
Q2qUaggAhgdOD3cEfOAw5jPJHCpIJnztotpFU8lakm63Zwa9vzP3+CUyoNaLkOyH
SelQV3rEEca93qz47+zIx1g0NszNi/ZOjXDhIC0C04/3ocTYwUCnofmtxZglEmY1
cgA+VAmNYWPK4+eqQtq/Zi+oDHmmo7m7npQCYKi0sAEssLTr8du9XMgr1yiBc3s4
ck5+yu3aVh7Gdclf37MvH5bvyYt86vrNseqVvENaiUXOZOsdbq6iInkEMwF3NvzA
C4I78/ut0VjkXYNLR/tX/wklQutMC/7abrzDnD8F+7CorUDGwVv+sdMJY5WcinmD
f1AJ84XdH0pl/noBB+Ry/i8qiqq6Bg==
=yETA
-----END PGP SIGNATURE-----

--vTh8IbNhmudJJMrwKjEsucO1f2lHOACmi--
