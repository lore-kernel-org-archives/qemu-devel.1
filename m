Received: from eggs.gnu.org ([2001:4830:134:3::10]:41502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHrdp-0003Lo-PN
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHrdm-0004wn-H4
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:34:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eHrdm-0004vR-8z
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:34:06 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vANDUd54075810
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 08:34:02 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2edue9pfgr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 08:34:02 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 23 Nov 2017 13:34:00 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
	<20171121172022.5da16158.cohuck@redhat.com>
	<88bc72cf-732c-fc07-9898-18d7b58b947d@linux.vnet.ibm.com>
	<20171122131343.26da0482.cohuck@redhat.com>
	<594e1952-7097-0927-d913-d3b915df2305@linux.vnet.ibm.com>
	<20171122172522.281cfb4b.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 23 Nov 2017 14:33:56 +0100
MIME-Version: 1.0
In-Reply-To: <20171122172522.281cfb4b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <76f95c6f-641e-2fe0-73b4-3ab24fc1a93f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.orgChristian Borntraeger <borntraeger@de.ibm.com>



On 11/22/2017 05:25 PM, Cornelia Huck wrote:
> On Wed, 22 Nov 2017 15:45:56 +0100
> Boris Fiuczynski <fiuczy@linux.vnet.ibm.com> wrote:
> 
>> On 11/22/2017 01:13 PM, Cornelia Huck wrote:
>>>>>>>> +    object_class_property_add_bool(klass, "cssid-unrestricted",
>>>>>>>> +                                   prop_get_true, NULL, NULL);  
>>>>>>> This looks really, really strange. This is a property that is always
>>>>>>> true if it exists.
>>>>>>>        
>>>>>> Won't argue about that. The libvirt guys are actually not interested
>>>>>> int he value at all: only that there is such a property.  
>>>>> So what about a machine property? Wouldn't that help as well?
>>>>>      
>>>> Technically it is doable. The property would be still a weird
>>>> one, but from QEMU perspective in a less weird place. I was also
>>>> arguing that from OO perspective this kind of a don't care about
>>>> it's value property is weird, but AFAIK not having the info if
>>>> we can do something with a device at the device is weird from
>>>> Libvirt perspective. I'm really uncomforble with speaking for
>>>> Libvirt/Boris. Hope he will make his point tomorrow.
>>>>  
>>>>> Or a css object?
>>>>>      
>>>> My first internal-only version used this approach, but
>>>> I was asked to do it like this.  
>>> If we formulate this rather as "we now expose the default css", we (a)
>>> have something that really makes the most sense at a channel subsystem
>>> or machine level, and (b) can be detected by libvirt as an indicator of
>>> "no restriction for virtual vs. non-virtual".  
>>
>> I think that there are good reasons for using a device property as well 
>> as for using a machine property. Technically both options are possible 
>> (even for libvirt :) without too much rope...). At first my personal 
>> choice was to express the changed behavior/capability on the device 
>> level since that is what a user defines on the command line and also 
>> where he gets restricted to use a css matching his device type.
>>  From the libvirt perspective we would have supported vfio-ccw devices 
>> only if the vfio-ccw would be allowed to be defined with unrestricted 
>> cssids.
> 
> Thanks, I can now understand where that property came from.
> 
>> As I wrote before I also understand the reasoning to express the channel 
>> subsystem wide changed behavior as a machine option. In that case 
>> libvirt would need to check that both capabilities (vfio-ccw and machine 
>> option cssid-unrestricted) are set and not just 
>> vfio-cww.cssid-unrestricted. All doable. A qemu command line user would 
>> obviously need to know the correlation of the machine option and the ccw 
>> devices but that certainly is also nothing new.
>> When talking to Christian and Halil I started to favor the idea of a new 
>> css object especially when thinking about the future in which the user 
>> might want to specify the default css. It for sure would also be able to 
>> be set with the use of a machine option but a css object would at that 
>> point be much a nicer and more capable approach. What do you think?
> 
> I think exposing the css object and making the default_css property
> available is the cleanest solution (especially if we want more css
> properties in the future). The only drawback I see is that it needs
> more coding (and probably care to keep it backwards compatible.)
> 
> Halil, do you think you can come up with something?
> 
Having an adequate representation for the css in QOM would be certainly
interesting, but at the same time (IMHO) is somewhat challenging. Let me
make some observations, which should some of my concerns. 

