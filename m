Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7F9C34026
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5ED20801
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aa2agkGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5ED20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3loj-0002An-Rz
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lns-0001N6-TZ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lnr-0007oA-MY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:11:36 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lnr-0007nc-Fc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:11:35 -0500
Received: by mail-pg1-x543.google.com with SMTP id g3so9570729pgs.11
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wHc2/v+ZvDDPsivCoccrEsJNEmFalW5BxSjKBXf8pVY=;
 b=aa2agkGoqiLI24jU/YOOwLWpIe3NKY6h5bhwxHhR+yfuoFq/HjWY6zeFzGnIy9k5A1
 QdRMHw3op7auQJkC/STLB9oMDBwhjZXv2hX6vErAqHdqo5DwLPh0U75ICES58onLMG2B
 FJGc4luAuF1FzKK8vEeBzHEzblZ4nsczG1PCCm/r48Ei0pIu+4hcKF5Kc+BNnQW0dyB7
 6hcX1W6FXUejxe5KBabhE08FsD9FVSiQ2IqKgPBnYM5WmBG50w10IQWqduVwksLWYQGy
 AW6h5v84MHXaXsNoe5JPsi58qBOaOGORewOJnCRH12MmF248zIDLK83ko/f5ZuV1fWZo
 IsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wHc2/v+ZvDDPsivCoccrEsJNEmFalW5BxSjKBXf8pVY=;
 b=t75XEn3NDW1Zrrd7zv87croxKvt7eWUQKibOZrk9n65gMeWG+tRzXEJhdQO+R0CFVF
 ZG2u4I9aA/m88z5XyPjU88uWzcAo+03jc0Dm9ig+GZkSLLwVlMJd93/44EApO5whzJAJ
 CUteYCg2f4d7C3LW8oJhVd09hP4ohuYhH0UQ4LYfxuUeLpHhzrQldMRHzHNjETTx7Tua
 Hv8ZwCHBuTh4inVeYaXMBBGA1wbP06uk4Kqih6P5uIzlPNGSdJrkPPTV3NSCqKylI6wJ
 wXQZ7MW51+7TO9kFG/yFjidNjSIj5HOYs4hBClK5Dg49un1jNW12Jz/3magXLZmu4a1z
 eCpg==
X-Gm-Message-State: APjAAAWZlhfy5YJ/mLyeivCleMBZoH0xTjWHtvcrY9J8G1bncTfBiWvG
 pbStOBLNo96CYw3BRz0Jpk8WZA==
X-Google-Smtp-Source: APXvYqzKC96uOvPZ712kSrYDO/Y4SQVRtrQnVBz6t7lBeVq69tBF+v0UjKWfH11Gl1EnhnD8rrNnxQ==
X-Received: by 2002:a17:90a:23e5:: with SMTP id
 g92mr636442pje.14.1581966694193; 
 Mon, 17 Feb 2020 11:11:34 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 o11sm216301pjs.6.2020.02.17.11.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:11:31 -0800 (PST)
Subject: Re: [PATCH v5 24/79] arm/musicpal: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-25-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a0a461ef-b4b3-fe1a-dba3-c1672a33670a@linaro.org>
Date: Mon, 17 Feb 2020 11:11:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-25-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jan.kiszka@web.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:33 AM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> PS:
>  while at it add check for user supplied RAM size and error
>  out if it mismatches board expected value.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -1589,16 +1590,21 @@ static void musicpal_init(MachineState *machine)
>      int i;
>      unsigned long flash_size;
>      DriveInfo *dinfo;
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
>      MemoryRegion *address_space_mem = get_system_memory();
> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>      MemoryRegion *sram = g_new(MemoryRegion, 1);
>  
> +    /* For now we use a fixed - the original - RAM size */
> +    if (machine->ram_size != mc->default_ram_size) {
> +        char *sz = size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }

If for some reason you need to re-spin this series again, and considering my
comment re arm/imx25_pdk, I think it would be worthwhile to create a common
helper for this:

void machine_memory_check_fixed_size(MachineState *machine)
{
    MachineClass *mc = MACHINE_GET_CLASS(machine);

    if (machine->ram_size != mc->default_ram_size) {
        char *sz = size_to_str(mc->default_ram_size);
        error_report("Invalid RAM size, should be %s", sz);
        g_free(sz);
        exit(EXIT_FAILURE);
    }
}

That would keep the language consistent across the boards.


r~

