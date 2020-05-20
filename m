Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99803C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F98205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X97PBlUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F98205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOrC-0004rH-Kg
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbOjP-0006AG-Me
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:25:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42000
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbOjO-0001Ny-Uf
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589981158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwIHrpyVIX86aJn0ORsOQ0Yk0TNb79Ag+DOjqPnc9zM=;
 b=X97PBlUXtA2Kpt5dNN6Oo9eZ8IcsUZB009ZLxOjTSwgga/8ZUcEyK1kN4DAakjROycaieN
 /wXhCoDw/kAsXDbzY/SE3hO2nBE4ctIYK2aSCr1c9FhoKTzP6YZi/f5Bekj3lFvsFU7Y10
 o9WB6BkmbQ3/eO0KI7hzIaz4BqMPb4M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-Y8_ct2jQOmeHofywZnVAFg-1; Wed, 20 May 2020 09:25:56 -0400
X-MC-Unique: Y8_ct2jQOmeHofywZnVAFg-1
Received: by mail-wm1-f70.google.com with SMTP id 202so891498wmb.8
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 06:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IwIHrpyVIX86aJn0ORsOQ0Yk0TNb79Ag+DOjqPnc9zM=;
 b=fk7oCUCVJRTtKIFxLXW+pWaqU6ka6CAcnwFnlP2cBNoYw2SzU1dKYFRfbaw/bd91DR
 vIiWJHJlfi86DYNhHNISV7Msd94Oz7dhQHdbGBjYcSFdOIWQpICDSl+i84g/d3KVlTQs
 U205KFCpIAKyLl8KnO84fXnJN346PinTS/at15lRAS8AoioAsEhSuCsRYS99FcWxWQaD
 GxNIRIQKrttJv+FqjGLCkxR6cSmY5XKFOrZ3ezkIlD07zoMindRctu7cf9T6T8wjkvPY
 rMfMFSQi5zFzxdYr+gS5pmN/pwwNB1iYcNESLWUpfMkO8nNviLi9k/gJfQLtQcijHsAy
 GZWg==
X-Gm-Message-State: AOAM530GBukp0Pa2qJEupPCY82dydAtPAMf7j6ThcRX5edBh71QxqSjc
 HbNsFKmZnlVf6EhSrL8dHrIaSULaIgKMVHEYKW/fG3ZOdgFdISGozcTprvz2ucb/rMaCc52dXQd
 A+lnBq4pfBThssE0=
X-Received: by 2002:adf:80f0:: with SMTP id 103mr3988800wrl.232.1589981155248; 
 Wed, 20 May 2020 06:25:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzYhQsIgJQQOJuShPPOZfl3CwWYQ5JfoC4O+vklCms/zSZ/TCYhPlJAtdbJ4o16f9u396woA==
X-Received: by 2002:adf:80f0:: with SMTP id 103mr3988774wrl.232.1589981155011; 
 Wed, 20 May 2020 06:25:55 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h133sm3213832wmf.25.2020.05.20.06.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 06:25:54 -0700 (PDT)
Subject: Re: [PATCH v3 01/22] microvm: name qboot binary qboot.bin
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2a9e8f07-a1eb-9c3b-5070-51d5a87d76d5@redhat.com>
Date: Wed, 20 May 2020 15:25:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520132003.9492-2-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 5/20/20 3:19 PM, Gerd Hoffmann wrote:
> qboot isn't a bios and shouldnt be named that way.

Still it resides in a directory named pc-bios =)

It is used later in x86_bios_rom_init() as:

     bios = g_malloc(sizeof(*bios));
     memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
     if (!isapc_ram_fw) {
         memory_region_set_readonly(bios, true);
     }
     ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
     if (ret != 0) {
     bios_error:
         fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
         exit(1);
     }
     g_free(filename);

Many 'bios' occurrences.

Should it be called 'qboot.rom' instead?

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/i386/microvm.c                       |   4 ++--
>   pc-bios/{bios-microvm.bin => qboot.bin} | Bin
>   roms/Makefile                           |   6 +++---
>   3 files changed, 5 insertions(+), 5 deletions(-)
>   rename pc-bios/{bios-microvm.bin => qboot.bin} (100%)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 937db10ae6a5..867d3d652145 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -47,7 +47,7 @@
>   #include "kvm_i386.h"
>   #include "hw/xen/start_info.h"
>   
> -#define MICROVM_BIOS_FILENAME "bios-microvm.bin"
> +#define MICROVM_QBOOT_FILENAME "qboot.bin"
>   
>   static void microvm_set_rtc(MicrovmMachineState *mms, ISADevice *s)
>   {
> @@ -158,7 +158,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>       }
>   
>       if (bios_name == NULL) {
> -        bios_name = MICROVM_BIOS_FILENAME;
> +        bios_name = MICROVM_QBOOT_FILENAME;
>       }
>       x86_bios_rom_init(get_system_memory(), true);
>   }
> diff --git a/pc-bios/bios-microvm.bin b/pc-bios/qboot.bin
> similarity index 100%
> rename from pc-bios/bios-microvm.bin
> rename to pc-bios/qboot.bin
> diff --git a/roms/Makefile b/roms/Makefile
> index f9acf39954dc..d6d4948bfc31 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -68,7 +68,7 @@ default help:
>   	@echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
>   	@echo "  opensbi32-sifive_u -- update OpenSBI for 32-bit sifive_u machine"
>   	@echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
> -	@echo "  bios-microvm       -- update bios-microvm.bin (qboot)"
> +	@echo "  qboot              -- update qboot"
>   	@echo "  clean              -- delete the files generated by the previous" \
>   	                              "build targets"
>   
> @@ -194,9 +194,9 @@ opensbi64-sifive_u:
>   		PLATFORM="sifive/fu540"
>   	cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>   
> -bios-microvm:
> +qboot:
>   	$(MAKE) -C qboot
> -	cp qboot/bios.bin ../pc-bios/bios-microvm.bin
> +	cp qboot/bios.bin ../pc-bios/qboot.bin
>   
>   clean:
>   	rm -rf seabios/.config seabios/out seabios/builds
> 


