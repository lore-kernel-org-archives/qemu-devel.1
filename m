Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CA5C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 20:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC742206E4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 20:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beR2iug4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC742206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibViF-0007gv-Tg
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 15:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ibVhU-0006yb-In
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ibVhQ-00036A-Hs
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:20:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40769
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ibVhQ-00035U-6l
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 15:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575231607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pb0n6ZZrbynTLltuE52Tz2yOldnsCjPyPg2ALbT6eVc=;
 b=beR2iug4zJ8Znu2Ivpyn5ZaedcvoqpLr74/vhK5H+Ah8tsuGnLX7zA+g0cmJ8GSSGCKFov
 7HLkXHk4ysFY/7ad5ChGIT0lq3UyE9dVRMHQvgiZpKxL3yPRwU7JVwmEMhZT5IqgDzki3h
 gAviHB+O6dTrWPsotbcpSXJ6YTZqmkY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-eDrpQpgyMlWEMBsIexg1kw-1; Sun, 01 Dec 2019 15:20:03 -0500
Received: by mail-wr1-f71.google.com with SMTP id l20so9409306wrc.13
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 12:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pb0n6ZZrbynTLltuE52Tz2yOldnsCjPyPg2ALbT6eVc=;
 b=iqNyTlz8UY+PWsxbrRVJp3oCBORcmc2iDbowPR/dtIn26T6uW53xPemOrnXgZK3v3Q
 pTLRG3/3ZgPbg1PtsQ5QJm9lJbVlhjMn1vWPT8FqxwdWyDRmatzm2CqSfnkKkBmh8rqy
 jv1tq94IaXoAn41QRTHfxpy6lFBMd/ZCNOZAw9BQjM1Xt/z1OxSk0uO4hhJnolnccScs
 sOe1bzRRPS5K0gXsF0sqQvmMTIcmiiNB7K5sS0jT0GXB3EYGH36OTOAR+7yOEo3LM9X3
 Bo7q6c/g85gSy+SIXgLIeheLAez9Y9KUfCgr6uE2a7aKZGYHuHlklVk6yTDpkSCZDZNU
 xtIQ==
X-Gm-Message-State: APjAAAWQeHktVhcOTIIYdHmOHDm6p5Y2tLauY2fEGzaRokibLpCulemo
 g/LDF2RFlS+Z/4ytP5oUNlyFGbs4+Z7BHAp84MOIErZPdNMEj5cCB9A/ETBreqF2Ols6QdSJKZq
 tgkeyVGIgmeuHiqs=
X-Received: by 2002:adf:83c7:: with SMTP id 65mr19770472wre.368.1575231602623; 
 Sun, 01 Dec 2019 12:20:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwiZs9b9yh5pb1fPXgo2Bg9PbuWhEG0EaIZXj7UFB+6/s14EMwJ6AajwaJXHnT83e819WXy1w==
X-Received: by 2002:adf:83c7:: with SMTP id 65mr19770454wre.368.1575231602286; 
 Sun, 01 Dec 2019 12:20:02 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id h15sm38074552wrb.44.2019.12.01.12.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 12:20:01 -0800 (PST)
Subject: Re: [PATCH 2/5] mips: malta: Renovate coding style
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1574687098-26689-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1574687098-26689-3-git-send-email-Filip.Bozuta@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7f7f98ec-6ee2-ec3d-6807-6b74af547241@redhat.com>
Date: Sun, 1 Dec 2019 21:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574687098-26689-3-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Language: en-US
X-MC-Unique: eDrpQpgyMlWEMBsIexg1kw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: pburton@wavecomp.com, aleksandar.rikalo@rt-rk.com, hpoussin@reactos.org,
 aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Filip,

