Received: from eggs.gnu.org ([2001:4830:134:3::10]:49157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef7Zb-0003qT-GL
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef7ZW-0001U0-UR
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:13:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ef7ZQ-0001OG-Qm
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:13:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D0E87822B
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 14:46:41 +0000 (UTC)
References: <1516958370-3955-1-git-send-email-thuth@redhat.com>
	<7b6392e6-6ff7-9f18-9bdf-eb8b27e72117@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64c6c821-f007-16ea-c500-0d0ce48f6bac@redhat.com>
Date: Fri, 26 Jan 2018 08:46:39 -0600
MIME-Version: 1.0
In-Reply-To: <7b6392e6-6ff7-9f18-9bdf-eb8b27e72117@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DZldGosyOUrff3FauoqBl0ae6hc7UAv3w"
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add "Understanding QEMU devices"
 blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DZldGosyOUrff3FauoqBl0ae6hc7UAv3w
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <64c6c821-f007-16ea-c500-0d0ce48f6bac@redhat.com>
Subject: Re: [qemu-web PATCH] Add "Understanding QEMU devices" blog post
References: <1516958370-3955-1-git-send-email-thuth@redhat.com>
 <7b6392e6-6ff7-9f18-9bdf-eb8b27e72117@redhat.com>
In-Reply-To: <7b6392e6-6ff7-9f18-9bdf-eb8b27e72117@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 06:40 AM, Paolo Bonzini wrote:
> On 26/01/2018 10:19, Thomas Huth wrote:
>> Last July, Eric Blake wrote a nice summary for newcomers about what
>> QEMU has to do to emulate devices for the guests. So far, we missed
>> to integrate this somewhere into the QEM web site or wiki, so let's
>> publish this now as a nice blog post for the users.
>=20
> It's very nice!  Some proofreading and corrections follow.

Thanks for digging up my original email, and enhancing it (I guess the
fact that I don't blog very often, and stick to email, means that I rely
on others helping to polish my gems for the masses).

>> +++ b/_posts/2018-01-26-understanding-qemu-devices.md
>> @@ -0,0 +1,139 @@
>> +---
>> +layout: post
>> +title:  "Understanding QEMU devices"
>> +date:   2018-01-26 10:00:00 +0100

That's when you're posting it online, but should it also mention when I
first started these thoughts in email form?

>> +author: Eric Blake
>> +categories: blog
>> +---
>> +Here are some notes that may help newcomers understand what is actual=
ly
>> +happening with QEMU devices:
>> +
>> +With QEMU, one thing to remember is that we are trying to emulate wha=
t
>> +an OS would see on bare-metal hardware.  All bare-metal machines are
>=20
> s/All/Most/ (s390 anyone? :))

Also, s/OS/Operating System (OS)/ to make the acronym easier to follow
in the rest of the document.

>=20
>> +basically giant memory maps, where software poking at a particular
>> +address will have a particular side effect (the most common side effe=
ct
>> +is, of course, accessing memory; but other common regions in memory
>> +include the register banks for controlling particular pieces of
>> +hardware, like the hard drive or a network card, or even the CPU
>> +itself).  The end-goal of emulation is to allow a user-space program,=

>> +using only normal memory accesses, to manage all of the side-effects
>> +that a guest OS is expecting.
>> +
>> +As an implementation detail, some hardware, like x86, actually has tw=
o
>> +memory spaces, where I/O space uses different assembly codes than
>> +normal; QEMU has to emulate these alternative accesses.  Similarly, m=
any
>> +modern hardware is so complex that the CPU itself provides both
>> +specialized assembly instructions and a bank of registers within the
>> +memory map (a classic example being the management of the MMU, or
>> +separation between Ring 0 kernel code and Ring 3 userspace code - if
>> +that's not crazy enough, there's nested virtualization).
>=20
> I'd say the interrupt controllers are a better example so:
>=20
> Similarly, many modern CPUs provide themselves a bank of CPU-local
> registers within the memory map, such as for an interrupt controller.

Is it still worth a mention of nested virtualization?

>=20
> And then a paragraph break.
>=20
>> +With certain
>> +hardware, we have virtualization hooks where the CPU itself makes it
>> +easy to trap on just the problematic assembly instructions (those tha=
t
>> +access I/O space or CPU internal registers, and therefore require sid=
e
>> +effects different than a normal memory access), so that the guest jus=
t
>> +executes the same assembly sequence as on bare metal, but that execut=
ion
>> +then causes a trap to let user-space QEMU then react to the instructi=
ons
>> +using just its normal user-space memory accesses before returning
>> +control to the guest.  This is the kvm accelerator, and can let a gue=
st
>=20
> This is supported in QEMU through "accelerators" such as KVM.

Yeah, when I first wrote the email, we didn't have as many accelerators
in qemu.git :)

