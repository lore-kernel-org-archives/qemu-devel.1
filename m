Received: from eggs.gnu.org ([2001:4830:134:3::10]:55126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8KzQ-0007Y7-N9
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 03:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8KjO-0007bl-8G
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 03:41:08 -0400
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-19-david@redhat.com>
	<20181003062949.GZ1886@umbus.fritz.box>
	<cb8dd5d6-bb8c-f4a1-85c3-6b7ba53ad828@redhat.com>
	<20181004175915.5f366e67@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6fc6cf77-2023-7370-a77d-c283fc078d74@redhat.com>
Date: Fri, 5 Oct 2018 09:40:50 +0200
MIME-Version: 1.0
In-Reply-To: <20181004175915.5f366e67@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 18/24] qdev: hotplug: provide do_unplug
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>

On 04/10/2018 17:59, Igor Mammedov wrote:
> On Wed, 3 Oct 2018 19:21:25 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 03/10/2018 08:29, David Gibson wrote:
>>> On Wed, Sep 26, 2018 at 11:42:13AM +0200, David Hildenbrand wrote:  
>>>> The unplug and unplug_request handlers are special: They are not
>>>> executed when unrealizing a device, but rather trigger the removal of a
>>>> device from device_del() via object_unparent() - to effectively
>>>> unrealize a device.
>>>>
>>>> If such a device has a child bus and another device attached to
>>>> that bus (e.g. how virtio devices are created with their proxy device),
>>>> we will not get a call to the unplug handler. As we want to support
>>>> hotplug handlers (and especially also some unplug logic to undo resource
>>>> assignment) for such devices, we cannot simply call the unplug handler
>>>> when unrealizing - it has a different semantic ("trigger removal").
>>>>
>>>> To handle this scenario, we need a do_unplug handler, that will be
>>>> executed for all devices with a hotplug handler.
>>>>
>>>> While at it, introduce hotplug_fn_nofail and fix a spelling mistake in
>>>> a comment.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  hw/core/hotplug.c    | 10 ++++++++++
>>>>  hw/core/qdev.c       |  6 ++++++
>>>>  include/hw/hotplug.h | 26 ++++++++++++++++++++++++--
>>>>  3 files changed, 40 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
>>>> index 2253072d0e..e7a68d5160 100644
>>>> --- a/hw/core/hotplug.c
>>>> +++ b/hw/core/hotplug.c
>>>> @@ -45,6 +45,16 @@ void hotplug_handler_post_plug(HotplugHandler *plug_handler,
>>>>      }
>>>>  }
>>>>  
>>>> +void hotplug_handler_do_unplug(HotplugHandler *plug_handler,
>>>> +                                 DeviceState *plugged_dev)  
>>>
>>> Hrm.  I really dislike things named "do_X".  The "do" rarely adds any
>>> useful meaning.  And when there's also something called just plain
>>> "X", it's *always* unclear how they relate to each other.
>>>
>>> That's doubly true when it's a general interface like this, rather
>>> than just some local functions.
>>>   
>>
>> Yes, the naming is not the best, but I didn't want to rename all unplug
>> handlers before we have an agreement on how to proceed. My concept would
>> be that
>>
>> 1. unplug() is renamed to trigger_unplug(). unplug_request() remains.
>> 2. do_unplug() is renamed to pre_unplug() (just like pre_plug())
>> 3. we might have in addition unplug() after realize(false) - just like
>> plug()
>>
>> trigger_unplug() would perform checks and result in object_unparent().
>> From there, all cleanup/unplugging would be performed via the unrealize
>> chain, just like we have for realize() now. That would allow to properly
>> unplug complete device hierarchies.
>>
>> But Igor rather wants one hotplug handler chain, and no dedicated
>> hotplug handlers for other devices in the device hierarchy.
> 
> Because what we are dealing here with (virtio-pmem) is not separate
> devices hierarchy, it's one complex device and if we are to avoid
> layering violation, we should operate internal devices via that outer
> device which would orchestrate given to it resources internally as it
> sees it fit.
> 
> It's similar with be spapr cpu core, where internal threads do
> not have their own handlers they are plugged as the integral part
> of the core.
> 
> What I'm strongly opposed is using separate hotplug handlers for
> internal devices of a composite one.
> I'm more lenient in cases of where the hotplug handler of a composite
> device access it's internals directly if creating interfaces to
> manage internal devices is big over-engineering, since all
> hotplug flow is explicitly described within one handler and
> I don't need to hunt around to figure out how device is wired up.
> 
> It's still not right wrt not violating abstraction layers and
> might break if internal details change, but usually hotplug
> handler is target unique and tightly coupled code of manged
> and managing pieces (like the case of spapr cpu core) so it
> works so far. For some generic handler I'd vote for following
> all the rules.
> 
> In this series approach, handlers are used if they are separate
> devices without explicit connection which I find totally broken
> (and tried to explain in this thread, probably not well enough).

Thanks for the extended explanation.

Let's see if I can make it work. I guess virtio devices are really
special (and turning other devices without proxys into memory devices
would be much easier).


-- 

Thanks,

David / dhildenb