We already have virtual-css-bridge which is  the QOM type/object that
kind of conceptually stands for the channel subsystem as subsystem (not
for the images but for the big whole).

The virtual-css-bridge is however non-user-creatable (inherited this from
sysbus-device-type), so I doubt it can be used for specifying properties
on the command line. That is no good for something like specifying the
default css (image, not the big whole). What we usually do is pull up the
property to the machine level. But this comes at a cost.

A small digression, Christian pointed me to the -set cmd line option.
I've done a quick PoC (assigned an id in code and did the command line)
but I failed.

Furthermore the (canonical) QOM path of virtual-css-bridge is
/machine/unattached/device[2] (there is a link from sysbus but the child
property is connecting it to unattached, see [1]). I would prefer seeing
and working wit something like /machine/css/default_css.

Under the virtual-css-bridge there is a virtual-css-bus called
QOM-path-ly virtual-css, so it's canonical path is
/machine/unattached/device[2]/virtual-css. The virtual-css-bus is in qdev
a bus however. AFAIU buses are not very suitable for hosting properties
(as one can't attach/add buses directly only via devices.

Another interesting fact is that virtio-ccw devices are QOMly only linked
to their qdev parent bus, the virtual-ccs-bus, and are a QOMly children
of /machine/peripheral (see [2]).

To sum it up: I'm pretty confused with the QOM view of things.

My intuition would be that the object/device has to be somewhere between
/machine and the vrtio-ccw devices in the children graph.  And since we
want to do a command line controllable properties on the css object, the
object probably needs to be a device.

Given what we currently have I don't see a good place for this css
object.

Furthermore I'm currently under the impression that every non-abstract
device is user creatable (but some can be created only implicitly). Some
seem to go even further and say should workwith device-add [3].
 
In my opinion having a something like is_singleton (bool) with the
meaning exactly one instance of this device type is required, instead of
user_creatabe would have been more useful, and would actually be
something worth exposing to the user.

Some of our devices are such, that neither more than one, nor none makes
any sense (flic, and I think the channel subsystem (big)). With something
like this we could say QEMU is free to fill in with defaults if some of
these singletons is not specified on the command line (but can be
deduced), but the user is still in control regarding properties.

Summa summarum, coming up with a really nice solution does not appear to
be trivial if even possible.

If we think less than nice, then having an object object under /objects
(something like iothread) which could be called css_config is something
that pops up in my mind. The way to specify the default css on the
command line would look something like --object
ccs-config,default-css=0xfe I guess. I'm not sure it's less weird then
then a machine property, and the same goes for the QOM path. Furthermore,
we would probably have to make this a singleton (in a sense described
above) if we want to have a consistent interface for querying.

Is what I described the 'css object' you have been asking for or did
I misunderstand? If it is, I really don't have the feeling it would be
nicer nor simpler than what we have in this patch.

I'm not that familiar with how object-objects work in qemu, and honestly
I got curious, so I will explore this. Even if just for the sake of
learning.  But frankly, right now this does not appear simpler or more
elegant than the current solution plus a machine property for the default
css id.

My overall impression is: I'm pretty confused by our QOM. That's why I
tried to avoid getting too deeply involved with it. Currently, the
approach taken in this patch seems to be the least painful option.
Especially if deeper-going changes (qom paths, singletons, whatever) are
not desirable.

And since I'm not convinced we need to set the default css I think
worrying about setting css properties when the need arises is viable at
this moment.

If you can help me getting rid of some of the confusion, and gain
a better understanding of our QOM modeling, that would be highly
appreciated.


Halil

References:
[1]
(qemu) qom-list /machine/unattached/
io[0] (child<qemu:memory-region>)
system[0] (child<qemu:memory-region>)
device[2] (child<virtual-css-bridge>)

[2]
(qemu) qom-list /machine/unattached/device[2]/virtual-css
type (string)
child[1] (link<virtio-blk-ccw>)
child[0] (link<virtio-blk-ccw>)
hotplug-handler (link<hotplug-handler>)
realized (bool)


[3]
   /*
     * Can this device be instantiated with -device / device_add?
     * All devices should support instantiation with device_add, and
     * this flag should not exist.  But we're not there, yet.  Some
     * devices fail to instantiate with cryptic error messages.
     * Others instantiate, but don't work.  Exposing users to such
     * behavior would be cruel; clearing this flag will protect them.
     * It should never be cleared without a comment explaining why it
     * is cleared.
     * TODO remove once we're there
     */
    bool user_creatable;
