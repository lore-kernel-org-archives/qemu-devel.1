Received: from eggs.gnu.org ([2001:4830:134:3::10]:36018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dAkb4-00010N-3C
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dAkb0-0005OD-RO
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:05:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38804
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dAkb0-0005Nu-LL
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:05:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4GM3cos054147
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 18:05:33 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ag9cth5bd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 18:05:33 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 16 May 2017 23:05:31 +0100
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-7-pasic@linux.vnet.ibm.com>
	<20170508173650.GJ2120@work-vm>
	<877c80d1-fa63-0fd1-e394-fb649281aea1@linux.vnet.ibm.com>
	<20170508175906.GK2120@work-vm>
	<b69e0df0-120f-6634-d7ff-4bea9ccb4e31@linux.vnet.ibm.com>
	<20170508184251.GM2120@work-vm>
	<f84db83a-4347-ef8c-56d3-ba3171d5a430@linux.vnet.ibm.com>
	<20170515190706.GD2324@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 00:05:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170515190706.GD2324@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <0000bcfe-5d9f-e656-1819-9403a1663c39@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] virtio-ccw: use vmstate way for
 config migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 05/15/2017 09:07 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>
>>
>> On 05/08/2017 08:42 PM, Dr. David Alan Gilbert wrote:
>>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>>>
>>>>
>>>> On 05/08/2017 07:59 PM, Dr. David Alan Gilbert wrote:
[..]
>>>>
>>>> Why not use virtio oddities? Because they are oddities. I have
>>>> figured, it's a good idea to separate the migration of the 
>>>> proxy form the rest: we have two QEMU Device objects and it
>>>> should be good practice, that these are migrating themselves via
>>>> DeviceClass.vmsd. That's what I get with this patch set, 
>>>> for new machine versions (since we can not fix the past), and
>>>> with the notable difference of config_vector, because it is
>>>> defined as a common infrastructure (struct VirtIODevice) but
>>>> ain't migrated as a common virtio infrastructure.
>>>
>>> Have you got a bit of a description of your classes/structure - it's
>>> a little hard to get my head around.
>>>
>>
>> Unfortunately I do not have any extra description besides the comments
>> and the commit messages. What exactly do you mean  by 'my
>> classes/structure'?  I would like to provide some helpful developer
>> documentation on how migration works for s390x. There were voices on the
>> internal mailing list too requesting something like that, but I find it
>> hard, because for me, the most challenging part was understanding how
>> qemu migration works in general and the virtio oddities come next. 
> 
> Yes, there are only about 2 people who have the overlap of understanding
> migration AND s390 IO.
> 
>> Fore example, I still don't understand why is is (virtio) load_config
>> called like that, when what it mainly does is loading state of the proxy
>> which is basically the reification of the device side of the virtio spec
>> calls the transport within QOM. (I say mainly, because of this
>> config_vector which resides in core but is migrated by via a callback for
>> some strange reason I do not understand).
> 
> I think the idea is that virtio_load is trying to act as a generic
> save/load with a number of virtual components that are specialised for:
>   a) The device (e.g. rng, serial, gpu, net, blk)
>   b) The transport (PCI, MMIO, CCW etc)
>   c) The virtio queue content
>   d) But has a load of core stuff (features, the virtio ring management)
> 
> (a) & (b) are very much virtual-function like that doesn't fit that
> well with the migration macro structure.
> 
> The split between (a) & (c) isn't necessary clean - gpu does it a
> different way.
> And the order of a/b/c/d is very random (aka wrong).
> 

I mostly agree with your analysis. Honestly I have forgot abut this
load_queue callback (I think its c)), but it's a strange one too. What it
does is handling the vector of the queue which is again common
infrastructure in a sense that it reside within VirtIODevice, but it may
need some proxy specific handling.

In my understanding the virtio migration and the migration subsystem
(lets call it vmstate) are a misfit in the following aspect. Most
importantly it separation of concerns. In my understanding, for vmstate,
each device is supposed to load/save itself, and loading state and doing
stuff with the state we have loaded are separate concerns. I'm not sure
whats the vmstate place for code which is supposed to run as a part of
the migration logic, but requires cooperation of devices (e.g. notify in
virtio_load which basically generates an interrupt). 


>> Could tell me to which (specific) questions should I provide an answer?
>> It would make my job much easier.
>>
>> About the general approach. First step was to provide VMStateDescription
>> for the entities which have migration relevant state but no
>> VMStateDescription (patches 3, 4 and 5).  This is done so that
>> lots of qemu_put/qem_get calls can be replaced with few
>> vmstate_save_state/vmstate_save_state calls (patch 6 and 7) on one hand,
>> and that state not migrated yet but needed is also included, if the
>> compat. switch (property) added in patch 2 is on. Then in patch 8, I add
>> ORB which is a state we wanted to add for some time now, but we needed
>> vmstate to add it without breaking migration. So we waited.
> 
> I'm most interested at this point in understanding which bits aren't
> changing behaviour - if we've got stuff that's just converting qemu_get
> to vmstate then lets go for it, no problem; easy to check.

