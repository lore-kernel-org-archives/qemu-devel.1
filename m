Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B55C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED9220774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1a+vwpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED9220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6d6z-0003gF-QE
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d2h-00055v-5t
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:58:59 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d2e-0004hq-IC
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:58:58 -0400
Received: by mail-pf1-x443.google.com with SMTP id 74so4815458pfx.13
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SGEvOD8Sdst9ffAcqV6LmcnUv1ddRcdN8gMCw99PDzw=;
 b=Q1a+vwpAONyi/CqsphmqSMRg1+dL+hte9B9+XycNvBHX3uZHFqLsQu3gX22WmFbRoT
 jbPd/hsbCZKS7PqP+xkFG9fVS7A9okJL4q7ilMFBu3r2TK2AwRjOpzNkYrcJunwax4D2
 F2OauWlTt0R+4Wb8u7HcQDiwgdwvYvbq2akNFbs4S2doEhODsUoJxA3gBffbqFt/a2Yu
 w5+QeQqFrmnXef+LbkM7DgcdYxPG29hoLFDhKoNKJ2Osp3pFm59HFl7rKm5FbKwudgKJ
 2sYNTjDwleI6SGfLGilzoGHz+SbmTO3o0SuhHDWXVXTw7Agu4OTVCo/WllhQc3D8jva/
 xCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SGEvOD8Sdst9ffAcqV6LmcnUv1ddRcdN8gMCw99PDzw=;
 b=PWPrXSDP1XjfBZ5N/2WGl78X8OnACOsL4dNP+i2ncY3Ke/DOIeabGyEAbzAZ7P5X9s
 67LAeuj6soMiwupDUGAbwJZ3E9tEeEmAT/j8J1m0i5MLBg/TcWblkLatcfTRRZBwVpkF
 /HeAyhEiWRZWaZtHYu1OWXs84VOsHo/mHz84rp9wWAO7iFt7K5LvHo+JNfjJMfQGVFLO
 XPwghQ1PombCgkKLKF4YIKrgIf+2LsETFqdlSimGQzAJR9V5HU7rjsf0efU7Hps1UFSN
 GslB3ComVRXrikUBSevzUzTP9w+2gL2xu4NhlwpltXMevi05N5eIKkgvfOY4cMNKby2F
 uLkw==
X-Gm-Message-State: AOAM531QuvOD5GAaCodmXhE6+K3MxheqkhG99VrSAFy9/cyoIn5qfndL
 CxhCrEYz5eV7i3csFtk8X0HeCQ==
X-Google-Smtp-Source: ABdhPJxTMAQvdU04RcPD3gFOD5hzq3rOJqs0V7KIq7BXMx7Pqht4PHtAVrZpMTev1vxU668RT9f20A==
X-Received: by 2002:a63:571c:: with SMTP id l28mr2454923pgb.168.1597424335308; 
 Fri, 14 Aug 2020 09:58:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 196sm10149127pfc.178.2020.08.14.09.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:58:54 -0700 (PDT)
Subject: Re: [PATCH 4/7] hw/ide/ahci: Replace magic '512' value by
 BDRV_SECTOR_SIZE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-5-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13250cf6-516c-2e05-a6ae-15e40dc97181@linaro.org>
Date: Fri, 14 Aug 2020 09:58:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814082841.27000-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 1:28 AM, Philippe Mathieu-Daudé wrote:
> Use self-explicit definitions instead of magic '512' value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/ide/ahci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


