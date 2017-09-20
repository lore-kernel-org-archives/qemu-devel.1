Received: from eggs.gnu.org ([2001:4830:134:3::10]:33642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dui9V-0007H3-PN
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dui9R-0008Dc-MW
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:47:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dui9R-0008Bt-Du
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:47:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KGkvuA085300
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 12:47:04 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3s8mvect-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 12:47:02 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 17:47:00 +0100
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-6-pasic@linux.vnet.ibm.com>
	<20170920074238.GH11080@bjsdjshi@linux.vnet.ibm.com>
	<20170920103312.50b8b69b.cohuck@redhat.com>
	<009428a2-fb31-ecc9-d477-4cdea226f2d8@linux.vnet.ibm.com>
	<20170920131844.066e53d7.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 20 Sep 2017 18:46:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170920131844.066e53d7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <268904f1-0b31-3255-02da-c3248abef6a2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] s390x/css: support ccw IDA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/20/2017 01:18 PM, Cornelia Huck wrote:
> On Wed, 20 Sep 2017 13:13:01 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 09/20/2017 10:33 AM, Cornelia Huck wrote:
>>> On Wed, 20 Sep 2017 15:42:38 +0800
>>> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
>>>   
>>>> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-19 20:27:45 +0200]:
> 
>>>>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
>>>>> +                               sizeof(idaw.fmt2), false);
>>>>> +        cds->cda = be64_to_cpu(idaw.fmt2);
>>>>> +    } else {
>>>>> +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
>>>>> +        if (idaw_addr & 0x03 && cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
>>>>> +            return -EINVAL; /* channel program check */
>>>>> +        }
>>>>> +        ret = address_space_rw(&address_space_memory, idaw_addr,
>>>>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
>>>>> +                               sizeof(idaw.fmt1), false);
>>>>> +        cds->cda = be64_to_cpu(idaw.fmt1);    
>>>> Still need to check bit 0x80000000 here I think.  
>>>
>>> Yes, I think this is 'must be zero' for format-1 idaws, and not covered
>>> by the ccw-format specific checks above. (Although the PoP can be a bit
>>> confusing with many similar terms...)
>>>  
>>
>> It's taken care of in ccw_dstream_rw_ida before the actual
>> access happens. Code looks like this:
>> +        if (!idaw_fmt2 && (cds->cda + iter_len) >= (1ULL << 31)) {
>> +                ret = -EINVAL; /* channel program check */
>> +                goto err;
>> +        }
>>
>> The idea was to have it similar to the non-indirect case.
> 
> <looks at patch again>
> 
> Ah, I was simply looking for the wrong pattern. Looks correct.
> 
> 

Thinking about this some more. Since in case of IDA we are guaranteed
to never cross a block boundary with a single IDAW we won't ever cross
block boundary. So we can do the check in ida_read_next_idaw by checking
bit 0x80000000 on the ccw->cda. So we could keep idaw_fmt2 and ccw_fmt1
local to ida_read_next_idaw and save one goto err. I think that would
look a bit nicer than what I have here in v3. Agree?

>>>>> +static int ccw_dstream_rw_ida(CcwDataStream *cds, void *buff, int len,
>>>>> +                              CcwDataStreamOp op)
>>>>> +{
>>>>> +    uint64_t bsz = ccw_ida_block_size(cds->flags);
>>>>> +    int ret = 0;
>>>>> +    uint16_t cont_left, iter_len;
>>>>> +    const bool idaw_fmt2 = cds->flags & CDS_F_C64;
>>>>> +    bool ccw_fmt1 = cds->flags & CDS_F_FMT;    
>>>> Use 'const bool' either? Although I doubt the value of using const here.
>>>> ;)  
>>>
>>> Both being the same is still a good idea.
>>>   
>>
>> Yeah. For which one should I go (with const or without)?
> 
> For the one you prefer :) (I'm not sure if the const adds value here.)
> 

I think we generally don't care about const-ness in such situations,
so I think I won't use consts.

I intend to fix the issues we have found and do a v4 tomorrow, unless
somebody screams -- could do it today but I would like to give Dong
Jia an opportunity to react. On the other hand waiting more that that
will IMHO do us no favor either (I think of our storage/memory hierarchy).

Regards,
Halil
