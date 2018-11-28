Received: from eggs.gnu.org ([2001:4830:134:3::10]:48809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gS0si-0002Ks-Ca
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gS0sf-0000Xk-5v
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:32:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44002
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gS0se-0000XJ-WD
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:31:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wASENxEa117897
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 09:31:56 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p1u9av6c0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 09:31:55 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 28 Nov 2018 14:31:55 -0000
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
	<b5066f7a-7024-ac3e-a91d-938fd845e1d9@linux.ibm.com>
	<20181128100249.72d4299a.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 28 Nov 2018 09:31:51 -0500
MIME-Version: 1.0
In-Reply-To: <20181128100249.72d4299a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <25021742-a7a8-a90c-a2a3-eb8a78bf1fb0@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] vfio-ccw: add handling for asnyc
 channel instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 11/28/2018 04:02 AM, Cornelia Huck wrote:
> On Tue, 27 Nov 2018 14:09:49 -0500
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 11/22/2018 11:54 AM, Cornelia Huck wrote:
>>> Add a region to the vfio-ccw device that can be used to submit
>>> asynchronous I/O instructions. ssch continues to be handled by the
>>> existing I/O region; the new region handles hsch and csch.
>>>
>>> Interrupt status continues to be reported through the same channels
>>> as for ssch.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>    drivers/s390/cio/Makefile           |   3 +-
>>>    drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++++++
>>>    drivers/s390/cio/vfio_ccw_drv.c     |  48 ++++++---
>>>    drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++++++++-
>>>    drivers/s390/cio/vfio_ccw_ops.c     |  13 ++-
>>>    drivers/s390/cio/vfio_ccw_private.h |   6 ++
>>>    include/uapi/linux/vfio.h           |   4 +
>>>    include/uapi/linux/vfio_ccw.h       |  12 +++
>>>    8 files changed, 313 insertions(+), 19 deletions(-)
>>>    create mode 100644 drivers/s390/cio/vfio_ccw_async.c
>>>
> 
>>> @@ -76,7 +79,8 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>>>    	private = container_of(work, struct vfio_ccw_private, io_work);
>>>    	irb = &private->irb;
>>>    
>>> -	if (scsw_is_solicited(&irb->scsw)) {
>>> +	if (scsw_is_solicited(&irb->scsw) &&
>>> +	    (scsw_fctl(&irb->scsw) & SCSW_FCTL_START_FUNC)) {
>>>    		cp_update_scsw(&private->cp, &irb->scsw);
>>>    		cp_free(&private->cp);
>>>    	}
>>
>> I am a little confused about this. Why do we need to update the scsw.cpa
>> if we have the start function function control bit set? Is it an
>> optimization?
> 
> No, it's not an optimization. This is the work function that is
> scheduled if we get an interrupt for the device. Previously, we only
> got an interrupt if either the device presented us an unsolicited
> status or if we got an interrupt as a response to the channel program
> we submitted. Now, we can get an interrupt for halt/clear subchannel as
> well, and in that case, we don't necessarily have a cp.
> 
> [Thinking some more about it, we need to verify if the start function
> actually remains set if we try to terminate a running channel program
> with halt/clear. A clear might scrub too much. If that's the case, we
> also need to free the cp if the start function is not set.]
> 
> 

According to PoPs (Chapter 16: I/O interruptions, under function control):

The start-function indication is also cleared at
the subchannel during the execution of CLEAR SUB-
CHANNEL.

So maybe we do need to free the cp.
