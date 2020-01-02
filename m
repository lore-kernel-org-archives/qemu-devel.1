Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16825C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 17:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96C820866
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 17:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaFsCui4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96C820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in45T-0006aW-1c
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 12:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1in43w-0005J3-S0
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1in43v-000737-I3
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:15:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55989
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1in43v-00072s-DQ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577985306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYaRyxOqnU57eSsXwFJ7vbz4YtTXxFqre5cwtHZawLw=;
 b=eaFsCui48nTAUqcgJ26ufCP6Fq9mkeCbbSoOv99DxxXtVSadvI5aQJpOecX8cOF+2WsdbK
 /MejDTsziM643RabHExK2tZK2qsqeXldY2RNVANbxZRSxQnXWPLPFu8/Q5WAnJzyHu6Gvq
 Qo15Vp4PJkMKXUZEHteYJN+rmR6HC60=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-zUS_ozWZNaK5JiqZ540ROw-1; Thu, 02 Jan 2020 12:15:05 -0500
Received: by mail-wr1-f69.google.com with SMTP id z10so17684140wrt.21
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 09:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XYaRyxOqnU57eSsXwFJ7vbz4YtTXxFqre5cwtHZawLw=;
 b=OaHfrdJeKXJzzt+m91Jtz2bGFOlni8ovMIl7oFtgbpfEDFU5Q01x62wHWLCHj6DzDV
 COErzCaAOIeygKQAghydz2Ae3Njb+oRn1JItQprtFDGtqS5e/qp0WI+bvYLhMgtwrteE
 i+0dwef2zQ/QQlseRBKq7+qeGM3bLhUJQMqItr/gejisvB0vDa81Shfsw0ZdfY5Gr1f1
 NGKHf8zDARMGEFhaaUuZyHL/A+Er7X3f53f+T6ravsNBt+XseYY1PBSFsrei5jLKfDGV
 5GCcQdbqFXMo4OV9zWS/cUKsE+IZ8CK5uLAFWI8CHFkX6QGHFlPQuHPq0M6USez7HoPQ
 vVHg==
X-Gm-Message-State: APjAAAW80tcJ+KPtGxp8cIJ1aadN7hl06/LUVRLiPW+7KqOK/5nYw9bH
 Z3RkkXjTS9C4mHGihJBJsCwhp//n1Cs1uow1a6XCsQdjMGCTlEHNOZ1lMaWQS/jJ0AiU/Xh7nvD
 SfSfEqb1wMQjh8mg=
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr14782298wmm.85.1577985304210; 
 Thu, 02 Jan 2020 09:15:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEaZj4DYqxiILW1oZEYWT/mjxH/4iuUEqnBEQlITaUunl7u8Fm9TFTy1NcVfoAlLWEdnzAzA==
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr14782282wmm.85.1577985303952; 
 Thu, 02 Jan 2020 09:15:03 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id c17sm57819420wrr.87.2020.01.02.09.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 09:15:03 -0800 (PST)
