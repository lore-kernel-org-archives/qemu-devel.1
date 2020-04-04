Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9A3C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 00:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0206C20737
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 00:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiF5YG5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0206C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKWNt-0006jb-1o
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 20:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jKWNC-0006Jg-Qz
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 20:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jKWNB-0006FR-Bk
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 20:09:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jKWNB-0006Ci-11
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 20:09:17 -0400
Received: by mail-pg1-x544.google.com with SMTP id m13so384680pgd.8
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 17:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=7weIJkauizCAOMV7owXBXKORGxf+7zwfZGH3k846kl4=;
 b=MiF5YG5Ktjpn8rYwNHcnlbdJ6s1tVzciOcqdN59pRiUTPt7T9miWR3g+Q5vEE7hF7u
 DoqvSKFYvnqzogiIzE5OqhLZO5bPD8kEE1Yh8gmqVveOLXVA4lavzHT4OpsBLc6N1Esb
 GMuEIM8Nn1F68q1YCmV1VqwwJlzjFvwFVjT8zdMhyCOiMXHuLtJHl2hOCYmtAW8smeaZ
 O5vhRs1AhYkZ/7t6f3tUNVChDrQ7q62ZYyIZSRHrSTiIVeJt7fEjkDKG1TLXVVNASlQ+
 VrGwlhs5Kj64JhcjMoIBtF741fFw0Y08ICute1694pQDljDaaQ/NZCHkXeAjQYgcC4GD
 l0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7weIJkauizCAOMV7owXBXKORGxf+7zwfZGH3k846kl4=;
 b=R3AZ8U12EVTL8C+mF4ie+aLkUsZlx/jIUt89P+T9ktoBFxoTfatrPYgeanxOaPvnlp
 Tdixyqz+aHAki/MHVAje/rew4nO6aetQmu4LiJVhF3hhoZI3FOcg0uZdZ7kSIrUnlVX9
 0oj38k+AQex3fT2dtbHuzPkmSEHfFo7eVxs5+HNu+yThiFmwbDaeukZnP2Bf8Mmd7D1L
 4FPwnG/CwRgIQZCC2CVS1y+yx5nVOs0hCl2WJ0rYOynPB/6CVXf4H0Ut42Gw+UWblSWc
 vC6CHCTS+M3UP/PjRhMdSRqS023u4pfQBebxyuu6PmTlVE/vYSL/Wl+01Sd4Mb2Bc8Rn
 AGEg==
X-Gm-Message-State: AGi0PuZ2JOr+1px9Zt8ZBMHSBRy20zuRYZ0hxk131h15gtYf28D6qRXJ
 zCEkLH8lIMRiC3/L5UZGRaDTH4xDLhQ=
X-Google-Smtp-Source: APiQypJdVQDS4F/lArA0Mmlxu+p/mt5/Szk3SUFzd5j2ImIpoJ3mEd+Xr7B2vE7yYyW6XAk+jKZBBg==
X-Received: by 2002:a63:7d12:: with SMTP id y18mr10832281pgc.207.1585958955241; 
 Fri, 03 Apr 2020 17:09:15 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id g11sm6245806pjs.17.2020.04.03.17.09.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 17:09:14 -0700 (PDT)
Subject: Re: [PATCH for-5.0?] docs: Improve our gdbstub documentation
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200403094014.9589-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13a1c186-bcf9-bdbd-6a78-4dd8836a3c98@linaro.org>
Date: Fri, 3 Apr 2020 17:09:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200403094014.9589-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

On 4/3/20 2:40 AM, Peter Maydell wrote:
> The documentation of our -s and -gdb options is quite old; in
> particular it still claims that it will cause QEMU to stop and wait
> for the gdb connection, when this has not been true for some time:
> you also need to pass -S if you want to make QEMU not launch the
> guest on startup.
> 
> Improve the documentation to mention this requirement in the
> executable's --help output, the documentation of the -gdb option in
> the manual, and in the "GDB usage" chapter.
> 
> Includes some minor tweaks to these paragraphs of documentation
> since I was editing them anyway (such as dropping the description
> of our gdb support as "primitive").
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Maybe 5.0 material since it's just a docs improvement?

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

