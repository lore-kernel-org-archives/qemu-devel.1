Received: from eggs.gnu.org ([2001:4830:134:3::10]:50537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gS2CD-00009Z-BG
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gS2C6-00045G-HF
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:56:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gS2C6-00042n-5w
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:56:06 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wASFtrrs108659
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 10:56:04 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p1ugr03h5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 10:55:56 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 28 Nov 2018 15:55:15 -0000
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
	<b5066f7a-7024-ac3e-a91d-938fd845e1d9@linux.ibm.com>
	<20181128100249.72d4299a.cohuck@redhat.com>
	<25021742-a7a8-a90c-a2a3-eb8a78bf1fb0@linux.ibm.com>
	<20181128155201.5be1d582.cohuck@redhat.com>
	<1feb66c0-ce80-2853-1522-e7d787471fd3@linux.ibm.com>
	<20181128163547.7eb33873.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 28 Nov 2018 10:55:11 -0500
MIME-Version: 1.0
In-Reply-To: <20181128163547.7eb33873.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a9eb4e42-536e-efa4-7097-c05492078fb0@linux.ibm.com>
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



On 11/28/2018 10:35 AM, Cornelia Huck wrote:
> On Wed, 28 Nov 2018 10:00:59 -0500
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 11/28/2018 09:52 AM, Cornelia Huck wrote:
>>> On Wed, 28 Nov 2018 09:31:51 -0500
>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>    
>>>> On 11/28/2018 04:02 AM, Cornelia Huck wrote:
>>>>> On Tue, 27 Nov 2018 14:09:49 -0500
>>>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>>>       
>>>>>> On 11/22/2018 11:54 AM, Cornelia Huck wrote:
>>>>>>> Add a region to the vfio-ccw device that can be used to submit
>>>>>>> asynchronous I/O instructions. ssch continues to be handled by the
>>>>>>> existing I/O region; the new region handles hsch and csch.
>>>>>>>
>>>>>>> Interrupt status continues to be reported through the same channels
>>>>>>> as for ssch.
>>>>>>>
>>>>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>>>> ---
>>>>>>>      drivers/s390/cio/Makefile           |   3 +-
>>>>>>>      drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++++++
>>>>>>>      drivers/s390/cio/vfio_ccw_drv.c     |  48 ++++++---
>>>>>>>      drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++++++++-
>>>>>>>      drivers/s390/cio/vfio_ccw_ops.c     |  13 ++-
>>>>>>>      drivers/s390/cio/vfio_ccw_private.h |   6 ++
>>>>>>>      include/uapi/linux/vfio.h           |   4 +
>>>>>>>      include/uapi/linux/vfio_ccw.h       |  12 +++
>>>>>>>      8 files changed, 313 insertions(+), 19 deletions(-)
>>>>>>>      create mode 100644 drivers/s390/cio/vfio_ccw_async.c
>>>>>>>      
>>>>>       
>>>>>>> @@ -76,7 +79,8 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>>>>>>>      	private = container_of(work, struct vfio_ccw_private, io_work);
>>>>>>>      	irb = &private->irb;
>>>>>>>      
>>>>>>> -	if (scsw_is_solicited(&irb->scsw)) {
>>>>>>> +	if (scsw_is_solicited(&irb->scsw) &&
>>>>>>> +	    (scsw_fctl(&irb->scsw) & SCSW_FCTL_START_FUNC)) {
>>>>>>>      		cp_update_scsw(&private->cp, &irb->scsw);
>>>>>>>      		cp_free(&private->cp);
>>>>>>>      	}
>>>>>>
>>>>>> I am a little confused about this. Why do we need to update the scsw.cpa
>>>>>> if we have the start function function control bit set? Is it an
>>>>>> optimization?
>>>>>
>>>>> No, it's not an optimization. This is the work function that is
>>>>> scheduled if we get an interrupt for the device. Previously, we only
>>>>> got an interrupt if either the device presented us an unsolicited
>>>>> status or if we got an interrupt as a response to the channel program
>>>>> we submitted. Now, we can get an interrupt for halt/clear subchannel as
>>>>> well, and in that case, we don't necessarily have a cp.
>>>>>
>>>>> [Thinking some more about it, we need to verify if the start function
>>>>> actually remains set if we try to terminate a running channel program
>>>>> with halt/clear. A clear might scrub too much. If that's the case, we
>>>>> also need to free the cp if the start function is not set.]
>>>>>
>>>>>       
>>>>
>>>> According to PoPs (Chapter 16: I/O interruptions, under function control):
>>>>
>>>> The start-function indication is also cleared at
>>>> the subchannel during the execution of CLEAR SUB-
>>>> CHANNEL.
>>>>
>>>> So maybe we do need to free the cp.
>>>
>>> Hm... so we need to make sure that cp_update_scsw() and cp_free() only
>>> do something when there's actually a valid cp around and call them
>>> unconditionally.
>>
>> Yes, I agree.
>>
>>> Maybe add a ->valid flag to struct channel_program?
>>
>> We could do that. So we would set the flag once we have copied the
>> channel program to kernel memory? since that's when we should care about
>> freeing it.
> 
> I hacked up the following (still untested):
> 
>  From e771c8dc5abbfbd19688b452096bab9d032e0df5 Mon Sep 17 00:00:00 2001
> From: Cornelia Huck <cohuck@redhat.com>
> Date: Wed, 28 Nov 2018 16:30:51 +0100
> Subject: [PATCH] vfio-ccw: make it safe to access channel programs
> 
> When we get a solicited interrupt, the start function may have
> been cleared by a csch, but we still have a channel program
> structure allocated. Make it safe to call the cp accessors in
> any case, so we can call them unconditionally.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c  | 9 ++++++++-
>   drivers/s390/cio/vfio_ccw_cp.h  | 2 ++
>   drivers/s390/cio/vfio_ccw_drv.c | 3 +--
>   3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 70a006ba4d05..35f87514276b 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -335,6 +335,7 @@ static void cp_unpin_free(struct channel_program *cp)
>   	struct ccwchain *chain, *temp;
>   	int i;
>   
> +	cp->initialized = false;
>   	list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
>   		for (i = 0; i < chain->ch_len; i++) {
>   			pfn_array_table_unpin_free(chain->ch_pat + i,
> @@ -701,6 +702,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>   	 */
>   	cp->orb.cmd.c64 = 1;
>   
> +	cp->initialized = true;
> +
>   	return ret;
>   }
>   
> @@ -715,7 +718,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>    */
>   void cp_free(struct channel_program *cp)
>   {
> -	cp_unpin_free(cp);
> +	if (cp->initialized)
> +		cp_unpin_free(cp);
>   }
>   
>   /**
> @@ -831,6 +835,9 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
>   	u32 cpa = scsw->cmd.cpa;
>   	u32 ccw_head, ccw_tail;
>   
> +	if (!cp->initialized)
> +		return;
> +
>   	/*
>   	 * LATER:
>   	 * For now, only update the cmd.cpa part. We may need to deal with
> diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
> index a4b74fb1aa57..3c20cd208da5 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.h
> +++ b/drivers/s390/cio/vfio_ccw_cp.h
> @@ -21,6 +21,7 @@
>    * @ccwchain_list: list head of ccwchains
>    * @orb: orb for the currently processed ssch request
>    * @mdev: the mediated device to perform page pinning/unpinning
> + * @initialized: whether this instance is actually initialized
>    *
>    * @ccwchain_list is the head of a ccwchain list, that contents the
>    * translated result of the guest channel program that pointed out by
> @@ -30,6 +31,7 @@ struct channel_program {
>   	struct list_head ccwchain_list;
>   	union orb orb;
>   	struct device *mdev;
> +	bool initialized;
>   };
>   
>   extern int cp_init(struct channel_program *cp, struct device *mdev,
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 890c588a3a61..83d6f43792b6 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -79,8 +79,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
>   	private = container_of(work, struct vfio_ccw_private, io_work);
>   	irb = &private->irb;
>   
> -	if (scsw_is_solicited(&irb->scsw) &&
> -	    (scsw_fctl(&irb->scsw) & SCSW_FCTL_START_FUNC)) {
> +	if (scsw_is_solicited(&irb->scsw)) {
>   		cp_update_scsw(&private->cp, &irb->scsw);
>   		cp_free(&private->cp);
>   	}
> 

The changes look good to me.

Thanks
Farhan
