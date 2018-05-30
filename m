Received: from eggs.gnu.org ([2001:4830:134:3::10]:47577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fNtB5-0005Lq-GB
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fNtB2-0003b1-Fa
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:57:39 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:44122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fNtB2-0003ar-5D
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:57:36 -0400
Received: by mail-pf0-x229.google.com with SMTP id q22-v6so8376341pff.11
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 21:57:35 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20180430062536.49077-1-aik@ozlabs.ru>
	<20180430062536.49077-2-aik@ozlabs.ru>
	<00093926-1d43-0213-34ba-68f72e4057ac@redhat.com>
	<d15375ef-2a6a-9a72-d0ef-0394c8e6832c@ozlabs.ru>
Message-ID: <c3558bb9-3e13-3fcf-61f2-2925ce16c14e@ozlabs.ru>
Date: Wed, 30 May 2018 14:57:29 +1000
MIME-Version: 1.0
In-Reply-To: <d15375ef-2a6a-9a72-d0ef-0394c8e6832c@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2 1/2] memory/hmp: Print
 owners/parents in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 3/5/18 3:40 pm, Alexey Kardashevskiy wrote:
> On 30/4/18 7:53 pm, Paolo Bonzini wrote:
>> On 30/04/2018 08:25, Alexey Kardashevskiy wrote:
>>> +    DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
>>> +    const char *id = object_property_print(obj, "id", true, NULL);
>>
>> The only objects that have an "id" property are memdevs.  If you want to
>> special case their printing too, it's probably a good idea (that is,
>> print one of "dev id=ID"/"memdev id=ID"/"obj path=PATH").
>>
>> Otherwise, I can also queue this patch as is, but I'd remove the "id"
>> property handling because I'm going to submit a small series to remove
>> the "id" property altogether.
>>
>> Let me know what you prefer!
> 
> 
> I choose to wait and repost, thanks :)

I waited, checked https://git.qemu.org/?p=qemu.git;a=commitdiff;h=29de4e
that "id" is no more and then grepped:

hw/intc/apic_common.c|489| object_property_add(obj, "id", "uint32",
hw/ppc/spapr_drc.c|557| object_property_add_uint32_ptr(obj, "id", &drc->id,
NULL);

This does not look like "remove the "id" property altogether" :) Does this
mean we still rather want to print QOM's "id"? spapr_drc does not own MRs
and APIC seems not to either.



> 
> 
>>
>> Thanks,
>>
>> Paolo
>>
>>> +    mon_printf(f, " %s:{%s", label, dev ? "dev" : "obj");
>>> +    if (dev ? dev->id : id) {
>>> +        mon_printf(f, " id=%s", dev ? dev->id : id);
>>> +    } else {
>>> +        gchar *canonical_path = object_get_canonical_path(obj);
>>> +        mon_printf(f, " path=%s", canonical_path);
>>> +        g_free(canonical_path);
>>> +    }
>>> +    mon_printf(f, "}");
>>
> 
> 


-- 
Alexey
