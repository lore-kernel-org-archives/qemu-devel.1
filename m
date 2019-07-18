Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B245FC7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 01:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797A321783
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 01:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="2I4taRY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797A321783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnuts-0008Db-Qs
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 21:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52341)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hnuth-0007iZ-7c
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 21:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hnutf-00056z-EH
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 21:07:49 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hnute-000558-UV
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 21:07:47 -0400
Received: by mail-pg1-x541.google.com with SMTP id f25so12005267pgv.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MTrgzv9dmFruoQ6tGhnDXylBe/GUu6g6dfXNVhUZ4U4=;
 b=2I4taRY73X9wyBGa9g4unlBhloBaml5oZ8UtkMuHlww4kn968a6J2iCp63LS/Y0lR8
 jqGaDciRZJdra/0gTIUau8/DKECEXbq54vn7FuFicJEzqoFBWwS4HeGdVVqR0LfoR5zw
 ktKzwWVpub3OxbSZkVKu6RPp07BwT1Q6a4pZTtHBm6XZMPqKZjX4eecIVLPEftu5NE58
 oGSuDOsSwzjAz3478c/ofhDlt0Z3Zvvz6hoJaf4Poyt8b3VSyufbQFDFgC2ZsGvKiDCr
 uLHlw6q/NcM/PPcanoutOhDG4h6K9pnz84iylFmYi++A7tR2fKll8l5kJin5aaDC8UnL
 Isaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MTrgzv9dmFruoQ6tGhnDXylBe/GUu6g6dfXNVhUZ4U4=;
 b=fvNg2yA10BGist+Fk6shZ3AHuutrUEp3swIbQibv8gk7kRseO+daXDHFFLZn+M9N07
 y641MyBK4dFyqZPjEhWvPGVcAgcGXAi5Pkhx2FVwcNus5eF6JYW2AZe2vj4QL0Ig95px
 PfBfFz4NO8i76GiYJrJBl+fcZsBU/BeUcwmeUuSdZEnFY+FretfHXZHQH/R/OaCMJcmM
 R7PAr48748C00XpE8AlCBGLgFw5lyWq6oajzy/BiTfC+HlVxpRZw9YyW7GtEmYsb2Abx
 97xxaBKB3muuU+x4zyz1yT+zutV33TNDJRN9xiS5g1Lld61N6a+kMGqaAkSvnGjqW8UR
 c4qw==
X-Gm-Message-State: APjAAAWNHpsCAHKO6UMLk6VuTTfVaF0bCU3A3MlYHKPirVuygK7Rbubz
 D1h+CHYdjSG3u7kS52UBQio=
X-Google-Smtp-Source: APXvYqxzKSIcQQKJFlF6mT1aHfkv2U7oUeXFBuSAZ649dd3aV/Um6LSaFMNT1ai9bmic+i1B+a8F+g==
X-Received: by 2002:a17:90a:bd8c:: with SMTP id
 z12mr48027986pjr.60.1563412065614; 
 Wed, 17 Jul 2019 18:07:45 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id f27sm6848162pgm.60.2019.07.17.18.07.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 18:07:44 -0700 (PDT)
To: Greg Kurz <groug@kaod.org>
References: <20190717070637.101776-1-aik@ozlabs.ru>
 <20190717122141.53d6bd53@bahia.lab.toulouse-stg.fr.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <585be5a2-b645-88df-e268-05e44890a351@ozlabs.ru>
Date: Thu, 18 Jul 2019 11:07:41 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717122141.53d6bd53@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu v2] spapr_pci: Advertise
 BAR reallocation capability
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 17/07/2019 20:21, Greg Kurz wrote:
> On Wed, 17 Jul 2019 17:06:36 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> The pseries guests do not normally allocate PCI resources and rely on
>> the system firmware doing so. Furthermore at least at some point in
>> the past the pseries guests won't even allowed to change BARs, probably
>> it is still the case for phyp. So since the initial commit we have [1]
>> which prevents resource reallocation.
>>
>> This is not a problem until we want specific BAR alignments, for example,
>> PAGE_SIZE==64k to make sure we can still map MMIO BARs directly. For
>> the boot time devices we handle this in SLOF [2] but since QEMU's RTAS
>> does not allocate BARs, the guest does this instead and does not align
>> BARs even if Linux is given pci=resource_alignment=16@pci:0:0 as
>> PCI_PROBE_ONLY makes Linux ignore alignment requests.
>>
>> ARM folks added a dial to control PCI_PROBE_ONLY via the device tree [3].
>> This makes use of the dial to advertise to the guest that we can handle
>> BAR reassignments. This limits the change to the latest pseries machine
>> to avoid old guests explosion.
>>
>> We do not remove the flag from [1] as pseries guests are still supported
>> under phyp so having that removed may cause problems.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/platforms/pseries/setup.c?h=v5.1#n773
>> [2] https://git.qemu.org/?p=SLOF.git;a=blob;f=board-qemu/slof/pci-phb.fs;h=06729bcf77a0d4e900c527adcd9befe2a269f65d;hb=HEAD#l338
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f81c11af
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v2:
>> * limited the change by a machine version
>>
>> ---
>>   include/hw/ppc/spapr.h |  1 +
>>   hw/ppc/spapr.c         | 11 +++++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 60553d32c4fa..11c8185b94a1 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -120,6 +120,7 @@ struct SpaprMachineClass {
>>       bool legacy_irq_allocation;
>>       bool broken_host_serial_model; /* present real host info to the guest */
>>       bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
>> +    bool linux_pci_probe;
>>   
>>       void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>>                             uint64_t *buid, hwaddr *pio,
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 8783b433960c..734d759d65b3 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1162,6 +1162,7 @@ static void spapr_dt_ov5_platform_support(SpaprMachineState *spapr, void *fdt,
>>   static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>>   {
>>       MachineState *machine = MACHINE(spapr);
>> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
>>       int chosen;
>>       const char *boot_device = machine->boot_order;
>>       char *stdout_path = spapr_vio_stdout_path(spapr->vio_bus);
>> @@ -1219,6 +1220,11 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>>           _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_path));
>>       }
>>   
>> +    /* We can deal with BAR reallocation just fine, advertise it to the guest */
>> +    if (smc->linux_pci_probe) {
>> +        _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
>> +    }
>> +
>>       spapr_dt_ov5_platform_support(spapr, fdt, chosen);
>>   
>>       g_free(stdout_path);
>> @@ -4432,6 +4438,9 @@ static const TypeInfo spapr_machine_info = {
>>   static void spapr_machine_4_2_class_options(MachineClass *mc)
>>   {
>>       /* Defaults for the latest behaviour inherited from the base class */
>> +    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>> +
>> +    smc->linux_pci_probe = true;
> 
> As written in the comment, defaults for the latest behavior belong to the
> base class, ie. this should go to spapr_machine_class_init().

ah that's what it meant :)

I'll repost tomorrow if this is the only objection (not sure if I want 
to make a machine option, for example). Thanks,



>>   }
>>   
>>   DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
>> @@ -4441,12 +4450,14 @@ DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
>>    */
>>   static void spapr_machine_4_1_class_options(MachineClass *mc)
>>   {
>> +    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>>       static GlobalProperty compat[] = {
>>           /* Only allow 4kiB and 64kiB IOMMU pagesizes */
>>           { TYPE_SPAPR_PCI_HOST_BRIDGE, "pgsz", "0x11000" },
>>       };
>>   
>>       spapr_machine_4_2_class_options(mc);
>> +    smc->linux_pci_probe = false;
>>       compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>>   }
>>   
> 

-- 
Alexey

