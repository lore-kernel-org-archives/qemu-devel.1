Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2664C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBE82239E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="tn0iYtzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBE82239E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnTI-0004z5-QG
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43354)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hpnT6-0004Uw-Vl
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hpnT5-0007vc-Pi
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:36:08 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hpnT5-0007ug-9p
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:36:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id i18so18814451pgl.11
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 22:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2a1OWjTB5XmL89mGY+UgQNB0q+WEcS0yROpOEFXe+sI=;
 b=tn0iYtzPlqAv0Z2OIqxLMYTiHjdam0j7Hg+7c2cFvqydyE1raxPs1zMYQWjUwEe6px
 pdYAOZdVTtA27i4+OKvLJuBFlxiEoyAF7hNnRnwPLmrZaFwfXHqWBMoA4xN+jJsTLfkS
 iVaCGaubPccPT3dLAEUr56wvMTG5viA6s/IDaqs8asQM+myRVMidiqFJ/oivhzVNX7/E
 pqUa3I0vOPZEeBnsGyxpzCT4CoViCODMnO9liVnhJvE2UrifvRYr96257hmaijY+A7mq
 Kw+RGZw5klMzyJ4m15iLbZLY7cp4/mHE2/8Q5P07IhLEuWmoC/r+EJ3rpGS314wz3sEh
 Nd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2a1OWjTB5XmL89mGY+UgQNB0q+WEcS0yROpOEFXe+sI=;
 b=nivioEm9BB4s6r+IizJPXZJ3Rt+sDNr7YGNTrA3epnnjADSFKC0mAZEcCCeluDnMMr
 rxrOMd8vUPFAX6p0YtfdvYgVLuQD1UVpVef2w4USlH8hK7TnEWebtBP88yUbY7VokPNs
 oHn8yjOSf7Ec9mbuq/2a7SwytGcfkZlt2wkgDzdwqzLw2nUy/F2JxMYrdHtNYsIC8snq
 j4Oidev+7cuiU+LPmMliRTPBcxnvUdMROvk5Y0z6IZmku5JLm5kr1I8mIWZhHoxpebnT
 Iv9fYw8DLRlcsVia0pwnm6cuHwrKRYy9ydu83RMZE5p7lSxcArqnAuB/CTH5k3BhXpQO
 jjGg==
X-Gm-Message-State: APjAAAU2SkkM6XbWjHNRsCnU/sNsXYR3q84Q3zYpfOkFY/syHkLD+Aw/
 RpgW9alykizJcHG2DJc5A1Q=
X-Google-Smtp-Source: APXvYqzxtMYauLSMes34j5YYgZSy//Dr/jh6ehJUwYwdrSjQkgGU0Xiwer/V8Re2X/d5rm5J4Wr9OQ==
X-Received: by 2002:a17:90a:25c8:: with SMTP id
 k66mr80928237pje.129.1563860165636; 
 Mon, 22 Jul 2019 22:36:05 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id i74sm69533913pje.16.2019.07.22.22.36.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 22:36:04 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190720012850.14369-1-aik@ozlabs.ru>
 <20190720012850.14369-2-aik@ozlabs.ru>
 <20190723034908.GO25073@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <c221f516-770e-6976-ee0b-c19c51af94f0@ozlabs.ru>
Date: Tue, 23 Jul 2019 15:36:00 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723034908.GO25073@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH qemu RFC 1/4] spapr: Allow changing kernel
 loading address
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
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 23/07/2019 13:49, David Gibson wrote:
> On Sat, Jul 20, 2019 at 11:28:47AM +1000, Alexey Kardashevskiy wrote:
>> Useful for the debugging purposes.
> 
> Am I correct in understanding this isn't actually necessary for the
> rest of the series to work, just useful for debugging?


Correct. When I just started and used stepping in gdb stub, it helped to 
have the kernel at specific location. And since there is another 
property added in this patchset - "bios" - I did not really want to 
rebase (I will have to anyway if we decide to proceed). Thanks,