The commit messages should be helpful. Up to patch 8 all I do is
converting qemu_get to vmstate as you said. 

> I'm just trying to make sure I understand the bit where you're
> converting from being a virtio device.
> 

By converting from being a virtio device you mean factoring out the
transport stuff into a separate section? That's happening in patch
9. Let me try to explain that patch.

The think of that patch is the following:
* Prior to it css_migration_enabled() always returned false. After
patch 9 it returns true for new machine versions and false for old
ones. That ensures there is still no change of behavior except
for the conversion to vmstate for old machines.

It's hunk where the change happens:
@@ -196,7 +196,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)

     s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
-    s390mc->css_migration_enabled = false; /* TODO: set to true */
+    s390mc->css_migration_enabled = true;

* If css_migration_enabled() we turn virtio_load_config into noop because we
use the DeviceClass.vmsd to migrate the stuff that was migrated
in virtio_load_config (new section).
* We need to to make sure if !css_migration_enabled() we do not have
a new section (this is what we rewrote with top level .needed).
* ccw_machine_2_10_instance_options makes sure all future machine versions
are calling css_register_vmstate() if css_migration_enabled() so
we have a new subsection for the common css stuff (not device specific).
* css_migration_enabled() returning true has a side effect that some
subsections are become needed. That's effectively switching between
compat. representation and complete representation. That includes
the ORB which was added in patch 8 so that it's subsection can utilize
this very same kill switch instead of needing a new property. Otherwise
the ORB has no connection with the objective of this patch set whatsoever.


>>>> Would you suggest to rather keep the oddities? Should I expect
>>>> to see a generic solution to the problem sometime soon?
>>>
>>> Not soon I fear; virtio_load is just too hairy.
>>
>> Of course it ain't a problem for me to omit assigning an vmsd to
>> VirtioCcwDeviceClass, but since I have to introduce a new section anyway
>> (for the css stuff) it ain't hurting me to put the state of
>> VirtioCcwDevice, that is the virtio proxy, into a separate section.
>>
>> I can't think of any decisive benefit in favor of having separate
>> sections for the proxy (transport) providing a virtio bus and the generic
>> virtio device sitting on that bus, but I think it should be slightly more
>> robust. One of the reasons I included this change is to make thinking
>> about the question easier by clearing the questions: is it viable and
>> complex/ugly is it to implement.
>>
>> What is your preference, keep the migration of the two devices lumped
>> together in one section, or rather go with two?
> 
> I'm not sure!
> But my main worries with you changing it are:
>   a) What happens when something changes in virtio and they need to add
>      some new virtio field somewhere - if you do it different will it
>      make it harder.
>   b) If you have a virtio device which does it differently, is it going
>      to make cleaning up virtio_load/save even harder?
> 
> Dave

My biggest concerns are actually -- let's assign them letters too: 
c) Possible dependencies between the states of the proxy and the device:
If virtio_load should need some transport state, or the other way around,
if the proxy device should need some device state in post_load for
example we have a problem (AFAIK) because the order in which the states
of the two qdev devices are loaded not any more under the control of
virtio_load.  
d) It would be an oddball among the oddballs. I have no idea how would I
change the documentation to reflect that properly.

I think c) is quite nasty. For instance we have
virtio_notify_vector(vdev, VIRTIO_NO_VECTOR) from virtio_load is called
which needs to happen after the proxy is loaded. My code works, because
the order of load is the same as the order of load, which is the same
as the order of device_set_realized calls which is proxy first
and then device (e.g. virtio-net). But it's fragile, because of some
recent changes with priorities. So should virtio get (high) prio assigned
to it this would break pretty bad!

I wonder if thinking into the direction of splitting the stuff makes
sense any more.

If we agree on not splitting up the virtio proxy and the rest into two
sections (one per device), I would like to fix that and do a re-spin.
Your opinion?

I would also like give you my opinion on your concerns, keep on reading
if you think it's still relevant: 

AFAIU a) is a human problem, and I'm not that concerned about it: if it
is a generic virtio field, it should be placed into the core, and is
completely unaffected by this change (except if something breaks it may
be easier to figure out because different sections). If it is a transport
specific thing, it's likely to be done by the s390x folks anyway. So I
think @Connie should make the call on that one.

About b), I guess it depends. If things go towards separate sections for
separate qdev devices (that is, for the transport (proxy) and for the
generic specific virtio device (e.g. rng, serial, gpu, net, blk) which
inherits for VirtIODevice which is a part of  what we call the virtio
core it may even simplify things.  If we are going to keep the state of
the two devices in one section, then it would remain an exception, and
exceptions are ugly.

To sum it up although I'm currently leaning towards abandoning my idea
of two sections for two devices, I'm not comfortable with making the
call myself. I'm hoping for some maintainer guidance (s390x, virtio
and migration). 

Many thanks!

Halil
