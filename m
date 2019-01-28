Received: from eggs.gnu.org ([209.51.188.92]:38033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1goElm-0006Tg-Sh
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1goElj-0008GO-FA
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:48:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49150
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1goElg-00082R-77
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:48:36 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0SLiGnO079969
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 16:48:18 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qa6hca8v1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 16:48:17 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Mon, 28 Jan 2019 21:48:17 -0000
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<20190125150101.3b61f0a1@oc2783563651>
	<20190128180948.506a9695.cohuck@redhat.com>
	<20190128201548.1ecfb84f@oc2783563651>
From: Eric Farman <farman@linux.ibm.com>
Date: Mon, 28 Jan 2019 16:48:10 -0500
MIME-Version: 1.0
In-Reply-To: <20190128201548.1ecfb84f@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d43e273d-ef90-9a1e-c87a-1365718d8978@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 01/28/2019 02:15 PM, Halil Pasic wrote:
> On Mon, 28 Jan 2019 18:09:48 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Fri, 25 Jan 2019 15:01:01 +0100
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>> On Fri, 25 Jan 2019 13:58:35 +0100
>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>>> - The code should not be interrupted while we process the channel
>>>>    program, do the ssch etc. We want the caller to try again later (i.e.
>>>>    return -EAGAIN)
>>
>> (...)
>>
>>>> - With the async interface, we want user space to be able to submit a
>>>>    halt/clear while a start request is still in flight, but not while
>>>>    we're processing a start request with translation etc. We probably
>>>>    want to do -EAGAIN in that case.
>>>
>>> This reads very similar to your first point.
>>
>> Not quite. ssch() means that we have a cp around; for hsch()/csch() we
>> don't have such a thing. So we want to protect the process of
>> translating the cp etc., but we don't need such protection for the
>> halt/clear processing.
>>
> 
> What does this don't 'need such protection' mean in terms of code,
> moving the unlock of the io_mutex upward (in
> vfio_ccw_async_region_write())?
> 
> Here the function in question for reference:
> 
> +static ssize_t vfio_ccw_async_region_write(struct vfio_ccw_private
> *private,
> +					   const char __user *buf,
> size_t count,
> +					   loff_t *ppos)
> +{
> +	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) -
> VFIO_CCW_NUM_REGIONS;
> +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
> +	struct ccw_cmd_region *region;
> +	int ret;
> +
> +	if (pos + count > sizeof(*region))
> +		return -EINVAL;
> +
> +	if (private->state == VFIO_CCW_STATE_NOT_OPER ||
> +	    private->state == VFIO_CCW_STATE_STANDBY)
> +		return -EACCES;
> +	if (!mutex_trylock(&private->io_mutex))
> +		return -EAGAIN;
> +
> +	region = private->region[i].data;
> +	if (copy_from_user((void *)region + pos, buf, count)) {
> +		ret = -EFAULT;
> +		goto out_unlock;
> +	}
> +
> +	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_ASYNC_REQ);
> +
> +	ret = region->ret_code ? region->ret_code : count;
> +
> +out_unlock:
> +	mutex_unlock(&private->io_mutex);
> +	return ret;
> +}
> 
> That does not make much sense to me at the moment (so I guess I
> misunderstood again).
> 
>>>
>>>>
>>>> My idea would be:
>>>>
>>>> - The BUSY state denotes "I'm busy processing a request right now, try
>>>>    again". We hold it while processing the cp and doing the ssch and
>>>>    leave it afterwards (i.e., while the start request is processed by
>>>>    the hardware). I/O requests and async requests get -EAGAIN in that
>>>>    state.
>>>> - A new state (CP_PENDING?) is entered after ssch returned with cc 0
>>>>    (from the BUSY state). We stay in there as long as no final state for
>>>>    that request has been received and delivered. (This may be final
>>>>    interrupt for that request, a deferred cc, or successful halt/clear.)
>>>>    I/O requests get -EBUSY, async requests are processed. This state can
>>>>    be removed again once we are able to handle more than one outstanding
>>>>    cp.
>>>>
>>>> Does that make sense?
>>>>    
>>>
>>> AFAIU your idea is to split up the busy state into two states: CP_PENDING
>>> and of busy without CP_PENDING called BUSY. I like the idea of having a
>>> separate state for CP_PENDING but I don't like the new semantic of BUSY.
>>>
>>> Hm mashing a conceptual state machine and the jumptabe stuff ain't
>>> making reasoning about this simpler either. I'm taking about the
>>> conceptual state machine. It would be nice to have a picture of it and
>>> then think about how to express that in code.
>>
>> Sorry, I'm having a hard time parsing your comments. Are you looking
>> for something like the below?
> 
> I had more something like this
> https://en.wikipedia.org/wiki/UML_state_machine,
> in mind but the lists of state transitions are also useful.
> 

