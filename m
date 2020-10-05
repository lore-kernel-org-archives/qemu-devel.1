Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2707BC4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A047D20756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HySMxQa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A047D20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLUV-0004Ye-Nh
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPLTO-0003uf-Sg; Mon, 05 Oct 2020 04:03:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPLTM-0004f8-Bj; Mon, 05 Oct 2020 04:03:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id g12so2975000wrp.10;
 Mon, 05 Oct 2020 01:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LbMt+Pu6MqpSl/W9Pmhtx4pQZgPNkHrYRQ0sEuni6LY=;
 b=HySMxQa0gjhJfQYmqvnBo9nG6TXPHLtVR7uSVEB5kYXUcLGLbtYPWc+F//fLoCmIT0
 spkpiiL03JTMxWEj6mGlve1P3aslND8JX/3ZbvNmWyWCj3oFzGquZWcaU6QlL/gXN0Oi
 ZqfrqBKmAr4k2zaoh+s6JFD8tJRFaFqo8+dwFHGweG1R5BgEpZv2gQhrz23e+BvsuBLE
 tN37BSE0BYaxpbIxkj6pzgao51rdrbKSwokNxOcjuuBigxi7w9vk5xkzcN6xYC6PF3VC
 KA1666DjgUPh+06+ebzdVxiZ+7tMkRuSEeQbzb/bJRW4Jss8w0bl5a3uZcQAeKoAlhTa
 csbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LbMt+Pu6MqpSl/W9Pmhtx4pQZgPNkHrYRQ0sEuni6LY=;
 b=CYEUd1KFZ8RVXqNquMuiewbHlFSPUzd2CAhmwLT0cW7+WViFmrROHDlDYZwG6g9hWZ
 TqyDYONFkTB+hGWYUdVGvJVGG4NEN2ThoJTB+PnyG19nGqZbJCGQJmEVFJJlbXiQtUuv
 fGQyIsnjFUJy6zkSStNKeyJ54cqHECu4yxdCejcIgV8A7x6EoWp9j6yInYi3vCUwe2yp
 w8RO2zy1Nre3OHhpUbIOgCMIUfeEbBhos47mHYNxD6HM47u1dG277l0vb2OtDK/qA7zj
 YVwok7glzck+mb/B2k+sQXeZ3virQoOZXVfX1CfvObyc1a5KfigVyc0YFx7Tu89TXnfY
 6hdw==
X-Gm-Message-State: AOAM532lM5BQYwKPUeYZ8IziwGaG78s8rY9sxc3NyrkNVPISxMEYxJuo
 u7azJcbsYGWsN1nIyykuWGxMJ6Zf2Trx0w==
X-Google-Smtp-Source: ABdhPJxNr48hcKMA9NgKvJQLTtTeSK6kMleySvlRMnL3gLodXrO8zE2phLaBc2rvzfGI/vKGfvdlVw==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr16177085wrv.222.1601885028400; 
 Mon, 05 Oct 2020 01:03:48 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p3sm11495793wmm.40.2020.10.05.01.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 01:03:47 -0700 (PDT)
Subject: Re: [PATCH v2] sd: Exhibit support for CMD23
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Rahul Thati <rthati@xilinx.com>
References: <1600278689-32187-1-git-send-email-sai.pavan.boddu@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5a6c8c83-da12-70b0-6178-9edc0bc9db76@amsat.org>
Date: Mon, 5 Oct 2020 10:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600278689-32187-1-git-send-email-sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sai,

On 9/16/20 7:51 PM, Sai Pavan Boddu wrote:
> Update 'SCR.CMD_SUPPORT' register with support of CMD23.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Reported-by: Rahul Thati <rthati@xilinx.com>
> ---
> Changes for V2:
> 	Fix commit message
> 
>  hw/sd/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 0012882..16d1b61 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -335,7 +335,7 @@ static void sd_set_scr(SDState *sd)
>      if (sd->spec_version >= SD_PHY_SPECv3_01_VERS) {
>          sd->scr[2] |= 1 << 7;   /* Spec Version 3.0X */
>      }
> -    sd->scr[3] = 0x00;
> +    sd->scr[3] = 0x2;           /* CMD23 supported */

You need to check:
- spec_version >= SD_PHY_SPECv3_01_VERS
- sd->size > SDSC_MAX_CAPACITY

Then you should also update the TRAN_SPEED value in sd_set_csd().

>      /* reserved for manufacturer usage */
>      sd->scr[4] = 0x00;
>      sd->scr[5] = 0x00;
> 

