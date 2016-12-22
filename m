Received: from eggs.gnu.org ([2001:4830:134:3::10]:36219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cK0sG-0001yN-V7
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cK0sD-0005Dr-OO
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:45:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cK0sD-0005Dj-FB
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:45:21 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3FACC05680F
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 10:45:19 +0000 (UTC)
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
	<1480980749-182204-8-git-send-email-imammedo@redhat.com>
	<e9ac461e-ad69-bd6c-0127-5dc86af63ab2@redhat.com>
	<20161221143949.042dddc6@nial.brq.redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <1becd61e-77a1-887e-95d7-ecbfd0d27ebf@redhat.com>
Date: Thu, 22 Dec 2016 12:45:16 +0200
MIME-Version: 1.0
In-Reply-To: <20161221143949.042dddc6@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 07/10] memhp: move GPE handler_E03
 into build_memory_hotplug_aml()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 12/21/2016 03:39 PM, Igor Mammedov wrote:
> On Wed, 21 Dec 2016 14:31:45 +0200
> Marcel Apfelbaum <marcel@redhat.com> wrote:
>
>> On 12/06/2016 01:32 AM, Igor Mammedov wrote:
>>> From this patch all the memory hotplug related AML
>>> bits are consolidated in one place within DSTD.
>>> Follow up patches will utilize that to simplify
>>> memory hotplug related C/AML code.
>>
>>
>> I didn't quite understand what you mean...
> me neither :/, it's quite useless commit message,
> how about this one instead:
>
> --
> build hotplug event handler method body in generic
> hw/acpi/memory_hotplug.c and make hw/i386/acpi-build.c
> only provide target specific full name of the event
> handler.
> That removes hardcoded MEMORY_HOTPLUG_HANDLER_PATH and
> allows to do target specific memory hotplug AML placement
> and wiring it with a target specific hotplug event handler
> (it's GPE for i386 and would be GPIO for ARM).
>

Works for me.

> PS:
> similar approach has been used with CPU hotplug as part of commit:
> (d2238cb6 acpi: cpuhp: implement hot-add parts of CPU hotplug interface)
> --
>
>
>>
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>  include/hw/acpi/memory_hotplug.h |  6 +++---
>>>  hw/acpi/memory_hotplug.c         | 42 ++++++++++++++++++++++++++--------------
>>>  hw/i386/acpi-build.c             |  7 ++-----
>>>  3 files changed, 32 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
>>> index 6dc48d2..37e2706 100644
>>> --- a/include/hw/acpi/memory_hotplug.h
>>> +++ b/include/hw/acpi/memory_hotplug.h
>>> @@ -49,9 +49,9 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
>>>
>>>  #define MEMORY_HOTPLUG_DEVICE        "MHPD"
>>>  #define MEMORY_SLOT_SCAN_METHOD      "MSCN"
>>> -#define MEMORY_HOTPLUG_HANDLER_PATH "\\_SB.PCI0." \
>>> -     MEMORY_HOTPLUG_DEVICE "." MEMORY_SLOT_SCAN_METHOD
>>>
>>>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>>> -                              uint16_t io_base, uint16_t io_len);
>>> +                              uint16_t io_base, uint16_t io_len,
>>> +                              const char *res_root,
>>> +                              const char *event_handler_method);
>>>  #endif
>>> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
>>> index 18b95f2..49e856f 100644
>>> --- a/hw/acpi/memory_hotplug.c
>>> +++ b/hw/acpi/memory_hotplug.c
>>> @@ -308,18 +308,19 @@ const VMStateDescription vmstate_memory_hotplug = {
>>>  };
>>>
>>>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>>> -                              uint16_t io_base, uint16_t io_len)
>>> +                              uint16_t io_base, uint16_t io_len,
>>> +                              const char *res_root,
>>> +                              const char *event_handler_method)
>>>  {
>>>      int i;
>>>      Aml *ifctx;
>>>      Aml *method;
>>> -    Aml *pci_scope;
>>>      Aml *sb_scope;
>>>      Aml *mem_ctrl_dev;
>>> +    char *scan_path;
>>> +    char *mhp_res_path = g_strdup_printf("%s." MEMORY_HOTPLUG_DEVICE, res_root);
>>>
>>> -    /* scope for memory hotplug controller device node */
>>> -    pci_scope = aml_scope("_SB.PCI0");
>>> -    mem_ctrl_dev = aml_device(MEMORY_HOTPLUG_DEVICE);
>>> +    mem_ctrl_dev = aml_device("%s", mhp_res_path);
>>
>>
>> Will mem_ctrl_dev's name will have an extra "." suffix now?
> nope it will be declared with target specific full path rather
> than within separately created static scope:

Right, I mismatched the printf arguments..

>
> -    Scope (_SB.PCI0)
> +    Device (\_SB.PCI0.MHPD) // concat (res_root, ".", MEMORY_HOTPLUG_DEVICE)
>      {
> -        Device (MHPD)
> ...
> and event handler would change like this:
>
> +    Method (\_GPE._E03, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
> +    {
> +        \_SB.PCI0.MHPD.MSCN ()
> +    }
> +
>      Scope (_GPE)
>      {
>          Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID: Hardware ID
> -        Method (_E03, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
> -        {
> -            \_SB.PCI0.MHPD.MSCN ()
> -        }
>
>

OK

>
>>
>>>      {
>>>          Aml *crs;
>>>          Aml *field;
>>> @@ -610,47 +611,50 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>>>          }
>>>          aml_append(mem_ctrl_dev, method);
>>>      }
>>> -    aml_append(pci_scope, mem_ctrl_dev);
>>> -    aml_append(table, pci_scope);
>>> +    aml_append(table, mem_ctrl_dev);
>>>
>>>      sb_scope = aml_scope("_SB");
>>>      /* build memory devices */
>>>      for (i = 0; i < nr_mem; i++) {
>>> -        #define BASEPATH "\\_SB.PCI0." MEMORY_HOTPLUG_DEVICE "."
>>>          Aml *dev;
>>> -        const char *s;
>>> +        char *s;
>>>
>>>          dev = aml_device("MP%02X", i);
>>>          aml_append(dev, aml_name_decl("_UID", aml_string("0x%02X", i)));
>>>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C80")));
>>>
>>>          method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
>>> -        s = BASEPATH MEMORY_SLOT_CRS_METHOD;
>>> +        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_CRS_METHOD);
>>
>> Same question here, do we get ".." in the path? Maybe is OK?
> nope, it dynamic equivalent of original static 'BASEPATH MEMORY_SLOT_CRS_METHOD;'
> where BASEPATH is replaced with
>   concat(mhp_res_path, ".", MEMORY_SLOT_CRS_METHOD)
>
> this 'for' loop changes are temporary and are part of transition
> to dynamic mem hotplug AML placement. See patch 10/10 which simplifies
> names within this 'for' loop and reduces AML size as result by placing
> called methods within the same scope/container.
>

Thanks for the explanations.

>> Thanks,
>> Marcel
>>
>>>          aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
>>> +        g_free(s);
>>>          aml_append(dev, method);
>>>
>>>          method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>>> -        s = BASEPATH MEMORY_SLOT_STATUS_METHOD;
>>> +        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_STATUS_METHOD);
>>>          aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
>>> +        g_free(s);
>>>          aml_append(dev, method);
>>>
>>>          method = aml_method("_PXM", 0, AML_NOTSERIALIZED);
>>> -        s = BASEPATH MEMORY_SLOT_PROXIMITY_METHOD;
>>> +        s = g_strdup_printf("%s.%s", mhp_res_path,
>>> +                            MEMORY_SLOT_PROXIMITY_METHOD);
>>>          aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
>>> +        g_free(s);
>>>          aml_append(dev, method);
>>>
>>>          method = aml_method("_OST", 3, AML_NOTSERIALIZED);
>>> -        s = BASEPATH MEMORY_SLOT_OST_METHOD;
>>> -
>>> +        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_OST_METHOD);
>>>          aml_append(method, aml_return(aml_call4(
>>>              s, aml_name("_UID"), aml_arg(0), aml_arg(1), aml_arg(2)
>>>          )));
>>> +        g_free(s);
>>>          aml_append(dev, method);
>>>
>>>          method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
>>> -        s = BASEPATH MEMORY_SLOT_EJECT_METHOD;
>>> +        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_EJECT_METHOD);
>>>          aml_append(method, aml_return(aml_call2(
>>>                     s, aml_name("_UID"), aml_arg(0))));
>>> +        g_free(s);
>>>          aml_append(dev, method);
>>>
>>>          aml_append(sb_scope, dev);
>>> @@ -669,4 +673,12 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>>>      }
>>>      aml_append(sb_scope, method);
>>>      aml_append(table, sb_scope);
>>> +
>>> +    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
>>> +    scan_path = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_SCAN_METHOD);
>>> +    aml_append(method, aml_call0(scan_path));
>>> +    g_free(scan_path);
>>> +    aml_append(table, method);
>>> +
>>> +    g_free(mhp_res_path);
>>>  }
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index 690e9a0..b7f4682 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -1926,7 +1926,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>                         "\\_SB.PCI0", "\\_GPE._E02");
>>>      }
>>>      build_memory_hotplug_aml(dsdt, nr_mem, pm->mem_hp_io_base,
>>> -                             pm->mem_hp_io_len);
>>> +                             pm->mem_hp_io_len,
>>> +                             "\\_SB.PCI0", "\\_GPE._E03");
>>>
>>>      scope =  aml_scope("_GPE");
>>>      {
>>> @@ -1941,10 +1942,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>>              aml_append(scope, method);
>>>          }
>>>
>>> -        method = aml_method("_E03", 0, AML_NOTSERIALIZED);
>>> -        aml_append(method, aml_call0(MEMORY_HOTPLUG_HANDLER_PATH));
>>> -        aml_append(scope, method);
>>> -
>>>          if (pcms->acpi_nvdimm_state.is_enabled) {
>>>              method = aml_method("_E04", 0, AML_NOTSERIALIZED);
>>>              aml_append(method, aml_notify(aml_name("\\_SB.NVDR"),
>>>
>>
>


Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
