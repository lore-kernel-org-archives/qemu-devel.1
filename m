Received: from eggs.gnu.org ([2001:4830:134:3::10]:38645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eIDbp-000093-4L
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eIDbk-0003mL-5S
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:01:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42984
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eIDbj-0003la-VT
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:01:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAOCxhWC053256
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 08:01:25 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eekfcs98m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 08:01:24 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 24 Nov 2017 13:01:23 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
	<20171121172022.5da16158.cohuck@redhat.com>
	<88bc72cf-732c-fc07-9898-18d7b58b947d@linux.vnet.ibm.com>
	<20171122131343.26da0482.cohuck@redhat.com>
	<594e1952-7097-0927-d913-d3b915df2305@linux.vnet.ibm.com>
	<20171122172522.281cfb4b.cohuck@redhat.com>
	<76f95c6f-641e-2fe0-73b4-3ab24fc1a93f@linux.vnet.ibm.com>
	<20171124134650.46665791.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 Nov 2017 14:01:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171124134650.46665791.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7eaa796e-7815-f943-58b5-ecb5a0bb252e@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>



On 11/24/2017 01:46 PM, Cornelia Huck wrote:
> On Thu, 23 Nov 2017 14:33:56 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Having an adequate representation for the css in QOM would be certainly
>> interesting, but at the same time (IMHO) is somewhat challenging. Let me
>> make some observations, which should some of my concerns. 
>>
>> We already have virtual-css-bridge which is  the QOM type/object that
>> kind of conceptually stands for the channel subsystem as subsystem (not
>> for the images but for the big whole).
>>
>> The virtual-css-bridge is however non-user-creatable (inherited this from
>> sysbus-device-type), so I doubt it can be used for specifying properties
>> on the command line. That is no good for something like specifying the
>> default css (image, not the big whole). What we usually do is pull up the
>> property to the machine level. But this comes at a cost.
> 
> It might be better to not have inherit this from sysbus (at the price
> of doing some stuff like reset handling ourselves.) Not sure if that
> helps for this concrete issue, though.
> 
>>
>> A small digression, Christian pointed me to the -set cmd line option.
>> I've done a quick PoC (assigned an id in code and did the command line)
>> but I failed.
>>
>> Furthermore the (canonical) QOM path of virtual-css-bridge is
>> /machine/unattached/device[2] (there is a link from sysbus but the child
>> property is connecting it to unattached, see [1]). I would prefer seeing
>> and working wit something like /machine/css/default_css.
> 
> That's because the parent reference is not set up before registering
> the device. It should do a object_property_add_child() (as e.g. the
> flic does) so that it will show up as attached to the machine.
> 
>>
>> Under the virtual-css-bridge there is a virtual-css-bus called
>> QOM-path-ly virtual-css, so it's canonical path is
>> /machine/unattached/device[2]/virtual-css. The virtual-css-bus is in qdev
>> a bus however. AFAIU buses are not very suitable for hosting properties
>> (as one can't attach/add buses directly only via devices.
>>
>> Another interesting fact is that virtio-ccw devices are QOMly only linked
>> to their qdev parent bus, the virtual-ccs-bus, and are a QOMly children
>> of /machine/peripheral (see [2]).
> 
> That's true of anything added via qdev_device_add().
> 
> [As an aside, that's why the autogenerated net devices show up as
> unattached as well. Not sure if it is worth doing anything about it.]
> 
>>
>> To sum it up: I'm pretty confused with the QOM view of things.
>>
>> My intuition would be that the object/device has to be somewhere between
>> /machine and the vrtio-ccw devices in the children graph.  And since we
>> want to do a command line controllable properties on the css object, the
>> object probably needs to be a device.
>>
>> Given what we currently have I don't see a good place for this css
>> object.
> 
> I don't think qom is supposed to map the hardware hierarchy (I might be
> mistaken, though.) I don't see anything speaking against a css object
> attached to the machine (if we can't use the css bridge for that
> purpose.)
> 
>>
>> Furthermore I'm currently under the impression that every non-abstract
>> device is user creatable (but some can be created only implicitly). Some
>> seem to go even further and say should workwith device-add [3].
> 
> There are quite a number of devices for which being user-createable
> does not make any sense at all.
> 
> What _could_ make sense is having a way to add css images manually and
> having specify whether they are default. (Obviously not when they are
> hotplugged.) For compatibility, we could create css image 0xfe
> automatically as default if none has been defined. Not sure how easy it
> would be to get this right, though.

I first liked the idea to have it as a property of the css, but 
this is all pretty unclear how to do right. I start to think that going with
Halils first patch (a property per virtio device) is going to be the most
simple solution without causing any harm. After all as of today we only want 
to have a way to tell libvirt that devices can be everywhere. Specifying the
default css might be something that we want to have in the future, but here
future might even mean never.
