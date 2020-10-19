Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375E1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F14222D9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mf32AJSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F14222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWXX-0000LP-T0
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 10:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUWVi-0007CM-N6
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:51:44 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUWVc-0008BX-LQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:51:39 -0400
Received: by mail-pl1-x641.google.com with SMTP id p11so5089812pld.5
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C3d+9lAkjL4bgsA9015fd7GqTqKmrYxUnjVp4gP/DVU=;
 b=Mf32AJSaxAb9a7vIHNpmmJGAG8kgn8vFEQOtouaxdrCmnBdnu5Bvbg1daQFzJnLRLa
 Pm78GNYdLntY2QcMNgdUT8cy0fQIlAqGC80Qqa72Y66obsyIOPHv+7jKhs4QO2AOz5KI
 FhBlgLjz12Kuc3VNI5yNbbx1whmovKyYSS5D8yaYStt12PTely11q2bSvjDfNLDdalN/
 WMnyC4scNpOcsypvuYu5ASvVTGxdKPRDdzH80W7oyoe21zJm1s0tXccKa0EdD4RNDbyo
 4Ej74BmQZRWvNMJwAww6xHRl2CrGz0My9qdJEkyOu1LleCmOwaBCNfqqeDae3D4gthgQ
 H/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C3d+9lAkjL4bgsA9015fd7GqTqKmrYxUnjVp4gP/DVU=;
 b=LzIWzVAtwpG3A3DkHwIOkut8VREVMu72igk8H0Fv3JxH8ZiV+xbcZ8Q3oF/TXlEf4q
 ci8dWFhi45FdAVOng6EdQPnnbLmfuExkwABEqR/nPQqc4B8iQ7xAIuTHTO4YGX30JPGq
 wB3ocQUlq7KzXFY3Kylb69LhD9zDdXyQ20IlUuibU/xj9WF9ltY2/Wswh7qh/yBRhRGp
 3CPKJspRYj7vkKWY0uDtaJIhFx04Djjybo/KsuaJUydbYjVqoyWBDVhstvVGDBXNa/fR
 t7aklsXwFvUONS/07U6+9kQqxAXdOGP70Yje4ooDnf5FKkK4D+uFw+zBGEbHb7q7wV7f
 CyKQ==
X-Gm-Message-State: AOAM5314gc2L5g6qA7ySD7VPScSyIf11kq3t/BTtxEx6j5FsUPj10akl
 GNCe0giaIxYyGJ2saA/+2A/gtQ==
X-Google-Smtp-Source: ABdhPJxpSTq0sQmVsUkdC5QUG5NJC21g3eBKNcmWkyoV+THny7wtpE0Nmr2hXj4T33KzzT+vOfpHpw==
X-Received: by 2002:a17:90b:e13:: with SMTP id
 ge19mr119746pjb.175.1603119093238; 
 Mon, 19 Oct 2020 07:51:33 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id g12sm129664pfb.170.2020.10.19.07.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 07:51:32 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/nseries: Fix loading kernel image on n8x0 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201019095148.1602119-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f6ca56ef-d0f7-d059-e4da-5f729650c1c1@linaro.org>
Date: Mon, 19 Oct 2020 07:51:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019095148.1602119-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 2:51 AM, Philippe Mathieu-Daudé wrote:
> Commit 7998beb9c2e removed the ram_size initialization in the
> arm_boot_info structure, however it is used by arm_load_kernel().
> 
> Initialize the field to fix:
> 
>   $ qemu-system-arm -M n800 -append 'console=ttyS1' \
>     -kernel meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0
>   qemu-system-arm: kernel 'meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0' is too large to fit in RAM (kernel size 1964608, RAM size 0)
> 
> Noticed while running the test introduced in commit 050a82f0c5b
> ("tests/acceptance: Add a test for the N800 and N810 arm machines").
> 
> Fixes: 7998beb9c2e ("arm/nseries: use memdev for RAM")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/nseries.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

