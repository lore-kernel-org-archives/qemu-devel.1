Received: from eggs.gnu.org ([2001:4830:134:3::10]:54826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e7fdY-0005GU-GD
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e7fdV-00077y-Dh
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:43:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e7fdV-00076h-55
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:43:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9QAftZV035319
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 06:43:36 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dudvf909p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 06:43:33 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 11:43:29 +0100
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
	<46a65cf7-8c60-3aac-de93-95be25360f11@linux.vnet.ibm.com>
	<7da3a9f3-918f-3859-1f5e-eee028c2586d@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 12:43:26 +0200
MIME-Version: 1.0
In-Reply-To: <7da3a9f3-918f-3859-1f5e-eee028c2586d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <4d92c2d7-41a2-b527-d913-2505d9c00713@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Jiri Denemark <jdenemar@redhat.com>



On 10/26/2017 10:13 AM, Christian Borntraeger wrote:
> 
> 
> On 10/26/2017 01:35 AM, Halil Pasic wrote:
>  try the most interesting scenarios out.
>>
>> The idea of the patch is very clear, but I don't understand the bigger gs
>> feature context fully.
>>
>> From what I read in the code, the attempt to enable the gs capability in
>> the kernel is made regardless of the cpu model. If the attempt was
>> successful kvm_s390_get_gs will keep returning true. That would in turn
>> affect migration, as far as I see (usages of kvm_s390_get_gs). I could
>> not figure out how does gs being turned off via cpu-model (-cpu
>> z14,gs=off) does turn of gs support -- at least not the details. I wanted
>> to give a timely review, so I've limited myself there. 
> 
> When the CPU model turns off gs, facility bit 133 will be turned off.
> Then the kernel does the right thing, see priv.c handle_gs.
> 
> guarded storage is enabled lazily. Whenever the guest issues a Gs instruction
> we will get an exit and only enable GS if facility 133 is set.
> 
>>
>> From what I see, this patch does what it advertises, and since I think
>> it's the right thing to do in the current situation I gonna give it an:
>> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>
>> At the same time, I would prefer the commit message being reworded. IMHO
>> this patch is a good stop-gap measure, but essentially it trades an
>> annoying and obvious bug for a subtle and hopefully painless one.
>>
>> Let me explain this last statement. For starters, I  do share some of the
>> concerns Boris has voiced.  I won't repeat those. Same goes for the
>> example Christian paraphrased previously, and the the fear of an implicit
>> requirement for having to support a Cartesian product of the advertised
>> machine-types and cpu-models (for each qemu binary).
> 
> I will try to come up with a patch description that explains the open issues
> and it will tell that additional might or might not be necessary depending
> on followup discussions.

I would be already happy with adding something like:
During the discussion enabling cpu-model features for preexisting
machine-types came out as at least controversial. We agreed to implement
this patch as a stop-gap measure for the next release. What is a clean
enough solution shall be decided without time pressure.

> I will schedule this patch for 2.11 then.
> 

Sounds like a plan.

Cheers,
Halil

> 
