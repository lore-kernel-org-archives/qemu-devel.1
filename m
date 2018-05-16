Received: from eggs.gnu.org ([2001:4830:134:3::10]:47618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIzVI-0001qj-Gj
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIzVD-0007Yh-TS
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:42:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fIzVD-0007YP-LR
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:42:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4GGd9Jn089271
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 12:42:10 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j0pny5d41-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 12:42:09 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 16 May 2018 17:42:07 +0100
References: <20180510000712.6472-1-pasic@linux.ibm.com>
	<20180510000712.6472-2-pasic@linux.ibm.com>
	<20180514141808.78efe5c0.cohuck@redhat.com>
	<ea3c977e-de5c-ed68-fc8d-448efca1d463@linux.ibm.com>
	<20180514154515.056b605f.cohuck@redhat.com>
	<2b5d39df-ae97-5fe3-7a1a-658eff5db038@linux.ibm.com>
	<20180514180409.5eed7d79.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 16 May 2018 18:42:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180514180409.5eed7d79.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a5e60306-891d-5d9b-5ae2-0b10224aea93@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/2] vfio-ccw: add force
 unlimited prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Pierre Morel <pmorel@linux.ibm.com>



On 05/14/2018 06:04 PM, Cornelia Huck wrote:
> On Mon, 14 May 2018 16:22:30 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 05/14/2018 03:45 PM, Cornelia Huck wrote:
>>> On Mon, 14 May 2018 14:40:13 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    
>>>> On 05/14/2018 02:18 PM, Cornelia Huck wrote:
>>>>> On Thu, 10 May 2018 02:07:11 +0200
>>>>> Halil Pasic <pasic@linux.ibm.com> wrote:

[..]

>>>>>> +    bool f_upfch;
>>>>>
>>>>> force_unlimited_prefetch? You only use it that often :)
>>>>>       
>>>>
>>>> I would have expected complaints for the property name in the
>>>> first place. I think we should first find a good name for the
>>>> property and then consider the rest.
>>>
>>> What about 'force_pfch' (at least matches the name of the bit in the
>>> code)?
>>>    
>>
>> I like upfch more as it really not about forcing any prefetch, but
>> allowing *unlimited* prefetch for the channel program.
> 
> 'always_allow_prefetch', then? The problem is that we force a flag to
> be set, which does not force but allow something. Hard to express in a
> short property name :(
> 
> Any other suggestions?
> 

How about force-orb-pfch or force-orb-pbit (PoP name) for the property
and with underscores for the variable. My idea was (starting from your
force_pfch) to spell out that we are fiddling with that orb bit.

Can I/do I have to document the property somewhere? Telling the whole
story with the name is going to be difficult.

>>
>>>>   
>>>>>>     } VFIOCCWDevice;
> 
>>>>>> @@ -429,6 +441,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
>>>>>>     
>>>>>>     static Property vfio_ccw_properties[] = {
>>>>>>         DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
>>>>>> +    DEFINE_PROP_BOOL("f-upfch", VFIOCCWDevice, f_upfch, false),
>>>>>

[..]

>>>
>>> Another thought: Should there be a warning logged somewhere if we
>>> actually force pfch (i.e., not just set the property)?
>>>    
>>
>> I don't think so. With libvirt the cmd line gets logged. So we can
>> tell if the machine was running with this forced or not. This knob
>> is really (an opt-in) for expert users only.
> 
> But there's a difference between 'we set this one preemptively' and 'we
> set it, and the guest actually did a request with pfch off'.
> 

I expect the admin to set it *only* after seeing SSCHs fail with
the 'vfio-ccw requires PFCH flag set' message. So no preemptive usage
is expected, but...

>>
>> Furthermore a warning about this may not be very constructive,
>> as there is not much that can be done to make the warning go away.
>> IMHO getting used to warnings is not a good thing.
>>
>> Or am I missing a reason for issuing a warning?
> 
> Just log this once so that the admin sees 'yes, the guest actually did
> a request with pfch off, so if funny things happened, that might be the
> reason'. Of course, if this is only an edge use case, that would be
> overkill.
> 

... if the admin (actually more likely developer/tester) is mistaken
about the guest, and it does require the guarantees, but things don't blow
up right away, this message, together with the timestamp could help
determine why things turned funny.

So I do see the benefit now. But then I wonder if it should be a
WARN_ONCE type thing, or if we shall issue a warning each time the override
happens. (Considering the laid out expected benefit, if the first request
is OK but some subsequent one is not OK (needs the conservative prefetch
behavior) we don't gain much).

Regards,
Halil
