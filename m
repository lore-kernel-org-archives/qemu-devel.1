Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81054C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129AE20709
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1Pxb+Zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129AE20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtXn-0000f0-4H
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtVm-0006nm-88; Fri, 09 Oct 2020 10:36:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtVk-0007gV-Mn; Fri, 09 Oct 2020 10:36:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id g12so10529798wrp.10;
 Fri, 09 Oct 2020 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mmCCdFj+Kaux51WJzT8oE4ZuVYLTS3sQGupMAH0RdrY=;
 b=A1Pxb+Zies04cRhvbRhimXgo49t06FDy8J1mtVcvun9nN5fHlCTRhZHAARvAlqU1ZV
 /snzfMQjqh/L7d50BxOQgVDTYe4fZIw2T01GcLvWqactW/YOAmOfNLUitGkl7OJs4IUR
 5mOcivPIR6bUEa7WEAl3BUct39ORf1NelM8Tk1z78cWxvyLODnUPKB/1fPG+fmCKFKFU
 MA/rVoaIoYHISk9qXYvcMtg6oZGkEA9+Ud/Fs0Z6fqyqT4uOro+R3ag+P4atAu1HKN+O
 pK+rGXrAzmFWO3IQG7AUt8peVZfU7EgN3T+YeMuyNtkx3XttpFPjWdI2XGnN+EqqYyUr
 iSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mmCCdFj+Kaux51WJzT8oE4ZuVYLTS3sQGupMAH0RdrY=;
 b=Bps/yekykR/U3exyCQAf+6bdfj6Hw4nHQWTt8mOnh6kDpy30XD8KcimaZrpeSJ/rzz
 HZJQ8nOrPMkl/Q/NE+AS5ieOrdLQePH5vYRr30A6LxjQn3BEyLFL3Lg3IhKoxtBusZae
 jIkR+mpVrFCXfY7aCDLvLPHy6CbqjIdXNt+rBsHms0x0hn5OABClMUfdGxNHPFnfjbdn
 3q4AIsvDZE3rPSHCBzc2Qe0eIuNzTQjAcF6P1lf4Pk1nARL4Wd/ee/s63ONhEF4FUWzT
 NvYGGS6y2P0lYtdNK0VTWlSH4T+u3HtOrn0zuNE5YanF9BA7/gakYOQUHqHchJzZI5Pt
 6GlQ==
X-Gm-Message-State: AOAM53046C56lTgSxFPfGVqB57Vu6c/SjRm0kwNiafK/rkPx8Spz7X4+
 VuPo+OLIDpW6pi1ly4BJBp3ycGOmSRA=
X-Google-Smtp-Source: ABdhPJyLnAlqJFHF9QbQ+a78eunDspPYaVEcHbEco0wl13ONySK83ScTlIHSH/BTsHZe298fwTV73g==
X-Received: by 2002:adf:e3ce:: with SMTP id k14mr15168005wrm.230.1602254202378; 
 Fri, 09 Oct 2020 07:36:42 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y6sm12504479wrt.80.2020.10.09.07.36.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 07:36:41 -0700 (PDT)
Subject: Re: [PATCH V2 06/14] mips/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20201009064449.2336-1-zhaolichang@huawei.com>
 <20201009064449.2336-7-zhaolichang@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <db7d3c7a-4889-2cd5-9d60-909175917c97@amsat.org>
Date: Fri, 9 Oct 2020 16:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201009064449.2336-7-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 8:44 AM, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/target/mips.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> Reviewed-by: Philippe Mathieu-Daude<f4bug@amsat.org>

The line I sent is:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/mips/internal.h           |  2 +-
>   target/mips/translate.c          | 10 +++++-----
>   target/mips/translate_init.c.inc |  2 +-
>   3 files changed, 7 insertions(+), 7 deletions(-)

