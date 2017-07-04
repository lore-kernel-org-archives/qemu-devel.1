Received: from eggs.gnu.org ([2001:4830:134:3::10]:45921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dSPS0-00066e-AD
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dSPRx-0004iB-0T
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:09:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38470
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dSPRw-0004hv-QL
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:09:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64F98SA051955
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 11:09:11 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bg9tpfdt2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 11:09:11 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 4 Jul 2017 16:08:55 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
	<1499177279-131407-4-git-send-email-borntraeger@de.ibm.com>
	<20170704163103.4d6670a9@dhcp-192-215.str.redhat.com>
	<3200e2c0-8ffe-2f6d-b7a8-049352851c96@linux.vnet.ibm.com>
Date: Tue, 4 Jul 2017 17:08:52 +0200
MIME-Version: 1.0
In-Reply-To: <3200e2c0-8ffe-2f6d-b7a8-049352851c96@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <87aeaca3-5261-91c9-506b-eded3dededb4@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>



On 07/04/2017 04:46 PM, Halil Pasic wrote:
> 
> 
> On 07/04/2017 04:31 PM, Cornelia Huck wrote:
>> On Tue,  4 Jul 2017 16:07:55 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> From: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>
>>> From the moment it was introduced by commit a2875e6f98 ("s390x/kvm:
>>> implement floating-interrupt controller device", 2013-07-16) the kvm-flic
>>> is not making realize fail properly in case it's impossible to create the
>>> KVM device which basically serves as a backend and is absolutely
>>> essential for having an operational kvm-flic.
>>>
>>> Let's fix this by making sure we do proper error propagation in realize.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> Fixes: a2875e6f98 "s390x/kvm: implement floating-interrupt controller device"
>>> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  hw/intc/s390_flic_kvm.c | 14 +++++++++++---
>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>
>> (...)
>>
>>>      cd.type = KVM_DEV_TYPE_FLIC;
>>>      ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
>>>      if (ret < 0) {
>>> -        trace_flic_create_device(errno);
>>> -        return;
>>> +        error_setg_errno(&errp_local, errno, "Creating the KVM device failed");
>>> +        trace_flic_no_device_api(errno);
>>
>> Err... this should still be trace_flic_create_device(), no?
> 
> I'm afraid you are right! Probably a copy paste error :/
> 

Do you think the traces are still appropriate once we have
proper error propagation?

I did not feel comfortable removing them but thinking again,
than might be the thing to do.

@Christian:
I think we should really fix this the one way or the other.
Can you tell me what is the proper procedure?

>>
>>> +        goto fail;
>>>      }
>>>      flic_state->fd = cd.fd;
>>
> 
> 
