Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D216C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 11:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794F5207C4
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 11:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0bflVei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794F5207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWeQz-0003Lm-CE
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 07:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWeOi-0002id-Vo
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 07:41:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWeOg-0001XY-9R
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 07:41:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id y12so9266319wrp.6
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 04:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iIE8It2FXNG0XWUL/CSj00U0tv985rXsk6j+tNxgJz4=;
 b=W0bflVeiZeyQAlDPDQb2CjK+zoeQNiWPm8dktKLyg485pG1subUor5S+06HNJmKE3T
 Zxp7bQABGU7ZgJ3p9jY8l4BQ4gMUiX6czvEkDhJtDfr6rFGr+5MpV6LvITQdCo1KlnB3
 8O8MEHvx9Luu/t3g7Wk1VTPy+0Jprxdp+poz16Z2+SP/ypzx4HMs4hZDP7AKHbMlSaiY
 MgNGH+qwN6Swog7DWNogj4oyU7b9H6e6g/40BMMlqhOMVetb/2IrWtf8/W1zS5mjVsfl
 DhxDgGtXESpo+TJlvHgKb42C9F5Ale/W6yuFlRD0NbxuTvSrxJ3eY32d5ZJ2ecc+FUoU
 UJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iIE8It2FXNG0XWUL/CSj00U0tv985rXsk6j+tNxgJz4=;
 b=VlVWv55tUwWl0chj0m/M+mXEGliyB5DPXPmGddXlfhzGA7D2F6ClIhlRo4co8jWzlz
 MCNdf5TaNy/ULZ8VcKhmVMHc0SNf0g7wogo7GR9CMw65InFS2X5SNttXd3XmqxR3pofQ
 50F9hI8T2FCyI5L1fWCSqDX1rBvqiBorfPB0/zRHiZFd+dQyUWRF6Y1xZE+hL++/of7u
 eqUCUNrt9jROoAjDpqEgjdKXlcMHed8/gBcifsUhQ4Y72qvM5mi02rLl8C15ywHGc7GU
 VkkMYixh/9v1IAlESvHGSmhGKoMxcdE2RPjkEc7AyBZ0lBlO9nk2dNCfmOmJ4r7LA23k
 F3Mg==
X-Gm-Message-State: AOAM531c21wVrysCND0iO2hFhSG6uPzsbq8D9FSEOdJ94kCzmqpA5UWw
 Eg4DYgZ3g5K4L72YmICJfecEgRitNEs=
X-Google-Smtp-Source: ABdhPJxQuUEK7UNiTCp+XxJcAILGyMUB+5voyaiU6bS8SrPU20UcqjAFyfwH4sd4WvENJ7E5dY514w==
X-Received: by 2002:a5d:5092:: with SMTP id a18mr11843874wrt.323.1603626071049; 
 Sun, 25 Oct 2020 04:41:11 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u6sm14520881wmj.40.2020.10.25.04.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2020 04:41:10 -0700 (PDT)
Subject: Re: [PATCH] sabre: use object_initialize_child() for iommu child
 object
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20201021114300.11579-1-mark.cave-ayland@ilande.co.uk>
 <24f4d006-f8b4-4eac-5319-67ad14b182b5@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4dc23e8c-8527-9334-477c-2aed648c621b@amsat.org>
