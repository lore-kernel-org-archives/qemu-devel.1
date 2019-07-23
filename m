Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769BCC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9B42229A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="nq6CRZss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9B42229A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpna9-0006jw-4F
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44730)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hpnZx-0006Fh-B3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hpnZv-00053L-SY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:43:13 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hpnZv-00052q-KV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:43:11 -0400
Received: by mail-pf1-x441.google.com with SMTP id t16so18511806pfe.11
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 22:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nmXtiYnszE98NnOfSJAzQgZFKP+s5tlhO5wLAt0Xk7s=;
 b=nq6CRZssHs+pzSmxzU3z2XTnjKUlRIn146YCxXL96Z1bNJJa0CyZprw2ZW6Df0BfRM
 oG1/4BLPHgZx5tBOR3753q2iB7sg1dNKSKlLNDKRYE8seIepA8XkxHKlehZuZ7TECYV3
 VIM8KT1QbclDXiRsmJ4SPMP4gWh5BXFtNKXWlL2x0GNYk4zTGmVA/g3VVGfIfJmfL96k
 J56RxznWyJVWiyn9zfzkz96UIdPHSATAJhl6vj2wZpo5nhQOIunH1KoXisGpl0nRuxMH
 PoqnTD5ZVFXSLPiVD0Z1vJjr132BsveJXY8/zwH4toT8iFk+Zfc5bVUThXxMYRQXPzH6
 BVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nmXtiYnszE98NnOfSJAzQgZFKP+s5tlhO5wLAt0Xk7s=;
 b=sjmqbDUaMBHWidYFyDGRvo8v034vKuwNQfvB75VgWfZABIA96KygOrZ2kwexg7njny
 +8xuabQmb6DJUzQgRh/HMXomB/k14SP7Arfix5XX5R+DJIwapQgv/QwpEz1opzutobhm
 +2P6lh/jnkdrXzBu6FUsLppUDVyknG1vDndh5hD+oi06f91vlkNYsfIEltKjgpP5Cg85
 kHcHUkXbMUxtQ+1+Zs/kbjeMQXbIw802ErVj6diw1epzNIMQnKfcAV6O4LiEQRYUf16w
 PWRvS+Oivn/35HUn9kggQs8VjrgQ0g09qKffHthuxyrgQkzAVdZDyZT3hOhQnohMTR3W
 7VIw==
X-Gm-Message-State: APjAAAV25yjaAnNbVU4eckcDll6yE5o6ix3pBSXPE7OSIAbXVnQ2XdIy
 44SvGPV+xXe65n6FZQlimpM=
X-Google-Smtp-Source: APXvYqxAXzXi8hQnyP3KRCi7j1IT1EF5QnjD1z0w4oeNwNrfNkz22r9q1ZGiNyyBGJBqmbvvtPjxDw==
X-Received: by 2002:a17:90a:3724:: with SMTP id
 u33mr79755984pjb.19.1563860590417; 
 Mon, 22 Jul 2019 22:43:10 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id m11sm30598056pgl.8.2019.07.22.22.43.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 22:43:09 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190720012850.14369-1-aik@ozlabs.ru>
 <20190720012850.14369-3-aik@ozlabs.ru>
 <20190723035229.GP25073@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b79afd60-ec62-86ec-ecc3-bd96387b2b80@ozlabs.ru>
Date: Tue, 23 Jul 2019 15:43:05 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723035229.GP25073@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH qemu RFC 2/4] spapr: Allow bios-less
 configuration
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
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Anton Blanchard <anton@samba.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 23/07/2019 13:52, David Gibson wrote:
> On Sat, Jul 20, 2019 at 11:28:48AM +1000, Alexey Kardashevskiy wrote:
>> The pseries kernel can do either usual prom-init boot or kexec style boot.
>> We always did the prom-init which relies on the completeness of
>> the device tree (for example, PCI BARs have to be assigned beforehand) and
>> the client interface; the system firmware (SLOF) implements this.
>>
>> However we can use the kexec style boot as well. To do that, we can skip
>> loading SLOF and jump straight to the kernel. GPR5==0 (the client
>> interface entry point, SLOF passes a valid pointer there) tells Linux to
>> do the kexec boot rather than prom_init so it can proceed to the initramfs.
>> With few PCI fixes in the guest kernel, it can boot from PCI (via
>> petitboot, for example).
>>
>> This adds a "bios" machine option which controls whether QEMU loads SLOF
>> or jumps directly to the kernel. When bios==off, this does not copy SLOF
>> and RTAS into the guest RAM and sets RTAS properties to 0 to bypass
>> the kexec user space tool which checks for their presence (not for
>> the values though).
> 
> BIOS is sometimes used to refer to any machine's firmware, but it's
> also used to refer specifically to PC style BIOS.  I think it would be
> clearer to be explicit here and call the options "slof" rather than
> "bios".


