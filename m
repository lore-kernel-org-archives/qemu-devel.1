Received: from eggs.gnu.org ([2001:4830:134:3::10]:43221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT6Z1-000764-0s
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT6Yy-0002h5-5p
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:15:55 -0400
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-11-david@redhat.com>
	<20180613151056.6ebbccc2@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <569f9534-162c-29c1-a097-51427e028b4e@redhat.com>
Date: Wed, 13 Jun 2018 16:15:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180613151056.6ebbccc2@redhat.com>
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

On 13.06.2018 15:10, Igor Mammedov wrote:
> On Mon, 11 Jun 2018 14:16:54 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> We'll be factoring out some pc-dimm specific and some memory-device
>> checks next.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/i386/pc.c             | 2 ++
>>  hw/mem/pc-dimm.c         | 5 +++++
>>  hw/ppc/spapr.c           | 1 +
>>  include/hw/mem/pc-dimm.h | 2 ++
>>  4 files changed, 10 insertions(+)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 017396fe84..dc8e7b033b 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1695,6 +1695,8 @@ static void pc_dimm_pre_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
> keeping                              ^^^^^
> similar to newly introduced pc_dimm_memory_pre_plug()
> and I have no clue what to suggest as alternative

Can you elaborate?

In pc.c we now have:
- static void pc_dimm_plug()
- static void pc_dimm_unplug_request()
- static void pc_dimm_unplug()

And I add
- static void pc_dimm_pre_plug()

I am sticking to the existing naming scheme.

(maybe the problem is that PC_DIMM should never have been named PC_DIMM
but simply DIMM, then the "pc_" prefix would be unique)

>=20
>>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in =
'-M'");
>>          return;
>>      }
>> +
>> +    pc_dimm_memory_pre_plug(dev, MACHINE(hotplug_dev), errp);
>>  }
>> =20
>>  static void pc_dimm_plug(HotplugHandler *hotplug_dev,
>> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
>> index bc79dd04d8..995ce22d8d 100644
>> --- a/hw/mem/pc-dimm.c
>> +++ b/hw/mem/pc-dimm.c
>> @@ -27,6 +27,11 @@
>>  #include "sysemu/numa.h"
>>  #include "trace.h"
>> =20
>> +void pc_dimm_memory_pre_plug(DeviceState *dev, MachineState *machine,
>> +                             Error **errp)
>> +{
>> +}
> why introducing shim without anything?

Because you requested for review to split things up :)

I can easily squash this.

> I'd just merge it with following patch and clarify (in commit message)
> why the rest of pre_plug code isn't moved here as well.


--=20

Thanks,

David / dhildenb
