Received: from eggs.gnu.org ([2001:4830:134:3::10]:44427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpZOV-000245-S6
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpZOS-0000l3-Np
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:25:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpZOS-0000kQ-Eq
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:25:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v86COATT127379
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 08:25:18 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ctcd5dt6v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 08:25:18 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 13:25:16 +0100
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-5-pasic@linux.vnet.ibm.com>
	<20170831115535.1e4201d3.cohuck@redhat.com>
	<7540741b-d230-e7c4-50d3-036f31997c8b@linux.vnet.ibm.com>
	<20170905182546.00457332.cohuck@redhat.com>
	<fe102a7a-e998-8ebe-b94d-e653c4f66c39@linux.vnet.ibm.com>
	<20170906043108.GY31680@bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 14:25:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170906043108.GY31680@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <8946b1ec-4d14-c953-deab-aaded7cd2c9d@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/06/2017 06:31 AM, Dong Jia Shi wrote:
> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-06 00:30:58 +0200]:
> 
> [...]
> 
>>>
>>>> But I guess, I was afraid of somebody blaming me for this
>>>> comment (such TODOs in production code are a bit strange -- what
>>>> does it mean: we did not bother to figure it out?).
>>>
>>> For one, the TODO is preexisting... and we really should remember to
>>> figure out if there's something better rather than just drop the
>>> comment.
>>>
>>> (And I sure hope nobody is using vfio-ccw in production yet...)
>>>
>> Since blame says the TODO has been around since 2017-05-17
>> let me have a critical look at it.
>>
>> At a first glance I would say addressing exception for SSCH
>> is not what we want: the only possibility I see for address
>> exception for SSCH is due to the ORB address. But if that's
>> the case we will never reach the code in question.
> Agree.
> 
>> So I suppose we can do better.
> As the comment said, I'm (still) in the state of 'wondering'.
> 
>>
>> Adding Ren. @Ren: Do you agree with my analysis. If you do,
>> I could come up with a proposal what to do -- after some reading.
> If you have a better idea, and time, why not? ;)
> 

We have basically two possibilities/options which ask for different
handling:
1) EFAULT is due to a bug in the vfio-ccw implementation
(can be QEMU or kernel).
2) EFAULT is due to buggy channel program.

Option 2) is basically to be handled with a channel-program check and
setting primary secondary and alert status. For reference see PoP page
15-59 ("Designation of Storage Area").  An exception may be an invalid
channel program address in the ORB. There the channel-program check ain't
explicitly stated (although) I would expect one. It may be implied by the
things on page 15-59 though.

Option 1) is however very similar to other we have figured out that the
implementation is broken situations and should be handled consequently.
The current state of the discussion is with a unit exception.

Does that make sense?

Now, Dong Jia, I need your help to figure out do we have option 1 or
option 2 here? After quick look at the kernel code, it appears to me that
I've seen both option 1 and option 2 (I'm afraid) -- but my assessment
was really very superficial.

I would expect option 2 to be handled differently (kernel provides the
SCSW) though.

Regards,
Halil
