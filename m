Received: from eggs.gnu.org ([209.51.188.92]:55726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gw566-0008E6-If
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gw564-0007qW-Ed
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:06:06 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:45248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1gw562-0007iV-Fg
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:06:04 -0500
Received: by mail-ed1-x543.google.com with SMTP id d9so16627122edh.12
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 05:05:44 -0800 (PST)
Date: Tue, 19 Feb 2019 13:05:41 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190219130541.3dpdlposer7prfqh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190219060719.8211-1-richardw.yang@linux.intel.com>
	<20190219060719.8211-3-richardw.yang@linux.intel.com>
	<a9b921ba-0486-860a-02cf-6598466857aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9b921ba-0486-860a-02cf-6598466857aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] pc-dimm: remove realize callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com

On Tue, Feb 19, 2019 at 01:36:57PM +0100, Philippe Mathieu-Daudé wrote:
>On 2/19/19 7:07 AM, Wei Yang wrote:
>> PCDIMM's realize callback is introduced to do proper setup for NVDIMM.
>> 
>> Currently the NVDIMM setup task is nvdimm_prepare_memory_region(), which
>> is done in pre_plug stage. This means related task has already been done
>> at realize point.
>> 
>> This patch remove PCDIMM realize callback.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  hw/acpi/memory_hotplug.c |  1 -
>>  hw/mem/nvdimm.c          | 11 -----------
>>  hw/mem/pc-dimm.c         |  5 -----
>>  include/hw/mem/pc-dimm.h |  3 ---
>>  4 files changed, 20 deletions(-)
>> 
>> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
>> index b19673d337..cb5284d36f 100644
>> --- a/hw/acpi/memory_hotplug.c
>> +++ b/hw/acpi/memory_hotplug.c
>> @@ -264,7 +264,6 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
>>                           DeviceState *dev, Error **errp)
>>  {
>>      MemStatus *mdev;
>> -    DeviceClass *dc = DEVICE_GET_CLASS(dev);
>
>OK now I see the leftover of patch #1.
>

Ah, I should move this in patch #1.

Thanks.

>>  
>>      mdev = acpi_memory_slot_status(mem_st, dev, errp);
>>      if (!mdev) {
>> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
>> index bf2adf5e16..8f69576926 100644
>> --- a/hw/mem/nvdimm.c
>> +++ b/hw/mem/nvdimm.c
>> @@ -136,15 +136,6 @@ static MemoryRegion *nvdimm_md_get_memory_region(MemoryDeviceState *md,
>>      return nvdimm->nvdimm_mr;
>>  }
>>  
>> -static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>> -{
>> -    NVDIMMDevice *nvdimm = NVDIMM(dimm);
>> -
>> -    if (!nvdimm->nvdimm_mr) {
>> -        nvdimm_prepare_memory_region(nvdimm, errp);
>> -    }
>> -}
>> -
>>  /*
>>   * the caller should check the input parameters before calling
>>   * label read/write functions.
>> @@ -192,12 +183,10 @@ static Property nvdimm_properties[] = {
>>  
>>  static void nvdimm_class_init(ObjectClass *oc, void *data)
>>  {
>> -    PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
>>      MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
>>      NVDIMMClass *nvc = NVDIMM_CLASS(oc);
>>      DeviceClass *dc = DEVICE_CLASS(oc);
>>  
>> -    ddc->realize = nvdimm_realize;
>>      mdc->get_memory_region = nvdimm_md_get_memory_region;
>>      dc->props = nvdimm_properties;
>>  
>
>I'd split your patch in 2:
>- the previous part, cleaning NVDIMM,
>- the part below, doing "git revert 9f318f8f7e6" and improving the
>commit description.
>

Sounds reasonable. Let me split this into two.

>> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
>> index 152400b1fc..5832c0ba92 100644
>> --- a/hw/mem/pc-dimm.c
>> +++ b/hw/mem/pc-dimm.c
>> @@ -159,7 +159,6 @@ static void pc_dimm_init(Object *obj)
>>  static void pc_dimm_realize(DeviceState *dev, Error **errp)
>>  {
>>      PCDIMMDevice *dimm = PC_DIMM(dev);
>> -    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>>  
>>      if (!dimm->hostmem) {
>>          error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
>> @@ -178,10 +177,6 @@ static void pc_dimm_realize(DeviceState *dev, Error **errp)
>>          return;
>>      }
>>  
>> -    if (ddc->realize) {
>> -        ddc->realize(dimm, errp);
>> -    }
>> -
>>      host_memory_backend_set_mapped(dimm->hostmem, true);
>>  }
>>  
>> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
>> index 01436b9f50..d18f8246b7 100644
>> --- a/include/hw/mem/pc-dimm.h
>> +++ b/include/hw/mem/pc-dimm.h
>> @@ -59,8 +59,6 @@ typedef struct PCDIMMDevice {
>>  
>>  /**
>>   * PCDIMMDeviceClass:
>> - * @realize: called after common dimm is realized so that the dimm based
>> - * devices get the chance to do specified operations.
>>   * @get_vmstate_memory_region: returns #MemoryRegion which indicates the
>>   * memory of @dimm should be kept during live migration. Will not fail
>>   * after the device was realized.
>> @@ -70,7 +68,6 @@ typedef struct PCDIMMDeviceClass {
>>      DeviceClass parent_class;
>>  
>>      /* public */
>> -    void (*realize)(PCDIMMDevice *dimm, Error **errp);
>>      MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm,
>>                                                 Error **errp);
>>  } PCDIMMDeviceClass;
>> 

-- 
Wei Yang
Help you, Help me
