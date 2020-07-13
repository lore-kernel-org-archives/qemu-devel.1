Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2608C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92F82067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPbfZcI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92F82067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuSP-0004Ik-0m
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juuRm-0003Yl-Cy
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:08:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juuRk-0003wZ-Qg
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:08:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id z2so15191108wrp.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Lx+ilzxa45X1M9ISx7QGCxwG+gFynzXKt0VbUiDnuT0=;
 b=BPbfZcI+QNqOarjxwBGnMtvrCiDDwbSL/f0yPyGYT/DMsPz6+IKi9c9i7858Q3XPrh
 dbFuz5CpMnOAoHJf7ki7et68e6kPmG9wNudTXq7y15y8C99U17E9CUlTZrbjpNnzu/6/
 TObovqfCV+UHPyiUC/87s/jb93PkzbizxJWZiHj4Bpagicc64tLml8Asd25gL5LlofVA
 B4ahfmu9McdAP94uzLSWq+niog/5qWWtownVKZR0RdQyYPqaom1nf+u+Cze0krqRX14a
 p66/LJBbCws4b7dAfqpePH34IMWFU7l+Xvg6BBwGB6EIT7+76hpBzZt5nsJpsJRPALZA
 WlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lx+ilzxa45X1M9ISx7QGCxwG+gFynzXKt0VbUiDnuT0=;
 b=C45M77UV93nYeCPjFRte5U/K+o0Xh9YzSCCauReE/zHS4jsekBTqbhsbfhz06xJg15
 XJQQDoY2Ums3PS1vSP0ERkt7NajXa5RI+JL/dzdfphFRE8nu9yxVk6uDaZYhmk4Zs3MA
 WD2lBNnxYgRTAPqnlSkVI/mfIYG7GEKOUipC9dtuyreOY/cYK/MOjLdTU0Gy7UTak0GE
 u2+ziOVEmRrvu89nLEMz8uSRAhnfEmevu9xx/ooq4H+VCHYKHo6eU1PIzt/CaEz4YYfD
 ZnISac+PxiUQ4rvEwUBGI6ARhe6efLrGFdKwww29WbGx5eCFYBr/QHP5QWphuvcBdAnO
 qqWQ==
X-Gm-Message-State: AOAM530HNkBUhkyjQZxGeEgr/TeMpeW/lBqa0UQmA6tSfzYnbmxYKJnt
 rdl0+uDfOleCjkBwm3/8IwM=
X-Google-Smtp-Source: ABdhPJyza+rUWQyjv9D36J9m/5WRyAE4TTA/bQwcL8pivfshGm0WQmM7m7L1JCPI2guyi97aPZnwKg==
X-Received: by 2002:adf:f14c:: with SMTP id y12mr77440531wro.30.1594631303212; 
 Mon, 13 Jul 2020 02:08:23 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id x1sm22119034wrp.10.2020.07.13.02.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 02:08:22 -0700 (PDT)
Subject: Re: [PATCH 05/12] virtfs-proxy-helper: Remove the superfluous break
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594631070-36397-1-git-send-email-wang.yi59@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9fbd45d9-08fc-bdee-9726-ef09c46eec10@amsat.org>
Date: Mon, 13 Jul 2020 11:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594631070-36397-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 11:04 AM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove the superfluous break, as there is a "return" before it.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org> 

Hmm I never reviewed this patch, only the openrisc one:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04078.html

Something is wrong in your workflow, you are posting each patch as
a new thread. You might be missing the --cc-cover option, see:
https://wiki.qemu.org/Contribute/SubmitAPatch#Use_git_format-patch

> ---
>  fsdev/virtfs-proxy-helper.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> index de061a8..e68acc1 100644
> --- a/fsdev/virtfs-proxy-helper.c
> +++ b/fsdev/virtfs-proxy-helper.c
> @@ -825,7 +825,6 @@ static int process_reply(int sock, int type,
>          break;
>      default:
>          return -1;
> -        break;
>      }
>      return 0;
>  }
> 


