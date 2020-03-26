Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA515C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDFB20409
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqxGBHgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDFB20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHR3W-0005TZ-Pu
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 07:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jHR2r-0004nW-Gj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jHR2p-0002XS-J3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:51:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56271)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jHR2p-0002X2-Di
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585223490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLnEAt+6BrBaQnSkassFqgYv79Jhms/iTJpo2JV6vpc=;
 b=RqxGBHgl/7S8CzdycEE7xI05XUZtRHbTLxaMdDUYaNWRIV9vyz54SOpP2PhXNLF5HmyBK0
 2yufqh02Gpks+3jYGg1gA4/VbibYSbCdGhUX36713q8MJGLpGdhvRTFMy5NNV2i+cv6hZB
 eGMjDiF+MU3K1UwBYMv1mpPOQPheVEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-v_8ALUnhOQmM4E1s_lZKZg-1; Thu, 26 Mar 2020 07:51:24 -0400
X-MC-Unique: v_8ALUnhOQmM4E1s_lZKZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2227800D4E;
 Thu, 26 Mar 2020 11:51:22 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0A4D19925;
 Thu, 26 Mar 2020 11:51:15 +0000 (UTC)
Subject: Re: [RFC v1] arm/virt: Add memory hot remove support
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <20200318123722.19736-1-shameerali.kolothum.thodi@huawei.com>
 <b6c6f33b-7e4f-0b46-b67d-2de572e12626@redhat.com>
 <246eb04443e342749ed91533949a5e67@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <65e01a68-8228-ea4b-10b9-a21eac55eda0@redhat.com>
Date: Thu, 26 Mar 2020 12:51:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <246eb04443e342749ed91533949a5e67@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "xuwei \(O\)" <xuwei5@huawei.com>, "mst@redhat.com" <mst@redhat.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,

On 3/26/20 12:14 PM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Auger Eric [mailto:eric.auger@redhat.com]
>> Sent: 26 March 2020 11:01
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> qemu-devel@nongnu.org; qemu-arm@nongnu.org
>> Cc: imammedo@redhat.com; peter.maydell@linaro.org; mst@redhat.com;
>> xuwei (O) <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
>> Linuxarm <linuxarm@huawei.com>; Anshuman Khandual
>> <anshuman.khandual@arm.com>
>> Subject: Re: [RFC v1] arm/virt: Add memory hot remove support
>>
>> Hi Shameer,
>>
>> On 3/18/20 1:37 PM, Shameer Kolothum wrote:
>>> This adds support for memory hot remove on arm/virt that
>>> uses acpi ged device.
>>
>> I gave this a try and it works fine if the PCDIMM slot was initially
>> hotplugged:
>> (QEMU) object-add qom-type=memory-backend-ram id=mem1
>> props.size=4294967296
>> {"return": {}}
>> (QEMU) device_add driver=pc-dimm  id=pcdimm1 memdev=mem1
>> (QEMU) device_del id=pcdimm1
>> {"return": {}}
>>
>> on guest I can see:
>> [   82.466321] Offlined Pages 262144
>> [   82.541712] Offlined Pages 262144
>> [   82.589236] Offlined Pages 262144
>> [   82.969166] Offlined Pages 262144
>>
>> However I noticed that if qemu is launched directly with
>>
>> -m 16G,maxmem=32G,slots=2 \
>> -object memory-backend-ram,id=mem1,size=4G \
>> -device pc-dimm,memdev=mem1,id=dimm1,driver=pc-dimm -device
>>
>> and then in the qmp shell:
>> (QEMU) device_del id=dimm1
>>
>> the hot-unplug fails in guest:
>>
>> [   78.897407] Offlined Pages 262144
>> [   79.260811] Offlined Pages 262144
>> [   79.308105] Offlined Pages 262144
>> [   79.333675] page:fffffe00137d1f40 refcount:1 mapcount:0
>> mapping:ffff0004ea9f20b1 index:0xaaab11c6e
>> [   79.335927] anon flags: 0x17ffff8000080024(uptodate|active|swapbacked)
>> [   79.337571] raw: 17ffff8000080024 dead000000000100
>> dead000000000122
>> ffff0004ea9f20b1
>> [   79.339502] raw: 0000000aaab11c6e 0000000000000000 00000001ffffffff
>> ffff0004fd4e3000
>> [   79.341701] page dumped because: unmovable page
>> [   79.342887] page->mem_cgroup:ffff0004fd4e3000
>> [   79.354729] page:fffffe00137d1f40 refcount:1 mapcount:0
>> mapping:ffff0004ea9f20b1 index:0xaaab11c6e
>> [   79.357012] anon flags: 0x17ffff8000080024(uptodate|active|swapbacked)
>> [   79.358658] raw: 17ffff8000080024 dead000000000100
>> dead000000000122
>> ffff0004ea9f20b1
>> [   79.360611] raw: 0000000aaab11c6e 0000000000000000 00000001ffffffff
>> ffff0004fd4e3000
>> [   79.362560] page dumped because: unmovable page
>> [   79.363742] page->mem_cgroup:ffff0004fd4e3000
>> [   79.368636] memory memory20: Offline failed.
>>
>> I did not expect this. The PCDIMM slot in that case does not seem to be
>> interpreted as a hot-unpluggable one (?). I added Anshuman in cc.
> 
> Could you please try adding "movable_node" to qemu guest kernel command line params.
> This will prevent any kernel allocation from hotplugable memory nodes which I think is
> causing the behavior you are seeing.

