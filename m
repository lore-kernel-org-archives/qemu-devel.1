Received: from eggs.gnu.org ([2001:4830:134:3::10]:43050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVy7x-0007pQ-Ub
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVy7u-0001VU-SS
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:51:50 -0400
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-2-david@redhat.com>
	<574e1e82-79f7-af2a-c590-87f480f369a0@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <777bf001-cd4f-90c3-25d8-d52a6baae9d3@redhat.com>
Date: Thu, 21 Jun 2018 13:51:44 +0200
MIME-Version: 1.0
In-Reply-To: <574e1e82-79f7-af2a-c590-87f480f369a0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/7] s390x/tod: factor out TOD into
 separate device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 21.06.2018 13:15, Thomas Huth wrote:
> On 20.06.2018 12:08, David Hildenbrand wrote:
>> Let's treat this like a separate device. TCG will have to store the
>> actual state/time later on.
>>
>> Include cpu-qom.h in kvm_s390x.h (due to S390CPU) to compile tod-kvm.c.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> [...]
>> +static void s390_tod_class_init(ObjectClass *oc, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>> +
>> +    dc->desc = "TOD (Time Of Day) Clock";
>> +    dc->realize = s390_tod_realize;
>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +
>> +    /* We only have one TOD clock in the system attached to the machine */
>> +    dc->user_creatable = false;
>> +    dc->hotpluggable = false;
>> +}
> 
> IIRC you don't need the hotpluggable = false if you already set
> user_creatable = false.

That makes sense.

> 
>> +static TypeInfo s390_tod_info = {
>> +    .name = TYPE_S390_TOD,
>> +    .parent = TYPE_DEVICE,
>> +    .instance_size = sizeof(S390TODState),
>> +    .class_init = s390_tod_class_init,
>> +    .class_size = sizeof(S390TODClass),
>> +    .abstract = true,
>> +};
>> +
>> +static void register_types(void)
>> +{
>> +    type_register_static(&s390_tod_info);
>> +}
>> +type_init(register_types);
>> diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
>> new file mode 100644
>> index 0000000000..43ed71600f
>> --- /dev/null
>> +++ b/include/hw/s390x/tod.h
>> @@ -0,0 +1,46 @@
>> +/*
>> + * TOD (Time Of Day) clock
>> + *
>> + * Copyright 2018 Red Hat, Inc.
>> + * Author(s): David Hildenbrand <david@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef HW_S390_TOD_H
>> +#define HW_S390_TOD_H
>> +
>> +#include "hw/qdev.h"
>> +
>> +typedef struct S390TOD {
>> +    uint8_t high;
>> +    uint64_t low;
>> +} S390TOD;
>> +
>> +#define TYPE_S390_TOD "s390-tod"
>> +#define S390_TOD(obj) OBJECT_CHECK(S390TODState, (obj), TYPE_S390_TOD)
>> +#define S390_TOD_CLASS(oc) OBJECT_CLASS_CHECK(S390TODClass, (oc), \
>> +                                              TYPE_S390_TOD)
>> +#define S390_TOD_GET_CLASS(obj) OBJECT_GET_CLASS(S390TODClass, (obj), \
>> +                                                 TYPE_S390_TOD)
>> +#define TYPE_KVM_S390_TOD "kvm-" TYPE_S390_TOD
>> +#define TYPE_QEMU_S390_TOD "qemu-" TYPE_S390_TOD
> 
> I'd prefer if you could turn that into suffixes instead of prefixes,
> like it is done in include/hw/s390x/storage-keys.h and
> storage-attributes.h already.
> 
> Apart from that, the patch looks fine to me, so once you've changed
> that, feel free to add:

Sure, will change! Thanks!

> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


-- 

Thanks,

David / dhildenb
