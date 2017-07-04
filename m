Received: from eggs.gnu.org ([2001:4830:134:3::10]:49631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSRoR-0004xh-D9
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSRoO-0006lX-3Q
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:40:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSRoN-0006ks-Oq
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:40:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64HcdWB061013
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 13:40:29 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bfurksatu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 13:40:28 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 11:40:28 -0600
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
	<1499177279-131407-4-git-send-email-borntraeger@de.ibm.com>
	<20170704163103.4d6670a9@dhcp-192-215.str.redhat.com>
	<3200e2c0-8ffe-2f6d-b7a8-049352851c96@linux.vnet.ibm.com>
	<87aeaca3-5261-91c9-506b-eded3dededb4@linux.vnet.ibm.com>
	<20170704185924.3eb7171d@dhcp-192-215.str.redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 4 Jul 2017 19:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170704185924.3eb7171d@dhcp-192-215.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <0a35bfd4-b1d1-ce6c-19e0-4aea225c4406@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] s390x: fix error propagation in
 kvm-flic's realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On 07/04/2017 06:59 PM, Cornelia Huck wrote:
> On Tue, 4 Jul 2017 17:08:52 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>>>>>      cd.type = KVM_DEV_TYPE_FLIC;
>>>>>      ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
>>>>>      if (ret < 0) {
>>>>> -        trace_flic_create_device(errno);
>>>>> -        return;
>>>>> +        error_setg_errno(&errp_local, errno, "Creating the KVM device failed");
>>>>> +        trace_flic_no_device_api(errno);  
>>>>
>>>> Err... this should still be trace_flic_create_device(), no?  
>>>
>>> I'm afraid you are right! Probably a copy paste error :/
>>>   
>>
>> Do you think the traces are still appropriate once we have
>> proper error propagation?
> 
> They add less value, but I'd just keep them.
> 
>>
>> I did not feel comfortable removing them but thinking again,
>> than might be the thing to do.
>>
>> @Christian:
>> I think we should really fix this the one way or the other.
>> Can you tell me what is the proper procedure?
> 
> I'd vote for just fixing the trace event. Smaller change, and we can
> revisit this later.
> 

+1