I think the picture Connie paints below is just as useful as any 
formalized UML diagram.

>>
>> IDLE --- IO_REQ --> BUSY ---> CP_PENDING --- IRQ ---> IDLE (if final
> 
> There ain't no trigger/action list  between BUSY and CP_PENDING.

Right, because BUSY means "KVM started processing a SSCH" and CP_PENDING 
means "KVM finished processing the SSCH and issued it to the hardware, 
and got cc=0."

> I'm also in the  dark about where the issuing of the ssch() happen
> here (is it an internal transition within CP_PENDING?). 

Connie said...

 >>>> - A new state (CP_PENDING?) is entered after ssch returned with cc 0
 >>>>    (from the BUSY state).

...and I agree with that.

I guess if
> the ssch() returns with non cc == 0 the CP_PENDING ---IRQ---> IDLE
> transition
> won't take place. And I guess the IRQ is a final one.

Yes this is the one point I hadn't seen explicitly stated.  We shouldn't 
remain in state=BUSY if the ssch got cc!=0, and probably return to IDLE 
when processing the failure.  In Connie's response (Mon, 28 Jan 2019 
18:24:24 +0100) to my note, she expressed some agreement to that.

> 
> Sorry abstraction is not a concept unknown to me. But this is too much
> abstraction for me in this context. The devil is in the details, and
> AFAIU we are discussing these details right now.
>   
> 
>> state for I/O)
>> (normal ssch)
>>
>> BUSY --- IO_REQ ---> return -EAGAIN, stay in BUSY
>> (user space is supposed to retry, as we'll eventually progress from
>> BUSY)
>>
>> CP_PENDING --- IO_REQ ---> return -EBUSY, stay in CP_PENDING
>> (user space is supposed to map this to the appropriate cc for the guest)
> 
>  From this it seems you don't intend to issue the second  requested ssch()
> any more (and don't want to do any translation). Is that right? (If it
> is, that what I was asking for for a while, but then it's a pity for the
> retries.)
> 
>>
>> IDLE --- ASYNC_REQ ---> IDLE
>> (user space is welcome to do anything else right away)
> 
> Your idea is to not issue a requested hsch() if we think we are IDLE
> it seems. Do I understand this right? We would end up with a different
> semantic for hsch()/and csch() (compared to PoP) in the guest with this
> (AFAICT).
> 
>>
>> BUSY --- ASYNC_REQ ---> return -EAGAIN, stay in BUSY
>> (user space is supposed to retry, as above)
>>
>> CP_PENDING --- ASYNC_REQ ---> return success, stay in CP_PENDING
>> (the interrupt will get us out of CP_PENDING eventually)
> 
> Issue (c|h)sch() is an action that is done on this internal
> transition (within CP_PENDING).

These three do read like CSCH/HSCH are subject to the same rules as 
SSCH, when in fact they would be (among other reasons) issued to clean 
up a lost interrupt from a previous SSCH.  So maybe return -EAGAIN on 
state=BUSY (don't race ourselves with the start), but issue to hardware 
if CP_PENDING.

If we get an async request when state=IDLE, then maybe just issue it for 
fun, as if it were an SSCH?

> 
> Thank you very much for investing into this description of the state
> machine. I'm afraid I'm acting like a not so nice person (self censored)
> at the moment. I can't help myself, sorry. Maybe Farhan and Eric can take
> this as a starting point and come up with something that we can integrate
> into our documentation. Maybe not...
> 
> Regards,
> Halil
> 
