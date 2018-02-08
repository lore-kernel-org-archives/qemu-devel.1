Received: from eggs.gnu.org ([2001:4830:134:3::10]:51599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejkPY-0003en-FD
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejkPU-0002Cc-7F
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:30:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ejkPT-0002C6-WC
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 06:30:36 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w18BU88n054399
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 06:30:35 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g0nk9gd0c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 06:30:34 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 8 Feb 2018 11:30:31 -0000
References: <20180202094241.59537-1-borntraeger@de.ibm.com>
	<8d3af693-3dd8-20b7-c7c1-38d7c6cce65d@de.ibm.com>
	<20180202113301.0522c7bc.cohuck@redhat.com>
	<20180202113513.15c37b32.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 8 Feb 2018 12:30:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180202113513.15c37b32.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <47ffc4f7-a66b-0328-d0bf-2d06ad0f7c30@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/sclp: fix event mask handling -->
 stable 2.11.1?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, qemu-stable@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>



On 02/02/2018 11:35 AM, Cornelia Huck wrote:
> On Fri, 2 Feb 2018 11:33:01 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Fri, 2 Feb 2018 10:43:18 +0100
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 02/02/2018 10:42 AM, Christian Borntraeger wrote:  
>>>> commit 67915de9f038 ("s390x/event-facility: variable-length event
>>>> masks") switches the sclp receive/send mask. This broke the sclp
>>>> lm console.  
>>
>> Hum. Probably should add sclp-lm to my test setup.
>>
>>>>
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> Fixes: commit 67915de9f038 ("s390x/event-facility: variable-length event masks")
>>>> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>    
>>>
>>> opps. Please fixup yourself Conny :-)  
>>
>> Well, you did cc: the original author :)
>>
>>>   
>>>> Cc: Jason J. Herne <jjherne@linux.vnet.ibm.com>
>>>> Cc: qemu-stable@nongnu.org
>>>> ---
>>>>  hw/s390x/event-facility.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>>>> index b0f71f4554..155a69467b 100644
>>>> --- a/hw/s390x/event-facility.c
>>>> +++ b/hw/s390x/event-facility.c
>>>> @@ -293,10 +293,10 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>>>>      ef->receive_mask = be32_to_cpu(tmp_mask);
>>>>
>>>>      /* return the SCLP's capability masks to the guest */
>>>> -    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
>>>> +    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
>>>>      copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
>>>>                mask_length, sizeof(tmp_mask));
>>>> -    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
>>>> +    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
>>>>      copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
>>>>                mask_length, sizeof(tmp_mask));
>>>>     
>>>   
>>
>> Thanks, applied.
> 
> Oh, and as always, I still take R-bs until I prepare a pull req.
> 

Would be good to have that in 2.11.1 stable as well I think
