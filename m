Received: from eggs.gnu.org ([2001:4830:134:3::10]:59052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cTQLV-0006Xl-3K
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cTQLR-0002iB-3w
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:46:29 -0500
Received: from thoth.sbs.de ([192.35.17.2]:47294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1cTQLQ-0002hq-Ny
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:46:25 -0500
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<CAJ+F1C+WV7OhxpYb3RgmtRjXU7_kfygr2jh2cawYwZq8MMrJGQ@mail.gmail.com>
	<79bc9757-3ba0-87c3-3502-a25a30e304a3@siemens.com>
	<286AC319A985734F985F78AFA26841F73916DDD2@shsmsx102.ccr.corp.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <58a51a88-967d-bdc7-dc0b-e3e501ecccd3@siemens.com>
Date: Tue, 17 Jan 2017 10:46:17 +0100
MIME-Version: 1.0
In-Reply-To: <286AC319A985734F985F78AFA26841F73916DDD2@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Jailhouse <jailhouse-dev@googlegroups.com>
Cc: Markus Armbruster <armbru@redhat.com>

On 2017-01-17 10:13, Wang, Wei W wrote:
> Hi Jan,
>=20
> On Monday, January 16, 2017 9:10 PM, Jan Kiszka wrote:
>> On 2017-01-16 13:41, Marc-Andr=C3=A9 Lureau wrote:
>>> On Mon, Jan 16, 2017 at 12:37 PM Jan Kiszka <jan.kiszka@siemens.com
>>> <mailto:jan.kiszka@siemens.com>> wrote:
>>>     some of you may know that we are using a shared memory device sim=
ilar to
>>>     ivshmem in the partitioning hypervisor Jailhouse [1].
>>>
>>>     We started as being compatible to the original ivshmem that QEMU
>>>     implements, but we quickly deviated in some details, and in the r=
ecent
>>>     months even more. Some of the deviations are related to making th=
e
>>>     implementation simpler. The new ivshmem takes <500 LoC - Jailhous=
e is
>>>     aiming at safety critical systems and, therefore, a small code ba=
se.
>>>     Other changes address deficits in the original design, like missi=
ng
>>>     life-cycle management.
>>>
>>>     Now the question is if there is interest in defining a common new
>>>     revision of this device and maybe also of some protocols used on =
top,
>>>     such as virtual network links. Ideally, this would enable us to s=
hare
>>>     Linux drivers. We will definitely go for upstreaming at least a n=
etwork
>>>     driver such as [2], a UIO driver and maybe also a serial port/con=
sole.
>>>
>>>
>>> This sounds like duplicating efforts done with virtio and vhost-pci.
>>> Have you looked at Wei Wang proposal?
>>
>> I didn't follow it recently, but the original concept was about introd=
ucing an
>> IOMMU model to the picture, and that's complexity-wise a no-go for us =
(we can
>> do this whole thing in less than 500 lines, even virtio itself is more=
 complex). IIUC,
>> the alternative to an IOMMU is mapping the whole frontend VM memory in=
to
>> the backend VM - that's security/safety-wise an absolute no-go.
>=20
> Though the virtio based solution might be complex for you, a big advant=
age is that we have lots of people working to improve virtio. For example=
, the upcoming virtio 1.1 has vring improvement, we can easily upgrade al=
l the virtio based solutions, such as vhost-pci, to take advantage of thi=
s improvement. From the long term perspective, I think this kind of compl=
exity is worthwhile.

We will adopt virtio 1.1 ring formats. That's one reason why there is
also still a bidirectional shared memory region: to host the new
descriptors (while keeping the payload safely in the unidirectional
regions).

>=20
> We further have security features(e.g. vIOMMU) can be applied to vhost-=
pci.

As pointed out, this is way too complex for us. A complete vIOMMU model
would easily add a few thousand lines of code to a hypervisor that tries
to stay below 10k LoC. Each line costs a lot of money when going for
certification. Plus I'm not even sure that there will always be
performance benefits, but that's to be seen when both solutions matured.

>=20
>>>
>>>     Deviations from the original design:
>>>
>>>     - Only two peers per link
>>>
>>>
>>> sound sane, that's also what vhost-pci aims to afaik
>>>
>>>
>>>       This simplifies the implementation and also the interfaces (thi=
nk of
>>>       life-cycle management in a multi-peer environment). Moreover, w=
e do
>>>       not have an urgent use case for multiple peers, thus also not
>>>       reference for a protocol that could be used in such setups. If =
someone
>>>       else happens to share such a protocol, it would be possible to =
discuss
>>>       potential extensions and their implications.
>>>
>>>     - Side-band registers to discover and configure share memory
>>> regions
>>>
>>>       This was one of the first changes: We removed the memory region=
s from
>>>       the PCI BARs and gave them special configuration space register=
s. By
>>>       now, these registers are embedded in a PCI capability. The reas=
ons are
>>>       that Jailhouse does not allow to relocate the regions in guest =
address
>>>       space (but other hypervisors may if they like to) and that we n=
ow have
>>>       up to three of them.
>>>
>>>
>>>  Sorry, I can't comment on that.
>>>
>>>
>>>     - Changed PCI base class code to 0xff (unspecified class)
>>>
>>>       This allows us to define our own sub classes and interfaces. Th=
at is
>>>       now exploited for specifying the shared memory protocol the two
>>>       connected peers should use. It also allows the Linux drivers to=
 match
>>>       on that.
>>>
>>>
>>> Why not, but it worries me that you are going to invent protocols
>>> similar to virtio devices, aren't you?
>>
>> That partly comes with the desire to simplify the transport (pure shar=
ed memory).
>> With ivshmem-net, we are at least reusing virtio rings and will try to=
 do this with
>> the new (and faster) virtio ring format as well.
>>
>>>
>>>
>>>     - INTx interrupts support is back
>>>
>>>       This is needed on target platforms without MSI controllers, i.e.
>>>       without the required guest support. Namely some PCI-less ARM So=
Cs
>>>       required the reintroduction. While doing this, we also took car=
e of
>>>       keeping the MMIO registers free of privileged controls so that =
a
>>>       guest OS can map them safely into a guest userspace application.
>>>
>>>
>>> Right, it's not completely removed from ivshmem qemu upstream,
>>> although it should probably be allowed to setup a doorbell-ivshmem
>>> with msi=3Doff (this may be quite trivial to add back)
>>>
>>>
>>>     And then there are some extensions of the original ivshmem:
>>>
>>>     - Multiple shared memory regions, including unidirectional ones
>>>
>>>       It is now possible to expose up to three different shared memor=
y
>>>       regions: The first one is read/writable for both sides. The sec=
ond
>>>       region is read/writable for the local peer and read-only for th=
e
>>>       remote peer (useful for output queues). And the third is read-o=
nly
>>>       locally but read/writable remotely (ie. for input queues).
>>>       Unidirectional regions prevent that the receiver of some data c=
an
>>>       interfere with the sender while it is still building the messag=
e, a
>>>       property that is not only useful for safety critical communicat=
ion,
>>>       we are sure.
>>>
>>>
>>> Sounds like a good idea, and something we may want in virtio too
>=20
> Can you please explain more about the process of transferring a packet =
using the three different memory regions?
> In the kernel implementation, the sk_buf can be allocated anywhere.

With shared memory-backed communication, you obviously will have to
copy, to and sometimes also from the communication regions. But you no
longer have to flip any mappings (or even give up on secure isolation).

Why we have up to three regions: two unidirectional ones for payload,
one for shared control structures or custom protocols. See also above.

>=20
> Btw, this looks similar to the memory access protection mechanism using=
 EPTP switching:
> Slide 25 http://www.linux-kvm.org/images/8/87/02x09-Aspen-Jun_Nakajima-=
KVM_as_the_NFV_Hypervisor.pdf
> This missed right side of the figure is an alternative EPT, which gives=
 a full access permission to the small piece of security code.

EPTP might be some nice optimization for scenarios where you have to
switch (but are its security problems resolved by now?), but a) we can
avoid switching and b) it's Intel-only while we need a generic solution
for all archs.