Effectively, when adding the movable_node option in the guest kernel
parameters, I get the following traces:

[   29.581418] Offlined Pages 262144
[   29.663605] Offlined Pages 262144
[   29.714225] Offlined Pages 262144
[   30.222953] Offlined Pages 262144
[   30.314288] Built 1 zonelists, mobility grouping on.  Total pages:
4076898
[   30.316067] Policy zone: Normal

Thanks

Eric

> 
> Thanks,
> Shameer
> 
> 
>> Thanks
>>
>> Eric
>>
>>
>>
>>>
>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  -RFC because linux kernel support for mem hot remove is just queued
>>>   for 5.7[1].
>>>  -Tested with guest kernel 5.6-rc5 + [1]
>>>
>>> 1. https://patchwork.kernel.org/cover/11419301/
>>> ---
>>>  hw/acpi/generic_event_device.c | 28 +++++++++++++++++
>>>  hw/arm/virt.c                  | 56
>> ++++++++++++++++++++++++++++++++--
>>>  2 files changed, 82 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/acpi/generic_event_device.c
>> b/hw/acpi/generic_event_device.c
>>> index 021ed2bf23..3e28c110fa 100644
>>> --- a/hw/acpi/generic_event_device.c
>>> +++ b/hw/acpi/generic_event_device.c
>>> @@ -182,6 +182,32 @@ static void
>> acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>>>      }
>>>  }
>>>
>>> +static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
>>> +                                       DeviceState *dev, Error
>> **errp)
>>> +{
>>> +    AcpiGedState *s = ACPI_GED(hotplug_dev);
>>> +
>>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>> +        acpi_memory_unplug_request_cb(hotplug_dev,
>> &s->memhp_state, dev, errp);
>>> +    } else {
>>> +        error_setg(errp, "acpi: device unplug request for unsupported
>> device"
>>> +                   " type: %s", object_get_typename(OBJECT(dev)));
>>> +    }
>>> +}
>>> +
>>> +static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
>>> +                               DeviceState *dev, Error **errp)
>>> +{
>>> +    AcpiGedState *s = ACPI_GED(hotplug_dev);
>>> +
>>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>> +        acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
>>> +    } else {
>>> +        error_setg(errp, "acpi: device unplug for unsupported device"
>>> +                   " type: %s", object_get_typename(OBJECT(dev)));
>>> +    }
>>> +}
>>> +
>>>  static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits
>> ev)
>>>  {
>>>      AcpiGedState *s = ACPI_GED(adev);
>>> @@ -286,6 +312,8 @@ static void acpi_ged_class_init(ObjectClass *class,
>> void *data)
>>>      dc->vmsd = &vmstate_acpi_ged;
>>>
>>>      hc->plug = acpi_ged_device_plug_cb;
>>> +    hc->unplug_request = acpi_ged_unplug_request_cb;
>>> +    hc->unplug = acpi_ged_unplug_cb;
>>>
>>>      adevc->send_event = acpi_ged_send_event;
>>>  }
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 94f93dda54..91974e4e80 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -2096,11 +2096,62 @@ static void
>> virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>>      }
>>>  }
>>>
>>> +static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
>>> +                                     DeviceState *dev, Error
>> **errp)
>>> +{
>>> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>>> +    Error *local_err = NULL;
>>> +
>>> +    if (!vms->acpi_dev) {
>>> +        error_setg(errp,
>>> +                   "memory hotplug is not enabled: missing acpi-ged
>> device");
>>> +        goto out;
>>> +    }
>>> +
>>> +    hotplug_handler_unplug_request(HOTPLUG_HANDLER(vms->acpi_dev),
>> dev,
>>> +                                   &local_err);
>>> +out:
>>> +    error_propagate(errp, local_err);
>>> +}
>>> +
>>> +static void virt_dimm_unplug(HotplugHandler *hotplug_dev,
>>> +                             DeviceState *dev, Error **errp)
>>> +{
>>> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>>> +    Error *local_err = NULL;
>>> +
>>> +    hotplug_handler_unplug(HOTPLUG_HANDLER(vms->acpi_dev), dev,
>> &local_err);
>>> +    if (local_err) {
>>> +        goto out;
>>> +    }
>>> +
>>> +    pc_dimm_unplug(PC_DIMM(dev), MACHINE(vms));
>>> +    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
>>> +
>>> + out:
>>> +    error_propagate(errp, local_err);
>>> +}
>>> +
>>>  static void virt_machine_device_unplug_request_cb(HotplugHandler
>> *hotplug_dev,
>>>                                            DeviceState *dev, Error
>> **errp)
>>>  {
>>> -    error_setg(errp, "device unplug request for unsupported device"
>>> -               " type: %s", object_get_typename(OBJECT(dev)));
>>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>> +        virt_dimm_unplug_request(hotplug_dev, dev, errp);
>>> +    } else {
>>> +        error_setg(errp, "device unplug request for unsupported device"
>>> +                   " type: %s", object_get_typename(OBJECT(dev)));
>>> +    }
>>> +}
>>> +
>>> +static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>>> +                                          DeviceState *dev, Error
>> **errp)
>>> +{
>>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>> +        virt_dimm_unplug(hotplug_dev, dev, errp);
>>> +    } else {
>>> +        error_setg(errp, "virt: device unplug for unsupported device"
>>> +                   " type: %s", object_get_typename(OBJECT(dev)));
>>> +    }
>>>  }
>>>
>>>  static HotplugHandler *virt_machine_get_hotplug_handler(MachineState
>> *machine,
>>> @@ -2181,6 +2232,7 @@ static void virt_machine_class_init(ObjectClass
>> *oc, void *data)
>>>      hc->pre_plug = virt_machine_device_pre_plug_cb;
>>>      hc->plug = virt_machine_device_plug_cb;
>>>      hc->unplug_request = virt_machine_device_unplug_request_cb;
>>> +    hc->unplug = virt_machine_device_unplug_cb;
>>>      mc->numa_mem_supported = true;
>>>      mc->auto_enable_numa_with_memhp = true;
>>>      mc->default_ram_id = "mach-virt.ram";
>>>
> 