On 11/25/19 2:04 PM, Filip Bozuta wrote:
> The script checkpatch.pl located in scripts folder was
> used to detect all errors and warrnings in files:
>      hw/mips/mips_malta.c
>      hw/mips/gt64xxx_pci.c
>      tests/acceptance/linux_ssh_mips_malta.py
> 
> All these mips malta machine files were edited and
> all the errors and warrings generated by the checkpatch.pl
> script were corrected and then the script was
> ran again to make sure there are no more errors and warnings.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>   hw/mips/mips_malta.c                     | 139 ++++++++++++++++---------------
>   tests/acceptance/linux_ssh_mips_malta.py |   6 +-
>   2 files changed, 75 insertions(+), 70 deletions(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 92e9ca5..18eafac 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -137,7 +137,8 @@ static void malta_fpga_update_display(void *opaque)
>    */
>   
>   #if defined(DEBUG)
> -#  define logout(fmt, ...) fprintf(stderr, "MALTA\t%-24s" fmt, __func__, ## __VA_ARGS__)
> +#  define logout(fmt, ...) \
> +          fprintf(stderr, "MALTA\t%-24s" fmt, __func__, ## __VA_ARGS__)

This is deprecated code, if you look in the repository history, we 
usually don't touch it, except to get rid of it. The way to get rid of 
it is to replace the calls by trace events.

>   #else
>   #  define logout(fmt, ...) ((void)0)
>   #endif
> @@ -569,7 +570,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
>       MaltaFPGAState *s;
>       Chardev *chr;
>   
> -    s = (MaltaFPGAState *)g_malloc0(sizeof(MaltaFPGAState));
> +    s = (MaltaFPGAState *)g_new0(sizeof(MaltaFPGAState));

This change doesn't even compile... Please compile your patches before 
posting them to the list.

You can find the prototype of this macro here:
https://developer.gnome.org/glib/stable/glib-Memory-Allocation.html#g-new0

>   
>       memory_region_init_io(&s->iomem, NULL, &malta_fpga_ops, s,
>                             "malta-fpga", 0x100000);
> @@ -844,9 +845,9 @@ static void write_bootloader(uint8_t *base, int64_t run_addr,
>       /* Small bootloader */
>       p = (uint32_t *)base;
>   
> -    stl_p(p++, 0x08000000 |                                      /* j 0x1fc00580 */
> +    stl_p(p++, 0x08000000 |                                   /* j 0x1fc00580 */
>                    ((run_addr + 0x580) & 0x0fffffff) >> 2);
> -    stl_p(p++, 0x00000000);                                      /* nop */
> +    stl_p(p++, 0x00000000);                                   /* nop */
>   
>       /* YAMON service vector */
>       stl_p(base + 0x500, run_addr + 0x0580);      /* start: */
> @@ -892,104 +893,106 @@ static void write_bootloader(uint8_t *base, int64_t run_addr,
>       stl_p(p++, 0x34e70000 | (loaderparams.ram_low_size & 0xffff));
>   
>       /* Load BAR registers as done by YAMON */
> -    stl_p(p++, 0x3c09b400);                                      /* lui t1, 0xb400 */
> +    stl_p(p++, 0x3c09b400);                 /* lui t1, 0xb400 */
>   
>   #ifdef TARGET_WORDS_BIGENDIAN
> -    stl_p(p++, 0x3c08df00);                                      /* lui t0, 0xdf00 */
> +    stl_p(p++, 0x3c08df00);                  /* lui t0, 0xdf00 */
>   #else
> -    stl_p(p++, 0x340800df);                                      /* ori t0, r0, 0x00df */
> +    stl_p(p++, 0x340800df);                  /* ori t0, r0, 0x00df */
>   #endif
> -    stl_p(p++, 0xad280068);                                      /* sw t0, 0x0068(t1) */
> +    stl_p(p++, 0xad280068);                  /* sw t0, 0x0068(t1) */
>   
> -    stl_p(p++, 0x3c09bbe0);                                      /* lui t1, 0xbbe0 */
> +    stl_p(p++, 0x3c09bbe0);                  /* lui t1, 0xbbe0 */
>   
>   #ifdef TARGET_WORDS_BIGENDIAN
> -    stl_p(p++, 0x3c08c000);                                      /* lui t0, 0xc000 */
> +    stl_p(p++, 0x3c08c000);                  /* lui t0, 0xc000 */
>   #else
> -    stl_p(p++, 0x340800c0);                                      /* ori t0, r0, 0x00c0 */
> +    stl_p(p++, 0x340800c0);                  /* ori t0, r0, 0x00c0 */
>   #endif
> -    stl_p(p++, 0xad280048);                                      /* sw t0, 0x0048(t1) */
> +    stl_p(p++, 0xad280048);                  /* sw t0, 0x0048(t1) */
>   #ifdef TARGET_WORDS_BIGENDIAN
> -    stl_p(p++, 0x3c084000);                                      /* lui t0, 0x4000 */
> +    stl_p(p++, 0x3c084000);                  /* lui t0, 0x4000 */
>   #else
> -    stl_p(p++, 0x34080040);                                      /* ori t0, r0, 0x0040 */
> +    stl_p(p++, 0x34080040);                  /* ori t0, r0, 0x0040 */
>   #endif
> -    stl_p(p++, 0xad280050);                                      /* sw t0, 0x0050(t1) */
> +    stl_p(p++, 0xad280050);                  /* sw t0, 0x0050(t1) */
>   
>   #ifdef TARGET_WORDS_BIGENDIAN
> -    stl_p(p++, 0x3c088000);                                      /* lui t0, 0x8000 */
> +    stl_p(p++, 0x3c088000);                  /* lui t0, 0x8000 */
>   #else
> -    stl_p(p++, 0x34080080);                                      /* ori t0, r0, 0x0080 */
> +    stl_p(p++, 0x34080080);                  /* ori t0, r0, 0x0080 */
>   #endif
> -    stl_p(p++, 0xad280058);                                      /* sw t0, 0x0058(t1) */
> +    stl_p(p++, 0xad280058);                  /* sw t0, 0x0058(t1) */
>   #ifdef TARGET_WORDS_BIGENDIAN
> -    stl_p(p++, 0x3c083f00);                                      /* lui t0, 0x3f00 */
> +    stl_p(p++, 0x3c083f00);                  /* lui t0, 0x3f00 */
>   #else
> -    stl_p(p++, 0x3408003f);                                      /* ori t0, r0, 0x003f */
> +    stl_p(p++, 0x3408003f);                  /* ori t0, r0, 0x003f */
>   #endif
> -    stl_p(p++, 0xad280060);                                      /* sw t0, 0x0060(t1) */
> +    stl_p(p++, 0xad280060);                  /* sw t0, 0x0060(t1) */
>   
>   #ifdef TARGET_WORDS_BIGENDIAN
> -    stl_p(p++, 0x3c08c100);                                      /* lui t0, 0xc100 */
> +    stl_p(p++, 0x3c08c100);                  /* lui t0, 0xc100 */
>   #else
> -    stl_p(p++, 0x340800c1);                                      /* ori t0, r0, 0x00c1 */
> +    stl_p(p++, 0x340800c1);                  /* ori t0, r0, 0x00c1 */
>   #endif
> -    stl_p(p++, 0xad280080);                                      /* sw t0, 0x0080(t1) */
> +    stl_p(p++, 0xad280080);                  /* sw t0, 0x0080(t1) */
>   #ifdef TARGET_WORDS_BIGENDIAN
> -    stl_p(p++, 0x3c085e00);                                      /* lui t0, 0x5e00 */
> +    stl_p(p++, 0x3c085e00);                  /* lui t0, 0x5e00 */
>   #else
> -    stl_p(p++, 0x3408005e);                                      /* ori t0, r0, 0x005e */
> +    stl_p(p++, 0x3408005e);                  /* ori t0, r0, 0x005e */
>   #endif
> -    stl_p(p++, 0xad280088);                                      /* sw t0, 0x0088(t1) */
> +    stl_p(p++, 0xad280088);                  /* sw t0, 0x0088(t1) */
>   
>       /* Jump to kernel code */
> -    stl_p(p++, 0x3c1f0000 | ((kernel_entry >> 16) & 0xffff));    /* lui ra, high(kernel_entry) */
> -    stl_p(p++, 0x37ff0000 | (kernel_entry & 0xffff));            /* ori ra, ra, low(kernel_entry) */
> -    stl_p(p++, 0x03e00009);                                      /* jalr ra */
> -    stl_p(p++, 0x00000000);                                      /* nop */
> +    stl_p(p++, 0x3c1f0000 |
> +          ((kernel_entry >> 16) & 0xffff));  /* lui ra, high(kernel_entry) */
> +    stl_p(p++, 0x37ff0000 |
> +          (kernel_entry & 0xffff));          /* ori ra, ra, low(kernel_entry) */
> +    stl_p(p++, 0x03e00009);                  /* jalr ra */
> +    stl_p(p++, 0x00000000);                  /* nop */
>   
>       /* YAMON subroutines */
>       p = (uint32_t *) (base + 0x800);
> -    stl_p(p++, 0x03e00009);                                     /* jalr ra */
> -    stl_p(p++, 0x24020000);                                     /* li v0,0 */
> +    stl_p(p++, 0x03e00009);                  /* jalr ra */
> +    stl_p(p++, 0x24020000);                  /* li v0,0 */
>       /* 808 YAMON print */
> -    stl_p(p++, 0x03e06821);                                     /* move t5,ra */
> -    stl_p(p++, 0x00805821);                                     /* move t3,a0 */
> -    stl_p(p++, 0x00a05021);                                     /* move t2,a1 */
> -    stl_p(p++, 0x91440000);                                     /* lbu a0,0(t2) */
> -    stl_p(p++, 0x254a0001);                                     /* addiu t2,t2,1 */
> -    stl_p(p++, 0x10800005);                                     /* beqz a0,834 */
> -    stl_p(p++, 0x00000000);                                     /* nop */
> -    stl_p(p++, 0x0ff0021c);                                     /* jal 870 */
> -    stl_p(p++, 0x00000000);                                     /* nop */
> -    stl_p(p++, 0x1000fff9);                                     /* b 814 */
> -    stl_p(p++, 0x00000000);                                     /* nop */
> -    stl_p(p++, 0x01a00009);                                     /* jalr t5 */
> -    stl_p(p++, 0x01602021);                                     /* move a0,t3 */
> +    stl_p(p++, 0x03e06821);                  /* move t5,ra */
> +    stl_p(p++, 0x00805821);                  /* move t3,a0 */
> +    stl_p(p++, 0x00a05021);                  /* move t2,a1 */
> +    stl_p(p++, 0x91440000);                  /* lbu a0,0(t2) */
> +    stl_p(p++, 0x254a0001);                  /* addiu t2,t2,1 */
> +    stl_p(p++, 0x10800005);                  /* beqz a0,834 */
> +    stl_p(p++, 0x00000000);                  /* nop */
> +    stl_p(p++, 0x0ff0021c);                  /* jal 870 */
> +    stl_p(p++, 0x00000000);                  /* nop */
> +    stl_p(p++, 0x1000fff9);                  /* b 814 */
> +    stl_p(p++, 0x00000000);                  /* nop */
> +    stl_p(p++, 0x01a00009);                  /* jalr t5 */
> +    stl_p(p++, 0x01602021);                  /* move a0,t3 */
>       /* 0x83c YAMON print_count */
> -    stl_p(p++, 0x03e06821);                                     /* move t5,ra */
> -    stl_p(p++, 0x00805821);                                     /* move t3,a0 */
> -    stl_p(p++, 0x00a05021);                                     /* move t2,a1 */
> -    stl_p(p++, 0x00c06021);                                     /* move t4,a2 */
> -    stl_p(p++, 0x91440000);                                     /* lbu a0,0(t2) */
> -    stl_p(p++, 0x0ff0021c);                                     /* jal 870 */
> -    stl_p(p++, 0x00000000);                                     /* nop */
> -    stl_p(p++, 0x254a0001);                                     /* addiu t2,t2,1 */
> -    stl_p(p++, 0x258cffff);                                     /* addiu t4,t4,-1 */
> -    stl_p(p++, 0x1580fffa);                                     /* bnez t4,84c */
> -    stl_p(p++, 0x00000000);                                     /* nop */
> -    stl_p(p++, 0x01a00009);                                     /* jalr t5 */
> -    stl_p(p++, 0x01602021);                                     /* move a0,t3 */
> +    stl_p(p++, 0x03e06821);                  /* move t5,ra */
> +    stl_p(p++, 0x00805821);                  /* move t3,a0 */
> +    stl_p(p++, 0x00a05021);                  /* move t2,a1 */
> +    stl_p(p++, 0x00c06021);                  /* move t4,a2 */
> +    stl_p(p++, 0x91440000);                  /* lbu a0,0(t2) */
> +    stl_p(p++, 0x0ff0021c);                  /* jal 870 */
> +    stl_p(p++, 0x00000000);                  /* nop */
> +    stl_p(p++, 0x254a0001);                  /* addiu t2,t2,1 */
> +    stl_p(p++, 0x258cffff);                  /* addiu t4,t4,-1 */
> +    stl_p(p++, 0x1580fffa);                  /* bnez t4,84c */
> +    stl_p(p++, 0x00000000);                  /* nop */
> +    stl_p(p++, 0x01a00009);                  /* jalr t5 */
> +    stl_p(p++, 0x01602021);                  /* move a0,t3 */
>       /* 0x870 */
> -    stl_p(p++, 0x3c08b800);                                     /* lui t0,0xb400 */
> -    stl_p(p++, 0x350803f8);                                     /* ori t0,t0,0x3f8 */
> -    stl_p(p++, 0x91090005);                                     /* lbu t1,5(t0) */
> -    stl_p(p++, 0x00000000);                                     /* nop */
> -    stl_p(p++, 0x31290040);                                     /* andi t1,t1,0x40 */
> -    stl_p(p++, 0x1120fffc);                                     /* beqz t1,878 <outch+0x8> */
> -    stl_p(p++, 0x00000000);                                     /* nop */
> -    stl_p(p++, 0x03e00009);                                     /* jalr ra */
> -    stl_p(p++, 0xa1040000);                                     /* sb a0,0(t0) */
> +    stl_p(p++, 0x3c08b800);                  /* lui t0,0xb400 */
> +    stl_p(p++, 0x350803f8);                  /* ori t0,t0,0x3f8 */
> +    stl_p(p++, 0x91090005);                  /* lbu t1,5(t0) */
> +    stl_p(p++, 0x00000000);                  /* nop */
> +    stl_p(p++, 0x31290040);                  /* andi t1,t1,0x40 */
> +    stl_p(p++, 0x1120fffc);                  /* beqz t1,878 <outch+0x8> */
> +    stl_p(p++, 0x00000000);                  /* nop */
> +    stl_p(p++, 0x03e00009);                  /* jalr ra */
> +    stl_p(p++, 0xa1040000);                  /* sb a0,0(t0) */

Are you planning to move/rename this file? Telling this now would 
justify your cleanup.

>   
>   }
>   
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
> index fc13f9e..44e1118 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -99,10 +99,12 @@ class LinuxSSH(Test):
>       def ssh_command(self, command, is_root=True):
>           self.ssh_logger.info(command)
>           result = self.ssh_session.cmd(command)
> -        stdout_lines = [line.rstrip() for line in result.stdout_text.splitlines()]
> +        stdout_lines = [line.rstrip() for line
> +        in result.stdout_text.splitlines()]

I think QEMU Python coding style is to align below the opening bracket.

>           for line in stdout_lines:
>               self.ssh_logger.info(line)
> -        stderr_lines = [line.rstrip() for line in result.stderr_text.splitlines()]
> +        stderr_lines = [line.rstrip() for line
> +        in result.stderr_text.splitlines()]
>           for line in stderr_lines:
>               self.ssh_logger.warning(line)
>           return stdout_lines, stderr_lines
> 


