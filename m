Received: from eggs.gnu.org ([2001:4830:134:3::10]:56662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dBMCy-00054l-KW
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dBMCv-00082W-AG
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:15:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dBMCv-00081s-05
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:15:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4IDxkLt123150
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 10:15:11 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahb4qf28y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 10:15:11 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 18 May 2017 15:15:08 +0100
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-4-pasic@linux.vnet.ibm.com>
	<20170508164505.GG2120@work-vm>
	<3e0195e2-ada5-2efc-1feb-e2415761e7bc@linux.vnet.ibm.com>
	<20170515180129.GC2324@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 18 May 2017 16:15:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170515180129.GC2324@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <2bf9d9d3-86ed-da36-dc81-415065e08a91@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] s390x/css: add vmstate entities for
 css
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 05/15/2017 08:01 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>
>>
>> On 05/08/2017 06:45 PM, Dr. David Alan Gilbert wrote:
>>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>>> As a preparation for switching to a vmstate based migration let us
>>>> introduce vmstate entities (e.g. VMStateDescription) for the css entities
>>>> to be migrated. Alongside some comments explaining or indicating the not
>>>> migration of certain members are introduced too.
>>>>
>>>> No changes in behavior, we just added some dead code -- which should
>>>> rise to life soon.
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> ---
>>>>  hw/s390x/css.c         | 276 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  include/hw/s390x/css.h |  10 +-
>>>>  2 files changed, 285 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>>> index c03bb20..2bda7d0 100644
>>>> --- a/hw/s390x/css.c
>>>> +++ b/hw/s390x/css.c
>>>> @@ -20,29 +20,231 @@
>>>>  #include "hw/s390x/css.h"
>>>>  #include "trace.h"
>>>>  #include "hw/s390x/s390_flic.h"
>>>> +#include "hw/s390x/s390-virtio-ccw.h"
>>>>  
>>
>> [..]
>>
>>>> +static int css_get_ind_addr(QEMUFile *f, void *pv, size_t size,
>>>> +                            VMStateField *field)
>>>> +{
>>>> +    int32_t len;
>>>> +    IndAddr **ind_addr = pv;
>>>> +
>>>> +    len = qemu_get_be32(f);
>>>> +    if (len != 0) {
>>>> +        *ind_addr = get_indicator(qemu_get_be64(f), len);
>>>> +    } else {
>>>> +        qemu_get_be64(f);
>>>> +        *ind_addr = NULL;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int css_put_ind_addr(QEMUFile *f, void *pv, size_t size,
>>>> +                            VMStateField *field, QJSON *vmdesc)
>>>> +{
>>>> +    IndAddr *ind_addr = *(IndAddr **) pv;
>>>> +
>>>> +    if (ind_addr != NULL) {
>>>> +        qemu_put_be32(f, ind_addr->len);
>>>> +        qemu_put_be64(f, ind_addr->addr);
>>>> +    } else {
>>>> +        qemu_put_be32(f, 0);
>>>> +        qemu_put_be64(f, 0UL);
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +const VMStateInfo vmstate_info_ind_addr = {
>>>> +    .name = "s390_ind_addr",
>>>> +    .get = css_get_ind_addr,
>>>> +    .put = css_put_ind_addr
>>>> +};
>>>
>>> You should be able to avoid this .get/.put by using VMSTATE_WITH_TMP,
>>> declare a temporary struct something like:
>>>   struct tmp_ind_addr {
>>>      IndAddr *parent;
>>>      uint32_t  len;
>>>      uint64_t  addr;
>>>   }
>>>
>>> and then your .get/.put routines turn into pre_save/post_load
>>> routines to just setup the len/addr.
>>>
>>
>> I don't think this is going to work -- unfortunately! You can see below,
>> how this IndAddr* migration stuff is supposed to be used:
>> the client code just uses the VMSTATE_PTR_TO_IND_ADDR macro as a
>> field when describing state which needs and IndAddr* migrated.
>>
>> The problem is, we do not know in what state will this field
>> be embedded, the pre_save/post_load called by put_tmp/get_tmp
>> is however copying the pointer to this state into the parent.
>> So instead of having a pointer to IndAddr* in those functions
>> and updating it accordingly, I would have to find the IndAddr*
>> in some arbitrary state (in our case VirtioCcwDevice) first,
>> and I lack information for that.
>>
>> If it's hard to follow I can give you the patch I was debugging
>> to come to this conclusion. (By the way I ended up with 10
>> lines of code more than in this version, and although I think
>> it looks nicer, it's simpler only if one knows how WITH_TMP
>> works. My plan was to ask you which version do you like more
>> and go with that before I realized it ain't gonna work.)
>>
> 
> Yes, I see - I've got some similar other cases; the challenge
> is it's a custom allocator - 'get_indicator' - and it's used
> as fields in a few places.  Hmm.
> 
> 

The problem can be worked around by wrapping the WITH_TMP into a another
vmsd and using VMSTATE_STRUCT for describing the field in question. It's
quite some boilerplate (+16 lines). Should I post the patch here?


We could also consider making WITH_TMP act as a normal field. 
Working on the whole state looks like a bit like a corner case:
we have some stuff adjacent in the migration stream, and we have
to map it on multiple fields (and vice-versa). Getting the whole
state with a pointer to a certain field could work via container_of.

Btw, I would rather call it get_indicator a factory method or even a
constructor than an allocator, but I think we understand each-other
anyway.

Regards,
Halil
