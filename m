Received: from eggs.gnu.org ([209.51.188.92]:44877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gr24l-0004as-Hw
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gr21r-0003oA-SV
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:48:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38896
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gr21o-0003Yz-63
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:48:49 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x15EcTZF023847
	for <qemu-devel@nongnu.org>; Tue, 5 Feb 2019 09:48:28 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qfamdp5qu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:48:28 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Tue, 5 Feb 2019 14:48:27 -0000
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-2-cohuck@redhat.com>
	<20190130195127.5ff3c849@oc2783563651>
	<20190131125220.285a4bc8.cohuck@redhat.com>
	<20190131133455.3097613f@oc2783563651>
	<20190204163102.33d744d8.cohuck@redhat.com>
	<20190205125229.56c6e252@oc2783563651>
	<20190205133540.573902d8.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 5 Feb 2019 09:48:23 -0500
MIME-Version: 1.0
In-Reply-To: <20190205133540.573902d8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ad60e2d5-f222-da38-41fd-bcbd7c9965a0@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/6] vfio-ccw: make it safe to access
 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 02/05/2019 07:35 AM, Cornelia Huck wrote:
> On Tue, 5 Feb 2019 12:52:29 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Mon, 4 Feb 2019 16:31:02 +0100
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>> On Thu, 31 Jan 2019 13:34:55 +0100
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    
>>>> On Thu, 31 Jan 2019 12:52:20 +0100
>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>    
>>>>> On Wed, 30 Jan 2019 19:51:27 +0100
>>>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>>>      
>>>>>> On Wed, 30 Jan 2019 14:22:07 +0100
>>>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>>>      
>>>>>>> When we get a solicited interrupt, the start function may have
>>>>>>> been cleared by a csch, but we still have a channel program
>>>>>>> structure allocated. Make it safe to call the cp accessors in
>>>>>>> any case, so we can call them unconditionally.
>>>>>>
>>>>>> I read this like it is supposed to be safe regardless of
>>>>>> parallelism and threads. However I don't see any explicit
>>>>>> synchronization done for cp->initialized.
>>>>>>
>>>>>> I've managed to figure out how is that supposed to be safe
>>>>>> for the cp_free() (which is probably our main concern) in
>>>>>> vfio_ccw_sch_io_todo(), but if fail when it comes to the one
>>>>>> in vfio_ccw_mdev_notifier().
>>>>>>
>>>>>> Can you explain us how does the synchronization work?
>>>>>
>>>>> You read that wrong, I don't add synchronization, I just add a check.
>>>>>      
>>>>
>>>> Now I'm confused. Does that mean we don't need synchronization for this?
>>>
>>> If we lack synchronization (that is not provided by the current state
>>> machine handling, or the rework here), we should do a patch on top
>>> (preferably on top of the whole series, so this does not get even more
>>> tangled up.) This is really just about the extra check.
>>>    
>>
>> I'm not a huge fan of keeping or introducing races -- it makes things
>> difficult to reason about, but I do have some understanging your
>> position.
> 
> The only thing I want to avoid is knowingly making things worse than
> before, and I don't think this patch does that.
> 
>>
>> This patch-series is AFAICT a big improvement over what we have. I would
>> like Farhan confirming that it makes these hick-ups when he used to hit
>> BUSY with another ssch request disappear. If it does (I hope it does)
>> it's definitely a good thing for anybody who wants to use vfio-ccw.
> 
> Yep. There remains a lot to be done, but it's a first step.

s/a first step/an excellent first step/  :)

Can't speak for Farhan, but this makes things somewhat better for me. 
I'm still getting some periodic errors, but they happen infrequently 
enough now that debugging them is frustrating.  ;-)

  - Eric

> 
>>
>> Yet I find it difficult to slap my r-b over racy code, or partial
>> solutions. In the latter case, when I lack conceptual clarity, I find it
>> difficult to tell if we are heading into the right direction, or is what
>> we build today going to turn against us tomorrow. Sorry for being a drag.
> 
> As long as we don't introduce bad user space interfaces we have to drag
> around forever, I think anything is fair game if we think it's a good
> idea at that moment. We can rewrite things if it turned out to be a bad
> idea (although I'm not arguing for doing random crap, of course :)
> 
