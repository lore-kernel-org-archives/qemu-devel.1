Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF89C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC56820BED
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgHO3ngO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC56820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSQGU-0003o0-MJ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 15:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSQF0-0002kE-CR; Tue, 13 Oct 2020 15:45:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSQEy-0002yB-4W; Tue, 13 Oct 2020 15:45:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id d3so991336wma.4;
 Tue, 13 Oct 2020 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Jn6Sb8SIR+GFZ65vLCsZYsy+mkGzDltYe5Xn+8F2lDU=;
 b=XgHO3ngOIfH5UgGDU5oHDMz7jCMQZs9zFQbW3uwdbn7v5fROdi9pqxmysRFM5PzBcE
 wZU1IUvo6tnUHYlbVsBXBxqTiy09AeenfIC9KZ0lu/gf28fD1sfdnF00Und4iYhpU9BR
 MGbBc3xWY1fU5FCZ8dI15XPyCnH0RMGszNNjG4Y6tBvvQeM8woSFyF/LOq+za28K/Bc9
 xVwCRQqX1HFDLVUw6X1gDmp4yLA6gwralXjyiEmhOPPgG3AT5kCMPAbWN0CWBGzMRCBZ
 Gt7gxNKYJ7+LjOxXmItD2NOdWroNwvYNcSDOlCBOz9Rd9k13BcvNJ18A9kq5eXGbePjv
 efrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jn6Sb8SIR+GFZ65vLCsZYsy+mkGzDltYe5Xn+8F2lDU=;
 b=i1H0J7T7TsheJ/YHGHGAe+aGR3KZRWmheCAb79HyqIgE4RQtrgjrq7U8PEEISq9Oke
 mFP/uPNCSvM0J0R5+NVZa+P+yUEeUHmIh7eAce+5z6r2t5oVvv8gp/fNla4ferBT5cXZ
 Fq7RRy5giNPhEpdSpbXNIRMaXK4E+RGn4Kf5zZdVrDnoUP8Zv8yM9vYWvrpzpAwFCF7l
 83unRrzc6IXYQ7HeMEEjJsqPfexHFM05zbWXOdvTgqKHlpxDIEYG/B14N6fz8HNOYmLq
 io5xCQDn6W460pZv0N32aS48dRw6KlhHIgtIVQQC2E+6YeKBYHefcBhLsQDrmEWU1jFR
 5r/Q==
X-Gm-Message-State: AOAM533WpdiB4XdUqmcXBiiyy822NStZahFQPcWERYxDgUPGSYJs34W6
 pvs6VNgVa9Iu/D4GvxQ/n+0=
X-Google-Smtp-Source: ABdhPJxJJapVKZgwhXc6jXSQ9x0CwtiFx+9/S6QXvcAfcsRirooSePcAApw4fdc5gPIvnm0RpR2j7Q==
X-Received: by 2002:a1c:bbc6:: with SMTP id l189mr1493028wmf.52.1602618342149; 
 Tue, 13 Oct 2020 12:45:42 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f14sm912284wme.22.2020.10.13.12.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 12:45:41 -0700 (PDT)
Subject: Re: [PATCH v7 2/8] mac_newworld: Allow loading binary ROM image
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1593456926.git.balaton@eik.bme.hu>
 <cf1ee4b79ff72d51e6e05027bb51439c2e6bbda1.1593456926.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c094697c-95e2-7009-c693-81b74b5190ef@amsat.org>
Date: Tue, 13 Oct 2020 21:45:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <cf1ee4b79ff72d51e6e05027bb51439c2e6bbda1.1593456926.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 8:55 PM, BALATON Zoltan wrote:
> Fall back to load binary ROM image if loading ELF fails. This also
> moves PROM_BASE and PROM_SIZE defines to board as these are matching
> the ROM size and address on this board and removes the now unused
> PROM_ADDR and BIOS_SIZE defines from common mac.h.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> Unlike mac_oldworld where the openbios-ppc image loads at end of ROM
> region here we only check size and assume ELF image is loaded from
> PROM_BASE, Checking the load addr here is tricky because this board is
> also be compiled both 64 and 32 bit and load_elf seems to always
> return 64 bit value so handling that could become a mess. If this is a
> problem then it's a preexisting one so should be fixed in a separate
> patch. This one just allows loading ROM binary too otherwise
> preserving previous behaviour.
> 
>   hw/ppc/mac.h          |  2 --
>   hw/ppc/mac_newworld.c | 22 ++++++++++++++--------
>   2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index 04e498bc57..195967facd 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -40,10 +40,8 @@
>   /* SMP is not enabled, for now */
>   #define MAX_CPUS 1
>   
> -#define BIOS_SIZE        (1 * MiB)
>   #define NVRAM_SIZE        0x2000
>   #define PROM_FILENAME    "openbios-ppc"
> -#define PROM_ADDR         0xfff00000
>   
>   #define KERNEL_LOAD_ADDR 0x01000000
>   #define KERNEL_GAP       0x00100000
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 828c5992ae..c88142af57 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -82,6 +82,8 @@
>   
>   #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
>   
> +#define PROM_BASE 0xfff00000
> +#define PROM_SIZE (1 * MiB)
>   
>   static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>                               Error **errp)
> @@ -100,7 +102,7 @@ static void ppc_core99_reset(void *opaque)
>   
>       cpu_reset(CPU(cpu));
>       /* 970 CPUs want to get their initial IP as part of their boot protocol */
> -    cpu->env.nip = PROM_ADDR + 0x100;
> +    cpu->env.nip = PROM_BASE + 0x100;
>   }
>   
>   /* PowerPC Mac99 hardware initialisation */
> @@ -153,25 +155,29 @@ static void ppc_core99_init(MachineState *machine)
>       /* allocate RAM */
>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>   
> -    /* allocate and load BIOS */
> -    memory_region_init_rom(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
> +    /* allocate and load firmware ROM */
> +    memory_region_init_rom(bios, NULL, "ppc_core99.bios", PROM_SIZE,
>                              &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), PROM_BASE, bios);
>   
> -    if (bios_name == NULL)
> +    if (!bios_name) {
>           bios_name = PROM_FILENAME;
> +    }
>       filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -    memory_region_add_subregion(get_system_memory(), PROM_ADDR, bios);
> -
> -    /* Load OpenBIOS (ELF) */
>       if (filename) {
> +        /* Load OpenBIOS (ELF) */
>           bios_size = load_elf(filename, NULL, NULL, NULL, NULL,
>                                NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
>   
> +        if (bios_size <= 0) {
> +            /* or load binary ROM image */
> +            bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE);
> +        }
>           g_free(filename);
>       } else {
>           bios_size = -1;
>       }
> -    if (bios_size < 0 || bios_size > BIOS_SIZE) {
> +    if (bios_size < 0 || bios_size > PROM_SIZE) {
>           error_report("could not load PowerPC bios '%s'", bios_name);
>           exit(1);
>       }
> 


