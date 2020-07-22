Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A485EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B221206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cf5GjXqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B221206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHEn-0006yq-N3
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHAE-0001xX-6H
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:00:14 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHAC-0000S6-B1
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:00:13 -0400
Received: by mail-pl1-x642.google.com with SMTP id m16so1209764pls.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HwiPq/ihmkuTZzS34G1uHkCt279WwS3EykSqYSI2CKA=;
 b=Cf5GjXqmGrl2ZJH+D25FSq0AekilrTEdzbkXapw9vD88+e1Jgfx9N5IEWVetV9qplW
 qw+RKAJy69LcUdbcFSBoHUIox0Vba9SndSoZ4olwio+UriB0mZDq4S6eDSiaSMFgv0WU
 EyuKJWipnqUD0Ii5SgAAVJ1gRnbAt2B+l+ehTTo8Qibe88FpENhH5FaDwxpg7MmAW1Ff
 lxRWpdhS6rB/HzTODyWeGkEYfe8HRmuWrQ7rIziMWZ7Vr5KeeqVhpYkqjJYmYYlslOXa
 EwOKSKGbB7K4FHZja0uP9DacGr/xCWX7oEJSSO4W+VS/k+5wRlRPPLJrTh8/PNi42eow
 ZCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HwiPq/ihmkuTZzS34G1uHkCt279WwS3EykSqYSI2CKA=;
 b=VeXVzT+zwnQ5n2O+Suutjj7NJl2s7gL4IGO28QnuGd9U+J78PU+2BEyMohVECvUIpT
 GIQqwf0Elk4H9kZrr9HpvauXTijtGIMUHYwq/O6ZN9U/sqdCi7N4QjsihG+gQH0aIMsy
 J39G6KA7bhX2YvrJhY529WdkTHO0MV5H3wUi+mBUUFYlWrMX+2yiZGwLj49UB7vHQUVF
 p7pmCTgvtEy+oQXdV0JPgTcb/TOlBj9ttAD6FDh4BnTrhH4NEDGVytgSnxttANr/bzT/
 pRjUTvp00x3V845bCX7QQwYMP91FVB4jlUt/g1RHzkgenvFFEoMK7Vq2o9B+ZUD96LZb
 NJGQ==
X-Gm-Message-State: AOAM530gVU4FMiqsFEl435Q6Tf/Drrth6aye5PPAyY+CmCGrKeQUsQFE
 ouLtWEnZkb0ZkWbsQSyOW2e9pIjUvKo=
X-Google-Smtp-Source: ABdhPJyO+0TPcGNq+a0mnkJXJv/y6WDRrohtKeuvp08zdnFRNdLd+KWORTaIPtmCISpU34QOYSasQw==
X-Received: by 2002:a17:90a:338a:: with SMTP id
 n10mr128901pjb.50.1595433611003; 
 Wed, 22 Jul 2020 09:00:11 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 n137sm3964pfd.194.2020.07.22.09.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:00:10 -0700 (PDT)
Subject: Re: [PATCH v2 08/12] linux-user: don't use MAP_FIXED in
 pgd_find_hole_fallback
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f2f95833-4989-3df3-bf84-8a7017bc7683@linaro.org>
Date: Wed, 22 Jul 2020 09:00:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722062902.24509-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
 Laurent Vivier <laurent@vivier.eu>, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 11:28 PM, Alex Bennée wrote:
> Plain MAP_FIXED has the undesirable behaviour of splatting exiting
> maps so we don't actually achieve what we want when looking for gaps.
> We should be using MAP_FIXED_NOREPLACE. As this isn't always available
> we need to potentially check the returned address to see if the kernel
> gave us what we asked for.
> 
> Fixes: ad592e3
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/qemu/osdep.h |  3 +++
>  linux-user/elfload.c | 10 ++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