>=20
>>>
>>>
>>>     - Life-cycle management via local and remote state
>>>
>>>       Each device can now signal its own state in form of a value to =
the
>>>       remote side, which triggers an event there. Moreover, state cha=
nges
>>>       done by the hypervisor to one peer are signalled to the other s=
ide.
>>>       And we introduced a write-to-shared-memory mechanism for the
>>>       respective remote state so that guests do not have to issue an =
MMIO
>>>       access in order to check the state.
>>>
>>>
>>> There is also ongoing work to better support disconnect/reconnect in
>>> virtio.
>>>
>>>
>>>
>>>     So, this is our proposal. Would be great to hear some opinions if=
 you
>>>     see value in adding support for such an "ivshmem 2.0" device to Q=
EMU as
>>>     well and expand its ecosystem towards Linux upstream, maybe also =
DPDK
>>>     again. If you see problems in the new design /wrt what QEMU provi=
des so
>>>     far with its ivshmem device, let's discuss how to resolve them. L=
ooking
>>>     forward to any feedback!
>>>
>>>
>>> My feeling is that ivshmem is not being actively developped in qemu,
>>> but rather virtio-based solutions (vhost-pci for vm2vm).
>>
>> As pointed out, for us it's most important to keep the design simple -=
 even at the
>> price of "reinventing" some drivers for upstream (at least, we do not =
need two
>> sets of drivers because our interface is fully symmetric). I don't see=
 yet how
>> vhost-pci could achieve the same, but I'm open to learn more!
>=20
> Maybe I didn=E2=80=99t fully understand this - "we do not need two sets=
 of drivers because our interface is fully symmetric"?

We have no backend/frontend drivers. While vhost-pci can reuse virtio
frontend drivers, it still requires new backend drivers. We use the same
drivers on both sides - it's just symmetric. That also simplifies
arguing over non-interference because both sides have equal capabilities.

>=20
> The vhost-pci driver is a standalone network driver from the local gues=
t point of view - it's no different than any other network drivers in the=
 guest. When talking about usage,  it's used together with another VM's v=
irtio device - would this be the "two sets of drivers" that you meant? I =
think this is pretty nature and reasonable, as it is essentially a vm-to-=
vm communication. Furthermore, we are able to dynamically create/destroy =
and hot-plug in/out a vhost-pci device based on runtime requests.=20

Hotplugging works with shared memory devices as well. We don't use it
during runtime of the hypervisor due to safety constraints, but devices
show up and disappear in the root cell (the primary Linux) as the
hypervisor starts or stops.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
