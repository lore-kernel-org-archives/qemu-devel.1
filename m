Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B70CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A791207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rqopixxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A791207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxuj-0006Ni-Dk
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 23:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxuD-0005xN-In
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:59:29 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxuC-0002HL-M9
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:59:29 -0400
Received: by mail-pl1-x641.google.com with SMTP id x18so2728586pll.6
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=DTHwC6UnzfDqKrXHuiclko5o+CDF4Vfd4WOgyA+EcnQ=;
 b=RqopixxvuPUwKZqB0FuPzFDs1Dfgl0Ezz3Lcv1QVmXu+BlZgnTVLjAI6DQ9EykqPrA
 c4kHYia1naDUVeALZsKbLZm/QY5NMrhGAgf1S3bucU8m+aFkU7ZxeEnCcw0W+w36rHzA
 CvpdF3yECZASpUh+drgr/XgtviOmHTw5IAypV3v5tDZ6Sc8rjAOELiesufVUHLA7urcE
 y/AquH5x/9VrJHvfseqM0JLb7OzQcR6Bq7/obp0dCChAuIJX4BaRTFA/bl7RaybJlPg+
 JsDDPIJ8+C3RkfSE9yZEEHJ+M39HwALmNW7FUI1UYyZpT4QwoxqSnqSht9eYXqxD5jXC
 dywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DTHwC6UnzfDqKrXHuiclko5o+CDF4Vfd4WOgyA+EcnQ=;
 b=ZoRfIdduPBi8dkhvAVE/YrYEmFF5YLNXLew2ZYwrH8QT1m4U90Vesgd9VCA2QK1Dsa
 zLzHMmRhdcufcCwn4jLxoVc6kds5UHVX7q4Nf0a07YRKSbPhBpCX2vD8PV8qWYkAGNa2
 7bO4Fvl7PGO2zOSlQAQOKWcyU3fqnLoBEj0iHgZhA5/SxLwIlqfbMqfbgYdClw8EXNV1
 gjQHcpCjYxVZCMD5SMpLN32gFv4bfgGEZ4b53YzswKP+JZdGjUO069sR6DBIj3TbeTHD
 tcGIVGfbgn2KbXaLvpx1CmNE0kGua+7UnM5h1Q1NJPSlJpJS2DTdwP0HC047x5eedVYO
 oNjQ==
X-Gm-Message-State: AOAM530CXlXNgfAlbo8zWPQPhD+4iD9Z3X4EowM8FGpFmnUTYkzyWbJy
 tgU29BrJ2fkty7KgdKvilrtM28Ss3dY=
X-Google-Smtp-Source: ABdhPJyqv0kvnWn0I5jj77tKIdUfyPWMxhoLbXEIdf1vVchdvuXq6mM5hXzkzeFFEjjMD7uLDJVmpw==
X-Received: by 2002:a17:90a:498d:: with SMTP id
 d13mr1771293pjh.43.1590116366830; 
 Thu, 21 May 2020 19:59:26 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o9sm5747664pjp.4.2020.05.21.19.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 19:59:26 -0700 (PDT)
Subject: Re: [PATCH v1 05/15] tests/fp: enable extf80_le_quite tests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200520140541.30256-1-alex.bennee@linaro.org>
 <20200520140541.30256-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7d65c2ba-7a4d-2842-1f36-7440109ad257@linaro.org>
Date: Thu, 21 May 2020 19:59:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520140541.30256-6-alex.bennee@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 7:05 AM, Alex Bennée wrote:
> These have been fixed now so we no longer need a special version of
> the le_quiet rule to skip the test.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/Makefile.include | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

