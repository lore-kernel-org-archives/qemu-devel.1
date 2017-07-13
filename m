Received: from eggs.gnu.org ([2001:4830:134:3::10]:46167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVYel-0003Tn-D0
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVYei-0006Mn-8m
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:35:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVYeh-0006M9-Ur
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:35:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D7XxeP052564
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:35:22 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3qbv4v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:35:22 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 03:35:21 -0400
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-9-git-send-email-borntraeger@de.ibm.com>
	<20170712170713.1f5cf6b2@dhcp-192-215.str.redhat.com>
	<e44ca276-3318-1a18-9075-8edd6305c69c@de.ibm.com>
	<20170713092753.5a3ba530@gondolin>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 09:35:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170713092753.5a3ba530@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <dbd447b4-3a72-e5ef-9dc3-07202dad7c16@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 08/11] s390x/flic: introduce
 modify_ais_mode callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Fei Li <sherrylf@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

On 07/13/2017 09:27 AM, Cornelia Huck wrote:
> On Thu, 13 Jul 2017 09:12:50 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 07/12/2017 05:07 PM, Cornelia Huck wrote:
>>>> +
>>>> +    switch (mode) {
>>>> +    case SIC_IRQ_MODE_ALL:
>>>> +        flic->simm &= ~AIS_MODE_MASK(isc);
>>>> +        flic->nimm &= ~AIS_MODE_MASK(isc);
>>>> +        break;
>>>> +    case SIC_IRQ_MODE_SINGLE:
>>>> +        flic->simm |= AIS_MODE_MASK(isc);
>>>> +        flic->nimm &= ~AIS_MODE_MASK(isc);  
>>>
>>> Can we have some documentation about the meaning of simm/nimm in qemu?
>>> The one from the patch description of the respective kernel patch would
>>> be fine.  
>>
>> Do you want to have that description as part of the patch description or
>> somewhere in the docs folder or somewhere in the code?
> 
> A comment near the definition of simm/nimm would be nice. Or in the
> commit message, as for the kernel.
> 

I  think I will just add this to the commit message:

We introduce the 'simm' and 'nimm' fields to QEMUS390FLICState
to store interruption modes for each ISC. Each bit in 'simm' and
'nimm' targets to one ISC, and collaboratively indicate three modes:
ALL-Interruptions, SINGLE-Interruption and NO-Interruptions. This
interface can initiate most transitions between the states; transition
from SINGLE-Interruption to NO-Interruptions via adapter interrupt
injection will be introduced in a following patch. The meaningful
combinations are as follows:
    
    interruption mode | simm bit | nimm bit
    ------------------|----------|----------
             ALL      |    0     |     0
           SINGLE     |    1     |     0
             NO       |    1     |     1
    
