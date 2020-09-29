Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8467C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0979820897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL1ayDDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0979820897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCLA-0001Rz-W5
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNCIO-0006oR-3N; Tue, 29 Sep 2020 05:51:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNCIJ-0008KK-Ne; Tue, 29 Sep 2020 05:51:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id k10so4631766wru.6;
 Tue, 29 Sep 2020 02:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3wKhAnfsqGMoQNrr+7FobEXUOX/yULAy0h+HY70NG4M=;
 b=rL1ayDDVcHQXGYdRloLOB6xW3hS905NDLd1rqlGnLSTtdF3WAjWv9cxIPHqOHnZYEo
 PIvr1eEj35jju1Xt0zilhAVZxSaMbb2s0hAkt2Uprr8fOtm6cKOLEXRhimK8j4svWz+6
 Cy56Hq/PdtqQ6lbAxCNdGB8dzvyeYO8d1Rb2d1upNn7aDh6QPjEpJApeVVjerLy/G0Yg
 FQr0S3oZzxxhMDvadO2JB/60Ssc4I5XZr28rui5qEjv5HQWu2T729eH4nEt2E2KJbsqN
 hGGXqG3XU3+zkhNnVDmK+X2N+79PyOmBx3m5JiK2cbDbEXfyvLdgiJvCcUfb7Qr1OEzd
 4gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3wKhAnfsqGMoQNrr+7FobEXUOX/yULAy0h+HY70NG4M=;
 b=d+358cVTmUojgWZNVythYuaUms9PgvbdSf+KD+qg0Lf0TZgfjnANiDoa0gSLYFLOo5
 G+ZdB1yrc6+QUD31Uo3vottozXeLxuowmLYX3aXfo3OZntOpvxwkHwB1t1K2m52eqK0M
 fQM8UVtVTBNmUcEA6j2x5nqhNZCidnywdk9jlQq4q+ypVQVDHr7r1gLOB8gK0+OnIvaM
 mKUGzXhhPI2HLSdxSmqDI1ZTprKKC/Y1MvVFBRG1YgspTbKOPSZKvmze1Yeb3d4ZugEP
 u6ERSojQD0PxsGV/wLLK0E2BcTHP2goTw9n4PC/egusDO3ydJL/hzjt0Med+wzS+8CTC
 pu/A==
X-Gm-Message-State: AOAM530cRoNbQQOP+inD7abtzA7CDm9GFrEQbtKtE/ZK7WftftJz6x9V
 rBCDNJ9fGog+j2Qcz9Hi5/c=
X-Google-Smtp-Source: ABdhPJyfDqCVIgbDGl9ElZRoR0P3ouR8MG+oQ3BhKH7SOIG/cw3j0mZISQABleYvk/gZVlhEM3pQLg==
X-Received: by 2002:a5d:4842:: with SMTP id n2mr3314854wrs.260.1601373092602; 
 Tue, 29 Sep 2020 02:51:32 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z83sm5050385wmb.4.2020.09.29.02.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 02:51:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/arm/sbsa-ref : allocate IRQs for SMMUv3
To: Graeme Gregory <graeme@nuviainc.com>, qemu-arm@nongnu.org
References: <20200929094251.151722-1-graeme@nuviainc.com>
 <20200929094251.151722-3-graeme@nuviainc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <644e6a2a-c71e-365e-50dc-ad098e115713@amsat.org>
Date: Tue, 29 Sep 2020 11:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929094251.151722-3-graeme@nuviainc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
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
Cc: peter.maydell@linaro.org, jamie@nuviainc.com, rad@semihalf.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, leif@nuviainc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 11:42 AM, Graeme Gregory wrote:
> Original commit did not allocate IRQs for the SMMUv3 in the irqmap
> effectively using irq 0->3 (shared with other devices). Assuming
> original intent was to allocate unique IRQs then add an allocation
> to the irqmap.
> 
> Fixes: e9fdf453240 ("hw/arm: Add arm SBSA reference machine, devices part")
> Signed-off-by: Graeme Gregory <graeme@nuviainc.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/sbsa-ref.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 47e83252c1..9109fb58be 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -138,6 +138,7 @@ static const int sbsa_ref_irqmap[] = {
>      [SBSA_SECURE_UART_MM] = 9,
>      [SBSA_AHCI] = 10,
>      [SBSA_EHCI] = 11,
> +    [SBSA_SMMU] = 12, /* ... to 15 */
>  };
>  
>  static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> 