Subject: Re: [PATCH] hppa: allow max ram size upto 4Gb
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <1577984917-143579-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <27c3e31d-82ae-e62f-caba-a0a3fbd55e7c@redhat.com>
Date: Thu, 2 Jan 2020 18:15:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577984917-143579-1-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: zUS_ozWZNaK5JiqZ540ROw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: deller@gmx.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/2/20 6:08 PM, Igor Mammedov wrote:
> Previous patch drops silent ram_size fixup and makes
> QEMU error out with:
> 
>   "RAM size more than 3840m is not supported"
> 
> when user specified -m X more than supported value.
> 
> User shouldn't be bothered with starting QEMU with valid CLI,
> so for the sake of user convenience to allow using -m 4G vs -m 3840M.
> 
> Requested-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> I dislike it but if you feel it's really necessary feel free to ack it.
> 
> should be applied on top of:
>    "hppa: drop RAM size fixup"
> ---
>   hw/hppa/machine.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index ebbf44f..7f8c92f 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -54,6 +54,7 @@ static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t addr)
>   
>   static HPPACPU *cpu[HPPA_MAX_CPUS];
>   static uint64_t firmware_entry;
> +static ram_addr_t clamped_ram_size;
>   
>   static void machine_hppa_init(MachineState *machine)
>   {
> @@ -74,8 +75,6 @@ static void machine_hppa_init(MachineState *machine)
>       long i;
>       unsigned int smp_cpus = machine->smp.cpus;
>   
> -    ram_size = machine->ram_size;
> -
>       /* Create CPUs.  */
>       for (i = 0; i < smp_cpus; i++) {
>           char *name = g_strdup_printf("cpu%ld-io-eir", i);
> @@ -90,10 +89,12 @@ static void machine_hppa_init(MachineState *machine)
>       }
>   
>       /* Limit main memory. */
> -    if (ram_size > FIRMWARE_START) {
> -        error_report("RAM size more than %d is not supported", FIRMWARE_START);
> +    if (machine->ram_size > 4 * GiB) {
> +        error_report("RAM size more than 4Gb is not supported");
>           exit(EXIT_FAILURE);
>       }
> +    clamped_ram_size = machine->ram_size > FIRMWARE_START ?
> +        FIRMWARE_START : machine->ram_size;
>   
>       memory_region_add_subregion(addr_space, 0, machine->ram);
>   
> @@ -151,7 +152,7 @@ static void machine_hppa_init(MachineState *machine)
>       qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
>                     "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
>                     firmware_low, firmware_high, firmware_entry);
> -    if (firmware_low < ram_size || firmware_high >= FIRMWARE_END) {
> +    if (firmware_low < clamped_ram_size || firmware_high >= FIRMWARE_END) {
>           error_report("Firmware overlaps with memory or IO space");
>           exit(1);
>       }
> @@ -160,7 +161,8 @@ static void machine_hppa_init(MachineState *machine)
>       rom_region = g_new(MemoryRegion, 1);
>       memory_region_init_ram(rom_region, NULL, "firmware",
>                              (FIRMWARE_END - FIRMWARE_START), &error_fatal);
> -    memory_region_add_subregion(addr_space, FIRMWARE_START, rom_region);
> +    memory_region_add_subregion_overlap(addr_space, FIRMWARE_START, rom_region,
> +                                        1);

I don't think this is enough because we also have:

(qemu) info mtree
address-space: memory
   00000000f9000000-00000000f90007ff (prio 0, i/o): isa-io
   00000000fff80000-00000000fff80fff (prio 0, i/o): dino
   00000000fff83800-00000000fff83807 (prio 0, i/o): serial
   00000000fffb0000-00000000fffb0003 (prio 0, i/o): cpu0-io-eir

Which is why I went the other way around, using prio=-1 for the ram.

>   
>       /* Load kernel */
>       if (kernel_filename) {
> @@ -204,7 +206,7 @@ static void machine_hppa_init(MachineState *machine)
>                  (1) Due to sign-extension problems and PDC,
>                  put the initrd no higher than 1G.
>                  (2) Reserve 64k for stack.  */
> -            initrd_base = MIN(ram_size, 1 * GiB);
> +            initrd_base = MIN(clamped_ram_size, 1 * GiB);
>               initrd_base = initrd_base - 64 * KiB;
>               initrd_base = (initrd_base - initrd_size) & TARGET_PAGE_MASK;
>   
> @@ -232,7 +234,7 @@ static void machine_hppa_init(MachineState *machine)
>        * various parameters in registers. After firmware initialization,
>        * firmware will start the Linux kernel with ramdisk and cmdline.
>        */
> -    cpu[0]->env.gr[26] = ram_size;
> +    cpu[0]->env.gr[26] = clamped_ram_size;
>       cpu[0]->env.gr[25] = kernel_entry;
>   
>       /* tell firmware how many SMP CPUs to present in inventory table */
> @@ -255,11 +257,11 @@ static void hppa_machine_reset(MachineState *ms)
>       }
>   
>       /* already initialized by machine_hppa_init()? */
> -    if (cpu[0]->env.gr[26] == ram_size) {
> +    if (cpu[0]->env.gr[26] == clamped_ram_size) {
>           return;
>       }
>   
> -    cpu[0]->env.gr[26] = ram_size;
> +    cpu[0]->env.gr[26] = clamped_ram_size;
>       cpu[0]->env.gr[25] = 0; /* no firmware boot menu */
>       cpu[0]->env.gr[24] = 'c';
>       /* gr22/gr23 unused, no initrd while reboot. */
> 


