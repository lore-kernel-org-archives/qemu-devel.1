Received: from eggs.gnu.org ([209.51.188.92]:36975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDVrN-0004aO-CI
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDVrM-0006vF-8X
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:06:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hDVrL-0006uJ-T1
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:06:56 -0400
References: <20190407092314.11066-1-thuth@redhat.com>
	<20190408134517.GA9047@richard>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
Date: Mon, 8 Apr 2019 17:06:49 +0200
MIME-Version: 1.0
In-Reply-To: <20190408134517.GA9047@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0] hw/i386/pc: Fix crash when
 hot-plugging nvdimm on older machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 08/04/2019 15.45, Wei Yang wrote:
> On Sun, Apr 07, 2019 at 11:23:14AM +0200, Thomas Huth wrote:
>> QEMU currently crashes when you try to hot-plug an "nvdimm" device
>> on older machine types:
>>
>> $ qemu-system-x86_64 -monitor stdio -M pc-1.1
>> QEMU 3.1.92 monitor - type 'help' for more information
>> (qemu) device_add nvdimm,id=nvdimmn1
>> qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
>> Assertion `*errp == ((void *)0)' failed.
>> Aborted (core dumped)
>>
>> The call to hotplug_handler_pre_plug() in pc_memory_pre_plug() has been
>> added recently before the check whether nvdimm is enabled. It should
>> be done after the check. And while we're at it, also check the errp
>> after the hotplug_handler_pre_plug(), otherwise errors are silently
>> ignored here.
> 
> Thomas,
> 
> Thanks for pointing this out, while I have some different idea on how to fix
> this.
> 
> The reason of the core dump is errp already been set in
> hotplug_handler_pre_plug(), and this function check acpi hotplug capability.
> The order of this check is correct, while we should  return when errp is set
> in hotplug_handler_pre_plug().
> 
> I got a fix like this, which I have tested and looks good to me.
> 
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 6077d27361..b11f3b15c1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2091,6 +2091,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      }
>  
>      hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
> +    if (*errp) {
> +        return;
> +    }

Not sure, but I think you can not rely on the fact that the caller set
*errp = NULL already... that's why it is more common to use a local_err
variable and error_propagate() for such cases (which is what I did in my
patch).

Also, why don't you want the "nvdimm is not enabled: missing 'nvdimm' in
'-M'" check to be done first?

 Thomas



>      if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
> 
>>
>> Fixes: 9040e6dfa8c3fed87695a3de555d2c775727bb51
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> hw/i386/pc.c | 9 +++++++--
>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 6077d27361..f2c15bf1f2 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2078,6 +2078,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>     const MachineState *ms = MACHINE(hotplug_dev);
>>     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>>     const uint64_t legacy_align = TARGET_PAGE_SIZE;
>> +    Error *local_err = NULL;
>>
>>     /*
>>      * When -no-acpi is used with Q35 machine type, no ACPI is built,
>> @@ -2090,13 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>         return;
>>     }
>>
>> -    hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
>> -
>>     if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>>         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>>         return;
>>     }
>>
>> +    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>>     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
>>                      pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
>> }
>> -- 
>> 2.21.0
> 
