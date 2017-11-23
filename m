Received: from eggs.gnu.org ([2001:4830:134:3::10]:44704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHu4A-00078C-Pp
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHu47-0005iQ-Sx
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:09:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41336
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eHu47-0005hs-NP
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:09:27 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vANG8qra067815
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 11:09:24 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2edw6w5fqk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 11:09:23 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 23 Nov 2017 16:09:20 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
	<20171121172022.5da16158.cohuck@redhat.com>
	<88bc72cf-732c-fc07-9898-18d7b58b947d@linux.vnet.ibm.com>
	<20171122131343.26da0482.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 23 Nov 2017 17:09:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171122131343.26da0482.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <35aee93c-70e0-d9dd-b8e1-598c4e4c6a1c@linux.vnet.ibm.com>
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
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>Christian Borntraeger <borntraeger@de.ibm.com>



On 11/22/2017 01:13 PM, Cornelia Huck wrote:
[..]

>> The original question was about weather keep the start putting
>> non-virtual devices into (the non-guest-visible) 0 if no devno is
>> specified, or rather fill the default first and only then spill
>> to the next css.
> 
> Combined with what I said right below, I think we should be fine
> autogenerating into the default css. Anything else will just generate
> unusable configurations when the squash parameter is gone.
> 

OK. Will think about how to address this for v2 (separate patch or
part of this).

[..]

>>>
>>> So what about a machine property? Wouldn't that help as well?
>>>   
>>
>> Technically it is doable. The property would be still a weird
>> one, but from QEMU perspective in a less weird place. I was also
>> arguing that from OO perspective this kind of a don't care about
>> it's value property is weird, but AFAIK not having the info if
>> we can do something with a device at the device is weird from
>> Libvirt perspective. I'm really uncomforble with speaking for
>> Libvirt/Boris. Hope he will make his point tomorrow.
>>
>>> Or a css object?

This seems to be a concurrent discussion. Please see my other email.

>>>   
>>
>> My first internal-only version used this approach, but
>> I was asked to do it like this.
> 
> If we formulate this rather as "we now expose the default css", we (a)
> have something that really makes the most sense at a channel subsystem
> or machine level, and (b) can be detected by libvirt as an indicator of
> "no restriction for virtual vs. non-virtual".
> 

My previous statement was not entirely correct. I used a QOM type
but not to represent the css but this particular (cssids unrestricred
trait of the css).


>>
>>>>  
>>>>> What about compat machines? This qemu won't have the restriction, but
>>>>> old qemus will.
>>>>>     
>>>>
>>>> Very true. But as the commit message implies it should not be a problem.  
>>>
>>> How is that supposed to play with libvirt detection, then?
>>>   
>>
>> As written above. Libvirt will simply refuse to use vfio-ccw if the property
>> is not defined. This results in no prior history to care about for libvirt
>> users: vfio-ccw effectively becomes available with qemu 2.12.
> 
> I'm not worried about vfio-ccw. As you said, this should work. We just
> need to make sure that we don't break existing setups. (I don't think
> we will.)
> 

OK.

>>
>>>>  
>>>>> Also, I'd consider this a property of the machine, not of the
>>>>> individual devices. Or of the ChannelSubsystem structure, which is not
>>>>> qom'ified.
>>>>>     
>>>>
>>>> I've said the exact same thing to Boris. He said from libvirt perspective
>>>> a device property is better.
>>>>  
>>>>> As an alternative, I think providing a machine default_cssid parameter
>>>>> makes more sense: It is understandable, and you keep compatibility. I
>>>>> think we want this in the long run anyway.
>>>>>     
>>>>
>>>> I think most of us had the idea. I support this idea fully (expose default
>>>> cssid to the user (rw)). I see it as something that can be done on top
>>>> and is not a pressing issue, but rather a nice to have.  
>>>
>>> TBH, this weird property is what I like least about this patch.
>>>   
>>
>> I'm fine with any of the 3 alternatives (as is, new type, new machine prop).
>>
>> I do agree the property is weird, but a machine property would in my opinion
>> also be weird (especially form libvirt perspective, but also from qemu
>> perspective e.g. compat handling and machine type none).
>>
>> I used to think that using a trait type is the cleanest, but one advantage
> 
> What is a "trait type"?
> 

In code I did something like this:
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -961,3 +961,24 @@ static void ccw_machine_register_types(void)
 }

 type_init(ccw_machine_register_types)
+
+static const TypeInfo  s390_trait = {
+    .name =  TYPE_S390_TRAIT,
+    .parent = TYPE_OBJECT,
+    .abstract = true,
+};
+
+
+static const TypeInfo  cssids_unrestricted_info = {
+    .name = "s390-cssids-unresticted",
+    .parent = TYPE_S390_TRAIT,
+    .abstract = true,
+};
+
+static void css_register_traits(void)
+{
+    type_register_static(&s390_trait);
+    type_register_static(&cssids_unrestricted_info);
+}
+
+type_init(css_register_traits);

