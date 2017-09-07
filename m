Received: from eggs.gnu.org ([2001:4830:134:3::10]:45657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpv3G-00037h-Ua
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpv3C-0000Qa-5h
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:32:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57857
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpv3B-0000QS-WD
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:32:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v87BThb8051793
	for <qemu-devel@nongnu.org>; Thu, 7 Sep 2017 07:32:48 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cu3ef63m8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 07:32:48 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 7 Sep 2017 12:32:45 +0100
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-5-pasic@linux.vnet.ibm.com>
	<20170831115535.1e4201d3.cohuck@redhat.com>
	<7540741b-d230-e7c4-50d3-036f31997c8b@linux.vnet.ibm.com>
	<20170905182546.00457332.cohuck@redhat.com>
	<fe102a7a-e998-8ebe-b94d-e653c4f66c39@linux.vnet.ibm.com>
	<20170906043108.GY31680@bjsdjshi@linux.vnet.ibm.com>
	<8946b1ec-4d14-c953-deab-aaded7cd2c9d@linux.vnet.ibm.com>
	<20170906162019.45eeec4a.cohuck@redhat.com>
	<cc6eab96-969d-eb66-91b5-cdb965c1bcbb@linux.vnet.ibm.com>
	<20170907085831.GF31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907122400.5b2e3faa.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 7 Sep 2017 13:32:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170907122400.5b2e3faa.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <27b2addf-0d1c-81d7-1e82-1a8cdac70231@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] s390x: refactor error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/07/2017 12:24 PM, Cornelia Huck wrote:
> On Thu, 7 Sep 2017 16:58:31 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
>> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-06 16:43:42 +0200]:
>>
>>>
>>>
>>> On 09/06/2017 04:20 PM, Cornelia Huck wrote:  
>>>> On Wed, 6 Sep 2017 14:25:13 +0200
>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>>   
>>>>> We have basically two possibilities/options which ask for different
>>>>> handling:
>>>>> 1) EFAULT is due to a bug in the vfio-ccw implementation
>>>>> (can be QEMU or kernel).
>>>>> 2) EFAULT is due to buggy channel program.
>>>>>
>>>>> Option 2) is basically to be handled with a channel-program check and
>>>>> setting primary secondary and alert status. For reference see PoP page
>>>>> 15-59 ("Designation of Storage Area").  An exception may be an invalid
>>>>> channel program address in the ORB. There the channel-program check ain't
>>>>> explicitly stated (although) I would expect one. It may be implied by the
>>>>> things on page 15-59 though.
>>>>>
>>>>> Option 1) is however very similar to other we have figured out that the
>>>>> implementation is broken situations and should be handled consequently.
>>>>> The current state of the discussion is with a unit exception.
>>>>>
>>>>> Does that make sense?  
>>>>
>>>> I think the situation is slightly different here, though. For the orb
>>>> flags, we reject something out of hand because we have not implemented
>>>> it, and for that, unit exception sounds like a good fit. Processing
>>>> errors, however, are more similar to errors in the hardware, and as
>>>> such can probably be reported via something like equipment check.
>>>>   
>>>
>>> Noted. Let's see what Dong Jia has to say, before we continuing a
>>> discussion on something (option 1) what may be irrelevant anyway.
>>>   
>>>>>
>>>>> Now, Dong Jia, I need your help to figure out do we have option 1 or
>>>>> option 2 here? After quick look at the kernel code, it appears to me that
>>>>> I've seen both option 1 and option 2 (I'm afraid) -- but my assessment
>>>>> was really very superficial.  
>> There are three cases (all in the kernel) that generate a -EFAULT ret
>> code:
>> a. vfio_ccw_mdev_write: copy_from_user() fails.
>>   This is option 1.
>>
>> b. ccwchain_fetch_tic
>>   It's mostly likely that the vfio-ccw driver processed the ccw chains
>>   wrongly. (Actually I can not think of any other reason.)
> 
> Me neither, I'd consider hitting this a bug in the implementation.

Nod.

> 
>>   This is option 1.
>>
>> c. ccwchain_fetch_idal
>>   When we find that an IDAW contents an invalid address
>>   This is option 2.
>>
>>>>>
>>>>> I would expect option 2 to be handled differently (kernel provides the
>>>>> SCSW) though.
> 
> So we would do an equipment check for the first two ("equipment", i.e.
> the software, is malfunctioning) and use a more appropriate way for the
> malformed idaw?
> 

You have probably missed my previous email where I state something very
similar (MID  <2aa8cf98-c331-fe5a-0a7e-1a553c6c5054@linux.vnet.ibm.com>).
There I say: if we change the kernel code, yes, if we don't I prefer a
program check.


Halil
