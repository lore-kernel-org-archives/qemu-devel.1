Received: from eggs.gnu.org ([2001:4830:134:3::10]:39713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRCOo-0007Pv-SA
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRCOj-00064X-US
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:05:30 -0400
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-2-david@redhat.com>
	<44301f0f-9d8b-18f1-7fad-e00f13a584fd@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9ac778a6-6525-101e-7f06-cadde0cc4349@redhat.com>
Date: Fri, 8 Jun 2018 10:05:22 +0200
MIME-Version: 1.0
In-Reply-To: <44301f0f-9d8b-18f1-7fad-e00f13a584fd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 1/8] pc: local error
 handling in hotplug handler functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 08.06.2018 10:04, Thomas Huth wrote:
> On 07.06.2018 18:52, David Hildenbrand wrote:
>> Let's introduce and use local error variables in the hotplug handler
>> functions.
> 
> Why? You don't check local_err in the functions, so I fail to see why
> this is needed? If you need this in a later patch, I think this should
> simply be part of that later patch instead.

See the mail I sent a couple of minutes ago as reply to the cover
letter. Thanks.

> 
>  Thomas
> 
> 
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/i386/pc.c | 32 ++++++++++++++++++++++----------
>>  1 file changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index f3befe6721..8075c6af15 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2006,45 +2006,57 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>  static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>                                            DeviceState *dev, Error **errp)
>>  {
>> +    Error *local_err = NULL;
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> -        pc_cpu_pre_plug(hotplug_dev, dev, errp);
>> +        pc_cpu_pre_plug(hotplug_dev, dev, &local_err);
>>      }
>> +    error_propagate(errp, local_err);
>>  }
>>  
>>  static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>                                        DeviceState *dev, Error **errp)
>>  {
>> +    Error *local_err = NULL;
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>> -        pc_dimm_plug(hotplug_dev, dev, errp);
>> +        pc_dimm_plug(hotplug_dev, dev, &local_err);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> -        pc_cpu_plug(hotplug_dev, dev, errp);
>> +        pc_cpu_plug(hotplug_dev, dev, &local_err);
>>      }
>> +    error_propagate(errp, local_err);
>>  }
>>  
>>  static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>>                                                  DeviceState *dev, Error **errp)
>>  {
>> +    Error *local_err = NULL;
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>> -        pc_dimm_unplug_request(hotplug_dev, dev, errp);
>> +        pc_dimm_unplug_request(hotplug_dev, dev, &local_err);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> -        pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
>> +        pc_cpu_unplug_request_cb(hotplug_dev, dev, &local_err);
>>      } else {
>> -        error_setg(errp, "acpi: device unplug request for not supported device"
>> -                   " type: %s", object_get_typename(OBJECT(dev)));
>> +        error_setg(&local_err, "acpi: device unplug request for not supported"
>> +                   " device type: %s", object_get_typename(OBJECT(dev)));
>>      }
>> +    error_propagate(errp, local_err);
>>  }
>>  
>>  static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>>                                          DeviceState *dev, Error **errp)
>>  {
>> +    Error *local_err = NULL;
>> +
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>> -        pc_dimm_unplug(hotplug_dev, dev, errp);
>> +        pc_dimm_unplug(hotplug_dev, dev, &local_err);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> -        pc_cpu_unplug_cb(hotplug_dev, dev, errp);
>> +        pc_cpu_unplug_cb(hotplug_dev, dev, &local_err);
>>      } else {
>> -        error_setg(errp, "acpi: device unplug for not supported device"
>> +        error_setg(&local_err, "acpi: device unplug for not supported device"
>>                     " type: %s", object_get_typename(OBJECT(dev)));
>>      }
>> +    error_propagate(errp, local_err);
>>  }
>>  
>>  static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
>>
> 


-- 

Thanks,

David / dhildenb
