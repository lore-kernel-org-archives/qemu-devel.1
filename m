Received: from eggs.gnu.org ([2001:4830:134:3::10]:48182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1e48vN-0003sK-9j
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1e48vK-00085B-6M
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:11:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39728
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.vnet.ibm.com>)
	id 1e48vK-00084s-0q
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:11:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9GH983j019560
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 13:11:25 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dn01jjmvf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 13:11:24 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.vnet.ibm.com>;
	Mon, 16 Oct 2017 11:11:24 -0600
Reply-To: jjherne@linux.vnet.ibm.com
References: <1507729193-9747-1-git-send-email-jjherne@linux.vnet.ibm.com>
	<20171016154433.246fb264.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Date: Mon, 16 Oct 2017 13:11:19 -0400
MIME-Version: 1.0
In-Reply-To: <20171016154433.246fb264.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bc948ac4-6efd-63e2-35e3-e7be6c656536@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/event-facility: variable-length
 event masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 10/16/2017 09:44 AM, Cornelia Huck wrote:
> On Wed, 11 Oct 2017 09:39:53 -0400
> "Jason J. Herne" <jjherne@linux.vnet.ibm.com> wrote:
>> ...
> 
> Out of curiousity: Do you have a guest that can verify this for mask
> lengths != 4? Given that the guest I wrote that one for back then is
> not publicly available...
> 

I do have a guest OS that exercises larger mask lengths. Nothing 
publicly available however.

>> ...
>>   static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>>   {
>>       WriteEventMask *we_mask = (WriteEventMask *) sccb;
>> +    uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
>> +    uint32_t tmp_mask;
>>   
>> -    /* Attention: We assume that Linux uses 4-byte masks, what it actually
>> -       does. Architecture allows for masks of variable size, though */
>> -    if (be16_to_cpu(we_mask->mask_length) != 4) {
>> +    if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX)) {
>>           sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_MASK_LENGTH);
>>           goto out;
>>       }
>>   
>> +    /*
>> +     * Note: We currently only support masks up to 4 byte length;
>> +     *       the remainder is filled up with zeroes. Linux uses
>> +     *       a 4 byte mask length.
>> +     */
> 
> Do you have any plans for extending this? Or is there no need?
> 
> (I have to ask those questions, as the documentation is not publicly
> available...)
> 

As of right now 4B is all that is actually needed for any of the masks. 
The reason to allow for 32 byte requests is for guest operating systems 
who are already planning for the future. Someday more than 4B may be 
used but we have no way to know if or when.

>> ...
> 
> Patch looks reasonable as far as I can see (the documentation issue
> again...)
> 
> Did you need to change much from the original patch?
> 

Very little. Just a quick forward fit and test and all is well :)
Thanks for the original work. This saved me some time.

-- 
-- Jason J. Herne (jjherne@linux.vnet.ibm.com)
