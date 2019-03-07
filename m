Received: from eggs.gnu.org ([209.51.188.92]:46129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h1xGP-0008Nt-0k
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h1xGO-0000JC-87
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:57:00 -0500
References: <20190307090639.8261-1-eric.auger@redhat.com>
	<20190307172612.GC8899@habkost.net>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <42cc3974-3953-472d-d3d7-f2a507f6397c@redhat.com>
Date: Thu, 7 Mar 2019 18:56:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190307172612.GC8899@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] machine: Move acpi_nvdimm_state into
 struct MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org, sbhat@linux.ibm.com

Hi Eduardo,

On 3/7/19 6:26 PM, Eduardo Habkost wrote:
> On Thu, Mar 07, 2019 at 10:06:39AM +0100, Eric Auger wrote:
>> As NVDIMM support is looming for ARM and SPAPR, let's
>> move the acpi_nvdimm_state to the generic machine struct
>> instead of duplicating the same code in several machines.
>> It is also renamed into nvdimms_state.
>>
>> nvdimm and nvdimm-persistence become generic machine options.
>> We also add a description for those options.
>>
>> We also remove the nvdimms_state.is_enabled initialization to
>> false as objects are guaranteed to be zero initialized.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>> - s/acpi_nvdimm_state/nvdimms_state
>> - remove ms->nvdimms_state.is_enabled initialization to false.
> [...]
>> @@ -765,6 +806,20 @@ static void machine_class_init(ObjectClass *oc, void *data)
>>          &error_abort);
>>      object_class_property_set_description(oc, "memory-encryption",
>>          "Set memory encryption object to use", &error_abort);
>> +
>> +    object_class_property_add_bool(oc, "nvdimm",
>> +        machine_get_nvdimm, machine_set_nvdimm, &error_abort);
>> +    object_class_property_set_description(oc, "nvdimm",
>> +                                         "Set on/off to enable/disable NVDIMM "
>> +                                         "instantiation", NULL);
>> +
>> +    object_class_property_add_str(oc, "nvdimm-persistence",
>> +                                  machine_get_nvdimm_persistence,
>> +                                  machine_set_nvdimm_persistence, &error_abort);
>> +    object_class_property_set_description(oc, "nvdimm-persistence",
>> +                                          "Set NVDIMM persistence"
>> +                                          "Valid values are cpu and mem-ctrl",
>> +                                          NULL);
> 
> As noted in another reply, I don't mind adding new MachineState
> fields, but now I noticed you are adding new user-visible
> options, which requires more care.
> 
> This patch seems to make all machines except PC silently ignore
> the new nvdimm options.  If the current machine doesn't support
> nvdimm, "nvdimm-persistence=..." and "nvdimm=on" should be
> rejected by QEMU instead of silently ignored.
> 
> Probably the simplest way to do that is by making the
> registration of those QOM properties conditional.
> 
> We could add a simple
>   bool MachineClass::nvdimm_supported
Makes sense to me too. I will go that way.

Thanks

Eric
> field, or we could add a
>   static void nvdimm_machine_class_init(MachineClass *mc);
> helper that would enable nvdimm support on the machine type.
> 
