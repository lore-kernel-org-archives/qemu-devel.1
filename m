Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F53C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B73220897
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQp/ZPlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B73220897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWR5A-000704-UC
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 17:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWR4L-0006bG-OV
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:27:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWR4K-0001s9-3N
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:27:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id n15so7221875wrq.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hjJj5bRaqurqCuZponnvhHmP175a4DP+UdV71iQecfc=;
 b=aQp/ZPlxEAGrRoy/iGdWPqUwfPZjmyfCCTmO9+WNP2U1K5s6CDZejv5GZ8mtOk9YWr
 X+/9oqfonLBa6YmUVaRx4y4qa/Qhxsp9sR8q9jEBuxVyhJ8lgHu9eHtsbKHcIEw5OdXF
 KsC+sQAGrNfTrYFwhTGAAnjINJ19EBwk7tybhr9cCkrxRCg17hNXt3Snvtq61iWwFMxz
 LVJGZG1+7+F/8xiqeVpqavlNZJIGj1K5cYKdi/8UvJGFie6rzfbaauNiaGBchRFSeqQ5
 IaKsKpK+pVqtQapptziu9Q+129MOLIVgUNDsTb/vndHwq/EakQgfbEQK/64dnLcaKAJ6
 nxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hjJj5bRaqurqCuZponnvhHmP175a4DP+UdV71iQecfc=;
 b=D0E0bB3obXAeZLxrzuUymq2VF/IrO11nf2MJfbHDjWHdpV2ySKDZsweRBWbvw6ehZb
 j7fBFXpYLNyJ3jv+b8tVm+0B6EsJbqFp23iLkAsSGR7u5dSN8DR9reTOozFuVrKpKbMk
 ap23ViMaOenNmN1GPkcdjcxw7FRXYx3N6hXChqTum6J36gqaoJZISf1xH2l3d7tYQU8I
 gn9n0VdtBa9DIQJ6QqZT2G9zrjMz/YZjOrrYGc3cbAPQF1Cwho9ZmzRqpjIn4QNvEhZP
 Rt4/EVXt4M4c0728rb6Q1YJ+fqSUtg5I1ZVyF4LFYg+cAKSmWuFD1g5XrekGD4k2mToQ
 /zcA==
X-Gm-Message-State: AOAM531Vc9EIkkUsa/11p2B7LNL3uwYLVCyf2XgQtLcHBRQmx2yFkpCC
 0iOzN8wofxwDFSxM0etl6zQeGcXJ9FE=
X-Google-Smtp-Source: ABdhPJylxo3y1qJUgP1f2qjyPLJ/Nx4kwvqCA41xUX18E2H37JrYZ8cCLLWOlapzaGFbHbzy2G20og==
X-Received: by 2002:adf:deca:: with SMTP id i10mr9671954wrn.96.1603574838036; 
 Sat, 24 Oct 2020 14:27:18 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id v11sm11760713wml.26.2020.10.24.14.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 14:27:17 -0700 (PDT)
Subject: Re: [PATCH 06/20] hw/timer: Renesas 8bit timer emulation.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-7-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4db6d116-e5b6-e9cf-d6a3-27a2e4a131dd@amsat.org>
Date: Sat, 24 Oct 2020 23:27:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-7-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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

On 8/27/20 2:38 PM, Yoshinori Sato wrote:
> Rewrite for clock API.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   include/hw/timer/renesas_tmr.h  |  55 ----
>   include/hw/timer/renesas_tmr8.h |  67 ++++
>   hw/timer/renesas_tmr.c          | 477 ----------------------------
>   hw/timer/renesas_tmr8.c         | 540 ++++++++++++++++++++++++++++++++
>   hw/timer/Kconfig                |   3 +-
>   hw/timer/meson.build            |   2 +-
>   6 files changed, 610 insertions(+), 534 deletions(-)
>   delete mode 100644 include/hw/timer/renesas_tmr.h
>   create mode 100644 include/hw/timer/renesas_tmr8.h
>   delete mode 100644 hw/timer/renesas_tmr.c
>   create mode 100644 hw/timer/renesas_tmr8.c
...

> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index 8749edfb6a..5288660cda 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -36,7 +36,7 @@ config CMSDK_APB_DUALTIMER
>       bool
>       select PTIMER
>   
> -config RENESAS_TMR
> +config RENESAS_TMR8
>       bool

Build failure:

undefined symbol RENESAS_TMR

$ git grep RENESAS_TMR
hw/rx/Kconfig:4:    select RENESAS_TMR

>   
>   config RENESAS_CMT
> @@ -44,3 +44,4 @@ config RENESAS_CMT
>   
>   config AVR_TIMER16
>       bool
> +
> diff --git a/hw/timer/meson.build b/hw/timer/meson.build
> index 9f0a267c83..a02e45fdbd 100644
> --- a/hw/timer/meson.build
> +++ b/hw/timer/meson.build
> @@ -8,7 +8,7 @@ softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_timer.c'))
>   softmmu_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_ttc.c'))
>   softmmu_ss.add(when: 'CONFIG_CMSDK_APB_DUALTIMER', if_true: files('cmsdk-apb-dualtimer.c'))
>   softmmu_ss.add(when: 'CONFIG_CMSDK_APB_TIMER', if_true: files('cmsdk-apb-timer.c'))
> -softmmu_ss.add(when: 'CONFIG_RENESAS_TMR', if_true: files('renesas_tmr.c'))
> +softmmu_ss.add(when: 'CONFIG_RENESAS_TMR8', if_true: files('renesas_tmr8.c'))
>   softmmu_ss.add(when: 'CONFIG_RENESAS_CMT', if_true: files('renesas_cmt.c'))
>   softmmu_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-timer.c'))
>   softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_timer.c'))
> 