> 
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   include/hw/ppc/spapr.h |  1 +
>>   hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++------
>>   2 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 74e427b588fc..ff82bb8554e1 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -159,6 +159,7 @@ struct SpaprMachineState {
>>       void *fdt_blob;
>>       long kernel_size;
>>       bool kernel_le;
>> +    uint64_t kernel_addr;
>>       uint32_t initrd_base;
>>       long initrd_size;
>>       uint64_t rtc_offset; /* Now used only during incoming migration */
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 7fad42350538..6d13d65d8996 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1179,7 +1179,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>>                             spapr->initrd_base + spapr->initrd_size));
>>   
>>       if (spapr->kernel_size) {
>> -        uint64_t kprop[2] = { cpu_to_be64(KERNEL_LOAD_ADDR),
>> +        uint64_t kprop[2] = { cpu_to_be64(spapr->kernel_addr),
>>                                 cpu_to_be64(spapr->kernel_size) };
>>   
>>           _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
>> @@ -1365,7 +1365,7 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
>>   
>>       /* Build memory reserve map */
>>       if (spapr->kernel_size) {
>> -        _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_size)));
>> +        _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr, spapr->kernel_size)));
>>       }
>>       if (spapr->initrd_size) {
>>           _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base, spapr->initrd_size)));
>> @@ -1391,7 +1391,8 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
>>   
>>   static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>>   {
>> -    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
>> +    SpaprMachineState *spapr = opaque;
>> +    return (addr & 0x0fffffff) + spapr->kernel_addr;
>>   }
>>   
>>   static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
>> @@ -2995,12 +2996,12 @@ static void spapr_machine_init(MachineState *machine)
>>           uint64_t lowaddr = 0;
>>   
>>           spapr->kernel_size = load_elf(kernel_filename, NULL,
>> -                                      translate_kernel_address, NULL,
>> +                                      translate_kernel_address, spapr,
>>                                         NULL, &lowaddr, NULL, 1,
>>                                         PPC_ELF_MACHINE, 0, 0);
>>           if (spapr->kernel_size == ELF_LOAD_WRONG_ENDIAN) {
>>               spapr->kernel_size = load_elf(kernel_filename, NULL,
>> -                                          translate_kernel_address, NULL, NULL,
>> +                                          translate_kernel_address, spapr, NULL,
>>                                             &lowaddr, NULL, 0, PPC_ELF_MACHINE,
>>                                             0, 0);
>>               spapr->kernel_le = spapr->kernel_size > 0;
>> @@ -3016,7 +3017,7 @@ static void spapr_machine_init(MachineState *machine)
>>               /* Try to locate the initrd in the gap between the kernel
>>                * and the firmware. Add a bit of space just in case
>>                */
>> -            spapr->initrd_base = (KERNEL_LOAD_ADDR + spapr->kernel_size
>> +            spapr->initrd_base = (spapr->kernel_addr + spapr->kernel_size
>>                                     + 0x1ffff) & ~0xffff;
>>               spapr->initrd_size = load_image_targphys(initrd_filename,
>>                                                        spapr->initrd_base,
>> @@ -3253,6 +3254,18 @@ static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
>>       visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>>   }
>>   
>> +static void spapr_get_kernel_addr(Object *obj, Visitor *v, const char *name,
>> +                                  void *opaque, Error **errp)
>> +{
>> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
>> +}
>> +
>> +static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *name,
>> +                                  void *opaque, Error **errp)
>> +{
>> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
>> +}
>> +
>>   static char *spapr_get_ic_mode(Object *obj, Error **errp)
>>   {
>>       SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>> @@ -3358,6 +3371,14 @@ static void spapr_instance_init(Object *obj)
>>       object_property_add_bool(obj, "vfio-no-msix-emulation",
>>                                spapr_get_msix_emulation, NULL, NULL);
>>   
>> +    object_property_add(obj, "kernel-addr", "uint64", spapr_get_kernel_addr,
>> +                        spapr_set_kernel_addr, NULL, &spapr->kernel_addr,
>> +                        &error_abort);
>> +    object_property_set_description(obj, "kernel-addr",
>> +                                    stringify(KERNEL_LOAD_ADDR)
>> +                                    " for -kernel is the default",
>> +                                    NULL);
>> +    spapr->kernel_addr = KERNEL_LOAD_ADDR;
>>       /* The machine class defines the default interrupt controller mode */
>>       spapr->irq = smc->irq;
>>       object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
> 

-- 
Alexey