>=20
>> +run nearly as fast as bare metal, where the slowdowns are caused by e=
ach
>> +trap from guest back to QEMU (a vmexit) to handle a difficult assembl=
y
>> +instruction or memory address.  QEMU also supports a TCG accelerator,=

>=20
> QEMU also supports other virtualizing accelerators (such as
> [HAXM](https://www.qemu.org/2017/11/22/haxm-usage-windows/) or macOS's
> Hypervisor.framework) and also TCG,
>=20
>> +which takes the guest assembly instructions and compiles it on the fl=
y
>> +into comparable host instructions or calls to host helper routines (n=
ot
>> +as fast, but results in QEMU being able to do cross-hardware emulatio=
n).
>=20
> While not as fast, TCG is able to do cross-hardware emulation, such as
> running ARM code on x86. (Removing the parentheses)
>=20
>> +The next thing to realize is what is happening when an OS is accessin=
g
>> +various hardware resources.  For example, most OS ship with a driver
>=20
> most operating systems
>=20
>> +that knows how to manage an IDE disk - the driver is merely software
>> +that is programmed to make specific I/O requests to a specific subset=
 of
>> +the memory map (wherever the IDE bus lives, as hard-coded by the
>> +hardware board designers),
>=20
> (wherever the IDE bus lives, which is specific the hardware board).

specific to the

>=20
>  in order to make the disk drive hardware then
>> +obey commands to copy data from memory to persistent storage (writing=
 to
>> +disk) or from persistent storage to memory (reading from the disk).
>=20
> When the IDE controller hardware receives those I/O requests it
> communicates with the disk drive hardware, ultimately resulting in data=

> being copied from memory...
>=20
>> +When you first buy bare-metal hardware, your disk is uninitialized; y=
ou
>> +install the OS that uses the driver to make enough bare-metal accesse=
s
>> +to the IDE hardware portion of the memory map to then turn the disk i=
nto
>> +a set of partitions and filesystems on top of those partitions.
>> +
>> +So, how does QEMU emulate this? In the big memory map it provides to =
the
>> +guest, it emulates an IDE disk at the same address as bare-metal woul=
d.
>> +When the guest OS driver issues particular memory writes to the IDE
>> +control registers in order to copy data from memory to persistent
>> +storage, QEMU traps on those writes (whether via kvm hypervisor assis=
t,
>> +or by noticing during TCG translation that the addresses being access=
ed
>> +are special),
>=20
> the accelerator knows that these writes must trap (remove everything in=

> parentheses) and passes them to the QEMU IDE controller _device model_.=

>=20
>  and emulates the same side effects by issuing host
>> +commands to copy the specified guest memory into host storage.
>=20
> The device model parses the I/O requests, then emulates them by issuing=

> host system calls.  The result is that guest memory is copied into host=

> storage.

Works for me.  Thanks for helping clarify my concepts.

>=20
> (New paragraph).
>=20
>>  On the
>> +host side, the easiest way to emulate persistent storage is via treat=
ing
>> +a file in the host filesystem as raw data (a 1:1 mapping of offsets i=
n
>> +the host file to disk offsets being accessed by the guest driver), bu=
t
>> +QEMU actually has the ability to glue together a lot of different hos=
t
>> +formats (raw, qcow2, qed, vhdx, ...) and protocols (file system, bloc=
k
>> +device, NBD, sheepdog, gluster, ...) where any combination of host
>=20
> Can we link NBD, sheepdog and gluster?  Maybe Ceph instead of Sheepdog.=

>=20
>> +format and protocol can serve as the backend that is then tied to the=

>> +QEMU emulation providing the guest device.
>> +
>> +Thus, when you tell QEMU to use a host qcow2 file, the guest does not=

>> +have to know qcow2, but merely has its normal driver make the same
>> +register reads and writes as it would on bare metal, which cause vmex=
its
>> +into QEMU code, then QEMU maps those accesses into reads and writes i=
n
>> +the appropriate offsets of the qcow2 file.  When you first install th=
e
>> +guest, all the guest sees is a blank uninitialized linear disk
>> +(regardless of whether that disk is linear in the host, as in raw
>> +format, or optimized for random access, as in the qcow2 format); it i=
s
>> +up to the guest OS to decide how to partition its view of the hardwar=
e
>> +and install filesystems on top of that, and QEMU does not care what
>> +filesystems the guest is using, only what pattern of raw disk I/O
>> +register control sequences are issued.
>> +
>> +The next thing to realize is that emulating IDE is not always the mos=
t
>> +efficient.  Every time the guest writes to the control registers, it =
has
>> +to go through special handling, and vmexits slow down emulation.  One=

>> +way to speed this up is through paravirtualization, or cooperation
>> +between the guest and host.
>=20
> Replace last sentence with:
>=20
> Of course, different hardware models have different performance
> characteristics when virtualized.  In general, however, what works best=

> for real hardware does not necessarily work best for virtualization and=
,
> until recently, hardware was not designed to operate fast when emulated=

> by software such as QEMU.  Therefore, QEMU includes _paravirtualized_
> devices that _are_ designed specifically for this purpose.
>=20
> The meaning of "paravirtualization" here is slightly different from the=

> original one of "virtualization through cooperation between the guest
> and host".  (Continue with next sentence in the same paragraph).
>=20
>>  The QEMU developers have produced a
>> +specification for a set of hardware registers and the behavior for th=
ose
>> +registers which are designed to result in the minimum number of vmexi=
ts
>> +possible while still accomplishing what a hard disk must do, namely,
>> +transferring data between normal guest memory and persistent storage.=

>> +This specification is called virtio; using it requires installation o=
f a
>> +virtio driver in the guest.  While there is no known hardware that
>=20
> s/there is no known hardware/no physical device exists/
>=20
>> +follows the same register layout as virtio, the concept is the same: =
a
>> +virtio disk behaves like a memory-mapped register bank, where the gue=
st
>> +OS driver then knows what sequence of register commands to write into=

>> +that bank to cause data to be copied in and out of other guest memory=
=2E
>> +Much of the speedups in virtio come by its design - the guest sets as=
ide
>> +a portion of regular memory for the bulk of its command queue, and on=
ly
>> +has to kick a single register to then tell QEMU to read the command
>> +queue (fewer mapped register accesses mean fewer vmexits), coupled wi=
th
>> +handshaking guarantees that the guest driver won't be changing the
>> +normal memory while QEMU is acting on it.
>=20
> Maybe add a short paragraph here like:
>=20
> As an aside, just like recent hardware is fairly efficient to emulate,
> virtio is evolving to be also efficient to implement in hardware, of
> course without sacrificing performance for emulation or virtualization.=

> Therefore, in the future you could stumble upon physical virtio devices=

> as well.
>=20
>> +In a similar vein, many OS have support for a number of network cards=
, a
>> +common example being the e1000 card on the PCI bus.  On bare metal, a=
n
>> +OS will probe PCI space, see that a bank of registers with the signat=
ure
>> +for e1000 is populated, and load the driver that then knows what
>> +register sequences to write in order to let the hardware card transfe=
r
>> +network traffic in and out of the guest.  So QEMU has, as one of its
>> +many network card emulations, an e1000 device, which is mapped to the=

>> +same guest memory region as a real one would live on bare metal.  And=

>> +once again, the e1000 register layout tends to require a lot of regis=
ter
>> +writes (and thus vmexits) for the amount of work the hardware perform=
s,
>> +so the QEMU developers have added the virtio-net card (a PCI hardware=

>> +specification, although no bare-metal hardware exists that actually
>> +implements it), such that installing a virtio-net driver in the guest=
 OS
>> +can then minimize the number of vmexits while still getting the same
>> +side-effects of sending network traffic.  If you tell QEMU to start a=

>> +guest with a virtio-net card, then the guest OS will probe PCI space =
and
>> +see a bank of registers with the virtio-net signature, and load the
>> +appropriate driver like it would for any other PCI hardware.
>> +
>> +In summary, even though QEMU was first written as a way of emulating
>> +hardware memory maps in order to virtualize a guest OS, it turns out
>> +that the fastest virtualization also depends on virtual hardware: a
>> +memory map of registers with particular documented side effects that =
has
>> +no bare-metal counterpart.  And at the end of the day, all
>> +virtualization really means is running a particular set of assembly
>> +instructions (the guest OS) to manipulate locations within a giant
>> +memory map for causing a particular set of side effects, where QEMU i=
s
>> +just a user-space application providing a memory map and mimicking th=
e
>> +same side effects you would get when executing those guest instructio=
ns
>> +on the appropriate bare metal hardware.
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DZldGosyOUrff3FauoqBl0ae6hc7UAv3w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprP08ACgkQp6FrSiUn
Q2rYKQf/YdksJ7YBc13Jg+bSY7+7lE1lRBjBoneGotFbNl1rLo/IKlp+QtAXxdg6
DIisE49UwWYbKbGid/c2uz9Zjs5PPj7iSfYeEjg4QdvZ54y+1lBXrqp5qnvJjgWj
oBxdYOSjwOjBS4s+XBeCCqWOshe5fsDp22FCfRptxUxcjlHBbWZHg/LsOgnekg9L
doW/Ji6II8jhT/yWG2MGWSYa2268x/6g/j9amLkBkTIK6AtxvkFpS1hKsYMZSarl
RK1F70P8+0ZJdSiS5pbh53hRIY2C72JNCNUzC+NPXUfQzmEla8/g3eF19fAZfcTj
nFJuraKTerW7OfI9w4CPtVpczVAScg==
=4dP1
-----END PGP SIGNATURE-----

--DZldGosyOUrff3FauoqBl0ae6hc7UAv3w--
