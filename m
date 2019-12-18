Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8049FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DE8206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="tjhjJN38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DE8206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihN4z-0004eA-Bs
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 19:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ihN3w-00047d-7v
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ihN3s-0003v2-Gn
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:19:35 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ihN3r-0003sC-Tp
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:19:32 -0500
Received: by mail-pl1-x643.google.com with SMTP id p9so133418plk.9
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 16:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sPS8LzkYfTjqspUKt2p69o5zoIGq6Qzcn3H83eg9CvQ=;
 b=tjhjJN389YIWYTRbSNbU7PEvRQHXqFtabJvCLfqzWqP71nbFFjs/ir1sXEKdVNnubY
 s3xpegOPorImrCvhi+41hLtWybiTGoX1mBkBgzI85UT/NHtlReTHY2iFTuoG2sfN2kM1
 kP+xQruteJKSnVMoAvoAiNG6L5U1a8i4GaqBo7G7GEf5UAku19xS+CmlGUEijDlDYyaw
 zOZMyW6My6gO7tEI4HTGu1JMDTj9VFD/ZSxjCTiP3l/dybJxW15bD8dnvQdw1cdKpW2x
 9y+m9LfgjfIRj6fSNHwwUZc8Rb/KDljLFsG8GC5+o19mW7t/PfPA4WYKeDLE+5kIGkch
 9yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=sPS8LzkYfTjqspUKt2p69o5zoIGq6Qzcn3H83eg9CvQ=;
 b=tGQLRYB57AIFrcvRSpiFLG2A8ZsXAS6hkloLqCnwD/2u2QZ6myx8H3wN6XHk9iKJpv
 dsisLkxvUZtbst+YocSgOT0H3wGQIPrrrLoNN8ZqZnyk39iDET/EfEjnhUw1NEYIw7Rm
 9lUlDdf3s4Akkuxa3vG0236naQoUlx75ZXvHsnOijHieJZp66MMgNFbc0VEbzsxC4KbK
 o1E7ADhWWRH8xMDBgDiDeLtHJ05IwY0RHQKgMMdBkwRZZW9v8FnjwhGjua8NNg+dcj7G
 q0X+U835hAwimRH2h1aqhEBFLVfxVdwGZbdyKNxaMIiTfYcZd/a9+AoflH86SUY8ng7h
 EAaQ==
X-Gm-Message-State: APjAAAXEk1hj0zZE0kdGKHfmVWW/9a7NRbaRQcvNyk7daNx0BvLu9184
 m6w5jHgfmlUyYAA9rLqgo87c3TKKHUg=
X-Google-Smtp-Source: APXvYqyAeduUxu28yagoE03luZfbZ5rUQiv6onxHlIpMqs6So9V4P8LQ5N72uJ9Sv/UEN8JQvAT2NA==
X-Received: by 2002:a17:90a:508:: with SMTP id h8mr22557pjh.91.1576628368703; 
 Tue, 17 Dec 2019 16:19:28 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id c19sm201550pfc.144.2019.12.17.16.19.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 16:19:27 -0800 (PST)
Subject: Re: [PATCH v3 4/4] qom/object: Use common get/set uint helpers
To: Felipe Franciosi <felipe@nutanix.com>
References: <20191129174630.6922-1-felipe@nutanix.com>
 <20191129174630.6922-5-felipe@nutanix.com>
 <ef90cc03-7e72-2238-72c5-b531032208e2@ozlabs.ru>
 <894244E2-85E3-4779-A6A2-EC5192D504B7@nutanix.com>
 <5C28BA81-9EF0-4AA1-A04E-8F7B58E856FB@nutanix.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <69a0b0e6-5517-3242-6730-66e3659dd552@ozlabs.ru>
Date: Wed, 18 Dec 2019 11:19:23 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <5C28BA81-9EF0-4AA1-A04E-8F7B58E856FB@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 18/12/2019 09:19, Felipe Franciosi wrote:
> Hi Alexey,
> 
> I don't know how, but somehow I didn't receive your reply:
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg02127.html
> 
> (I was about to follow up, then I decided to look at the archives to
> make sure your response didn't get lost in my client somehow...)
> 
> Still not sure of what happened, lol, let's move on. :)

dunno, I spent time configuring "spf" on ozlabs.ru and gmail to make my
mails go through all possible checks :)


