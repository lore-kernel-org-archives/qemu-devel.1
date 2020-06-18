Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9342AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6C220884
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYtix3u/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6C220884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlqif-0005Os-Mb
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 05:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlqi0-0004px-0g
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 05:19:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23843
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlqhx-0001IL-DO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 05:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592471979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SG++NMBLXy8WlCCrqcoqtuHL8SKBj9Y06zDSsSohNOU=;
 b=WYtix3u/sLcqmrMNjH5X7C3fWsoAGmU/ndpW3EhhMjCRtBaV0VJJHY5kBG9cKYWaxJGBJv
 YhwiCabLkJ3gWo6FSS6CCidE/csvf8+QDpX8CZ5eskiRjiQUwOgDs6dW5+W2uhW0CHegSP
 7zLB7Ru/zHoHnv3CKvX8SUhWv3Sty9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-A2GZGWLdOnuz8DAFpEFhYw-1; Thu, 18 Jun 2020 05:19:37 -0400
X-MC-Unique: A2GZGWLdOnuz8DAFpEFhYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37D4B801504;
 Thu, 18 Jun 2020 09:19:36 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8916D5D9D3;
 Thu, 18 Jun 2020 09:19:30 +0000 (UTC)
Subject: Re: [PATCH v2] arm/virt: Add memory hot remove support
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <20200520110354.14352-1-shameerali.kolothum.thodi@huawei.com>
 <96e2efe0-0fda-6d73-4164-12ee9837a679@redhat.com>
 <dffc2d686d7f458aa22326b87f29b15b@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e73c673b-5986-744e-80a7-784e9af2027a@redhat.com>
Date: Thu, 18 Jun 2020 11:19:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dffc2d686d7f458aa22326b87f29b15b@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Linuxarm <linuxarm@huawei.com>, "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,

On 6/17/20 6:40 PM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Auger Eric [mailto:eric.auger@redhat.com]
>> Sent: 17 June 2020 14:54
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> qemu-devel@nongnu.org; qemu-arm@nongnu.org
>> Cc: imammedo@redhat.com; peter.maydell@linaro.org; mst@redhat.com;
>> xuwei (O) <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
>> Linuxarm <linuxarm@huawei.com>
>> Subject: Re: [PATCH v2] arm/virt: Add memory hot remove support
>>
>> Hi Shameer,
>>
>> On 5/20/20 1:03 PM, Shameer Kolothum wrote:
>>> This adds support for memory hot remove on arm/virt that
>>> uses acpi ged device.
>>>
>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>> RFC v1 --> v2
>>>   -Rebased on top of latest Qemu master.
>>>   -Dropped "RFC" and tested with kernel 5.7-rc6
>>> ---
>>>  hw/acpi/generic_event_device.c | 28 +++++++++++++++++
>>>  hw/arm/virt.c                  | 56
>> ++++++++++++++++++++++++++++++++--
>>>  2 files changed, 82 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/acpi/generic_event_device.c
>> b/hw/acpi/generic_event_device.c
>>> index b1cbdd86b6..2b3bedcd2f 100644
>>> --- a/hw/acpi/generic_event_device.c
>>> +++ b/hw/acpi/generic_event_device.c
>>> @@ -193,6 +193,32 @@ static void
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
>> is it allowed to unplug NVDIMM? As NVDIMM inherits from PCDIMM, I wonder
>> if we have to handle the case differently (as done in hotplug part).
> 
> True. This patch requires NVDMM check. I think when I sent out the initial RFC
> NVDIMM hot add was not merged and I forgot to update it. My bad.
> 
> But not sure we need to add the check here if we take care that in
> virt_machine_device_unplug_request_cb() as you have noted below. Do we?

I think I would, in case the GED were instantiated by another machine
that wouldn't have handled the case.
>  
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
>>> @@ -318,6 +344,8 @@ static void acpi_ged_class_init(ObjectClass *class,
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
>>> index 37462a6f78..110fa73990 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -2177,11 +2177,62 @@ static void
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
>> same here. By comparison, in hw/i386/pc.c, it is said
>> "nvdimm device hot unplug is not supported yet."
> 
> Sure. I will change it.
> 
>> what is the situation on ARM?
> 
> I don’t think it supports it. I will check.
OK

Thanks

Eric
> 
> Thanks,
> Shameer
>  
>> Thanks
>>
>> Eric
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
>>> @@ -2262,6 +2313,7 @@ static void virt_machine_class_init(ObjectClass
>> *oc, void *data)
>>>      hc->pre_plug = virt_machine_device_pre_plug_cb;
>>>      hc->plug = virt_machine_device_plug_cb;
>>>      hc->unplug_request = virt_machine_device_unplug_request_cb;
>>> +    hc->unplug = virt_machine_device_unplug_cb;
>>>      mc->numa_mem_supported = true;
>>>      mc->nvdimm_supported = true;
>>>      mc->auto_enable_numa_with_memhp = true;
>>>
> 


