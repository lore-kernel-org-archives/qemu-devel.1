Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8FDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8FF2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRrLP6Zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8FF2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUNT-0004cE-TM
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 13:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUMW-0003SY-2u
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:41:33 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:52432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUMU-0002GJ-A9
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:41:31 -0400
Received: by mail-pj1-x1044.google.com with SMTP id gc9so6886604pjb.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1TDrNTkhB473c5qVYfwnXP6IWa98wganudA4OflRNVI=;
 b=lRrLP6ZsOoXQWnq4tI6G3+KMQAU/J+X/p4Z1icfMXnArh/0j3gtZsjH3+vQK5EDb9R
 tYneJKw4igFSXNe1F60/cjAcYCrEloCLX3h3ICKzKQcv1zo/iiFUlQ5STWjt/8ck5AMj
 nMABe+pep3mGk2g7Fl2woIDmP1frEGnDUMFtE5LFxXUd/76UoKfG1t7Z84KtzqCepUkE
 4eWn2IrqnGUcGt4oO0yi/TYGQ+arp3Gl2H2dS2hVjqmdPTJCZw2ycNGqP+fxHJQJqTkf
 vurlg4CjM5rbjdjkrz/epVNnCiTtwJuyElXSn0zvFJQwOpud5/s5YF6WbvvKcbk4FAfP
 M7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1TDrNTkhB473c5qVYfwnXP6IWa98wganudA4OflRNVI=;
 b=CEwxLf09d3LnkgX+Redyfb1isv7LvMF4b5jx/FXgXOuSGE7cytg1UHKb6KOamf+c/v
 6DWUtiV6GJtx36Jld0FeRNqNcQ5j/J0kto6mVih+slFVKj7dP5fk6QOf8nv1zmk9jxJh
 xji431uV2rw3Y/OQ2z1Q373Sz7an12vYY6pWfC/LEepuKQfDzP0nR2qIn2SBLm/JZ1XW
 PPDdI2CnrNDbkhs6+/Oo3Xa+mgtgnrX1E+KUukLg3u13CxQM0Rjgo0mnUGOpLTaNCztO
 huUK8QJQn1ZIq4MaXmK9iLKLosoxhY1hVPVcNvSB0r5WQD4UXOXCvG8SsRCOonpxpl0b
 7Yxw==
X-Gm-Message-State: AOAM533BBaO8I7YXf4crGHMlRbcx3P+NHD5sabi5VFWPKz1I2NdzEN4o
 3s2+ZZTAdaE0ChkEA0jkM6lp9w==
X-Google-Smtp-Source: ABdhPJyABpkdt+/XQ61LcmTRaKxIkkI23LXY5XcSI8lC2enq4JA2sIB6ACGg1p01nQDft8g6cy9z8Q==
X-Received: by 2002:a17:902:bb8c:: with SMTP id
 m12mr2117307pls.274.1595007688629; 
 Fri, 17 Jul 2020 10:41:28 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 19sm8258721pfy.193.2020.07.17.10.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 10:41:27 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] semihosting: defer connect_chardevs a little more
 to use serialx
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dc7518e0-27c1-7ae8-9c31-842ec7878f42@linaro.org>
Date: Fri, 17 Jul 2020 10:41:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717105139.25293-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com, f4bug@amsat.org,
 KONRAD Frederic <frederic.konrad@adacore.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 3:51 AM, Alex Bennée wrote:
> From: KONRAD Frederic <frederic.konrad@adacore.com>
> 
> With that we can just use -semihosting-config chardev=serial0.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> Message-Id: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
> [AJB: tweak commit message]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  softmmu/vl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