This is a machine option of the "pseries" machine so it did not sound 
like PC bios to me, and slof itself lives in pc-bios so it seemed 
aligned name for a property like this.



> 
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   include/hw/ppc/spapr.h |  1 +
>>   hw/ppc/spapr.c         | 58 ++++++++++++++++++++++++++++++++----------
>>   2 files changed, 45 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index ff82bb8554e1..7f5d7a70d27e 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -160,6 +160,7 @@ struct SpaprMachineState {
>>       long kernel_size;
>>       bool kernel_le;
>>       uint64_t kernel_addr;
>> +    bool bios_enabled;
>>       uint32_t initrd_base;
>>       long initrd_size;
>>       uint64_t rtc_offset; /* Now used only during incoming migration */
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 6d13d65d8996..81ad6a6f28de 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1116,6 +1116,10 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>>       _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
>>                        lrdr_capacity, sizeof(lrdr_capacity)));
>>   
>> +    /* These are to make kexec-lite happy */
>> +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-base", 0));
>> +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", 0));
> 
> What exactly is kexec-lite and what does it need here?

This is a leftover which did not help (I think, need to double check).

It is a small kexec used in openpower builds, maintained by Anton:
https://github.com/open-power/kexec-lite

This is a part of the petitboot initramdisk used on bare metal powernv 
machines and if the tool detects /rtas in the DT, it insists on these 2 
properties, otherwise it does not proceed to reboot("kexec"):
https://github.com/open-power/kexec-lite/blob/master/kexec_memory_map.c#L272

I ended up patching it (hi Anton, please review my "[PATCH kexec] 
memory_map: Allow RTAS-less setup") and rebuilding the initramdisk.


> 
>>       spapr_dt_rtas_tokens(fdt, rtas);
>>   }
>>   
>> @@ -1814,7 +1818,11 @@ static void spapr_machine_reset(MachineState *machine)
>>       spapr->fdt_blob = fdt;
>>   
>>       /* Set up the entry state */
>> -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
>> +    if (!spapr->bios_enabled) {
>> +        spapr_cpu_set_entry_state(first_ppc_cpu, spapr->kernel_addr, fdt_addr);
>> +    } else {
>> +        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
>> +    }
>>       first_ppc_cpu->env.gpr[5] = 0;
>>   
>>       spapr->cas_reboot = false;
>> @@ -3031,20 +3039,22 @@ static void spapr_machine_init(MachineState *machine)
>>           }
>>       }
>>   
>> -    if (bios_name == NULL) {
>> -        bios_name = FW_FILE_NAME;
>> +    if (spapr->bios_enabled) {
>> +        if (bios_name == NULL) {
>> +            bios_name = FW_FILE_NAME;
>> +        }
>> +        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>> +        if (!filename) {
>> +            error_report("Could not find LPAR firmware '%s'", bios_name);
>> +            exit(1);
>> +        }
>> +        fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE);
>> +        if (fw_size <= 0) {
>> +            error_report("Could not load LPAR firmware '%s'", filename);
>> +            exit(1);
>> +        }
>> +        g_free(filename);
>>       }
>> -    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>> -    if (!filename) {
>> -        error_report("Could not find LPAR firmware '%s'", bios_name);
>> -        exit(1);
>> -    }
>> -    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE);
>> -    if (fw_size <= 0) {
>> -        error_report("Could not load LPAR firmware '%s'", filename);
>> -        exit(1);
>> -    }
>> -    g_free(filename);
>>   
>>       /* FIXME: Should register things through the MachineState's qdev
>>        * interface, this is a legacy from the sPAPREnvironment structure
>> @@ -3266,6 +3276,20 @@ static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *name,
>>       visit_type_uint64(v, name, (uint64_t *)opaque, errp);
>>   }
>>   
>> +static bool spapr_get_bios_enabled(Object *obj, Error **errp)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>> +
>> +    return spapr->bios_enabled;
>> +}
>> +
>> +static void spapr_set_bios_enabled(Object *obj, bool value, Error **errp)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>> +
>> +    spapr->bios_enabled = value;
>> +}
>> +
>>   static char *spapr_get_ic_mode(Object *obj, Error **errp)
>>   {
>>       SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>> @@ -3379,6 +3403,12 @@ static void spapr_instance_init(Object *obj)
>>                                       " for -kernel is the default",
>>                                       NULL);
>>       spapr->kernel_addr = KERNEL_LOAD_ADDR;
>> +    object_property_add_bool(obj, "bios", spapr_get_bios_enabled,
>> +                            spapr_set_bios_enabled, NULL);
>> +    object_property_set_description(obj, "bios", "Conrols whether to load bios",
>> +                                    NULL);
>> +    spapr->bios_enabled = true;
>> +
>>       /* The machine class defines the default interrupt controller mode */
>>       spapr->irq = smc->irq;
>>       object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
> 

-- 
Alexey

