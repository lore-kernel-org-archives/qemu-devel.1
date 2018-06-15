Received: from eggs.gnu.org ([2001:4830:134:3::10]:50341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTlLW-0006AU-LL
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTlLT-0005Id-G3
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:48:42 -0400
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-11-david@redhat.com>
	<20180613151056.6ebbccc2@redhat.com>
	<569f9534-162c-29c1-a097-51427e028b4e@redhat.com>
	<20180615113440.56844675@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <abdd97d1-5ffb-9b4b-e667-26b603cff57c@redhat.com>
Date: Fri, 15 Jun 2018 11:48:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180615113440.56844675@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 10/11] pc-dimm: introduce and use
 pc_dimm_memory_pre_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 15.06.2018 11:34, Igor Mammedov wrote:
> On Wed, 13 Jun 2018 16:15:48 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 13.06.2018 15:10, Igor Mammedov wrote:
>>> On Mon, 11 Jun 2018 14:16:54 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>  =20
>>>> We'll be factoring out some pc-dimm specific and some memory-device
>>>> checks next.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  hw/i386/pc.c             | 2 ++
>>>>  hw/mem/pc-dimm.c         | 5 +++++
>>>>  hw/ppc/spapr.c           | 1 +
>>>>  include/hw/mem/pc-dimm.h | 2 ++
>>>>  4 files changed, 10 insertions(+)
>>>>
>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>> index 017396fe84..dc8e7b033b 100644
>>>> --- a/hw/i386/pc.c
>>>> +++ b/hw/i386/pc.c
>>>> @@ -1695,6 +1695,8 @@ static void pc_dimm_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev, =20
>>> keeping                              ^^^^^
>>> similar to newly introduced pc_dimm_memory_pre_plug()
>>> and I have no clue what to suggest as alternative =20
>>
>> Can you elaborate?
>=20
> It's just that pc_dimm_pre_plug and pc_dimm_memory_pre_plug
> are very similar so it become confusing and with name alone
> you can't figure if both do the same or different things.
>=20
> Looking at 11/11 maybe you could just drop this and the next
> patch for now as there isn't obvious (if any) demand for it
> within this series at all.
> And introduce similar patch when it's actually required.
>=20
> I might imagine following naming in future:
>=20
>    pc_dimm_pre_plug()
>        memory_device_pre_plug()
>        ... some pc-dimm only stuff ...
>=20
>    virtio_mem_pre_plug()
>        memory_device_pre_plug()
>        ... some virtio-mem only stuff ...

We will always have the chain

$machine_XXX_pre_plug()
	... some machine specific stuff
	pc_dimm_memory_pre_plug()
		... some pc-dimm specific stuff
		memory_device_pre_plug()

I can rename

pc_dimm_(plug|unplug ...) to
pc_memory_(plug|unplug ...)

and pc_dimm_memory_(plug|unplug ...) to
pc_dimm_(plug|unplug ...)

That way we match spapr naming scheme:

spapr_memory_plug/spapr_memory_unplug

--=20

Thanks,

David / dhildenb
