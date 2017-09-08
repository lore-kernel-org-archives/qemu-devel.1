Received: from eggs.gnu.org ([2001:4830:134:3::10]:55591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqGWF-0003dr-GZ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqGWA-000531-I9
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:28:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dqGWA-000525-92
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:28:10 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v88ARooY005408
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 06:28:08 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cus6sggtw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 06:28:07 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 8 Sep 2017 11:28:05 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
	<20170907073108.GD31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907100817.08ddae29.cohuck@redhat.com>
	<f06e081a-aff4-f2db-5741-b1f85f98f995@linux.vnet.ibm.com>
	<20170907125220.0d78d285.cohuck@redhat.com>
	<20170908020134.GG31680@bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 8 Sep 2017 12:28:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170908020134.GG31680@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <61b525d8-a1a2-1e70-4c19-a9b7673f1cbe@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/08/2017 04:01 AM, Dong Jia Shi wrote:
> * Cornelia Huck <cohuck@redhat.com> [2017-09-07 12:52:20 +0200]:
> 
>> On Thu, 7 Sep 2017 12:21:50 +0200
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> On 09/07/2017 10:08 AM, Cornelia Huck wrote:
>>>> On Thu, 7 Sep 2017 15:31:09 +0800
>>>> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
>>
>>>>> I'm thinking of a method these days:
>>>>> Could passing through an fully emulated ccw device (e.g. 3270), or a
>>>>> virtio ccw device, in the level 1 kvm guest to a level 2 guest be a test
>>>>> method for this?
>>>>>
>>>>> All of the CCWs will be translated to IDAL CCWs by vfio-ccw in the level
>>>>> 1 guest (which is the level 2 kvm host) and issued to the level 1 kvm
>>>>> host. So, those IDALs will eventually be handled by the emulated device,
>>>>> or the virtio ccw device, on the level 1 kvm host...
>>>>>
>>>>> Some days ago, one of my colleague tried the emulated 3270 passing
>>>>> through. She stucked with the problem that the level 1 kvm host handling
>>>>> a senseid IDAL ccw as a Direct ccw.
>>>>>
>>>>> Maybe I could try to pass through a virtio ccw device. I don't think of
>>>>> any obvious problem that would lead to fail. Any comment?
>>>>>  
>>>>
>>>> That actually looks like a good thing to try! Cool idea.
>>>>   
>>>
>>> I'm afraid that it would not work without some extra work.
>>> AFAIR Connie we said that the 3270 does not use any IDA, so
>>> I did not touch the 3270 emulation code in QEMU. To make
>>> the scenario viable one should convert the 3270 emulation
>>> to ccw data stream (unless the original implementation
>>> already took care of IDA, which I doubt).
>>
>> But the vfio-ccw code uses idals... no need to touch the 3270 emulation.
>>
> What Halil pointed out is that the ccw_cb implementation of 3270
> emulation does not take care of IDALs. This is true.
> 
> I can also do that right after this series, if Halil agrees.
> (The 3270 emulation authors are busy of other stuff these days. :()

Generally, yes I agree. If it's trivial I will probably do it myself
for v2. I need to do a v2 anyway.

Halil
