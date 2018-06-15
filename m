Received: from eggs.gnu.org ([2001:4830:134:3::10]:49038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fToy9-0007lw-N6
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fToy4-0005H5-L5
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:40:49 -0400
From: David Hildenbrand <david@redhat.com>
References: <20180615112500.19854-1-david@redhat.com>
	<20180615112500.19854-11-david@redhat.com>
	<20180615145303.319140cb@redhat.com>
	<9b855eaf-a823-299f-d95b-cedf8ea664b3@redhat.com>
Message-ID: <5189f0d7-ad4c-b1e1-d0f8-1a4cde8c3300@redhat.com>
Date: Fri, 15 Jun 2018 15:40:41 +0200
MIME-Version: 1.0
In-Reply-To: <9b855eaf-a823-299f-d95b-cedf8ea664b3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/12] nvdimm: convert "label-size" into
 a static property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On 15.06.2018 15:30, David Hildenbrand wrote:
> On 15.06.2018 14:53, Igor Mammedov wrote:
>> On Fri, 15 Jun 2018 13:24:58 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> We don't allow to modify it after realization. So we can simply turn
>>> it into a static property. The value is now validated during realize().
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  hw/mem/nvdimm.c | 53 ++++++++-----------------------------------------
>>>  1 file changed, 8 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
>>> index 7260c9c6b1..d3e8a5bcbb 100644
>>> --- a/hw/mem/nvdimm.c
>>> +++ b/hw/mem/nvdimm.c
>>> @@ -27,50 +27,6 @@
>>>  #include "qapi/visitor.h"
>>>  #include "hw/mem/nvdimm.h"
>>>  
>>> -static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
>>> -                                  void *opaque, Error **errp)
>>> -{
>>> -    NVDIMMDevice *nvdimm = NVDIMM(obj);
>>> -    uint64_t value = nvdimm->label_size;
>>> -
>>> -    visit_type_size(v, name, &value, errp);
>>> -}
>>> -
>>> -static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
>>> -                                  void *opaque, Error **errp)
>>> -{
>>> -    NVDIMMDevice *nvdimm = NVDIMM(obj);
>>> -    Error *local_err = NULL;
>>> -    uint64_t value;
>>> -
>>> -    if (memory_region_size(&nvdimm->nvdimm_mr)) {
>>> -        error_setg(&local_err, "cannot change property value");
>>> -        goto out;
>>> -    }
>>> -
>>> -    visit_type_size(v, name, &value, &local_err);
>>> -    if (local_err) {
>>> -        goto out;
>>> -    }
>>> -    if (value < MIN_NAMESPACE_LABEL_SIZE) {
>>> -        error_setg(&local_err, "Property '%s.%s' (0x%" PRIx64 ") is required"
>>> -                   " at least 0x%lx", object_get_typename(obj),
>>> -                   name, value, MIN_NAMESPACE_LABEL_SIZE);
>>> -        goto out;
>>> -    }
>> doesn't seem right,
>> property setter should throw out error at the time it's set if possible.
>>
>> I'd keep this one check where it is and property dynamic.
>>
>> and fix only access to uninitialized "if (memory_region_size(&nvdimm->nvdimm_mr)) {"
> 
> Do we really want to simulate a static property with 25+ LOC?
> 
> But if you insist, to get this stuff of my list, I will turn the
> 
> if (memory_region_size(&nvdimm->nvdimm_mr)) {
> into a
> if (dev->realized)

or rather a pointer check as you said.

> 
> And allow setting the property to 0, too (which is also broken right now).
> 


-- 

Thanks,

David / dhildenb
