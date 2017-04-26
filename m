Received: from eggs.gnu.org ([2001:4830:134:3::10]:55600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3PNd-0006HM-76
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3PNZ-000357-Bm
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:01:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d3PNZ-00034l-2h
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:01:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QFxARR027938
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 12:01:19 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2wj348e1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 12:01:19 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 10:01:16 -0600
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<20170426144645.12476-5-farman@linux.vnet.ibm.com>
	<e917804b-95d8-dbba-03f8-4ec31c438705@redhat.com>
	<0e9eb169-73d8-9afc-fd8d-bed492046110@linux.vnet.ibm.com>
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 12:00:48 -0400
MIME-Version: 1.0
In-Reply-To: <0e9eb169-73d8-9afc-fd8d-bed492046110@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <dfe0ded1-f24e-b90a-8cb5-3ed5b408d82c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 4/5] pc-bios/s390-ccw: Break up
 virtio-scsi read into multiples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>



On 04/26/2017 11:24 AM, Eric Farman wrote:
>
>
> On 04/26/2017 11:17 AM, Eric Blake wrote:
>> On 04/26/2017 09:46 AM, Eric Farman wrote:
>>> A virtio-scsi request that goes through the host sd driver and
>>> exceeds the maximum transfer size is automatically broken up
>>> for us. But the equivalent request going to the sg driver
>>> presumes that any length requirements have already been honored.
>>> Let's use the max_sectors field from the device and break up
>>> all virtio-scsi requests (both sd and sg) to avoid problem from
>>> the host drivers.
>>>
>>> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
>>> ---
>>>  pc-bios/s390-ccw/s390-ccw.h    |  4 ++++
>>>  pc-bios/s390-ccw/virtio-scsi.c | 19 ++++++++++++++-----
>>>  2 files changed, 18 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>>> index ded67bc..e1f3751 100644
>>> --- a/pc-bios/s390-ccw/s390-ccw.h
>>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>>> @@ -42,6 +42,10 @@ typedef unsigned long long __u64;
>>>  #ifndef NULL
>>>  #define NULL    0
>>>  #endif
>>> +#ifndef MIN
>>> +#define MIN(a, b) (((a) < (b)) ? (a) : (b));
>>> +#endif
>>
>> osdep.h defines MIN() for ALL files, so this hunk is spurious.
>
> Ah, so it does.  Okay, removed.  Thanks!

Er, not.  Changing this header file didn't force virtio-scsi.c to 
recompile, so it bombs out as Cornelia points out.

>
> I guess it would make sense for the hunk that uses it to use
> MIN_NON_ZERO instead, which is also defined there.
>
>>
>
>
