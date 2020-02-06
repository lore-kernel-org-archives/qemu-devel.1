Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ABDC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA44206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGsOWJRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA44206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfDP-00080J-NI
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izfBl-0005wz-Tb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izfBj-00020Z-R2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:19:17 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izfBj-0001us-Ik
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:19:15 -0500
Received: by mail-wm1-x343.google.com with SMTP id q9so5872705wmj.5
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vN17QQ69gIBf8TKYtcFphBWXeRO1Dk7l8wmh8+tw57s=;
 b=iGsOWJRIruUVA9SDA4Qz5bK/11J2n7J5dtrZx4Zr5brQqsmGmmevbby9mVI7mUIfIf
 /4LYO0vSLyOLVG3BoUx5tJqujVKc8mUPhMIl8tvEpEYkETER6wT9Bx+z5yI6JlF0TJua
 Z1206Wqco2gjcm7BC1IZOEE4l+ag7VixekjTK6X9TJcQmlHApyYrHHHExjnZaFt98l+Z
 gJpAe7wxRnmi5ueJgPBQD+lqm7/Vhs/bWksxRiPOyxyBMBBZUqbG11UGqYm7tm+UygCr
 l5/YrgKdw5Y0mILQIbDhvJ2qouRcHoK+As9F/R8IdmIkFocZpKBd5llbT5Ufp5gF+Fbu
 E0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vN17QQ69gIBf8TKYtcFphBWXeRO1Dk7l8wmh8+tw57s=;
 b=Wd3WLeTdP1xlmdVFJd1pSuax2yUrPt7YH+BV+Nhq231KsHJ8fmcmrdV3HrVTyzflks
 4fpJMSCyNgRmhwqlzV1iKoE8o/EbiqXnfxhCLdv2g/43tJZWg14td42xSd5i3OUVcPoa
 30M7esS5cSXPFHvY/z9MTG1ZtXXWu/l5vdHKem19w+WVrhtIcYgVjFRcFkmYbyrkW/Pu
 bgipNkBzCtGMtbzYU9kioxablvRipxYHTj4mJzp0v+blcYiLOyY2l9hpJUbC9TNkFFxU
 KDusJ3TlkfkvXTKs/rzXzj0JWSOMgfVVXE1dQUnewGQXzVKSJusSr09w0EcpUMbeuYSf
 VPig==
X-Gm-Message-State: APjAAAU4GV3n2e3r8dkj5afWAy2gOsRyK6i+Ldezm4oHhAzgIlNwdBdZ
 joqpOBxTE5DRMT3FZAQN07+wpA==
X-Google-Smtp-Source: APXvYqyWDpXZe2M/Kgjd60DJW5qJf1clk0L194BGElg2EKik5Lh9TlREmulHXTbWnNge5Z/xXtUr+w==
X-Received: by 2002:a05:600c:2c08:: with SMTP id
 q8mr4090137wmg.45.1580987954335; 
 Thu, 06 Feb 2020 03:19:14 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id 16sm3349261wmi.0.2020.02.06.03.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 03:19:13 -0800 (PST)
Subject: Re: [PATCH v6 12/22] target/arm: default SVE length to 64 bytes for
 linux-user
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200205171031.22582-1-alex.bennee@linaro.org>
 <20200205171031.22582-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d7dff4d7-f8b6-d8be-76c3-386896d1a7f7@linaro.org>
Date: Thu, 6 Feb 2020 11:19:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205171031.22582-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 5:10 PM, Alex Bennée wrote:
> -        /* with maximum vector length */
> +        /* with reasonable vector length */
>          env->vfp.zcr_el[1] = cpu_isar_feature(aa64_sve, cpu) ?
> -                             cpu->sve_max_vq - 1 : 0;
> +            MIN(cpu->sve_max_vq - 1, 3) : 0;
>          env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
>          env->vfp.zcr_el[3] = env->vfp.zcr_el[1];

Let's reorg this to

    if (cpu_isar_feature(aa64_sve, cpu)) {
        env->vfp.zcr_el[1] = MIN(cpu->sve_max_vq - 1, 3);
        env->vfp.zcr_el[2] = cpu->sve_max_vq - 1;
        env->vfp.zcr_el[3] = cpu->sve_max_vq - 1;
    }

Using the MIN setting on el2 and el3 was wrong, as it meant that we could *not*
increase the setting later with PR_SVE_SET_VL, at least not without changes to
linux-user...


r~

