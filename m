Received: from eggs.gnu.org ([209.51.188.92]:55118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gguOC-0008Qx-KF
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gguOB-0005k6-K0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:38:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35220
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gguOB-0005hU-EL
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:38:03 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x08GXnhe059819
	for <qemu-devel@nongnu.org>; Tue, 8 Jan 2019 11:38:02 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pvwmaestc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 11:38:02 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Tue, 8 Jan 2019 16:38:01 -0000
Reply-To: jjherne@linux.ibm.com
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<20181212153426.2ca5a481.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 8 Jan 2019 11:37:56 -0500
MIME-Version: 1.0
In-Reply-To: <20181212153426.2ca5a481.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f38c791b-3aad-46a8-79e7-9adb74ba4726@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 00/15] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On 12/12/18 9:34 AM, Cornelia Huck wrote:
...
>>
>> NOTE: It has been a while, but I've finally chased down my infamous "reset bug".
>> On subsystem reset (I see this right after host ipl) we sometimes end up getting
>> an unexpected unit check status from a dasd device. This causes the first start
>> subchannel instruction to fail due to the pending unit check status. My solution
>> to this problem, as advised by the kernel folks, is to simply retry my ssch
>> instructions before declaring failure when unexpected unit checks happen. In the
>> event of a persistent error, after two retries we'll give up and print some
>> useful error info for the user.
> 
> So, is that a status we only see because the vfio-ccw driver keeps the
> subchannel enabled (as by the other recent thread)?
> 
> Is there any value in distinguishing different unit checks, or is retry
> the best strategy in any case?
> 
The status presents on device reset. So when the host kernel IPLs this status will be 
present. The very first attempt to use the device (SSCH, other instructions perhaps?) will 
cause this status to be presented. Sometimes the host kernel must "get there first" and 
clear the status. And other times the guest (by way of Qemu bios) gets there first.

The kernel handles unexpected unit checks by simply retrying a low number of times before 
giving up. Given that bios code is a constant frequency code path, and the kernel has 
already set this precedent, I feel safe with this decision and don't see a ton of value in 
doing much more. If we find a case that requires more handling we can take a look at it.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
