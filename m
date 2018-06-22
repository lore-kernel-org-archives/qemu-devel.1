Received: from eggs.gnu.org ([2001:4830:134:3::10]:48816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fWNSE-0006xn-OW
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fWNS9-0000EG-OI
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:54:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fWNS7-0000DF-JQ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:54:21 -0400
References: <c7c8dfc5-d7b3-a22e-586c-4436214c7b9f@redhat.com>
	<20180622161158.3a88c371@redhat.com>
	<cbb7f70c-20ff-324b-e286-ec881db00925@redhat.com>
	<20180622144346.GC2415@work-vm>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3893fc0d-c49f-d75f-dadb-9b9a00103a4a@redhat.com>
Date: Fri, 22 Jun 2018 16:54:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180622144346.GC2415@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Question] inconsistent memory amount statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Eugene Crosser <evgenii.cherkashin@profitbricks.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 22.06.2018 16:43, Dr. David Alan Gilbert wrote:
> * David Hildenbrand (david@redhat.com) wrote:
>> On 22.06.2018 16:11, Igor Mammedov wrote:
>>> On Fri, 22 Jun 2018 09:41:15 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> Starting qemu with and querying some outputs:
>>>>
>>>> [...]
>>>> -m 4G,maxmem=3D20G,slots=3D2 \
>>>> -numa node,nodeid=3D0,cpus=3D0-1 -numa node,nodeid=3D1,cpus=3D2-3 \
>>>> [...]
>>>> -device virtio-balloon \
>>>> -object memory-backend-ram,id=3Dmem0,size=3D8G \
>>>> -device pc-dimm,id=3Ddimm0,memdev=3Dmem0 \
>>>> -object memory-backend-ram,id=3Dmem1,size=3D8G \
>>>> -device nvdimm,id=3Ddimm1,memdev=3Dmem1,node=3D1
>>>>
>>>> (qemu) info numa
>>>> info numa
>>>> 2 nodes
>>>> node 0 cpus: 0 1
>>>> node 0 size: 10240 MB
>>>> node 0 plugged: 0 MB
>>>> node 1 cpus: 2 3
>>>> node 1 size: 10240 MB
>>>> node 1 plugged: 0 MB
>>>>
>>>>
>>>> (qemu) info memory_size_summary
>>>> info memory_size_summary
>>>> base memory: 4294967296
>>>> plugged memory: 17179869184
>>>>
>>>> (qemu) info memory-devices
>>>> info memory-devices
>>>> Memory device [dimm]: "dimm0"
>>>>   addr: 0x140000000
>>>>   slot: 0
>>>>   node: 0
>>>>   size: 8589934592
>>>>   memdev: /objects/mem0
>>>>   hotplugged: false
>>>>   hotpluggable: true
>>>> Memory device [nvdimm]: "dimm1"
>>>>   addr: 0x340000000
>>>>   slot: 1
>>>>   node: 1
>>>>   size: 8589934592
>>>>   memdev: /objects/mem1
>>>>   hotplugged: false
>>>>   hotpluggable: true
>>>>
>>>>
>>>> (qemu) info balloon
>>>> info balloon
>>>> balloon: actual=3D12288
>>>>
>>>>
>>>> 1. "info numa"
>>>> - considers both, pc-dimm and nvdimm
>>>> - "-device ..." are considered as "!plugged" although it could be
>>>>   theoretically "unplugged"
>>> I'd think that this part is broken there should be no difference
>>> -device vs device_add here (the only difference here is cold/hot-plug=
ged).
>>
>> I agree, it is "coldplugged" and should therefore be considered as
>> "plugged". I'll prepare a patch, then we can discuss.
>>
>>>
>>>> - device_add devices are considered as "plugged"
>>> =20
>>>>
>>>> 2. "info memory_size_summary"
>>>> - considers both, pc-dimm and nvdimm
>>>> - "-device ..." are considered as "plugged"
>>>> - device_add devices are considered as "plugged"
>>>>
>>>> 3. "info balloon"
>>>> - does not consider nvdimm devices to calculate "actual"
>>>> -- actual =3D get_current_ram_size() - inflated
>>>> -- get_current_ram_size() does not consider nvdimm
>>>>
>>>> So we have some inconsistency in regards of
>>>> 1. What is considered memory and what not (pc-dimm vs nvdimm)
>>>> 2. What is considered plugged memory (-device vs. device_add)
>>>>
>>>>
>>>> Is this what we expect? I think we should make up our mind
>>>>
>>>> a) what "plugged" means
>>>> b) which stats should consider "nvdimm" and which not.
>>>>
>>>> I would have guessed that "nvdimms" might be memory devices but shou=
ld
>>>> never count towards memory statistics ("not actually ram" - they mig=
ht
>>>> be OK).
>>> well, it depends.=20
>>> nvdimm might be actually battery powered RAM with nvram backend.
>>
>> I agree that it depends. So I wonder if virtio-balloon should be fixed
>> too, to consider nvdimms. (the complete balloon interface is broken, o=
ne
>> does not specify how much memory to inflate/deflate, but how much memo=
ry
>> the guest should have. One of the reasons why I dislike global balloon
>> drivers. They don't play nicely along with memory devices (that are e.=
g.
>> got hotplugged, or nvdimm). But that is a different story :) ).
>=20
> Balloon and NVDimm feels a bit different; if you're actually holding
> persistent data on the nvdimm you don't want to blow away pages when yo=
u
> want some more RAM to play with on the host.

To continue supporting this broken interface with new memory devices
(what we have to do and suddenly considering NVDIMM might be harmful in
setups) we would have to consider for the balloon "all devices that are
usually used as RAM and not as storage medium".

So e.g. virtio-mem would have to be considered, and virtio-pmem not. The
problem is that we are making assumptions on "how the guest will be
using this memory".

So I agree that for compatibility reasons, we most likely have to keep
it this way.

--=20

Thanks,

David / dhildenb
