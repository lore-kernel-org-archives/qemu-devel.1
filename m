Received: from eggs.gnu.org ([2001:4830:134:3::10]:51006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dptwf-00022i-Ld
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dptwc-0002he-G0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:22:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dptwc-0002hA-6s
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:21:58 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v87ALv7E022748
	for <qemu-devel@nongnu.org>; Thu, 7 Sep 2017 06:21:57 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cu1nyqed6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 06:21:56 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 7 Sep 2017 11:21:54 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
	<20170907073108.GD31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907100817.08ddae29.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 7 Sep 2017 12:21:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170907100817.08ddae29.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f06e081a-aff4-f2db-5741-b1f85f98f995@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/07/2017 10:08 AM, Cornelia Huck wrote:
> On Thu, 7 Sep 2017 15:31:09 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
>> * Cornelia Huck <cohuck@redhat.com> [2017-09-06 15:18:21 +0200]:
>>
>>> On Tue,  5 Sep 2017 13:16:45 +0200
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>   
>>>> Add a fake device meant for testing the correctness of our css emulation.
>>>>
>>>> What we currently have is writing a Fibonacci sequence of uint32_t to the
>>>> device via ccw write. The write is going to fail if it ain't a Fibonacci
>>>> and indicate a device exception in scsw together with the proper residual
>>>> count.
>>>>
>>>> Of course lot's of invalid inputs (besides basic data processing) can be
>>>> tested with that as well.
>>>>
>>>> Usage:
>>>> 1) fire up a qemu with something like -device ccw-tester,devno=fe.0.0001
>>>>    on the command line
>>>> 2) exercise the device from the guest
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> ---
>>>>
>>>> It may not make sense to merge this work in the current form, as it is
>>>> solely for test purposes.
>>>> ---
>>>>  hw/s390x/Makefile.objs |   1 +
>>>>  hw/s390x/ccw-tester.c  | 179 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 180 insertions(+)
>>>>  create mode 100644 hw/s390x/ccw-tester.c  
>>>
>>> The main problem here is that you want to exercise a middle layer (the
>>> css code) and need to write boilerplate code on both host and guest
>>> side in order to be able to do so.
>>>
>>> In general, a device that accepts arbitrary channel programs looks
>>> useful for testing purposes. I would split out processing of expected
>>> responses out, though, so that it can be more easily reused for
>>> different use cases.
>>>
>>> (I dimly recall other test devices...)
>>>
>>> For the guest tester: Can that be done via the qtest infrastructure
>>> somehow?
>>>   
>>
>> I'm thinking of a method these days:
>> Could passing through an fully emulated ccw device (e.g. 3270), or a
>> virtio ccw device, in the level 1 kvm guest to a level 2 guest be a test
>> method for this?
>>
>> All of the CCWs will be translated to IDAL CCWs by vfio-ccw in the level
>> 1 guest (which is the level 2 kvm host) and issued to the level 1 kvm
>> host. So, those IDALs will eventually be handled by the emulated device,
>> or the virtio ccw device, on the level 1 kvm host...
>>
>> Some days ago, one of my colleague tried the emulated 3270 passing
>> through. She stucked with the problem that the level 1 kvm host handling
>> a senseid IDAL ccw as a Direct ccw.
>>
>> Maybe I could try to pass through a virtio ccw device. I don't think of
>> any obvious problem that would lead to fail. Any comment?
>>
> 
> That actually looks like a good thing to try! Cool idea.
> 

I'm afraid that it would not work without some extra work.
AFAIR Connie we said that the 3270 does not use any IDA, so
I did not touch the 3270 emulation code in QEMU. To make
the scenario viable one should convert the 3270 emulation
to ccw data stream (unless the original implementation
already took care of IDA, which I doubt).

Halil
