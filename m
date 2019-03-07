Received: from eggs.gnu.org ([209.51.188.92]:58107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h1jvV-0000Kh-2q
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h1jvU-0008Vv-1I
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:42:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:29187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1h1jvT-0008CX-Ks
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:42:31 -0500
Date: Thu, 7 Mar 2019 11:41:56 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190307034156.GA11080@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190227075101.6263-1-richardw.yang@linux.intel.com>
	<20190227075101.6263-5-richardw.yang@linux.intel.com>
	<20190306171406.6e67d7ca@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306171406.6e67d7ca@Igors-MacBook-Pro.local>
Subject: Re: [Qemu-devel] [PATCH 4/4] nvdimm: build FIT in nvdimm_build_acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, xiaoguangrong.eric@gmail.com

On Wed, Mar 06, 2019 at 05:14:06PM +0100, Igor Mammedov wrote:
>On Wed, 27 Feb 2019 15:51:01 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> Currently we initialize nvdimm device like below:
>> 
>>     device_set_realized
>>         dc->realize
>> 	nvdimm_plug
>> 	    nvdimm_build_fit_buffer
>>     acpi_build
>>         nvdimm_build_acpi
>> 
>> This shows nvdimm's acpi stuff is prepared in two places:
>> 
>>     * device plug stage
>>     * acpi_build stage
>> 
>> It would be more proper to build fit buffer in nvdimm_build_acpi, which
>> consolidate all acpi related initialization together.
>> 
>> This patch moves FIT build in nvdimm_build_acpi.
>
>Does hotplug work after this change?
>

Looks no. I missed to test this case.

>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  hw/acpi/nvdimm.c        | 6 +-----
>>  hw/i386/pc.c            | 5 -----
>>  include/hw/mem/nvdimm.h | 1 -
>>  3 files changed, 1 insertion(+), 11 deletions(-)
>> 
>> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
>> index 2457c1aa44..6fc0c65ee0 100644
>> --- a/hw/acpi/nvdimm.c
>> +++ b/hw/acpi/nvdimm.c
>> @@ -425,11 +425,6 @@ static void nvdimm_build_fit_buffer(AcpiNVDIMMState *state)
>>      fit_buf->dirty = true;
>>  }
>>  
>> -void nvdimm_plug(AcpiNVDIMMState *state)
>> -{
>> -    nvdimm_build_fit_buffer(state);
>> -}
>> -
>>  static void nvdimm_build_nfit(AcpiNVDIMMState *state, GArray *table_offsets,
>>                                GArray *table_data, BIOSLinker *linker)
>>  {
>> @@ -1338,6 +1333,7 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
>>          return;
>>      }
>>  
>> +    nvdimm_build_fit_buffer(state);
>>      nvdimm_build_nfit(state, table_offsets, table_data, linker);
>>      g_slist_free(device_list);
>>  }
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 64d9e756fa..686b610c50 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2099,17 +2099,12 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
>>  {
>>      Error *local_err = NULL;
>>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>> -    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>>  
>>      pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
>>      if (local_err) {
>>          goto out;
>>      }
>>  
>> -    if (is_nvdimm) {
>> -        nvdimm_plug(&pcms->acpi_nvdimm_state);
>> -    }
>> -
>>      hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
>>  out:
>>      error_propagate(errp, local_err);
>> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
>> index c5c9b3c7f8..30869b4834 100644
>> --- a/include/hw/mem/nvdimm.h
>> +++ b/include/hw/mem/nvdimm.h
>> @@ -148,6 +148,5 @@ void nvdimm_init_acpi_state(AcpiNVDIMMState *state, MemoryRegion *io,
>>  void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
>>                         BIOSLinker *linker, AcpiNVDIMMState *state,
>>                         uint32_t ram_slots);
>> -void nvdimm_plug(AcpiNVDIMMState *state);
>>  void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev);
>>  #endif

-- 
Wei Yang
Help you, Help me
