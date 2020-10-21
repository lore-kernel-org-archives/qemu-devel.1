Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFACC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005CA208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCYTV8LU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005CA208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHmS-0004cI-I9
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVHjA-00010a-7A
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:16:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVHj8-0003WA-9E
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:16:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id q5so3404406wmq.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UxT/SQ9tYGP2PA2TN611gABS/xCrpDCxcfd0tThLPNQ=;
 b=SCYTV8LUdtAA6EQBV94JFM7V9aS+bUsTTpJggsrYbunCYEXuJBlD3rh78DE8L8GoRA
 Qf9Sw89z7LAuovLc+ljbqhpo0Cxqb6iUYGYo3qXc3SEEu4fGmWf32ylCEwq8wW8Yel5p
 jAOYI/kWaw3/8Wqmf8MLsD/46F0Y0+Oq2ZVs1SK5NIeBVVGK+/1AkXl2AQtPEV+XWQWX
 yd741JEMH7ZDTeBwATywH1w+MOyxmkkrFuyR4zQeOCKxdakyJO0LAzPT8hVVryLz/DCT
 ukVdhdrwu5TIV377Vt0GWbW444ZQKqxrpA1/9C3FZ3CcgiIgRP50Wvo+avzwlXFi2R6r
 /bAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UxT/SQ9tYGP2PA2TN611gABS/xCrpDCxcfd0tThLPNQ=;
 b=Vsg4xM0il23AfD5NVmqZygOorwpSNg9L/uTZno+PRCObCQY/ye+d6CI3iRssCccVaQ
 46YJCT4f2e3U16Tj0EOEn5fISC4wNkk21KLewE4RMj6jegbdjhj/O6omIPIJ/qY66BDn
 XjLKhYUP4rjbBUG13EIkM5yYQSMZ220DG63zptyOfZBcBMZydNoyV11QI+K5T518l5M/
 VI+AZAR/ESMVlhjgyW0PY+Si6/EgIJXs1/Kn6jryZKUeQflzIuDG+Ezq0hOQdaW79n2T
 I+TBkoSGSKcLjsOhpkoCKRcxPDS4U/ZnccdS/RyE2P/bZkSZD54N4UQ/p/WrZW2MnwcF
 ts5Q==
X-Gm-Message-State: AOAM532c92eIvB4m83PlowyqCcG/Oc+NBAc1jYeRWWtSaTS7WWJfDgWX
 Xc6foQDBQehNme1q+/uEugs=
X-Google-Smtp-Source: ABdhPJzoYmFh+ltvY9MEMZooU6T8HDP8bxV1HczbAEhrtRFafftZSjeuW2j3ZeDR8li3XCD7cfom7Q==
X-Received: by 2002:a1c:3503:: with SMTP id c3mr4551536wma.43.1603300600748;
 Wed, 21 Oct 2020 10:16:40 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id h4sm5162405wrv.11.2020.10.21.10.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 10:16:40 -0700 (PDT)
Subject: Re: [PATCH v1 2/6] contrib/gitdm: Add more individual contributors
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201021163136.27324-1-alex.bennee@linaro.org>
 <20201021163136.27324-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <20e65ce5-0e6a-9b7e-2d27-7ba09c73a6b7@amsat.org>
Date: Wed, 21 Oct 2020 19:16:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021163136.27324-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Thomas Huth <huth@tuxfamily.org>, James Hogan <jhogan@kernel.org>,
 Michael Rolnik <mrolnik@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 6:31 PM, Alex Bennée wrote:

Thanks for collecting :)

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-id: <20201004182506.2038515-1-f4bug@amsat.org>
> Acked-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> Acked-by: Michael Rolnik <mrolnik@gmail.com>
> Acked-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>

^ dup

I prepared this complementary patch for James Hogan:

-- >8 --
diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 0074da618f5..4ebfcc396c2 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -30,6 +30,7 @@ sifive.com      SiFive
  suse.com        SUSE
  suse.de         SUSE
  virtuozzo.com   Virtuozzo
+jhogan@kernel.org Wave Computing < 2017-10-15
  wdc.com         Western Digital
  xilinx.com      Xilinx
  yadro.com       YADRO
---

but since he already Acked this one:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Acked-by: Thomas Huth <huth@tuxfamily.org>
> Acked-by: James Hogan <jhogan@kernel.org>
> Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>   contrib/gitdm/group-map-individuals | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
> index d135f4b143..36bbb77c39 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -24,3 +24,8 @@ nieklinnenbank@gmail.com
>   devnexen@gmail.com
>   pauldzim@gmail.com
>   ani@anisinha.ca
> +sundeep.lkml@gmail.com
> +mrolnik@gmail.com
> +huth@tuxfamily.org
> +jhogan@kernel.org
> +atar4qemu@gmail.com
> 


