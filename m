Received: from eggs.gnu.org ([209.51.188.92]:39391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hDbpO-0007tv-QP
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hDbpN-00007s-Aq
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:29:18 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:34188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hDbpM-0008Ve-Mm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:29:17 -0400
Received: by mail-ed1-x544.google.com with SMTP id x14so13063178eds.1
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 14:29:14 -0700 (PDT)
Date: Mon, 8 Apr 2019 21:29:11 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190408212911.jiqdva62ddebndut@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190407092314.11066-1-thuth@redhat.com>
	<20190408134517.GA9047@richard>
	<14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, Apr 08, 2019 at 05:06:49PM +0200, Thomas Huth wrote:
>On 08/04/2019 15.45, Wei Yang wrote:
>> On Sun, Apr 07, 2019 at 11:23:14AM +0200, Thomas Huth wrote:
>>> QEMU currently crashes when you try to hot-plug an "nvdimm" device
>>> on older machine types:
>>>
>>> $ qemu-system-x86_64 -monitor stdio -M pc-1.1
>>> QEMU 3.1.92 monitor - type 'help' for more information
>>> (qemu) device_add nvdimm,id=nvdimmn1
>>> qemu-system-x86_64: /home/thuth/devel/qemu/util/error.c:57: error_setv:
>>> Assertion `*errp == ((void *)0)' failed.
>>> Aborted (core dumped)
>>>
>>> The call to hotplug_handler_pre_plug() in pc_memory_pre_plug() has been
>>> added recently before the check whether nvdimm is enabled. It should
>>> be done after the check. And while we're at it, also check the errp
>>> after the hotplug_handler_pre_plug(), otherwise errors are silently
>>> ignored here.
>> 
>> Thomas,
>> 
>> Thanks for pointing this out, while I have some different idea on how to fix
>> this.
>> 
>> The reason of the core dump is errp already been set in
>> hotplug_handler_pre_plug(), and this function check acpi hotplug capability.
>> The order of this check is correct, while we should  return when errp is set
>> in hotplug_handler_pre_plug().
>> 
>> I got a fix like this, which I have tested and looks good to me.
>> 
>> 
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 6077d27361..b11f3b15c1 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2091,6 +2091,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>      }
>>  
>>      hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
>> +    if (*errp) {
>> +        return;
>> +    }
>
>Not sure, but I think you can not rely on the fact that the caller set
>*errp = NULL already... that's why it is more common to use a local_err
>variable and error_propagate() for such cases (which is what I did in my
>patch).
>

Ok, that's fine for me.

>Also, why don't you want the "nvdimm is not enabled: missing 'nvdimm' in
>'-M'" check to be done first?
>

Because this function pc_memory_pre_plug() will be called not only when
nvdimm is hot-plugged but also dimm is hot-plugged. And
hotplug_handler_pre_plug() here is to check the acpi(if it has) hot-plug
capability.

So the check in pc_memory_pre_plug() is from generic to specific: 
    1. Do we have capability to hot-plug?
    2. If the device is nvdimm, do we enabled nvdimm?

> Thomas
>
>
>
>>      if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>> 
>>>
>>> Fixes: 9040e6dfa8c3fed87695a3de555d2c775727bb51
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> hw/i386/pc.c | 9 +++++++--
>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 6077d27361..f2c15bf1f2 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -2078,6 +2078,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>     const MachineState *ms = MACHINE(hotplug_dev);
>>>     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>>>     const uint64_t legacy_align = TARGET_PAGE_SIZE;
>>> +    Error *local_err = NULL;
>>>
>>>     /*
>>>      * When -no-acpi is used with Q35 machine type, no ACPI is built,
>>> @@ -2090,13 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>         return;
>>>     }
>>>
>>> -    hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
>>> -
>>>     if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
>>>         error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
>>>         return;
>>>     }
>>>
>>> +    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +
>>>     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
>>>                      pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
>>> }
>>> -- 
>>> 2.21.0
>> 
>

-- 
Wei Yang
Help you, Help me
