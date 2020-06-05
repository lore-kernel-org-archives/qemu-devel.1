Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30B8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9096F206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Osz5kDSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9096F206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhKFk-0002NU-So
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 17:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhKEs-0001on-HX
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:50:58 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhKEr-0003Uq-Pk
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:50:58 -0400
Received: by mail-pg1-x544.google.com with SMTP id o8so5776247pgm.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9OV9OAscxuTsjxbuT4Qg6j2sOXUOYfZroOrORki3r5g=;
 b=Osz5kDSGr4mWhGDgmXpE5BchahKld2jMb+L5OCKtP+NB7+Pz3HDjMrOiUA2Qn1KV+S
 hJfl12NZ+ThS/eTMhQbvbPRp/5mruSDC1Nd8jObTOPedS265SDoZSb8FN6jKi6ZsL2bO
 aXElHS6YJx2Ly882zBuaFaKppmfJidBD4XkiNXprEvGEH1UXTvGB8+1tdlKMV5Pb03eI
 cpiNl+9w9sz+cgXUGlCp1h9WXqq72Edf3QkpMYkZzo7eOzQuDKKOhCsvHk3p8kVWfsG6
 15OUuzUwiYKXypN+OwV4yVLI1Fb1+OpK1U5o++bXt2dWang6rP5Sjp2TNHncFB08YsHY
 xJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9OV9OAscxuTsjxbuT4Qg6j2sOXUOYfZroOrORki3r5g=;
 b=Gc9hq6cpqNlknNJI9RORovViYP9txmdDLBWAidOBEd7tIqcowuot582dcIrAs8ecKh
 qiRAGLHqZUr3zC58zdIoHciPSm+HeoiW3t/Lr3d5N5xyKEhPmwUF0YW34bWaJYcchmSl
 POp7KAfwLGNokvDzPocHmWwY7CQLPCpUi6X9cnsrcU/qmVMa0Yp+hgM7D0tL8qoo3vXA
 RBf7niwhll8THjFJ1n4JtqPJ8WIV2uczUNFmuKuKWpOqGYwH94wWQaNkDJErBEh4At/+
 bWsoXxGF0fS3w7wSN7/wJP/WyVz6tAWEsDxq1KOjeo9hRszVgMqmTAoX+MPmRDCUU6YE
 kpxA==
X-Gm-Message-State: AOAM5319K3ftVu1HTcppQ9ZKmyoX60l1ptgvrOQ07CabAxnz9aPObspz
 DL6ajQ5DhROnMR5UpomeUIpk5g==
X-Google-Smtp-Source: ABdhPJxZuTBaZ0aDMHA6Uuu10lI2QwJkMhPTXBaa7vMRFK8p1YENVHCF9H2jHE3IRHU6i5ky/iJd0Q==
X-Received: by 2002:a62:ac0a:: with SMTP id v10mr11898516pfe.27.1591393856228; 
 Fri, 05 Jun 2020 14:50:56 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id t2sm485464pfb.64.2020.06.05.14.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 14:50:55 -0700 (PDT)
Subject: Re: [PATCH v7 04/11] rules.mak: Add strequal() and startswith() rules
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200605175821.20926-1-philmd@redhat.com>
 <20200605175821.20926-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <719e7bef-10dc-dac9-ff90-eb944903cc36@linaro.org>
Date: Fri, 5 Jun 2020 14:50:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605175821.20926-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 10:58 AM, Philippe Mathieu-Daudé wrote:
> Add a rule to test if two strings are equal,
> and another to test if a string starts with a substring.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  rules.mak | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

