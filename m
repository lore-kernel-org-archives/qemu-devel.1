Received: from eggs.gnu.org ([2001:4830:134:3::10]:43903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cUcCI-0006bD-Nm
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cUcCF-00007M-El
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:37:54 -0500
Received: from david.siemens.de ([192.35.17.14]:52825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1cUcCF-0008Va-3a
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:37:51 -0500
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<CAJ+F1C+WV7OhxpYb3RgmtRjXU7_kfygr2jh2cawYwZq8MMrJGQ@mail.gmail.com>
	<79bc9757-3ba0-87c3-3502-a25a30e304a3@siemens.com>
	<286AC319A985734F985F78AFA26841F73916DDD2@shsmsx102.ccr.corp.intel.com>
	<58a51a88-967d-bdc7-dc0b-e3e501ecccd3@siemens.com>
	<286AC319A985734F985F78AFA26841F7391716D9@shsmsx102.ccr.corp.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <778e7730-8ece-9cc4-000c-9ced0b29d503@siemens.com>
Date: Fri, 20 Jan 2017 17:37:40 +0100
MIME-Version: 1.0
In-Reply-To: <286AC319A985734F985F78AFA26841F7391716D9@shsmsx102.ccr.corp.intel.com>
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

On 2017-01-20 12:54, Wang, Wei W wrote:
> On Tuesday, January 17, 2017 5:46 PM, Jan Kiszka wrote:
>> On 2017-01-17 10:13, Wang, Wei W wrote:
>>> Hi Jan,
>>>
>>> On Monday, January 16, 2017 9:10 PM, Jan Kiszka wrote:
>>>> On 2017-01-16 13:41, Marc-Andr=C3=A9 Lureau wrote:
>>>>> On Mon, Jan 16, 2017 at 12:37 PM Jan Kiszka <jan.kiszka@siemens.com
>>>>> <mailto:jan.kiszka@siemens.com>> wrote:
>>>>>     some of you may know that we are using a shared memory device s=
imilar
>> to
>>>>>     ivshmem in the partitioning hypervisor Jailhouse [1].
>>>>>
>>>>>     We started as being compatible to the original ivshmem that QEM=
U
>>>>>     implements, but we quickly deviated in some details, and in the=
 recent
>>>>>     months even more. Some of the deviations are related to making =
the
>>>>>     implementation simpler. The new ivshmem takes <500 LoC - Jailho=
use is
>>>>>     aiming at safety critical systems and, therefore, a small code =
base.
>>>>>     Other changes address deficits in the original design, like mis=
sing
>>>>>     life-cycle management.
>>>>>
>>>>>     Now the question is if there is interest in defining a common n=
ew
>>>>>     revision of this device and maybe also of some protocols used o=
n top,
>>>>>     such as virtual network links. Ideally, this would enable us to=
 share
>>>>>     Linux drivers. We will definitely go for upstreaming at least a=
 network
>>>>>     driver such as [2], a UIO driver and maybe also a serial port/c=
onsole.
>>>>>
>>>>>
>>>>> This sounds like duplicating efforts done with virtio and vhost-pci.
>>>>> Have you looked at Wei Wang proposal?
>>>>
>>>> I didn't follow it recently, but the original concept was about
>>>> introducing an IOMMU model to the picture, and that's complexity-wis=
e
>>>> a no-go for us (we can do this whole thing in less than 500 lines,
>>>> even virtio itself is more complex). IIUC, the alternative to an
>>>> IOMMU is mapping the whole frontend VM memory into the backend VM -
>> that's security/safety-wise an absolute no-go.
>>>
>>> Though the virtio based solution might be complex for you, a big adva=
ntage is
>> that we have lots of people working to improve virtio. For example, th=
e
>> upcoming virtio 1.1 has vring improvement, we can easily upgrade all t=
he virtio
>> based solutions, such as vhost-pci, to take advantage of this improvem=
ent. From
>> the long term perspective, I think this kind of complexity is worthwhi=
le.
>>
>> We will adopt virtio 1.1 ring formats. That's one reason why there is =
also still a
>> bidirectional shared memory region: to host the new descriptors (while=
 keeping
>> the payload safely in the unidirectional regions).
>=20
> The vring example I gave might be confusing, sorry about  that. My poin=
t is that every part of virtio is getting matured and improved from time =
to time.  Personally, having a new device developed and maintained in an =
active and popular model is helpful. Also, as new features being graduall=
y added in the future, a simple device could become complex.=20

We can't afford becoming more complex, that is the whole point.
Complexity shall go into the guest, not the hypervisor, when it is
really needed.

>=20
> Having a theoretical analysis on the performance:=20
> The traditional shared memory mechanism, sharing an intermediate memory=
, requires 2 copies to get the packet transmitted. It's not just one more=
 copy compared to the 1-copy solution, I think some more things we may ne=
ed to take into account:

1-copy (+potential transfers to userspace, but that's the same for
everyone) is conceptually possible, definitely under stacks like DPDK.
However, Linux skbs are currently not prepared for picking up
shmem-backed packets, we already looked into this. Likely addressable,
though.

> 1) there are extra ring operation overhead  on both the sending and rec=
eiving side to access the shared memory (i.e. IVSHMEM);
> 2) extra protocol to use the shared memory;
> 3) the piece of allocated shared memory from the host =3D C(n,2), where=
 n is the number of VMs. Like for 20 VMs who want to talk to each other, =
there will be 190 pieces of memory allocated from the host.=20

Well, only if all VMs need to talk to all others directly. On real
setups, you would add direct links for heavy traffic and otherwise do
software switching. Moreover, those links would only have to be backed
by physical memory in static setups all the time.

Also, we didn't completely rule out a shmem bus with multiple peers
connected. That's just looking for a strong use case - and then a robust
design, of course.

>=20
> That being said, if people really want the 2-copy solution, we can also=
 have vhost-pci support it that way as a new feature (not sure if you wou=
ld be interested in collaborating on the project):
> With the new feature added, the master VM sends only a piece of memory =
(equivalent to IVSHMEM, but allocated by the guest) to the slave over vho=
st-user protocol, and the vhost-pci device on the slave side only hosts t=
hat piece of shared memory.

I'm all in for something that allows to strip down vhost-pci to
something that - while staying secure - is simple and /also/ allows
static configurations. But I'm not yet seeing that this would still be
virtio or vhost-pci.

What would be the minimal viable vhost-pci device set from your POV?
What would have to be provided by the hypervisor for that?

Jan

--=20
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
