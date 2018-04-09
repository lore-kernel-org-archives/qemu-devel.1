Received: from eggs.gnu.org ([2001:4830:134:3::10]:42059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1f5Zs9-00049c-3B
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1f5Zs8-0000zq-0g
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 12:42:25 -0400
References: <20180409154921.29906-1-wei@redhat.com>
	<CAFEAcA9Law6n+2bGwd4-VkAJ1HT10c0ZqHASmtLdHcTFV9YBHw@mail.gmail.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <1d96c98e-3836-d05f-1dd1-259e89d02c18@redhat.com>
Date: Mon, 9 Apr 2018 11:42:17 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Law6n+2bGwd4-VkAJ1HT10c0ZqHASmtLdHcTFV9YBHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] mach-virt: Change default cpu and
 gic-version setting to "max"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrea Bolognani <abologna@redhat.com>



On 04/09/2018 10:55 AM, Peter Maydell wrote:
> On 9 April 2018 at 16:49, Wei Huang <wei@redhat.com> wrote:
>> Running mach-virt machine types (i.e. "-M virt") on different systems can
>> result in various misleading warnings if -cpu and/or gic-version not specified.
>> For KVM, this can be solved mostly by using "host" type. But the "host" type
>> doesn't work for TCG. Compared with "host", the "max" type not only supports
>> auto detection under KVM mode, but also works with TCG.
>> So this patch set "max" as the default types for both -cpu and gic-version.
> 
> Using "max" will make the VM not migratable by default, and also
> means that the behaviour might differ between host machines and
> between different QEMU versions. I'm not sure we want that for the
> default ?

Understood. If you think the -cpu shouldn't be changed due to the
reasons list above, we should at lease give a better warning message
when cpu doesn't match. Right now, the error msg is something like
"kvm_init_vcpu failed, ...".

Secondly, how about gic-version part? Should we use "max" as the default
gic-version?

> 
>> Signed-off-by: Wei Huang <wei@redhat.com>
>> ---
>>  hw/arm/virt.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 94dcb125d3..1a9d68b8d5 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1555,7 +1555,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>>      mc->minimum_page_bits = 12;
>>      mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
>>      mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
>> -    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
>>      mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>>  }
>>
>> @@ -1609,13 +1609,13 @@ static void virt_2_12_instance_init(Object *obj)
>>                                      "Set on/off to enable/disable using "
>>                                      "physical address space above 32 bits",
>>                                      NULL);
>> -    /* Default GIC type is v2 */
>> -    vms->gic_version = 2;
>> +    /* Default GIC type is max */
>> +    vms->gic_version = -1;
>>      object_property_add_str(obj, "gic-version", virt_get_gic_version,
>>                          virt_set_gic_version, NULL);
>>      object_property_set_description(obj, "gic-version",
>> -                                    "Set GIC version. "
>> -                                    "Valid values are 2, 3 and host", NULL);
>> +                                    "Set GIC version. Valid values are 2, 3, "
>> +                                    "host, and max", NULL);
> 
> This change in the help string is a bug fix not related to the
> rest of the patch. You should send that as a separate patch,
> because we want that regardless of what we do about the default
> value.
> 
> thanks
> -- PMM
> 
