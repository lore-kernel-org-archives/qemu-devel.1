Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F25C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 23:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B003A207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 23:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="JPiDI5Cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B003A207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia7DS-00022V-RH
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 18:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ia7CV-000174-2Y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:58:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ia7CQ-000532-LR
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:58:26 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ia7CQ-0004zW-18
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:58:22 -0500
Received: by mail-pf1-x444.google.com with SMTP id x28so12050071pfo.6
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 15:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=O5BGWyGtea2qETbd5/UcTO4bWXKZKfw6R2zFRxKhd3w=;
 b=JPiDI5CbL+AqpJqG0bP8AxI/eVU2gTyJRDQCe0mosuoIGIGDv6Dp23TED34HE914jM
 hTWRJZuyNh2sqrnQKM457CYx9eDN7NN6/1xH3J1p/w7O3EPG5H7rm8GG/stk1k8m66+S
 UfieQAh+l9G0QqNaKlDBkWXiR1wA/xRVcmBrloM7q5afRF2BwJKIDVSHACLosLeVIT0R
 RmvpDe0Z4Rkm0nygmDAd/brI0E0ZMlq5rGXO9y5RVAVoFRRRTPRs+P37IFgh8W9rbRPo
 pESGa8NKgOqYUjASfcfyz7W+48qRGZtoD4dcQjhY5VkPYvqA+j0ZVHLc6is1U/uuwp0i
 LegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=O5BGWyGtea2qETbd5/UcTO4bWXKZKfw6R2zFRxKhd3w=;
 b=rXBlwxGLDXY25ozKiSL6mcHgZV3ttaNTOvpcuVDv5snHADweK1AFTLgl9idTqAjHl9
 B5G4R+7RPZHnvmu4Q7XQ7BWzNAfRoH+AIm7c9DgTxwFBuTaBQNxy6Kvdqz5yFm8/qJQc
 8TIF/pJ9mTrD8Hu7RdyQ6v05Nuektc+ckwBJzlRDVs9sNzu7JIV1x/K1prnhQA/IwGR8
 qNwaWOacm2k2fFPb/NJLDCv6uaFzAiN3CKUdi8JiSvEDqDBfYigFkCBjWlfacNJCh/In
 KRUDK7Yh6zJ1YGCJUQIOxB3IuOK7Sad4d74JMnjiCcW3uxQVzXF/a2z/J84ebDNlymP0
 bFpw==
X-Gm-Message-State: APjAAAVJXwvYc9SEGjsjWWpwrFLVvvsP9GLcmrrnN44qdE09HPwkgxNl
 6dpzYCA6yz+hHdqF2FOv0aOJrL7B7bY=
X-Google-Smtp-Source: APXvYqwy4z0AXPoJcMVV9lqLU89+GlCtisLwoxA7Np0nklconC8mxEaanENMZhZ07cyzNnXuYZ1n4g==
X-Received: by 2002:a62:be0e:: with SMTP id l14mr10317162pff.117.1574899099586; 
 Wed, 27 Nov 2019 15:58:19 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d6sm17792061pfn.32.2019.11.27.15.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 15:58:18 -0800 (PST)
Subject: Re: [PATCH 4/4] qom/object: Use common get/set uint helpers
To: Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20191125153619.39893-1-felipe@nutanix.com>
 <20191125153619.39893-5-felipe@nutanix.com>
 <CAJ+F1CJT5pe6NYKHVk1OF70RkBK-d9uW4Q93J1yg+jTpL0FhOQ@mail.gmail.com>
 <BC542109-15C8-4C3E-B14F-AA4444BF16CD@nutanix.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <1aa35893-6686-b618-7fc7-8c48e7ba9a70@ozlabs.ru>
