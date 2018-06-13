Received: from eggs.gnu.org ([2001:4830:134:3::10]:40432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT6NH-0006jE-5n
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fT6NE-0000jT-Gr
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:03:47 -0400
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-7-david@redhat.com>
	<20180613145624.3004935c@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bb0b033f-d048-06db-96d1-89085000d792@redhat.com>
Date: Wed, 13 Jun 2018 16:03:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180613145624.3004935c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/11] pc-dimm: don't allow to access
 "size" before the device was realized
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

On 13.06.2018 14:56, Igor Mammedov wrote:
> On Mon, 11 Jun 2018 14:16:50 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> "size" should not be queried before the device was realized. Let' make
>> that explicit.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> It's generic property getter, it should work even before realize is called.

That's the point, as we can see in NVDIMM code , it is *not* a generic
property getter.

> 
> if issues described in 5/11 are properly fixed, this patch won't be needed.
> 
> So drop this patch
> 
> 
>> ---
>>  hw/mem/pc-dimm.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
>> index 86fbcf2d0c..5294734529 100644
>> --- a/hw/mem/pc-dimm.c
>> +++ b/hw/mem/pc-dimm.c
>> @@ -166,6 +166,12 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
>>      PCDIMMDevice *dimm = PC_DIMM(obj);
>>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(obj);
>>  
>> +    if (!DEVICE(obj)->realized) {
>> +        error_setg(errp, "Property \"%s\" not accessible before realized",
>> +                   name);
>> +        return;
>> +    }
>> +
>>      mr = ddc->get_memory_region(dimm, errp);
>>      if (!mr) {
>>          return;
> 


-- 

Thanks,

David / dhildenb
