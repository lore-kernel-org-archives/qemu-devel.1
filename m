Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0630CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA29A2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv8CwxyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA29A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUGd-0006iI-Sy
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUFt-0005Rn-2R
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:44:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUFs-0008UR-7A
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:44:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id c71so2171184wmd.5
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 00:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gpwR/7c6EaPR3HIglg1jfl2y8DImE2vk6w+M1ODXi8s=;
 b=Cv8CwxyYkzmSwQFVYZPOeDIlyYNb3UW2rPR53SlpoZcBFc9Bw+Yj3HbkZQai8IUiIE
 Cxw5WcJHFKNoSyvOi71humZl4fq/10PHToJo78ia14JCmFwUtOMC9gm0QJNPhx8wbjFX
 fp8ag1E301oPXJ3wB0uHs8eIDBwW0s5ORUKd+fGSFu0l6vcn3dWEPCbuRcpr7qgfZ4z0
 iC61CjncSL97HnF800VjUwjWTlpwjxUbxwuUdI2tNfDS1KKN8LVJWZR3AOQFQNzxKnvm
 Y9eyjnp+YJO735NqmuOIDXXdFlNqxSkWXrUbFCiIlOYE8TH9jFbdNeVCTNJfj4OosBG5
 5mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gpwR/7c6EaPR3HIglg1jfl2y8DImE2vk6w+M1ODXi8s=;
 b=CohzHRV+xQOt90DbbKYxrSWJ3YHci9W6irq5GT1gzSrMVWfkcXdJSemGG8olIna7Wm
 0Ml4D+tHc5jp0h3F1/X6Nc2AIZedfAsSC82VK87SBPPX0J9vaEsI2pniD6ZHXd/dW+Y8
 CiK8iH0K7lTQ7D0C23+HS/eArLYMsC5F0vg609sCxgNCyfTpQMkyimwzUSPIa9eWE6aI
 +tp/QZDfgJSZ8ftRaUxzr1Cv8jXR3AAYSG2F9CsEAywgKQQEbJq3AsLtxW9H0/2NJ7a3
 4Gyjrl9reJCiaXb87Ll+NHM+RpJICkvQaHJTvl0+yf8e2doTFLtetiPuQIKv51Tt3m8O
 6q0Q==
X-Gm-Message-State: AOAM530ITYuTTsk4M4+JEN0/YwU40QLvTLT9Os4YkEsCB31Vl+fFu1lx
 9oGNdX6ay4h3+UBTPdu9VkA=
X-Google-Smtp-Source: ABdhPJwCCUkKzpBz2/9qFADOqYTk4Z9rPr64cXu5Ob8lqRi3wgcNrHDNh+gg0JXhM4ykCl+Dh+SOfA==
X-Received: by 2002:a1c:a74a:: with SMTP id q71mr115277wme.23.1590479046776;
 Tue, 26 May 2020 00:44:06 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id r2sm7294767wrg.68.2020.05.26.00.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 00:44:06 -0700 (PDT)
Subject: Re: [PATCH v6 21/21] hw/mips: Rename malta/mipssim/r4k/jazz files in
 hw/mips
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
 <20200518200920.17344-22-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <070a8f41-ba92-3509-8293-c0148b1db512@amsat.org>
Date: Tue, 26 May 2020 09:44:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518200920.17344-22-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 10:09 PM, Aleksandar Markovic wrote:
> Machine file names should not have prefix "mips_".
> 
> Fuloong2e machine source file will be handled in a separate patch,
> to avoid conflicts. That patch is pending integration into the
> main tree.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  MAINTAINERS                           | 9 ++++-----
>  hw/mips/Makefile.objs                 | 8 ++++----
>  hw/mips/{mips_jazz.c => jazz.c}       | 0
>  hw/mips/{mips_malta.c => malta.c}     | 0
>  hw/mips/{mips_mipssim.c => mipssim.c} | 0
>  hw/mips/{mips_r4k.c => r4k.c}         | 0
>  6 files changed, 8 insertions(+), 9 deletions(-)
>  rename hw/mips/{mips_jazz.c => jazz.c} (100%)
>  rename hw/mips/{mips_malta.c => malta.c} (100%)
>  rename hw/mips/{mips_mipssim.c => mipssim.c} (100%)
>  rename hw/mips/{mips_r4k.c => r4k.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d5562c5c7..883d15c9d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11,7 +11,6 @@ consult qemu-devel and not any specific individual privately.
>  
>  Descriptions of section entries:
>  
> -	M: Mail patches to: FullName <address@domain>

Thanks, queued to mips-next without removing the 'M' tag description.

>  	   Maintainers are looking after a certain area and must be CCed on
>  	   patches. They are considered the main contact point.
>  	R: Designated reviewer: FullName <address@domain>
> @@ -1043,7 +1042,7 @@ Jazz
>  M: Hervé Poussineau <hpoussin@reactos.org>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
> -F: hw/mips/mips_jazz.c
> +F: hw/mips/jazz.c
>  F: hw/display/jazz_led.c
>  F: hw/dma/rc4030.c
>  
> @@ -1054,7 +1053,7 @@ R: Aurelien Jarno <aurelien@aurel32.net>
>  S: Maintained
>  F: hw/isa/piix4.c
>  F: hw/acpi/piix4.c
> -F: hw/mips/mips_malta.c
> +F: hw/mips/malta.c
>  F: hw/mips/gt64xxx_pci.c
>  F: include/hw/southbridge/piix.h
>  F: tests/acceptance/linux_ssh_mips_malta.py
> @@ -1064,7 +1063,7 @@ Mipssim
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Odd Fixes
> -F: hw/mips/mips_mipssim.c
> +F: hw/mips/mipssim.c
>  F: hw/net/mipsnet.c
>  
>  R4000
> @@ -1072,7 +1071,7 @@ M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>  R: Aurelien Jarno <aurelien@aurel32.net>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Obsolete
> -F: hw/mips/mips_r4k.c
> +F: hw/mips/r4k.c
>  
>  Fulong 2E
>  M: Philippe Mathieu-Daudé <f4bug@amsat.org>
> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> index 525809af07..1d767ed9a8 100644
> --- a/hw/mips/Makefile.objs
> +++ b/hw/mips/Makefile.objs
> @@ -1,8 +1,8 @@
>  obj-y += addr.o mips_int.o
> -obj-$(CONFIG_R4K) += mips_r4k.o
> -obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
> -obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
> -obj-$(CONFIG_JAZZ) += mips_jazz.o
> +obj-$(CONFIG_R4K) += r4k.o
> +obj-$(CONFIG_MALTA) += gt64xxx_pci.o malta.o
> +obj-$(CONFIG_MIPSSIM) += mipssim.o
> +obj-$(CONFIG_JAZZ) += jazz.o
>  obj-$(CONFIG_FULONG) += mips_fulong2e.o
>  obj-$(CONFIG_MIPS_CPS) += cps.o
>  obj-$(CONFIG_MIPS_BOSTON) += boston.o
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/jazz.c
> similarity index 100%
> rename from hw/mips/mips_jazz.c
> rename to hw/mips/jazz.c
> diff --git a/hw/mips/mips_malta.c b/hw/mips/malta.c
> similarity index 100%
> rename from hw/mips/mips_malta.c
> rename to hw/mips/malta.c
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mipssim.c
> similarity index 100%
> rename from hw/mips/mips_mipssim.c
> rename to hw/mips/mipssim.c
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/r4k.c
> similarity index 100%
> rename from hw/mips/mips_r4k.c
> rename to hw/mips/r4k.c
> 