> 
> I'm top-posting as I couldn't pull your response in for a proper reply.
> 
> You said:
>> The franciozzy/autosetters branch with this on top -
>> https://github.com/aik/qemu/commit/94c33bb7debf
>> - works fine. Thanks,
> 
> Your patch basically reverts a part of my commit and then makes the
> change Marc-Andre recommended (by dropping the (void *) cast).
> 
> Is it ok for me to just drop that part of my patch and send the v4?

Yes. Thanks,


> You can follow-up on the cast change afterwards.
>
> Thanks,
> F.
> 
> 
>> On Dec 10, 2019, at 1:04 PM, Felipe Franciosi <felipe@nutanix.com> wrote:
>>
>> Hi
>>
>>> On Dec 2, 2019, at 6:31 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>
>>>
>>>
>>> On 30/11/2019 04:46, Felipe Franciosi wrote:
>>>> Several objects implemented their own uint property getters and setters,
>>>> despite them being straightforward (without any checks/validations on
>>>> the values themselves) and identical across objects. This makes use of
>>>> an enhanced API for object_property_add_uintXX_ptr() which offers
>>>> default setters.
>>>>
>>>> Some of these setters used to update the value even if the type visit
>>>> failed (eg. because the value being set overflowed over the given type).
>>>> The new setter introduces a check for these errors, not updating the
>>>> value if an error occurred. The error is propagated.
>>>>
>>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>>> ---
>>>> hw/acpi/ich9.c       |  95 ++++----------------------------------
>>>> hw/isa/lpc_ich9.c    |  12 +----
>>>> hw/misc/edu.c        |  13 ++----
>>>> hw/pci-host/q35.c    |  14 ++----
>>>> hw/ppc/spapr.c       |  18 ++------
>>>> hw/vfio/pci-quirks.c |  20 +++-----
>>>> memory.c             |  15 +-----
>>>> target/arm/cpu.c     |  22 ++-------
>>>> target/i386/sev.c    | 106 ++++---------------------------------------
>>>> 9 files changed, 40 insertions(+), 275 deletions(-)
>>>>
>>>> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
>>>> index 742fb78226..d9305be891 100644
>>>> --- a/hw/acpi/ich9.c
>>>> +++ b/hw/acpi/ich9.c
>>>> @@ -357,81 +357,6 @@ static void ich9_pm_set_cpu_hotplug_legacy(Object *obj, bool value,
>>>>    s->pm.cpu_hotplug_legacy = value;
>>>> }
>>>>
>>>> -static void ich9_pm_get_disable_s3(Object *obj, Visitor *v, const char *name,
>>>> -                                   void *opaque, Error **errp)
>>>> -{
>>>> -    ICH9LPCPMRegs *pm = opaque;
>>>> -    uint8_t value = pm->disable_s3;
>>>> -
>>>> -    visit_type_uint8(v, name, &value, errp);
>>>> -}
>>>> -
>>>> -static void ich9_pm_set_disable_s3(Object *obj, Visitor *v, const char *name,
>>>> -                                   void *opaque, Error **errp)
>>>> -{
>>>> -    ICH9LPCPMRegs *pm = opaque;
>>>> -    Error *local_err = NULL;
>>>> -    uint8_t value;
>>>> -
>>>> -    visit_type_uint8(v, name, &value, &local_err);
>>>> -    if (local_err) {
>>>> -        goto out;
>>>> -    }
>>>> -    pm->disable_s3 = value;
>>>> -out:
>>>> -    error_propagate(errp, local_err);
>>>> -}
>>>> -
>>>> -static void ich9_pm_get_disable_s4(Object *obj, Visitor *v, const char *name,
>>>> -                                   void *opaque, Error **errp)
>>>> -{
>>>> -    ICH9LPCPMRegs *pm = opaque;
>>>> -    uint8_t value = pm->disable_s4;
>>>> -
>>>> -    visit_type_uint8(v, name, &value, errp);
>>>> -}
>>>> -
>>>> -static void ich9_pm_set_disable_s4(Object *obj, Visitor *v, const char *name,
>>>> -                                   void *opaque, Error **errp)
>>>> -{
>>>> -    ICH9LPCPMRegs *pm = opaque;
>>>> -    Error *local_err = NULL;
>>>> -    uint8_t value;
>>>> -
>>>> -    visit_type_uint8(v, name, &value, &local_err);
>>>> -    if (local_err) {
>>>> -        goto out;
>>>> -    }
>>>> -    pm->disable_s4 = value;
>>>> -out:
>>>> -    error_propagate(errp, local_err);
>>>> -}
>>>> -
>>>> -static void ich9_pm_get_s4_val(Object *obj, Visitor *v, const char *name,
>>>> -                               void *opaque, Error **errp)
>>>> -{
>>>> -    ICH9LPCPMRegs *pm = opaque;
>>>> -    uint8_t value = pm->s4_val;
>>>> -
>>>> -    visit_type_uint8(v, name, &value, errp);
>>>> -}
>>>> -
>>>> -static void ich9_pm_set_s4_val(Object *obj, Visitor *v, const char *name,
>>>> -                               void *opaque, Error **errp)
>>>> -{
>>>> -    ICH9LPCPMRegs *pm = opaque;
>>>> -    Error *local_err = NULL;
>>>> -    uint8_t value;
>>>> -
>>>> -    visit_type_uint8(v, name, &value, &local_err);
>>>> -    if (local_err) {
>>>> -        goto out;
>>>> -    }
>>>> -    pm->s4_val = value;
>>>> -out:
>>>> -    error_propagate(errp, local_err);
>>>> -}
>>>> -
>>>> static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
>>>> {
>>>>    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
>>>> @@ -468,18 +393,14 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
>>>>                             ich9_pm_get_cpu_hotplug_legacy,
>>>>                             ich9_pm_set_cpu_hotplug_legacy,
>>>>                             NULL);
>>>> -    object_property_add(obj, ACPI_PM_PROP_S3_DISABLED, "uint8",
>>>> -                        ich9_pm_get_disable_s3,
>>>> -                        ich9_pm_set_disable_s3,
>>>> -                        NULL, pm, NULL);
>>>> -    object_property_add(obj, ACPI_PM_PROP_S4_DISABLED, "uint8",
>>>> -                        ich9_pm_get_disable_s4,
>>>> -                        ich9_pm_set_disable_s4,
>>>> -                        NULL, pm, NULL);
>>>> -    object_property_add(obj, ACPI_PM_PROP_S4_VAL, "uint8",
>>>> -                        ich9_pm_get_s4_val,
>>>> -                        ich9_pm_set_s4_val,
>>>> -                        NULL, pm, NULL);
>>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
>>>> +                                  &pm->disable_s3, OBJ_PROP_FLAG_READWRITE,
>>>> +                                  NULL);
>>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
>>>> +                                  &pm->disable_s4, OBJ_PROP_FLAG_READWRITE,
>>>> +                                  NULL);
>>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
>>>> +                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE, NULL);
>>>>    object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
>>>>                             ich9_pm_get_enable_tco,
>>>>                             ich9_pm_set_enable_tco,
>>>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>>>> index c40bb3c420..b99a613954 100644
>>>> --- a/hw/isa/lpc_ich9.c
>>>> +++ b/hw/isa/lpc_ich9.c
>>>> @@ -627,13 +627,6 @@ static const MemoryRegionOps ich9_rst_cnt_ops = {
>>>>    .endianness = DEVICE_LITTLE_ENDIAN
>>>> };
>>>>
>>>> -static void ich9_lpc_get_sci_int(Object *obj, Visitor *v, const char *name,
>>>> -                                 void *opaque, Error **errp)
>>>> -{
>>>> -    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
>>>> -    visit_type_uint8(v, name, &lpc->sci_gsi, errp);
>>>> -}
>>>> -
>>>> static void ich9_lpc_initfn(Object *obj)
>>>> {
>>>>    ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
>>>> @@ -641,9 +634,8 @@ static void ich9_lpc_initfn(Object *obj)
>>>>    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
>>>>    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
>>>>
>>>> -    object_property_add(obj, ACPI_PM_PROP_SCI_INT, "uint8",
>>>> -                        ich9_lpc_get_sci_int,
>>>> -                        NULL, NULL, NULL, NULL);
>>>> +    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
>>>> +                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ, NULL);
>>>>    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
>>>>                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ, NULL);
>>>>    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
>>>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>>>> index d5e2bdbb57..ff10f5b794 100644
>>>> --- a/hw/misc/edu.c
>>>> +++ b/hw/misc/edu.c
>>>> @@ -396,21 +396,14 @@ static void pci_edu_uninit(PCIDevice *pdev)
>>>>    msi_uninit(pdev);
>>>> }
>>>>
>>>> -static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
>>>> -                           void *opaque, Error **errp)
>>>> -{
>>>> -    uint64_t *val = opaque;
>>>> -
>>>> -    visit_type_uint64(v, name, val, errp);
>>>> -}
>>>> -
>>>> static void edu_instance_init(Object *obj)
>>>> {
>>>>    EduState *edu = EDU(obj);
>>>>
>>>>    edu->dma_mask = (1UL << 28) - 1;
>>>> -    object_property_add(obj, "dma_mask", "uint64", edu_obj_uint64,
>>>> -                    edu_obj_uint64, NULL, &edu->dma_mask, NULL);
>>>> +    object_property_add_uint64_ptr(obj, "dma_mask",
>>>> +                                   &edu->dma_mask, OBJ_PROP_FLAG_READWRITE,
>>>> +                                   NULL);
>>>> }
>>>>
>>>> static void edu_class_init(ObjectClass *class, void *data)
>>>> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>>>> index 158d270b9f..f384ab95c6 100644
>>>> --- a/hw/pci-host/q35.c
>>>> +++ b/hw/pci-host/q35.c
>>>> @@ -165,14 +165,6 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
>>>>    visit_type_uint64(v, name, &value, errp);
>>>> }
>>>>
>>>> -static void q35_host_get_mmcfg_size(Object *obj, Visitor *v, const char *name,
>>>> -                                    void *opaque, Error **errp)
>>>> -{
>>>> -    PCIExpressHost *e = PCIE_HOST_BRIDGE(obj);
>>>> -
>>>> -    visit_type_uint64(v, name, &e->size, errp);
>>>> -}
>>>> -
>>>> /*
>>>> * NOTE: setting defaults for the mch.* fields in this table
>>>> * doesn't work, because mch is a separate QOM object that is
>>>> @@ -213,6 +205,7 @@ static void q35_host_initfn(Object *obj)
>>>> {
>>>>    Q35PCIHost *s = Q35_HOST_DEVICE(obj);
>>>>    PCIHostState *phb = PCI_HOST_BRIDGE(obj);
>>>> +    PCIExpressHost *pehb = PCIE_HOST_BRIDGE(obj);
>>>>
>>>>    memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, phb,
>>>>                          "pci-conf-idx", 4);
>>>> @@ -242,9 +235,8 @@ static void q35_host_initfn(Object *obj)
>>>>                        q35_host_get_pci_hole64_end,
>>>>                        NULL, NULL, NULL, NULL);
>>>>
>>>> -    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
>>>> -                        q35_host_get_mmcfg_size,
>>>> -                        NULL, NULL, NULL, NULL);
>>>> +    object_property_add_uint64_ptr(obj, PCIE_HOST_MCFG_SIZE,
>>>> +                                   &pehb->size, OBJ_PROP_FLAG_READ, NULL);
>>>>
>>>>    object_property_add_link(obj, MCH_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGION,
>>>>                             (Object **) &s->mch.ram_memory,
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index e076f6023c..668f045023 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -3227,18 +3227,6 @@ static void spapr_set_resize_hpt(Object *obj, const char *value, Error **errp)
>>>>    }
>>>> }
>>>>
>>>> -static void spapr_get_vsmt(Object *obj, Visitor *v, const char *name,
>>>> -                                   void *opaque, Error **errp)
>>>> -{
>>>> -    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>>>> -}
>>>> -
>>>> -static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
>>>> -                                   void *opaque, Error **errp)
>>>> -{
>>>> -    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>>>> -}
>>>> -
>>>> static char *spapr_get_ic_mode(Object *obj, Error **errp)
>>>> {
>>>>    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>>>> @@ -3336,8 +3324,10 @@ static void spapr_instance_init(Object *obj)
>>>>    object_property_set_description(obj, "resize-hpt",
>>>>                                    "Resizing of the Hash Page Table (enabled, disabled, required)",
>>>>                                    NULL);
>>>> -    object_property_add(obj, "vsmt", "uint32", spapr_get_vsmt,
>>>> -                        spapr_set_vsmt, NULL, &spapr->vsmt, &error_abort);
>>>> +    object_property_add_uint32_ptr(obj, "vsmt",
>>>> +                                   &spapr->vsmt, OBJ_PROP_FLAG_READWRITE,
>>>> +                                   &error_abort);
>>>
>>>
>>> Ths looks alright but...
>>
>> Ok.
>>
>>>
>>>
>>>> +
>>>>    object_property_set_description(obj, "vsmt",
>>>>                                    "Virtual SMT: KVM behaves as if this were"
>>>>                                    " the host's SMT mode", &error_abort);
>>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>>>> index 136f3a9ad6..d769c99bde 100644
>>>> --- a/hw/vfio/pci-quirks.c
>>>> +++ b/hw/vfio/pci-quirks.c
>>>> @@ -2187,14 +2187,6 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
>>>>    return 0;
>>>> }
>>>>
>>>> -static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
>>>> -                                     const char *name,
>>>> -                                     void *opaque, Error **errp)
>>>> -{
>>>> -    uint64_t tgt = (uintptr_t) opaque;
>>>> -    visit_type_uint64(v, name, &tgt, errp);
>>>> -}
>>>> -
>>>> static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
>>>>                                                 const char *name,
>>>>                                                 void *opaque, Error **errp)
>>>> @@ -2240,9 +2232,9 @@ int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
>>>>                               nv2reg->size, p);
>>>>    QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
>>>>
>>>> -    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
>>>> -                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
>>>> -                        (void *) (uintptr_t) cap->tgt, NULL);
>>>> +    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
>>>> +                                   (void *)(uintptr_t)cap->tgt,
>>>
>>>
>>> ... this does not seem equalent. The getter will assume cap->tgt is an
>>> userspace address which it is not. &cap->tgt would be QOM-correct but
>>> won't work because of the lifetime of @cap but this is another story.
>>
>> Maybe I just don't understand where this value comes from. It sounds
>> like you know what you are talking about :) so I'll send a v4 and
>> leave this method untouched, unless you have a chance to test this and
>> tell me that it still works.
>>
>>>
>>> btw what is this patchset based on? I tried applying it on top of 3 week
>>> old and today upstream and it failed. Thanks,
>>
>> I'm not sure why there were problems. I just rebased my branch on top
>> of latest master (without issues). I pushed it to Github so you can
>> have a look. Let me know if you want to try it out or if I should just
>> send a v4 straight away dropping the changes immediately above.
>>
>> https://github.com/franciozzy/qemu
>>
>> Thanks!
>> F.
>>
>>>
>>>
>>>
>>>
>>>
>>>> +                                   OBJ_PROP_FLAG_READ, NULL);
>>>>    trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
>>>>                                          nv2reg->size);
>>>> free_exit:
>>>> @@ -2301,9 +2293,9 @@ int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
>>>>        QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
>>>>    }
>>>>
>>>> -    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
>>>> -                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
>>>> -                        (void *) (uintptr_t) captgt->tgt, NULL);
>>>> +    object_property_add_uint64_ptr(OBJECT(vdev), "nvlink2-tgt",
>>>> +                                   (void *)(uintptr_t)captgt->tgt,
>>>> +                                   OBJ_PROP_FLAG_READ, NULL);
>>>>    trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, captgt->tgt,
>>>>                                              atsdreg->size);
>>>>
>>>> diff --git a/memory.c b/memory.c
>>>> index 06484c2bff..7dac2aa059 100644
>>>> --- a/memory.c
>>>> +++ b/memory.c
>>>> @@ -1158,15 +1158,6 @@ void memory_region_init(MemoryRegion *mr,
>>>>    memory_region_do_init(mr, owner, name, size);
>>>> }
>>>>
>>>> -static void memory_region_get_addr(Object *obj, Visitor *v, const char *name,
>>>> -                                   void *opaque, Error **errp)
>>>> -{
>>>> -    MemoryRegion *mr = MEMORY_REGION(obj);
>>>> -    uint64_t value = mr->addr;
>>>> -
>>>> -    visit_type_uint64(v, name, &value, errp);
>>>> -}
>>>> -
>>>> static void memory_region_get_container(Object *obj, Visitor *v,
>>>>                                        const char *name, void *opaque,
>>>>                                        Error **errp)
>>>> @@ -1230,10 +1221,8 @@ static void memory_region_initfn(Object *obj)
>>>>                             NULL, NULL, &error_abort);
>>>>    op->resolve = memory_region_resolve_container;
>>>>
>>>> -    object_property_add(OBJECT(mr), "addr", "uint64",
>>>> -                        memory_region_get_addr,
>>>> -                        NULL, /* memory_region_set_addr */
>>>> -                        NULL, NULL, &error_abort);
>>>> +    object_property_add_uint64_ptr(OBJECT(mr), "addr",
>>>> +                                   &mr->addr, OBJ_PROP_FLAG_READ, &error_abort);
>>>>    object_property_add(OBJECT(mr), "priority", "uint32",
>>>>                        memory_region_get_priority,
>>>>                        NULL, /* memory_region_set_priority */
>>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>>> index 7a4ac9339b..bbe25a73c4 100644
>>>> --- a/target/arm/cpu.c
>>>> +++ b/target/arm/cpu.c
>>>> @@ -1039,22 +1039,6 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
>>>>    cpu->has_pmu = value;
>>>> }
>>>>
>>>> -static void arm_get_init_svtor(Object *obj, Visitor *v, const char *name,
>>>> -                               void *opaque, Error **errp)
>>>> -{
>>>> -    ARMCPU *cpu = ARM_CPU(obj);
>>>> -
>>>> -    visit_type_uint32(v, name, &cpu->init_svtor, errp);
>>>> -}
>>>> -
>>>> -static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
>>>> -                               void *opaque, Error **errp)
>>>> -{
>>>> -    ARMCPU *cpu = ARM_CPU(obj);
>>>> -
>>>> -    visit_type_uint32(v, name, &cpu->init_svtor, errp);
>>>> -}
>>>> -
>>>> void arm_cpu_post_init(Object *obj)
>>>> {
>>>>    ARMCPU *cpu = ARM_CPU(obj);
>>>> @@ -1165,9 +1149,9 @@ void arm_cpu_post_init(Object *obj)
>>>>         * a simple DEFINE_PROP_UINT32 for this because we want to permit
>>>>         * the property to be set after realize.
>>>>         */
>>>> -        object_property_add(obj, "init-svtor", "uint32",
>>>> -                            arm_get_init_svtor, arm_set_init_svtor,
>>>> -                            NULL, NULL, &error_abort);
>>>> +        object_property_add_uint32_ptr(obj, "init-svtor",
>>>> +                                       &cpu->init_svtor,
>>>> +                                       OBJ_PROP_FLAG_READWRITE, &error_abort);
>>>>    }
>>>>
>>>>    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
>>>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>>>> index 024bb24e51..846018a12d 100644
>>>> --- a/target/i386/sev.c
>>>> +++ b/target/i386/sev.c
>>>> @@ -266,94 +266,6 @@ qsev_guest_class_init(ObjectClass *oc, void *data)
>>>>            "guest owners session parameters (encoded with base64)", NULL);
>>>> }
>>>>
>>>> -static void
>>>> -qsev_guest_set_handle(Object *obj, Visitor *v, const char *name,
>>>> -                      void *opaque, Error **errp)
>>>> -{
>>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>>> -    uint32_t value;
>>>> -
>>>> -    visit_type_uint32(v, name, &value, errp);
>>>> -    sev->handle = value;
>>>> -}
>>>> -
>>>> -static void
>>>> -qsev_guest_set_policy(Object *obj, Visitor *v, const char *name,
>>>> -                      void *opaque, Error **errp)
>>>> -{
>>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>>> -    uint32_t value;
>>>> -
>>>> -    visit_type_uint32(v, name, &value, errp);
>>>> -    sev->policy = value;
>>>> -}
>>>> -
>>>> -static void
>>>> -qsev_guest_set_cbitpos(Object *obj, Visitor *v, const char *name,
>>>> -                       void *opaque, Error **errp)
>>>> -{
>>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>>> -    uint32_t value;
>>>> -
>>>> -    visit_type_uint32(v, name, &value, errp);
>>>> -    sev->cbitpos = value;
>>>> -}
>>>> -
>>>> -static void
>>>> -qsev_guest_set_reduced_phys_bits(Object *obj, Visitor *v, const char *name,
>>>> -                                   void *opaque, Error **errp)
>>>> -{
>>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>>> -    uint32_t value;
>>>> -
>>>> -    visit_type_uint32(v, name, &value, errp);
>>>> -    sev->reduced_phys_bits = value;
>>>> -}
>>>> -
>>>> -static void
>>>> -qsev_guest_get_policy(Object *obj, Visitor *v, const char *name,
>>>> -                      void *opaque, Error **errp)
>>>> -{
>>>> -    uint32_t value;
>>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>>> -
>>>> -    value = sev->policy;
>>>> -    visit_type_uint32(v, name, &value, errp);
>>>> -}
>>>> -
>>>> -static void
>>>> -qsev_guest_get_handle(Object *obj, Visitor *v, const char *name,
>>>> -                      void *opaque, Error **errp)
>>>> -{
>>>> -    uint32_t value;
>>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>>> -
>>>> -    value = sev->handle;
>>>> -    visit_type_uint32(v, name, &value, errp);
>>>> -}
>>>> -
>>>> -static void
>>>> -qsev_guest_get_cbitpos(Object *obj, Visitor *v, const char *name,
>>>> -                       void *opaque, Error **errp)
>>>> -{
>>>> -    uint32_t value;
>>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>>> -
>>>> -    value = sev->cbitpos;
>>>> -    visit_type_uint32(v, name, &value, errp);
>>>> -}
>>>> -
>>>> -static void
>>>> -qsev_guest_get_reduced_phys_bits(Object *obj, Visitor *v, const char *name,
>>>> -                                   void *opaque, Error **errp)
>>>> -{
>>>> -    uint32_t value;
>>>> -    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
>>>> -
>>>> -    value = sev->reduced_phys_bits;
>>>> -    visit_type_uint32(v, name, &value, errp);
>>>> -}
>>>> -
>>>> static void
>>>> qsev_guest_init(Object *obj)
>>>> {
>>>> @@ -361,15 +273,15 @@ qsev_guest_init(Object *obj)
>>>>
>>>>    sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
>>>>    sev->policy = DEFAULT_GUEST_POLICY;
>>>> -    object_property_add(obj, "policy", "uint32", qsev_guest_get_policy,
>>>> -                        qsev_guest_set_policy, NULL, NULL, NULL);
>>>> -    object_property_add(obj, "handle", "uint32", qsev_guest_get_handle,
>>>> -                        qsev_guest_set_handle, NULL, NULL, NULL);
>>>> -    object_property_add(obj, "cbitpos", "uint32", qsev_guest_get_cbitpos,
>>>> -                        qsev_guest_set_cbitpos, NULL, NULL, NULL);
>>>> -    object_property_add(obj, "reduced-phys-bits", "uint32",
>>>> -                        qsev_guest_get_reduced_phys_bits,
>>>> -                        qsev_guest_set_reduced_phys_bits, NULL, NULL, NULL);
>>>> +    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
>>>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>>>> +    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
>>>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>>>> +    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
>>>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>>>> +    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
>>>> +                                   &sev->reduced_phys_bits,
>>>> +                                   OBJ_PROP_FLAG_READWRITE, NULL);
>>>> }
>>>>
>>>> /* sev guest info */
>>>>
>>>
>>> -- 
>>> Alexey
>>
> 

-- 
Alexey

