Received: from eggs.gnu.org ([2001:4830:134:3::10]:57753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRDYd-0006O3-54
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRDYc-0005rB-0N
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 05:19:43 -0400
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-9-david@redhat.com>
	<20180608092545.52133d91.cohuck@redhat.com>
	<6a2bf8b2-5b15-d2ec-39e4-7afaf981fa3f@de.ibm.com>
	<e553a053-b1e1-997b-27de-33f4e1c959b3@redhat.com>
	<20180608110350.13fbcd77@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <766df31f-96e6-eb2f-0b7f-2182476b540e@redhat.com>
Date: Fri, 8 Jun 2018 11:19:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180608110350.13fbcd77@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 8/8] s390x: local error handling in
 hotplug handler functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 08.06.2018 11:03, Igor Mammedov wrote:
> On Fri, 8 Jun 2018 09:40:04 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 08.06.2018 09:27, Christian Borntraeger wrote:
>>>
>>>
>>> On 06/08/2018 09:25 AM, Cornelia Huck wrote:  
>>>> On Thu,  7 Jun 2018 18:52:18 +0200
>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>  
>>>>> Let's introduce and use local error variables in the hotplug handler
>>>>> functions.
>>>>>
>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>> ---
>>>>>  hw/s390x/s390-virtio-ccw.c | 11 ++++++++---
>>>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>>> index 7ae5fb38dd..29ea50a177 100644
>>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>>> @@ -434,18 +434,23 @@ static void s390_machine_reset(void)
>>>>>  static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
>>>>>                                       DeviceState *dev, Error **errp)
>>>>>  {
>>>>> +    Error *local_err = NULL;
>>>>> +
>>>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>>>> -        s390_cpu_plug(hotplug_dev, dev, errp);
>>>>> +        s390_cpu_plug(hotplug_dev, dev, &local_err);
>>>>>      }
>>>>> +    error_propagate(errp, local_err);
>>>>>  }
>>>>>  
>>>>>  static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>>>>>                                                 DeviceState *dev, Error **errp)
>>>>>  {
>>>>> +    Error *local_err = NULL;
>>>>> +
>>>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>>>> -        error_setg(errp, "CPU hot unplug not supported on this machine");
>>>>> -        return;
>>>>> +        error_setg(&local_err, "CPU hot unplug not supported on this machine");
>>>>>      }
>>>>> +    error_propagate(errp, local_err);
>>>>>  }
>>>>>  
>>>>>  static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,  
>>>>
>>>> Just seeing this patch by itself, it does not really make much sense.
>>>> Even if this is a split out clean-up series, I'd prefer this to go
>>>> together with a patch that actually adds something more to the
>>>> plug/unplug functions.  
>>>
>>> +1. It is hard to see the "why". Maybe a better patch description could help here?
>>>   
>>
>> When checking for an error (*errp) we should make sure that we don't
>> dereference the NULL pointer. I will be doing that in the future (memory
>> devices), but as you both don't seem to like this patch, I'll drop it
>> for now.
> hotplug handlers aren't called with NULL errp, so it not really necessary.
> To be on the safe side we can ensure that errp is not NULL doing something
> like:

They are, but not on s390x :) But we should never life with such
assumptions - calling code may change. Passing NULL results right now
not in a crash, but the "return" value in case of a failure cannot be
indicated.

Maybe we should even change all users of NULL for errp to use &error_abort.

For now I dropped these "local_err" patches and kept only the spapr
cleanups.

> 
> diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
> index 17ac986..dc9e4bf 100644
> --- a/hw/core/hotplug.c
> +++ b/hw/core/hotplug.c
> @@ -52,6 +52,7 @@ void hotplug_handler_unplug(HotplugHandler *plug_handler,
>  {
>      HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
>  
> +    g_assert(errp);
>      if (hdc->unplug) {
>          hdc->unplug(plug_handler, plugged_dev, errp);
>      }
> 
> and do it for all similar wrappers in this file
> 
> 


-- 

Thanks,

David / dhildenb
