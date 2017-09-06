Received: from eggs.gnu.org ([2001:4830:134:3::10]:59304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpbGD-0006H6-Ay
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpbG6-0003nx-5t
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:24:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60004
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpbG5-0003nn-W7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:24:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v86EOPc5067079
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 10:24:49 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cth6x6y9v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 10:24:47 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 15:24:17 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 16:24:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170906151821.1a77afe5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <abc65014-f9fa-4cea-7f49-3e97e3845a3c@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Janosch Frank <frankja@linux.vnet.ibm.com>



On 09/06/2017 03:18 PM, Cornelia Huck wrote:
> On Tue,  5 Sep 2017 13:16:45 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Add a fake device meant for testing the correctness of our css emulation.
>>
>> What we currently have is writing a Fibonacci sequence of uint32_t to the
>> device via ccw write. The write is going to fail if it ain't a Fibonacci
>> and indicate a device exception in scsw together with the proper residual
>> count.
>>
>> Of course lot's of invalid inputs (besides basic data processing) can be
>> tested with that as well.
>>
>> Usage:
>> 1) fire up a qemu with something like -device ccw-tester,devno=fe.0.0001
>>    on the command line
>> 2) exercise the device from the guest
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>
>> It may not make sense to merge this work in the current form, as it is
>> solely for test purposes.
>> ---
>>  hw/s390x/Makefile.objs |   1 +
>>  hw/s390x/ccw-tester.c  | 179 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 180 insertions(+)
>>  create mode 100644 hw/s390x/ccw-tester.c
> 
> The main problem here is that you want to exercise a middle layer (the
> css code) and need to write boilerplate code on both host and guest
> side in order to be able to do so.
> 

Nod.

> In general, a device that accepts arbitrary channel programs looks
> useful for testing purposes. I would split out processing of expected
> responses out, though, so that it can be more easily reused for
> different use cases.
> 

I'm not sure what do you mean here. Could you clarify please?

> (I dimly recall other test devices...)
> 

What's on your mind? How do these relate to our problem? Can you
give me some pointers?

> For the guest tester: Can that be done via the qtest infrastructure
> somehow?
> 

Well, for now I have the out-of-tree Linux kernel module provided in the
cover letter of the series (you did not comment on that one yet).

I think for building trust regarding my IDA implementation it should be
able to do the job. Don't you agree?

Just a couple of hours ago Janosch (cc-ing Janosch) came to my office,
and told be that he is working on CCW-tests for zonk (a minimal kernel
for testing -- internal tool AFAIR).

By qtest you mean libqtest/libqos? I'm not familiar with that and have no
idea what do we have for s390x. I see on libqos-s390x file in test/libqos
for starters.

Regards,
Halil
