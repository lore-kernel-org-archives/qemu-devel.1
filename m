Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B009C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3E02064A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZDF4WlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3E02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49384 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHkP-0007L5-5q
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGDO-0003a9-WC
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGDN-00045B-MJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:51:34 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZGDN-00043S-Cj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:51:33 -0400
Received: by mail-oi1-x242.google.com with SMTP id u64so1641328oib.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uZoUAwCZM64CjI/sYBQ//kI4ibpdbMr/7i8IhdgNm3A=;
 b=VZDF4WlYJTRaCqvdraypaPV4CKl5rOpJtzu1ExmYRDcLJ8l1hiO5H9UPsTk1uNN8DP
 ZZUmI2D4k91OGyMEh8PoJ2uCmGRxXmAlZeIjBGwp3RPcsp3YSCb2T7w7LrjujSjsv7By
 3xwXr9MNd9DpuoKA5O4XuXYjKiHvx2oCi7Uq1F30ZC4N19MfVj1x/Yzmia9sYWPfP9C3
 88FqTHQliavw5VcAFoBmCXv7w7KzIfYN/7CP7ip0wokJ3lIw3FfndDJpynQbfgvLL/ce
 tXtUIi+d6F6WvqN2MRojFFmdyrMBie9A/6uyJAVk14ZXl1BUbXdlJkYG3E8X2Jc6Cf3Z
 DM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uZoUAwCZM64CjI/sYBQ//kI4ibpdbMr/7i8IhdgNm3A=;
 b=Kp55Zjbu6cnf/UE7F0NuJ1ULtD2RWFAWeQ3ac+b05X9K2yQPgQIXE0In4Pf+yK2f0Z
 3R4wZaFNoXzGMjMS4siGtLtvp+ofmVbSD8wl59sAkDk316QEyeu0F3w15gScCsmWd7zN
 DFnC1SzjU7YvIu3Mub5Pu6hgaKmyyejYcgGwrpGgc9zKznMOM5ICbh58j1KNg9euT172
 6Syc7q5qObTNqCimGiPmWheqBqbCgIlxKHCxYLDf9SZFTzdtZGjRiaGgYOlc9oJgDkas
 3xS7dxEUlJhtNAw4jpOlaRxatLp2IEzPzgVkIb330WkpKUhHkuyWPdebmofEXaNfShgU
 bUVQ==
X-Gm-Message-State: APjAAAW/h56MpGrVcdX5ieaszX0evPIszXY+hCCanlG2s2zzL4e9fjI6
 NMqf+mbPUpJWCUCQkNVSqUvDtkFMtMrA7Q==
X-Google-Smtp-Source: APXvYqwm98d2E/LTFW4q5vG3+dvtKPK0YrbWV3m92yeD8S2j4o6xog+zJDn5/X0kGYUjgYBhk+4CKg==
X-Received: by 2002:aca:3256:: with SMTP id y83mr4170162oiy.110.1559919092220; 
 Fri, 07 Jun 2019 07:51:32 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id r205sm773727oig.0.2019.06.07.07.51.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:51:31 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e264d4ee-e712-0d11-a368-1268d9290db3@linaro.org>
Date: Fri, 7 Jun 2019 09:51:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 05/42] target/arm: Explicitly enable VFP
 short-vectors for aarch32 -cpu max
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

On 6/6/19 12:45 PM, Peter Maydell wrote:
> At the moment our -cpu max for AArch32 supports VFP short-vectors
> because we always implement them, even for CPUs which should
> not have them. The following commits are going to switch to
> using the correct ID-register-check to enable or disable short
> vector support, so we need to turn it on explicitly for -cpu max,
> because Cortex-A15 doesn't implement it.
> 
> We don't enable this for the AArch64 -cpu max, because the v8A
> architecture never supports short-vectors.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


