Received: from eggs.gnu.org ([2001:4830:134:3::10]:35882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fbQs9-0003BK-QW
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fbQs4-0005sH-Sx
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:34:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fbQs4-0005rx-KM
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:34:00 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w66DXfAg083052
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 09:33:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k27mccsjt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 09:33:58 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 6 Jul 2018 14:33:56 +0100
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
	<20180706100346.3dda6b10.cohuck@redhat.com>
	<81699814-1e9a-7031-ca3f-4d4d5c58906a@linux.ibm.com>
	<20180706142631.664474ec.cohuck@redhat.com>
	<a33b6f31-cd56-4ceb-2130-862a07611eb6@linux.ibm.com>
	<20180706151559.1429f2ad.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 6 Jul 2018 15:33:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180706151559.1429f2ad.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ebfe4d75-3e9e-6bba-3e4e-370a1fdc5747@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 10/15] s390-bios: Support for
 running format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, bjsdjshi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com



On 07/06/2018 03:15 PM, Cornelia Huck wrote:
> On Fri, 6 Jul 2018 15:03:49 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 07/06/2018 02:26 PM, Cornelia Huck wrote:
>>> On Fri, 6 Jul 2018 13:42:25 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    
>>>> On 07/06/2018 10:03 AM, Cornelia Huck wrote:
>>>>> On Thu,  5 Jul 2018 13:25:38 -0400
>>>>> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
>>>>>> +    rc = ssch(schid, &orb);
>>>>>> +    if (rc) {
>>>>>> +        print_int("ssch failed with rc=", rc);
> 
> One nit: make this 'cc' instead of 'rc'?
> 
>>>>>> +        return rc;
>>>>>
>>>>> Are you doing anything like retrying on cc 1/2? It's probably fine to
>>>>> give up on cc 3.
>>>>>       
>>>>
>>>> We are in IPL context. We should have exclusive access to the DASD
>>>> we are IPL-ing from, or not? My understanding was that if the layers
>>>> below us don't violate the rules, we should never observe cc 1 or 2
>>>> here. Or am I wrong?
>>>
>>> cc 2 probably not (nobody should be doing a halt or a clear), but cc 1
>>> if there's some unsolicited status pending?
>>>    
>>
>> AFAIK we are supposed to give up then. The status was supposed to be
>> cleared away on the reset which precedes IPL. If the device presented
>> an unsolicited status between reset and starting the IPL IO on the
>> channel I think the IPL should fail.
> 
> I very dimly remember efforts to make (non-QEMU) IPL more robust, but I
> think that was more about IFCCs and the like.
> 
> Anyway, it is probably not worth spending too much time on. Being able
> to IPL from vfio-ccw handled dasd is already very nice :)
>

PoP does not say much, and the internal documentation is, well internal.
Maybe we could do more on IFCC but we don't have to. One other thing
where we could do more is diagnostic info. But I really think this is
good enough for the first shot.

Regards,
Halil



  