Date: Thu, 28 Nov 2019 10:58:14 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <BC542109-15C8-4C3E-B14F-AA4444BF16CD@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 26/11/2019 20:39, Felipe Franciosi wrote:
> 
> 
>> On Nov 26, 2019, at 8:39 AM, Marc-André Lureau <marcandre.lureau@gmail.com> wrote:
>>
>> Hi
> 
> Heya, thanks for the review.
> 
>>
>> On Mon, Nov 25, 2019 at 7:37 PM Felipe Franciosi <felipe@nutanix.com> wrote:
>>>
>>> Several objects implemented their own uint property getters and setters,
>>> despite them being straightforward (without any checks/validations on
>>> the values themselves) and identical across objects. This makes use of
>>> an enhanced API for object_property_add_uintXX_ptr() which offers
>>> default setters.
>>>
>>> Some of these setters used to update the value even if the type visit
>>> failed (eg. because the value being set overflowed over the given type).
>>> The new setter introduces a check for these errors, not updating the
>>> value if an error occurred. The error is propagated.
>>>
>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>
>>
>> Some comments below, otherwise:
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>>> ---
>>> hw/acpi/ich9.c       |  93 +++------------------------------------
>>> hw/isa/lpc_ich9.c    |  14 +-----
>>> hw/misc/edu.c        |  12 +----
>>> hw/pci-host/q35.c    |  14 ++----
>>> hw/ppc/spapr.c       |  17 ++------
>>> hw/vfio/pci-quirks.c |  18 ++------
>>> memory.c             |  15 +------
>>> target/arm/cpu.c     |  21 +--------
>>> target/i386/sev.c    | 102 +++----------------------------------------
>>> 9 files changed, 29 insertions(+), 277 deletions(-)
>>>
>>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
>>> index 94dc5147ce..aa3c7a59ab 100644
>>> --- a/hw/acpi/ich9.c
>>> +++ b/hw/acpi/ich9.c
>>> @@ -357,81 +357,6 @@ static void ich9_pm_set_cpu_hotplug_legacy(Object *obj, bool value,
>>>     s->pm.cpu_hotplug_legacy = value;
>>> }
>>>
>>> -static void ich9_pm_get_disable_s3(Object *obj, Visitor *v, const char *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm = opaque;
>>> -    uint8_t value = pm->disable_s3;
>>> -
>>> -    visit_type_uint8(v, name, &value, errp);
>>> -}
>>> -
>>> -static void ich9_pm_set_disable_s3(Object *obj, Visitor *v, const char *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm = opaque;
>>> -    Error *local_err = NULL;
>>> -    uint8_t value;
>>> -
>>> -    visit_type_uint8(v, name, &value, &local_err);
>>> -    if (local_err) {
>>> -        goto out;
>>> -    }
>>> -    pm->disable_s3 = value;
>>> -out:
>>> -    error_propagate(errp, local_err);
>>> -}
>>> -
>>> -static void ich9_pm_get_disable_s4(Object *obj, Visitor *v, const char *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm = opaque;
>>> -    uint8_t value = pm->disable_s4;
>>> -
>>> -    visit_type_uint8(v, name, &value, errp);
>>> -}
>>> -
>>> -static void ich9_pm_set_disable_s4(Object *obj, Visitor *v, const char *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm = opaque;
>>> -    Error *local_err = NULL;
>>> -    uint8_t value;
>>> -
>>> -    visit_type_uint8(v, name, &value, &local_err);
>>> -    if (local_err) {
>>> -        goto out;
>>> -    }
>>> -    pm->disable_s4 = value;
>>> -out:
>>> -    error_propagate(errp, local_err);
>>> -}
>>> -
>>> -static void ich9_pm_get_s4_val(Object *obj, Visitor *v, const char *name,
>>> -                               void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm = opaque;
>>> -    uint8_t value = pm->s4_val;
>>> -
>>> -    visit_type_uint8(v, name, &value, errp);
>>> -}
>>> -
>>> -static void ich9_pm_set_s4_val(Object *obj, Visitor *v, const char *name,
>>> -                               void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCPMRegs *pm = opaque;
>>> -    Error *local_err = NULL;
>>> -    uint8_t value;
>>> -
>>> -    visit_type_uint8(v, name, &value, &local_err);
>>> -    if (local_err) {
>>> -        goto out;
>>> -    }
>>> -    pm->s4_val = value;
>>> -out:
>>> -    error_propagate(errp, local_err);
>>> -}
>>> -
>>> static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
>>> {
>>>     ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
>>> @@ -468,18 +393,12 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
>>>                              ich9_pm_get_cpu_hotplug_legacy,
>>>                              ich9_pm_set_cpu_hotplug_legacy,
>>>                              NULL);
>>> -    object_property_add(obj, ACPI_PM_PROP_S3_DISABLED, "uint8",
>>> -                        ich9_pm_get_disable_s3,
>>> -                        ich9_pm_set_disable_s3,
>>> -                        NULL, pm, NULL);
>>> -    object_property_add(obj, ACPI_PM_PROP_S4_DISABLED, "uint8",
>>> -                        ich9_pm_get_disable_s4,
>>> -                        ich9_pm_set_disable_s4,
>>> -                        NULL, pm, NULL);
>>> -    object_property_add(obj, ACPI_PM_PROP_S4_VAL, "uint8",
>>> -                        ich9_pm_get_s4_val,
>>> -                        ich9_pm_set_s4_val,
>>> -                        NULL, pm, NULL);
>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
>>> +                                  &pm->disable_s3, false, errp);
>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
>>> +                                  &pm->disable_s4, false, errp);
>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
>>> +                                  &pm->s4_val, false, errp);
>>
>> Sometime object properties are registered with error_abort, sometime
>> with errp, sometime with NULL.
>>
>> Here you changed the argument. Not a big deal, but I think you should
>> leave it as is for now. And we can address the error handling
>> inconsisteny another day.
> 
> You are right. Let me go over that once more and send a v2. I don't
> believe in changing too many things at once and improvements or not,
> it should be done separately (if anything to allow an easier revert
> later on). :)
> 
>>
>>>     object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
>>>                              ich9_pm_get_enable_tco,
>>>                              ich9_pm_set_enable_tco,
>>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>>> index 232c7916f3..9abe07247e 100644
>>> --- a/hw/isa/lpc_ich9.c
>>> +++ b/hw/isa/lpc_ich9.c
>>> @@ -627,15 +627,6 @@ static const MemoryRegionOps ich9_rst_cnt_ops = {
>>>     .endianness = DEVICE_LITTLE_ENDIAN
>>> };
>>>
>>> -static void ich9_lpc_get_sci_int(Object *obj, Visitor *v, const char *name,
>>> -                                 void *opaque, Error **errp)
>>> -{
>>> -    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
>>> -    uint8_t value = lpc->sci_gsi;
>>> -
>>> -    visit_type_uint8(v, name, &value, errp);
>>> -}
>>> -
>>> static void ich9_lpc_initfn(Object *obj)
>>> {
>>>     ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
>>> @@ -643,9 +634,8 @@ static void ich9_lpc_initfn(Object *obj)
>>>     static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
>>>     static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
>>>
>>> -    object_property_add(obj, ACPI_PM_PROP_SCI_INT, "uint8",
>>> -                        ich9_lpc_get_sci_int,
>>> -                        NULL, NULL, NULL, NULL);
>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
>>> +                                  &lpc->sci_gsi, true, NULL);
>>>     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_ACPI_ENABLE_CMD,
>>>                                   &acpi_enable_cmd, true, NULL);
>>>     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_ACPI_DISABLE_CMD,
>>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>>> index d5e2bdbb57..200503ecfd 100644
>>> --- a/hw/misc/edu.c
>>> +++ b/hw/misc/edu.c
>>> @@ -396,21 +396,13 @@ static void pci_edu_uninit(PCIDevice *pdev)
>>>     msi_uninit(pdev);
>>> }
>>>
>>> -static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
>>> -                           void *opaque, Error **errp)
>>> -{
>>> -    uint64_t *val = opaque;
>>> -
>>> -    visit_type_uint64(v, name, val, errp);
>>> -}
>>> -
>>> static void edu_instance_init(Object *obj)
>>> {
>>>     EduState *edu = EDU(obj);
>>>
>>>     edu->dma_mask = (1UL << 28) - 1;
>>> -    object_property_add(obj, "dma_mask", "uint64", edu_obj_uint64,
>>> -                    edu_obj_uint64, NULL, &edu->dma_mask, NULL);
>>> +    object_property_add_uint64_ptr(obj, "dma_mask",
>>> +                                   &edu->dma_mask, false, NULL);
>>> }
>>>
>>> static void edu_class_init(ObjectClass *class, void *data)
>>> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>>> index 158d270b9f..61fbe04fe9 100644
>>> --- a/hw/pci-host/q35.c
>>> +++ b/hw/pci-host/q35.c
>>> @@ -165,14 +165,6 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
>>>     visit_type_uint64(v, name, &value, errp);
>>> }
>>>
>>> -static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const char *name,
>>> -                                    void *opaque, Error **errp)
>>> -{
>>> -    PCIExpressHost *e = PCIE_HOST_BRIDGE(obj);
>>> -
>>> -    visit_type_uint64(v, name, &e->size, errp);
>>> -}
>>> -
>>> /*
>>>  * NOTE: setting defaults for the mch.* fields in this table
>>>  * doesn't work, because mch is a separate QOM object that is
>>> @@ -213,6 +205,7 @@ static void q35_host_initfn(Object *obj)
>>> {
>>>     Q35PCIHost *s = Q35_HOST_DEVICE(obj);
>>>     PCIHostState *phb = PCI_HOST_BRIDGE(obj);
>>> +    PCIExpressHost *pehb = PCIE_HOST_BRIDGE(obj);
>>>
>>>     memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, phb,
>>>                           "pci-conf-idx", 4);
>>> @@ -242,9 +235,8 @@ static void q35_host_initfn(Object *obj)
>>>                         q35_host_get_pci_hole64_end,
>>>                         NULL, NULL, NULL, NULL);
>>>
>>> -    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
>>> -                        q35_host_get_mmcfg_size,
>>> -                        NULL, NULL, NULL, NULL);
>>> +    object_property_add_uint64_ptr(obj, PCIE_HOST_MCFG_SIZE,
>>> +                                   &pehb->size, true, NULL);
>>>
>>>     object_property_add_link(obj, MCH_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGION,
>>>                              (Object **) &s->mch.ram_memory,
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index e076f6023c..1b9400526f 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -3227,18 +3227,6 @@ static void spapr_set_resize_hpt(Object *obj, const char *value, Error **errp)
>>>     }
>>> }
>>>
>>> -static void spapr_get_vsmt(Object *obj, Visitor *v, const char *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>>> -}
>>> -
>>> -static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>>> -}
>>> -
>>> static char *spapr_get_ic_mode(Object *obj, Error **errp)
>>> {
>>>     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>>> @@ -3336,8 +3324,9 @@ static void spapr_instance_init(Object *obj)
>>>     object_property_set_description(obj, "resize-hpt",
>>>                                     "Resizing of the Hash Page Table (enabled, disabled, required)",
>>>                                     NULL);
>>> -    object_property_add(obj, "vsmt", "uint32", spapr_get_vsmt,
>>> -                        spapr_set_vsmt, NULL, &spapr->vsmt, &error_abort);
>>> +    object_property_add_uint32_ptr(obj, "vsmt",
>>> +                                   &spapr->vsmt, false, &error_abort);
>>> +
>>>     object_property_set_description(obj, "vsmt",
>>>                                     "Virtual SMT: KVM behaves as if this were"
>>>                                     " the host's SMT mode", &error_abort);
>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>>> index 136f3a9ad6..34335e071e 100644
>>> --- a/hw/vfio/pci-quirks.c
>>> +++ b/hw/vfio/pci-quirks.c
>>> @@ -2187,14 +2187,6 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
>>>     return 0;
>>> }
>>>
>>> -static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
>>> -                                     const char *name,
>>> -                                     void *opaque, Error **errp)
>>> -{
>>> -    uint64_t tgt = (uintptr_t) opaque;
>>> -    visit_type_uint64(v, name, &tgt, errp);
>>> -}
>>> -
>>> static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
>>>                                                  const char *name,
>>>                                                  void *opaque, Error **errp)
>>> @@ -2240,9 +2232,8 @@ int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
>>>                                nv2reg->size, p);
>>>     QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
>>>
>>> -    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
>>> -                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
>>> -                        (void *) (uintptr_t) cap->tgt, NULL);
>>> +    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
>>> +                                   (void *)(uintptr_t)cap->tgt, true, NULL);
>>
>> nit: (void *) is enough, no?
> 
> Actually, I think this is completely wrong. I asked AW on IRC (he was
> away and I didn't wait; oops), but I'll Cc him here and Alexey as well
> (who wrote the code).
> 
> Maybe I'm missing something, but it looks like this is passing the
> absolute value of cap->tgt as a pointer. Shouldn't it just be
> &cap->tg?


Passing &cap->tgt requres @cap to stay in memory until the user of that
property reads it which is not the case here - the property is set when
the device is "realized" and used every time the pseries machine is
reset. This is rather highjacking QOM and properties to pass a 64bit
value from VFIO to PPC64/pseries without sharing any C structures.


> I don't understand the casting to (void *).

object_property_add() takes void*, and cap->tgt is not exactly an
address so it is not a pointer, it is an abbreviated host hardware
address which acts here more like a handle/cookie as in fact it is only
56bit but whatever :)



> Later, in
> vfio_pci_nvlink2_get_*, it does:
> 
>     uint64_t val = (uintptr_t)opaque;
>     visit_type_unitXX(..., &val, ...);
> 
> It looks to me like that only gets the local variable and doesn't
> return anything in practice. But again, I'm not familiar with this at
> all so I may be saying non-sense.


This visit_type_unitXX() thing puts @val to the visitor object which is
then read by object_property_get(). I am having hardtime tracing this
code, below is the example of a read (hopefully TB won't break
formatting much). Thanks,


(gdb) bt
#0  0x0000000100b902e0 in qobject_output_add_obj (qov=0x101dbfd70,
name=0x100dbdaf0 "nvlink2-tgt", value=0x103b8f000) at
/home/aik/p/qemu/qapi/qobject-output-visitor.c:83
#1  0x0000000100b908c0 in qobject_output_type_uint64 (v=0x101dbfd70,
name=0x100dbdaf0 "nvlink2-tgt", obj=0x7fffffffe780, errp=0x7fffffffe888)
at /home/aik/p/qemu/qapi/qobject-output-visitor.c:158
#2  0x0000000100b8be94 in visit_type_uint64 (v=0x101dbfd70,
name=0x100dbdaf0 "nvlink2-tgt", obj=0x7fffffffe780, errp=0x7fffffffe888)
at /home/aik/p/qemu/qapi/qapi-visit-core.c:207
#3  0x00000001004678f4 in vfio_pci_nvlink2_get_tgt (obj=0x102a84910,
v=0x101dbfd70, name=0x100dbdaf0 "nvlink2-tgt", opaque=0x40000000000,
errp=0x7fffffffe888) at /home/aik/p/qemu/hw/vfio/pci-quirks.c:2195
#4  0x0000000100a45720 in object_property_get (obj=0x102a84910,
v=0x101dbfd70, name=0x100dbdaf0 "nvlink2-tgt", errp=0x7fffffffe888) at
/home/aik/p/qemu/qom/object.c:1257
#5  0x0000000100a49fe8 in object_property_get_qobject (obj=0x102a84910,
name=0x100dbdaf0 "nvlink2-tgt", errp=0x0) at
/home/aik/p/qemu/qom/qom-qobject.c:38
#6  0x0000000100a460c8 in object_property_get_uint (obj=0x102a84910,
name=0x100dbdaf0 "nvlink2-tgt", errp=0x0) at
/home/aik/p/qemu/qom/object.c:1407
#7  0x00000001004eca98 in spapr_phb_pci_collect_nvgpu (bus=0x101d817f0,
pdev=0x102a84910, opaque=0x101dbfaa0) at
/home/aik/p/qemu/hw/ppc/spapr_pci_nvlink2.c:139
#8  0x000000010087795c in pci_for_each_device_under_bus
(bus=0x101d817f0, fn=0x1004eca48 <spapr_phb_pci_collect_nvgpu>,
opaque=0x101dbfaa0) at /home/aik/p/qemu/hw/pci/pci.c:1638
#9  0x00000001008779fc in pci_for_each_device (bus=0x101d817f0,
bus_num=0x0, fn=0x1004eca48 <spapr_phb_pci_collect_nvgpu>,
opaque=0x101dbfaa0) at /home/aik/p/qemu/hw/pci/pci.c:1650
#10 0x00000001004ecdd0 in spapr_phb_nvgpu_setup (sphb=0x101d34f20,
errp=0x7fffffffeb68) at /home/aik/p/qemu/hw/ppc/spapr_pci_nvlink2.c:187
#11 0x00000001004cb8f8 in spapr_phb_reset (qdev=0x101d34f20) at
/home/aik/p/qemu/hw/ppc/spapr_pci.c:2049
#12 0x0000000100718858 in device_reset (dev=0x101d34f20) at
/home/aik/p/qemu/hw/core/qdev.c:1112
#13 0x00000001007159f0 in qdev_reset_one (dev=0x101d34f20, opaque=0x0)
at /home/aik/p/qemu/hw/core/qdev.c:277
#14 0x0000000100716d18 in qdev_walk_children (dev=0x101d34f20,
pre_devfn=0x0, pre_busfn=0x0, post_devfn=0x1007159c4 <qdev_reset_one>,
post_busfn=0x100715a18 <qbus_reset_one>, opaque=0x0) at
/home/aik/p/qemu/hw/core/qdev.c:593
#15 0x000000010071d1ac in qbus_walk_children (bus=0x1016df320,
pre_devfn=0x0, pre_busfn=0x0, post_devfn=0x1007159c4 <qdev_reset_one>,
post_busfn=0x100715a18 <qbus_reset_one>, opaque=0x0) at
/home/aik/p/qemu/hw/core/bus.c:53
#16 0x0000000100715bf4 in qbus_reset_all (bus=0x1016df320) at
/home/aik/p/qemu/hw/core/qdev.c:303
#17 0x0000000100715c4c in qbus_reset_all_fn (opaque=0x1016df320) at
/home/aik/p/qemu/hw/core/qdev.c:309
#18 0x000000010071df6c in qemu_devices_reset () at
/home/aik/p/qemu/hw/core/reset.c:69
#19 0x00000001004a3554 in spapr_machine_reset (machine=0x1016bec00) at
/home/aik/p/qemu/hw/ppc/spapr.c:1684
#20 0x0000000100688488 in qemu_system_reset (reason=SHUTDOWN_CAUSE_NONE)
at /home/aik/p/qemu/vl.c:1550
#21 0x0000000100692b3c in main (argc=0x2e, argv=0x7ffffffff568,
envp=0x7ffffffff6e0) at /home/aik/p/qemu/vl.c:4419


> 
> If this is confirmed to be wrong, I can fix this in an extra patch in
> this series. Thoughts welcome.
> 
> F.
> 
>>
>>>     trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
>>>                                           nv2reg->size);
>>> free_exit:
>>> @@ -2301,9 +2292,8 @@ int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
>>>         QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
>>>     }
>>>
>>> -    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
>>> -                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
>>> -                        (void *) (uintptr_t) captgt->tgt, NULL);
>>> +    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
>>> +                                   (void *)(uintptr_t)captgt->tgt, true, NULL);
>>
>> same
>>
>>>     trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, captgt->tgt,
>>>                                               atsdreg->size);
>>>
>>> diff --git a/memory.c b/memory.c
>>> index 06484c2bff..0a34ee3c86 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -1158,15 +1158,6 @@ void memory_region_init(MemoryRegion *mr,
>>>     memory_region_do_init(mr, owner, name, size);
>>> }
>>>
>>> -static void memory_region_get_addr(Object *obj, Visitor *v, const char *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    MemoryRegion *mr = MEMORY_REGION(obj);
>>> -    uint64_t value = mr->addr;
>>> -
>>> -    visit_type_uint64(v, name, &value, errp);
>>> -}
>>> -
>>> static void memory_region_get_container(Object *obj, Visitor *v,
>>>                                         const char *name, void *opaque,
>>>                                         Error **errp)
>>> @@ -1230,10 +1221,8 @@ static void memory_region_initfn(Object *obj)
>>>                              NULL, NULL, &error_abort);
>>>     op->resolve = memory_region_resolve_container;
>>>
>>> -    object_property_add(OBJECT(mr), "addr", "uint64",
>>> -                        memory_region_get_addr,
>>> -                        NULL, /* memory_region_set_addr */
>>> -                        NULL, NULL, &error_abort);
>>> +    object_property_add_uint64_ptr(OBJECT(mr), "addr",
>>> +                                   &mr->addr, true, &error_abort);
>>>     object_property_add(OBJECT(mr), "priority", "uint32",
>>>                         memory_region_get_priority,
>>>                         NULL, /* memory_region_set_priority */
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index 7a4ac9339b..aa7278e540 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -1039,22 +1039,6 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
>>>     cpu->has_pmu = value;
>>> }
>>>
>>> -static void arm_get_init_svtor(Object *obj, Visitor *v, const char *name,
>>> -                               void *opaque, Error **errp)
>>> -{
>>> -    ARMCPU *cpu = ARM_CPU(obj);
>>> -
>>> -    visit_type_uint32(v, name, &cpu->init_svtor, errp);
>>> -}
>>> -
>>> -static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
>>> -                               void *opaque, Error **errp)
>>> -{
>>> -    ARMCPU *cpu = ARM_CPU(obj);
>>> -
>>> -    visit_type_uint32(v, name, &cpu->init_svtor, errp);
>>> -}
>>> -
>>> void arm_cpu_post_init(Object *obj)
>>> {
>>>     ARMCPU *cpu = ARM_CPU(obj);
>>> @@ -1165,9 +1149,8 @@ void arm_cpu_post_init(Object *obj)
>>>          * a simple DEFINE_PROP_UINT32 for this because we want to permit
>>>          * the property to be set after realize.
>>>          */
>>> -        object_property_add(obj, "init-svtor", "uint32",
>>> -                            arm_get_init_svtor, arm_set_init_svtor,
>>> -                            NULL, NULL, &error_abort);
>>> +        object_property_add_uint32_ptr(obj, "init-svtor",
>>> +                                       &cpu->init_svtor, false, &error_abort);
>>>     }
>>>
>>>     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
>>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>>> index 024bb24e51..23d7ab8b72 100644
>>> --- a/target/i386/sev.c
>>> +++ b/target/i386/sev.c
>>> @@ -266,94 +266,6 @@ qsev_guest_class_init(ObjectClass *oc, void *data)
>>>             "guest owners session parameters (encoded with base64)", NULL);
>>> }
>>>
>>> -static void
>>> -qsev_guest_set_handle(Object *obj, Visitor *v, const char *name,
>>> -                      void *opaque, Error **errp)
>>> -{
>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>> -    uint32_t value;
>>> -
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -    sev->handle = value;
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_set_policy(Object *obj, Visitor *v, const char *name,
>>> -                      void *opaque, Error **errp)
>>> -{
>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>> -    uint32_t value;
>>> -
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -    sev->policy = value;
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_set_cbitpos(Object *obj, Visitor *v, const char *name,
>>> -                       void *opaque, Error **errp)
>>> -{
>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>> -    uint32_t value;
>>> -
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -    sev->cbitpos = value;
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_set_reduced_phys_bits(Object *obj, Visitor *v, const char *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>> -    uint32_t value;
>>> -
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -    sev->reduced_phys_bits = value;
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_get_policy(Object *obj, Visitor *v, const char *name,
>>> -                      void *opaque, Error **errp)
>>> -{
>>> -    uint32_t value;
>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>> -
>>> -    value = sev->policy;
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_get_handle(Object *obj, Visitor *v, const char *name,
>>> -                      void *opaque, Error **errp)
>>> -{
>>> -    uint32_t value;
>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>> -
>>> -    value = sev->handle;
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_get_cbitpos(Object *obj, Visitor *v, const char *name,
>>> -                       void *opaque, Error **errp)
>>> -{
>>> -    uint32_t value;
>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>> -
>>> -    value = sev->cbitpos;
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -}
>>> -
>>> -static void
>>> -qsev_guest_get_reduced_phys_bits(Object *obj, Visitor *v, const char *name,
>>> -                                   void *opaque, Error **errp)
>>> -{
>>> -    uint32_t value;
>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>> -
>>> -    value = sev->reduced_phys_bits;
>>> -    visit_type_uint32(v, name, &value, errp);
>>> -}
>>> -
>>> static void
>>> qsev_guest_init(Object *obj)
>>> {
>>> @@ -361,15 +273,11 @@ qsev_guest_init(Object *obj)
>>>
>>>     sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
>>>     sev->policy = DEFAULT_GUEST_POLICY;
>>> -    object_property_add(obj, "policy", "uint32", qsev_guest_get_policy,
>>> -                        qsev_guest_set_policy, NULL, NULL, NULL);
>>> -    object_property_add(obj, "handle", "uint32", qsev_guest_get_handle,
>>> -                        qsev_guest_set_handle, NULL, NULL, NULL);
>>> -    object_property_add(obj, "cbitpos", "uint32", qsev_guest_get_cbitpos,
>>> -                        qsev_guest_set_cbitpos, NULL, NULL, NULL);
>>> -    object_property_add(obj, "reduced-phys-bits", "uint32",
>>> -                        qsev_guest_get_reduced_phys_bits,
>>> -                        qsev_guest_set_reduced_phys_bits, NULL, NULL, NULL);
>>> +    object_property_add_uint32_ptr(obj, "policy", &sev->policy, false, NULL);
>>> +    object_property_add_uint32_ptr(obj, "handle", &sev->handle, false, NULL);
>>> +    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos, false, NULL);
>>> +    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
>>> +                                   &sev->reduced_phys_bits, false, NULL);
>>> }
>>>
>>> /* sev guest info */
>>> --
>>> 2.20.1
>>>
>>
>>
>> -- 
>> Marc-André Lureau
> 

-- 
Alexey

