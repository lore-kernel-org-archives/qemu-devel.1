Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2710C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 18:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA3B2053B
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 18:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYpz49tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA3B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja1z5-0005GT-Ut
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 14:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ja1xv-0004ND-PB
 for qemu-devel@nongnu.org; Sat, 16 May 2020 14:55:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20549
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ja1xr-0000g1-Qn
 for qemu-devel@nongnu.org; Sat, 16 May 2020 14:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589655314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q+rM1mJWqHmFaEsv3UOEJ4ZLmvK7Tg3Ct+4teYJb7tA=;
 b=iYpz49tmUg5atU0UKNFTuvxYRblgiKGd7Lc0VXbZHGgV8a0OEyFYGtGPeeYXXuxDQktKRs
 sYOrY3/aCTr5SFfdcYFg1vWZV2oYvmk0BwuFYMuowGFooJAVrzi+mS1PCN/DNivSyW6OqI
 B/4MoEjZZZHzm4i9WwAaNCcBkOzB0uo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-X2wmkPz5MP2l73PC1PmR4Q-1; Sat, 16 May 2020 14:55:12 -0400
X-MC-Unique: X2wmkPz5MP2l73PC1PmR4Q-1
Received: by mail-wr1-f72.google.com with SMTP id e14so2971388wrv.11
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 11:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q+rM1mJWqHmFaEsv3UOEJ4ZLmvK7Tg3Ct+4teYJb7tA=;
 b=AJoak7FJVszNwTn3Dr/nCkJ6oOs0QLOs1JidlhaKHbAjIs5BRD4Al79xNXctsH5Lmg
 Q5f8eL0FG+aTiGOTsnL7jCm0J4p42005kSkL8mu/ldnLwsPe6FXtPA7SEShqGbsAzucm
 DlKq4a0BSqKtSW313vex7wD0zVEXnCPZMyhcM2q3Di94aG6XMCAHN5ERlwEzic4Rzirf
 LzYBOf+QWOHif8g38aVCSdP4H7HXLrqOEmZ3/DaDIxE3isFAbQyztKXZN8yi7BkKdmjc
 MfPaWV/TqIP8lbBHilGdYz177tdGbRo6vrDREm5FM/wZs6tOSxNCteSbffx0OErm6syk
 MTDA==
X-Gm-Message-State: AOAM531wf2r+7atUKMDtZVO4zm4jOTSNo5+qZkjUZplOAdJUfj1yptW8
 /SxNbtIdJuJmrFs0Y174rFINLB0p6kajl/zFRNvAs29iDM91HnRPNejjsyjOgfI9LEbfR6kBLkQ
 00czlhBMczh9uvQQ=
X-Received: by 2002:a1c:1f16:: with SMTP id f22mr10138106wmf.46.1589655311059; 
 Sat, 16 May 2020 11:55:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZsadsIDgdJDrhNNGSONb9yOgYUt/ciVQP4Gl9VOVuuCui+Dq0/GgSfAXe45QgWBciLtXzlQ==
X-Received: by 2002:a1c:1f16:: with SMTP id f22mr10138094wmf.46.1589655310890; 
 Sat, 16 May 2020 11:55:10 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 88sm8736506wrq.77.2020.05.16.11.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2020 11:55:10 -0700 (PDT)
Subject: Re: [PATCH v3 18/18] MAINTAINERS: Change Aleksandar Rikalo's email
 address
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
 <20200516174548.7631-19-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a796202-106f-980f-6340-e7e300bbf28e@redhat.com>
Date: Sat, 16 May 2020 20:55:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200516174548.7631-19-aleksandar.qemu.devel@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 14:55:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/20 7:45 PM, Aleksandar Markovic wrote:
> Aleksandar Rikalo want to use a different email address

"wants"?

> from now on.
> 
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>   .mailmap    |  3 ++-
>   MAINTAINERS | 12 ++++++------
>   2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 6412067bde..e3628c7a66 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -42,7 +42,8 @@ Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu
>   Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@mips.com>
>   Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgtec.com>
>   Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
> -Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
> +Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
> +Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
>   Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
>   James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>   Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f84e3ae2c..8d5562c5c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -212,7 +212,7 @@ F: disas/microblaze.c
>   MIPS TCG CPUs
>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>   R: Aurelien Jarno <aurelien@aurel32.net>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Maintained
>   F: target/mips/
>   F: default-configs/*mips*
> @@ -1041,7 +1041,7 @@ MIPS Machines
>   -------------
>   Jazz
>   M: Hervé Poussineau <hpoussin@reactos.org>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Maintained
>   F: hw/mips/mips_jazz.c
>   F: hw/display/jazz_led.c
> @@ -1062,7 +1062,7 @@ F: tests/acceptance/machine_mips_malta.py
>   
>   Mipssim
>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Odd Fixes
>   F: hw/mips/mips_mipssim.c
>   F: hw/net/mipsnet.c
> @@ -1070,7 +1070,7 @@ F: hw/net/mipsnet.c
>   R4000
>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>   R: Aurelien Jarno <aurelien@aurel32.net>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Obsolete
>   F: hw/mips/mips_r4k.c
>   
> @@ -1085,7 +1085,7 @@ F: include/hw/isa/vt82c686.h
>   
>   Boston
>   M: Paul Burton <pburton@wavecomp.com>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Maintained
>   F: hw/core/loader-fit.c
>   F: hw/mips/boston.c
> @@ -2582,7 +2582,7 @@ F: disas/i386.c
>   MIPS TCG target
>   M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>   R: Aurelien Jarno <aurelien@aurel32.net>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> +R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>   S: Maintained
>   F: tcg/mips/
>   
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


