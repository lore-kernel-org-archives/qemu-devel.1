Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FB8C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5C8206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTWAmtst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5C8206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHhhn-0002ew-B6
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 02:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHheQ-0004Ue-Um
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:07:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHheP-0002RR-EB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:07:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id y15so9958266wmi.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 23:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Zpru2l6H5AvsbRbvD7bzBszMIc64fIb4bNTz3Zo/HDQ=;
 b=bTWAmtstPTUiPf8mkCPCChWiT88eB2n+STMsHq1RBOXlFP9h7hXD0hztyeIktNyr62
 VlWHusQf2Ii2MErUU8m0WSOCmlxT/VWqry2kX9AOo5jEEMJMzwCGejAD7ASS9YhsU8YV
 RZZ3Wpi/CKMLpMzWSa9dux0cXsRpv/Q0rbe//YcoGQKOgvXLQ00GB2/tUBntjJSYJBUe
 KOttgCohd6+oPubr56+31rCIW1Zk2HyY3kWBSfDeTnBAtwnD0OEvI0Xe5OxerDuetT4x
 Axv9qKqGZNLRpjn/42wPfi5U1S+Rnkvrg5/QIn8rJZsHAlP/n1xQ+f5yAcyrXZQLCzwz
 rGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zpru2l6H5AvsbRbvD7bzBszMIc64fIb4bNTz3Zo/HDQ=;
 b=hE2bvtCcsp/JPt4Io1IxU5i3Wsaoad4/KM2w8Zd+QPSQURunD/nEwD2j7pjOHxKI7M
 oyvFu08eLdtdtNA0xtWSgQEUISe/ePYRsTUK2Zo0nPGw5kB48RLVop0CK9aK0kM97g8K
 enmFSBgr51rC8HcyV4CISxbSFyHhGSFiYrTwSKPR4bEU0uhRUKwVk+4ZcAm6B9lzhZMy
 zlPREzXpG/FyaPCCslLkFFj2RRjRCCVfBuKiNfz8W8Vr2FkXXj3jo8Vth7XBcDCINmq8
 zhO70thazA5iSX/64Bk4MR6pXMaSBgYXfpqHJ2BELoqFRq+zPUSl7CLJO5L448eqr+fF
 0c6Q==
X-Gm-Message-State: AOAM533P93JYrmmLZpGKouMg9+VIQiHzk0xFuERTY+VffhMjiTIMniLY
 PdvbfITIOgCJClXITw6seq0=
X-Google-Smtp-Source: ABdhPJytRWrjQjLDbMQbs+D2sUUU1ShnWpjmcyqsmAYvJXWf2+A5LpHdmHTOMiy5qDnWGRtojsJOOQ==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr13871949wmb.171.1600063659902; 
 Sun, 13 Sep 2020 23:07:39 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id g143sm16944420wme.0.2020.09.13.23.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 23:07:39 -0700 (PDT)
Subject: Re: [PATCH 02/11] capstone: Update to upstream "next" branch
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
 <20200914000153.1725632-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7adb30d0-bf05-5809-24f3-c9478d2d9917@amsat.org>
Date: Mon, 14 Sep 2020 08:07:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914000153.1725632-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 2:01 AM, Richard Henderson wrote:
> This branch contains a number of improvements over master,
> including making all of the disassembler data constant.
> 
> We are skipping past the 4.0 branchpoint, which changed
> the location of the includes within the source directory.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  capstone    | 2 +-
>  meson.build | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/capstone b/capstone
> index 22ead3e0bf..f8b1b83301 160000
> --- a/capstone
> +++ b/capstone
> @@ -1 +1 @@
> -Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
> +Subproject commit f8b1b833015a4ae47110ed068e0deb7106ced66d
> diff --git a/meson.build b/meson.build
> index 4417de1e14..00e2b8cc29 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -668,6 +668,7 @@ else
>        'capstone/arch/X86/X86DisassemblerDecoder.c',
>        'capstone/arch/X86/X86ATTInstPrinter.c',
>        'capstone/arch/X86/X86IntelInstPrinter.c',
> +      'capstone/arch/X86/X86InstPrinterCommon.c',
>        'capstone/arch/X86/X86Mapping.c',
>        'capstone/arch/X86/X86Module.c'
>      )
> @@ -692,7 +693,7 @@ else
>                                 c_args: capstone_cargs,
>                                 include_directories: 'capstone/include')
>    capstone = declare_dependency(link_with: libcapstone,
> -                                include_directories: 'capstone/include')
> +                                include_directories: 'capstone/include/capstone')
>  endif

Not sure what is missing (here or in the previous?), I'm
getting:

In file included from disas/capstone.c:9:
include/disas/capstone.h:6:10: fatal error: capstone.h: No such file or
directory
    6 | #include <capstone.h>
      |          ^~~~~~~~~~~~

Ah, my build directory was already configured, so it uses --skip-meson.
Re-configuring without that, the build succeeds.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Paolo, maybe git submodule updates should invalidate the '--skip-meson'
option?

Regards,

Phil.