So management software could do something like
{"execute": "qom-list-types", "arguments" : {"abstract": true, "implements": "s390-trait"}

To figure out the traits (on binary basis). If "s390-cssids-unresticted"
pops up it means the restriction is no more (for the binary).

Since it is just a type there is no interaction with machine type 'none'
used for probing, no need to instantiate an object to read a property,
or just assume it's value is true, and no confusion about why does the
property pop up at multiple places (all virtio-ccw machine derived machines
or all ccw-device derived devices).

It's just basically tagging the qemu binary with a type. Since we
are doing something non-standard (kind of breaking compatibility)
I figured expressing it in a non-standard way may not be that bad.

I was eventually convinced that it is too strange. And command line
users would be completely unaware, which isn't necessarily a good thing.

(About trait: https://www.merriam-webster.com/dictionary/trait
and more specifically in CS it's a pretty commonly used idiom
in c++ template meta-programming for doing compile time conditional stuff
based on type parameters and their properties. )

>> of the approach taken in this patch is that it can be introspected via command
>> line (it is quite weird though).
> 
> Any property should be introspectable, no?
> 

Yes, the existence. The value AFAIK not via the command line.

>>
>>>>>>  }
>>>>>>  
>>>>>>  const VMStateDescription vmstate_ccw_dev = {
>>>>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>>>>> index f6b5c807cd..957cb9ec90 100644
>>>>>> --- a/hw/s390x/css.c
>>>>>> +++ b/hw/s390x/css.c
>>>>>> @@ -2377,15 +2377,6 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
>>>>>>      SubchDev *sch;
>>>>>>  
>>>>>>      if (bus_id.valid) {
>>>>>> -        if (is_virtual != (bus_id.cssid == VIRTUAL_CSSID)) {
>>>>>> -            error_setg(errp, "cssid %hhx not valid for %s devices",
>>>>>> -                       bus_id.cssid,
>>>>>> -                       (is_virtual ? "virtual" : "non-virtual"));
>>>>>> -            return NULL;
>>>>>> -        }
>>>>>> -    }    
>>>>>
>>>>> This allows building a commandline in a compat machine that will not
>>>>> work with old qemus, no?
>>>>>     
>>>>
>>>> Yes. We have considered this. I was convinced by Christian that
>>>> it ain't too bad. In the end, if we don't want non-virtual device
>>>> aware domains (see above), then there is no way to make this work
>>>> with libvirt. Actually to make the migration work with libvirt with
>>>> old qemus the only way would be to use sqash. But libvirt does not
>>>> want that.
>>>>
>>>> Also consider that vfio-ccw (AFAIK the only non-virtual css device
>>>> type) is not migratable. So having them on the command line and live
>>>> migrating is a lost case already.
>>>>
>>>> Yes, having a pre- 2.12 binary version and a post 2.12 binary version
>>>> way to use vfio-ccw is ugly to some extent. The recommendation would
>>>> be don't use it with pre 2.12 (libvirt is going to plainly refuse).
>>>>
>>>> And yes with this one is going to be able to write a 2.12 command
>>>> line which does not work with 2.11 but that is normal.
>>>>
>>>> This patch keeps the squash so the 2.10 definition will still be
>>>> viable for 2.12. Should we sometime get rid of the squash, then
>>>> that would be a breaking change.  
>>>
>>> Removing squash is easy to detect. I'm a bit worried about
>>> not-obvious-at-the-start breakage.
>>>   
>>
>> Again won't happen with libvirt. With a direct command line user
>> downgrading or moving to a qemu 2.10 or 2.11 it is a risk we can
>> take IMHO.
> 
> I want to avoid setting landmines, though.
> 

That's humane. I think doing full compat handling for the unrestrict
is also doable: Introduce a machine property that is going to be
false for less equal 2.11 and true for greater. And make the check
conditional on that property. The question is what do we gain by
that except having more code around that can makes only sense if
one knows the history behind it.

When I wrote my internal RFC the idea was maybe we can pretend
nobody ever used either vfio-ccw nor a ccsid other than 0xfe. The
idea seemed to resonate with the people.

Do you think we can get around full compat handling? Because if
we have to do that, then IMHO the property needs to be at the
machine. And is probably best implemented as an user r/w property.

My current status is that you and Christian agreed that we don't
want compat handling, but better sure than sorry.

>>
>> Also I can't find anything about vfio-ccw in the upstream users
>> manual for 2.10.91. 
> 
> We have an "upstream users manual"?
> 
This is what I mean:
https://qemu.weilnetz.de/doc/qemu-doc.html

>> So I would argue using vfio-ccw is using an
>> undocumented feature: if undocumented features changing in a non
>> compatible way hits you, it's partly your own fault.
> 
> If it's an x- interface, it is preliminary. If not, we should avoid
> breaking it.
> 

I don't see this documented in the users manual? Shouldn't the users
know what is preliminary?

Where is this documented?

Regards,
Halil
