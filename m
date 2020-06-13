Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6CEC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 18:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D812C2074D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 18:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjreXqMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D812C2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkAhI-000121-4O
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 14:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkAgS-0000QK-1p; Sat, 13 Jun 2020 14:15:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52255)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkAgP-0000Rc-At; Sat, 13 Jun 2020 14:15:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id r9so10758809wmh.2;
 Sat, 13 Jun 2020 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bxp5NsFrgJaRtzkpaBQCUvGSqXjwBTIe9kEIoSzZRXc=;
 b=kjreXqMDrWW4MGBW8NfFVHJoNlVAcGa48QRC4F5kJ5n1f2VjTdb9VBPRssQUaJceJD
 NbBRXS/lkcKTI1O1FNxUoQA6anHnOclHEyCq2LRTltL/uPoMB4ZP1WEtaEP5GOSB9NfP
 0AhIXLl1+6IkdH0/aB18b4FEmKerOGRSfB5N6hgPODgPE7Z6iHfNM13A6/8MkVIiS94f
 Vk3iby+ZMHi7YQTAOQx0VtXnAUDkRFEgk/mYZs8owUOp16idcPKXDJQZpCL2W2cMmyRz
 wSwoy60NrY5dlEft7oAQir2E2M7Qj7YTD5KYa+Hxq+26dEWIYrUv1ljEIsAveMMSkaH4
 KhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bxp5NsFrgJaRtzkpaBQCUvGSqXjwBTIe9kEIoSzZRXc=;
 b=AWFdrRjWS+h4EFyuLkPFEIs7aIXmDa5q9NlwgEcgeJnHhs6pSE7uNVDjukzKrbhrDe
 7koPuiemG9l3v408MrpGMHjnjrqM1O+FwWpsQJWnVc71KKjEfNSjjvBT72Cxr8uUNaX1
 xUcZMSmlKo/xtFNQxA6GNZB4FJtz8/ZkMU1lDR8JcBq1MQoAdpeounjXJ8tPlvL7oS60
 jxcM9WqUkDFY7enVGw4RSZGc6OkgL+ESLuwJZZ1mOexEKqtl2O8h2F3DBW89o0p1wwRI
 cm2qbjPWuFwrZtwrSuqwP0NerUyQG6MiAECtHUlz5QZoTQW7RQvJG+orld9Wcq00+zmY
 8KBw==
X-Gm-Message-State: AOAM533dlr9V7fLpiK7Xp2BJ/qn5TTBmIKikSpzkLvRJ6+P1nFD5wnXM
 AnADQgoB3wzIt7WoUWGsB/w=
X-Google-Smtp-Source: ABdhPJy/oQoROxiaqAZAzCyfVbo5ihFcEFFzsIerBCoeKlD31apy5O9TYJoLpdLfVF4/j0XlOCUnZQ==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr4760621wmb.15.1592072097366;
 Sat, 13 Jun 2020 11:14:57 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id k21sm16574616wrd.24.2020.06.13.11.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jun 2020 11:14:56 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] mac_oldworld: Map macio to expected address at
 reset
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1592055375.git.balaton@eik.bme.hu>
 <c637ae5d399e5681bb4f21662c7240590e7182e1.1592055375.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <627a963a-2bd7-eab2-2276-3a79eb97821d@amsat.org>
Date: Sat, 13 Jun 2020 20:14:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c637ae5d399e5681bb4f21662c7240590e7182e1.1592055375.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/13/20 3:36 PM, BALATON Zoltan wrote:
> Add a reset function that maps macio to the address expected by the
> firmware of the board at startup.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/mac.h          | 12 ++++++++++++
>  hw/ppc/mac_oldworld.c | 17 +++++++++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index 6af87d1fa0..35a5f21163 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -57,6 +57,18 @@
>  #define OLDWORLD_IDE1_IRQ      0xe
>  #define OLDWORLD_IDE1_DMA_IRQ  0x3
>  
> +/* g3beige machine */
> +#define TYPE_HEATHROW_MACHINE MACHINE_TYPE_NAME("g3beige")
> +#define HEATHROW_MACHINE(obj) OBJECT_CHECK(HeathrowMachineState, (obj), \
> +                                           TYPE_HEATHROW_MACHINE)
> +
> +typedef struct HeathrowMachineState {
> +    /*< private >*/
> +    MachineState parent;
> +
> +    PCIDevice *macio_pci;
> +} HeathrowMachineState;
> +
>  /* New World IRQs */
>  #define NEWWORLD_CUDA_IRQ      0x19
>  #define NEWWORLD_PMU_IRQ       0x19
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 9138752ccb..fa9527410d 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -73,6 +73,15 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>      return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
>  }
>  
> +static void ppc_heathrow_reset(MachineState *machine)
> +{
> +    HeathrowMachineState *m = HEATHROW_MACHINE(machine);
> +
> +    qemu_devices_reset();
> +    pci_default_write_config(m->macio_pci, PCI_COMMAND, PCI_COMMAND_MEMORY, 2);
> +    pci_default_write_config(m->macio_pci, PCI_BASE_ADDRESS_0, 0xf3000000, 4);

Hmm either this should be the default reset state of the device,
or we miss a 'BIOS' boot code that sets this state before you can
run your code.

> +}
> +
>  static void ppc_heathrow_cpu_reset(void *opaque)
>  {
>      PowerPCCPU *cpu = opaque;
> @@ -91,6 +100,7 @@ const MemoryRegionOps machine_id_reg_ops = {
>  
>  static void ppc_heathrow_init(MachineState *machine)
>  {
> +    HeathrowMachineState *hm = HEATHROW_MACHINE(machine);
>      ram_addr_t ram_size = machine->ram_size;
>      const char *kernel_filename = machine->kernel_filename;
>      const char *kernel_cmdline = machine->kernel_cmdline;
> @@ -298,7 +308,8 @@ static void ppc_heathrow_init(MachineState *machine)
>      ide_drive_get(hd, ARRAY_SIZE(hd));
>  
>      /* MacIO */
> -    macio = OLDWORLD_MACIO(pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO));
> +    hm->macio_pci = pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO);
> +    macio = OLDWORLD_MACIO(hm->macio_pci);
>      dev = DEVICE(macio);
>      qdev_prop_set_uint64(dev, "frequency", tbfreq);
>      object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
> @@ -450,6 +461,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
>  
>      mc->desc = "Heathrow based PowerMAC";
>      mc->init = ppc_heathrow_init;
> +    mc->reset = ppc_heathrow_reset;
>      mc->block_default_type = IF_IDE;
>      mc->max_cpus = MAX_CPUS;
>  #ifndef TARGET_PPC64
> @@ -466,9 +478,10 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
>  }
>  
>  static const TypeInfo ppc_heathrow_machine_info = {
> -    .name          = MACHINE_TYPE_NAME("g3beige"),
> +    .name          = TYPE_HEATHROW_MACHINE,
>      .parent        = TYPE_MACHINE,
>      .class_init    = heathrow_class_init,
> +    .instance_size = sizeof(HeathrowMachineState),
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_FW_PATH_PROVIDER },
>          { }
> 