Date: Sun, 25 Oct 2020 12:41:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <24f4d006-f8b4-4eac-5319-67ad14b182b5@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/20 12:11 PM, Mark Cave-Ayland wrote:
> On 21/10/2020 12:43, Mark Cave-Ayland wrote:
> 
>> Store the child object directly within the sabre object rather than using
>> link properties.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/pci-host/sabre.c         | 10 ++++------
>>   hw/sparc64/sun4u.c          |  8 +-------
>>   include/hw/pci-host/sabre.h |  2 +-
>>   3 files changed, 6 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
>> index f41a0cc301..aaa93acd6e 100644
>> --- a/hw/pci-host/sabre.c
>> +++ b/hw/pci-host/sabre.c
>> @@ -383,9 +383,10 @@ static void sabre_realize(DeviceState *dev, Error 
>> **errp)
>>       pci_create_simple(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
>>       /* IOMMU */
>> +    sysbus_realize(SYS_BUS_DEVICE(&s->iommu), &error_fatal);
>>       memory_region_add_subregion_overlap(&s->sabre_config, 0x200,
>> -                    sysbus_mmio_get_region(SYS_BUS_DEVICE(s->iommu), 
>> 0), 1);
>> -    pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, s->iommu);
>> +                    sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->iommu), 
>> 0), 1);
>> +    pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, &s->iommu);
>>       /* APB secondary busses */
>>       pci_dev = pci_new_multifunction(PCI_DEVFN(1, 0), true,
>> @@ -422,10 +423,7 @@ static void sabre_init(Object *obj)
>>       s->pci_irq_in = 0ULL;
>>       /* IOMMU */
>> -    object_property_add_link(obj, "iommu", TYPE_SUN4U_IOMMU,
>> -                             (Object **) &s->iommu,
>> -                             qdev_prop_allow_set_link_before_realize,
>> -                             0);
>> +    object_initialize_child(obj, "iommu", &s->iommu, TYPE_SUN4U_IOMMU);
>>       /* sabre_config */
>>       memory_region_init_io(&s->sabre_config, OBJECT(s), 
>> &sabre_config_ops, s,
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index 2f8fc670cf..a33f1eccfd 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -562,7 +562,7 @@ static void sun4uv_init(MemoryRegion 
>> *address_space_mem,
>>       PCIBus *pci_bus, *pci_busA, *pci_busB;
>>       PCIDevice *ebus, *pci_dev;
>>       SysBusDevice *s;
>> -    DeviceState *iommu, *dev;
>> +    DeviceState *dev;
>>       FWCfgState *fw_cfg;
>>       NICInfo *nd;
>>       MACAddr macaddr;
>> @@ -571,10 +571,6 @@ static void sun4uv_init(MemoryRegion 
>> *address_space_mem,
>>       /* init CPUs */
>>       cpu = sparc64_cpu_devinit(machine->cpu_type, hwdef->prom_addr);
>> -    /* IOMMU */
>> -    iommu = qdev_new(TYPE_SUN4U_IOMMU);
>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu), &error_fatal);
>> -
>>       /* set up devices */
>>       ram_init(0, machine->ram_size);
>> @@ -584,8 +580,6 @@ static void sun4uv_init(MemoryRegion 
>> *address_space_mem,
>>       sabre = SABRE(qdev_new(TYPE_SABRE));
>>       qdev_prop_set_uint64(DEVICE(sabre), "special-base", 
>> PBM_SPECIAL_BASE);
>>       qdev_prop_set_uint64(DEVICE(sabre), "mem-base", PBM_MEM_BASE);
>> -    object_property_set_link(OBJECT(sabre), "iommu", OBJECT(iommu),
>> -                             &error_abort);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(sabre), &error_fatal);
>>       /* sabre_config */
>> diff --git a/include/hw/pci-host/sabre.h b/include/hw/pci-host/sabre.h
>> index 01190241bb..05bf741cde 100644
>> --- a/include/hw/pci-host/sabre.h
>> +++ b/include/hw/pci-host/sabre.h
>> @@ -34,7 +34,7 @@ struct SabreState {
>>       MemoryRegion pci_mmio;
>>       MemoryRegion pci_ioport;
>>       uint64_t pci_irq_in;
>> -    IOMMUState *iommu;
>> +    IOMMUState iommu;
>>       PCIBridge *bridgeA;
>>       PCIBridge *bridgeB;
>>       uint32_t pci_control[16];
> 
> No further comments (and I'm happier that this is a better solution than 
> having an "optional" link property) so I've applied this to my 
> qemu-sparc branch.

Sorry I had this patch tagged for review but am having trouble
managing that folder. This is certainly better, thanks for this
cleanup.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> 
> ATB,
> 
> Mark.
> 

