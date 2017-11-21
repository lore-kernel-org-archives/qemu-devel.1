Received: from eggs.gnu.org ([2001:4830:134:3::10]:49187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHBzn-0001Kv-AI
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHBzi-0006S3-4L
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:06:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50122
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eHBzh-0006Ra-To
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:05:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vALGx8Z3020869
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 12:05:53 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ecqvah2p8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 12:05:53 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 21 Nov 2017 17:05:51 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
	<20171121172022.5da16158.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 21 Nov 2017 18:05:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171121172022.5da16158.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <88bc72cf-732c-fc07-9898-18d7b58b947d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 11/21/2017 05:20 PM, Cornelia Huck wrote:
> On Tue, 21 Nov 2017 16:47:29 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 11/21/2017 02:44 PM, Cornelia Huck wrote:
>>> On Tue, 21 Nov 2017 12:18:25 +0100
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
[..]
>>>
>>> - Add a property to specify the default cssid. Compat machines use a
>>>   default cssid of 0xfe.
>>> - Default to a cssid of 0.
>>> - (optional) Warn when putting a non-virtual device into css 0xfe,
>>>   unless it is the default css.
>>>   
>>
>> Please see Christians response. IMHO the libvirt perspective, and
>> especially keeping the domain xmls as they are today viable is the
>> key to a good solution.
>>
>> AFAIU one should probably use vfio-ccw as devices having their own
>> xml managed via attach-device and detach-device, as they are not
>> migratable (thus need to be removed before migrating). If we want
>> to be able to attach such devices to domains especially created
>> with vfio-ccw in mind putting all the devices into 0xfe seems to
>> be the only sane way.
>>
>> Something like mcsse-squash isn't really a good solution, because
>> doing it behind of the back of the user in libvirt feels wrong,
>> and if we have to make the user put it in the domain xml then
>> we are back at special domain definitions problem.
> 
> See my response in the other thread as well. I'm not really opposed to
> keeping 0xfe as the default.
> 

Sure. Done.

>>
>>>>
>>>> The adverse effect on migration should not be too severe as
>>>> vfio-ccw devices are not live-migratable yet, and for virtual
>>>> devices using the extra freedom would only make sense with
>>>> the aforementioned guest support in place.
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>>>
>>>> ---
>>>> Hi!
>>>>
>>>> About indicating this at the ccw devices instead of, e.g. as a machine
>>>> property (or otherwise globally), was requested by our libvirt guys. I
>>>> have no strong opinion regarding in this matter.  
>>>
>>> I would like to understand why. It feels very odd.
>>>   
>>
>> @Boris: I would like to delegate explaining to you. I did understand
>> your arguments, but I'm not confident about being able to reproduce them
>> authentically.
>>
>>>>
>>>> This patch is intended as a discussion starter. I would at least like to
>>>> get a Tested-by by Shalini before promoting it to non-RFC (provided the
>>>> discussion goes well).
>>>>
>>>> TODOs:
>>>> * Consider adding a description for the new property.  
>>>
>>> As it is, it is rather incomprehensible. But see below.
>>>   
>>
>> OK. The idea is that this property should be used for libvirt.
> 
> Yes, but what for? That was my problem.
> 

Libvirt is going to refuse using vfio-ccw devices if the
property is not defined (existent). I hope Boris is going to provide
his perspective tomorrow.

>>
>> Comprehensibility is a general problem as the user should not
>> really have to care about mcss-e at all (see PoP). How should we
>> explain mcss-e to the user? AFAIR this is what triggered the usability
>> discussion.
> 
> I think we can expect an admin wanting to set up machines understand
> the fact that there are multiple cssids, but only the default one can
> be seen by most guests.
> 

That much at least probably. But I think the less the admin/user is
forced to know abut multiple channel subsystems the better. For various
reasons.

>>
>>>> * Consider renaming VIRTUAL_CSSID.  
>>>
>>> Why? This is still reserved for virtual devices in the architecture.
>>> You just change qemu policy (and possibly what the default cssid is).
>>>  
>>
>> I don't think so. Where is it reserved in the architecture? The
>> only reference I've found is our VSM book. Sorry I really can't
>> find it.
> 
> It was reserved with some architecture folks; Christian should know (I
> obviously don't have access to anything anymore).
> 

@Christian: AFAIU you this wont be a problem. Let's have a chat about this
tomorrow.
 
>>  
>>>> * Consider changing the bus-id generation scheme (when
>>>> devno is not specified by the user). his patch keep the current scheme in
>>>> place: they won't go into the default css (but slots are filled up
>>>> starting at cssid 0). This is theoretically good for migration
>>>> compatibility same command line same addresses.  Practically since there
>>>> is no migratable non-virtual ccw device, we should consider using the
>>>> same bus-id generation scheme for virtual and non-virtual devices.  
>>>
>>> How does this interact with the squash parameter?  
>>
>>
>> With squash it would not change anything: we would start at default cssid which is 0
>> with squash. Without squash it would have the effect that we first
>> fill the default css and then proceed to the next one. Would change
>> behavior. The hope is that nobody used non-virtual devices without
>> squash on, as they are useless that way since there is no mcss-e
>> guest around.
>>
>> The expected benefit is that the devices would show up in the guest
>> instead of being effectively inaccessible -- sane defaults.
>>
>> I forgot to write, but I would actually like to deprecate the squash.
>> I see it as something on top though.
> 
> I'd vote for getting rid of it as soon as possible.
>

Me to. I've already got my patch for deprecation half baked ;).
 
The original question was about weather keep the start putting
non-virtual devices into (the non-guest-visible) 0 if no devno is
specified, or rather fill the default first and only then spill
to the next css.

>>
>>>
>>> If we force the default css to 0xfe for compat machines, we should be
>>> fine if we autogenerate to the default css. If you start at css 0
>>> regardless of the default css, you might end up with a configuration
>>> that the user did not expect at all.
>>>   
>>
>> I don't force anything in the compat machines here. So I don't understand
>> your question.
> 
> It refers to my suggestion above (specifying a default css).
> 

Was my understanding too, so I did not want to go too deep.

[..]

>>>> +    object_class_property_add_bool(klass, "cssid-unrestricted",
>>>> +                                   prop_get_true, NULL, NULL);  
>>>
>>> This looks really, really strange. This is a property that is always
>>> true if it exists.
>>>   
>>
>> Won't argue about that. The libvirt guys are actually not interested
>> int he value at all: only that there is such a property.
> 
> So what about a machine property? Wouldn't that help as well?
> 

Technically it is doable. The property would be still a weird
one, but from QEMU perspective in a less weird place. I was also
arguing that from OO perspective this kind of a don't care about
it's value property is weird, but AFAIK not having the info if
we can do something with a device at the device is weird from
Libvirt perspective. I'm really uncomforble with speaking for
Libvirt/Boris. Hope he will make his point tomorrow.

> Or a css object?
> 

My first internal-only version used this approach, but
I was asked to do it like this.

>>
>>> What about compat machines? This qemu won't have the restriction, but
>>> old qemus will.
>>>   
>>
>> Very true. But as the commit message implies it should not be a problem.
> 
> How is that supposed to play with libvirt detection, then?
> 

As written above. Libvirt will simply refuse to use vfio-ccw if the property
is not defined. This results in no prior history to care about for libvirt
users: vfio-ccw effectively becomes available with qemu 2.12.

>>
>>> Also, I'd consider this a property of the machine, not of the
>>> individual devices. Or of the ChannelSubsystem structure, which is not
>>> qom'ified.
>>>   
>>
>> I've said the exact same thing to Boris. He said from libvirt perspective
>> a device property is better.
>>
>>> As an alternative, I think providing a machine default_cssid parameter
>>> makes more sense: It is understandable, and you keep compatibility. I
>>> think we want this in the long run anyway.
>>>   
>>
>> I think most of us had the idea. I support this idea fully (expose default
>> cssid to the user (rw)). I see it as something that can be done on top
>> and is not a pressing issue, but rather a nice to have.
> 
> TBH, this weird property is what I like least about this patch.
> 

I'm fine with any of the 3 alternatives (as is, new type, new machine prop).

I do agree the property is weird, but a machine property would in my opinion
also be weird (especially form libvirt perspective, but also from qemu
perspective e.g. compat handling and machine type none).

I used to think that using a trait type is the cleanest, but one advantage
of the approach taken in this patch is that it can be introspected via command
line (it is quite weird though).

>>>>  }
>>>>  
>>>>  const VMStateDescription vmstate_ccw_dev = {
>>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>>> index f6b5c807cd..957cb9ec90 100644
>>>> --- a/hw/s390x/css.c
>>>> +++ b/hw/s390x/css.c
>>>> @@ -2377,15 +2377,6 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
>>>>      SubchDev *sch;
>>>>  
>>>>      if (bus_id.valid) {
>>>> -        if (is_virtual != (bus_id.cssid == VIRTUAL_CSSID)) {
>>>> -            error_setg(errp, "cssid %hhx not valid for %s devices",
>>>> -                       bus_id.cssid,
>>>> -                       (is_virtual ? "virtual" : "non-virtual"));
>>>> -            return NULL;
>>>> -        }
>>>> -    }  
>>>
>>> This allows building a commandline in a compat machine that will not
>>> work with old qemus, no?
>>>   
>>
>> Yes. We have considered this. I was convinced by Christian that
>> it ain't too bad. In the end, if we don't want non-virtual device
>> aware domains (see above), then there is no way to make this work
>> with libvirt. Actually to make the migration work with libvirt with
>> old qemus the only way would be to use sqash. But libvirt does not
>> want that.
>>
>> Also consider that vfio-ccw (AFAIK the only non-virtual css device
>> type) is not migratable. So having them on the command line and live
>> migrating is a lost case already.
>>
>> Yes, having a pre- 2.12 binary version and a post 2.12 binary version
>> way to use vfio-ccw is ugly to some extent. The recommendation would
>> be don't use it with pre 2.12 (libvirt is going to plainly refuse).
>>
>> And yes with this one is going to be able to write a 2.12 command
>> line which does not work with 2.11 but that is normal.
>>
>> This patch keeps the squash so the 2.10 definition will still be
>> viable for 2.12. Should we sometime get rid of the squash, then
>> that would be a breaking change.
> 
> Removing squash is easy to detect. I'm a bit worried about
> not-obvious-at-the-start breakage.
> 

Again won't happen with libvirt. With a direct command line user
downgrading or moving to a qemu 2.10 or 2.11 it is a risk we can
take IMHO.

Also I can't find anything about vfio-ccw in the upstream users
manual for 2.10.91. So I would argue using vfio-ccw is using an
undocumented feature: if undocumented features changing in a non
compatible way hits you, it's partly your own fault.

To sum it up. It is not nice, I agree but I don't see better alternatives.

I hope you and Boris will reach consensus on what is the best
way to expose the change.  I really don't have any strong opinion
on this (maybe except finding the machine property solution the least
favorable one). If it turns out Boris does not want to lead this
discussion, I will take responsibility as the author of course.

Regards,
Halil

[..]
