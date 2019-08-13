Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79A2C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A183F2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fhBhaFcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A183F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWc9-0005XO-W3
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57670)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWbS-0004bY-Ck
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWbR-0000sc-Ic
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:12:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxWbR-0000s6-Cs
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:12:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id r1so8620015wrl.7
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6l0ptRCj30COrlTWtl1hf6GFk4UHgRByUENgyxFpSsA=;
 b=fhBhaFcg7sSvUTzMd/Fm4J/ZVqRT+6uToOGv97mGmWwPpcksWUeDicP+eklSfFKGfS
 uKv1TQc7aeM/9qHrE/5tSctSgp05WIGmR/J8VGUw/u7X6n5uToLKJwQjGrxA2Ghv+Wke
 t93EwUSWZrcHuNs7Jdu9spjAH5RDAdXxKRQZ5caeCMZGICwAItq0FcEYx+w062PrOJhW
 kabkKHVqJoX25hAzzxPR/X4rC1XVa4y9OQhUlL75CqzQmCkDNAljoeetHsNXxbxAwxuh
 /IB+RHh9VTOkpXw/RLF8JCL1topu/2iwpCMARU4Z867sC70VDDUXH6lQuMqIjkGoO0+2
 1D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6l0ptRCj30COrlTWtl1hf6GFk4UHgRByUENgyxFpSsA=;
 b=nuQt6AdNOsFA5vdVymD8sshHrMjWt3m17j+z/pwewaJMZtasPZV1bt1gUxS6oIUx2S
 pU7ym13BlkupHIWAKO6e9hAHqXXp6zeDE0kZl71hF9StdHOMGg2w3uB/rTATn1/bzyNz
 V7q0QBSf/sHyKOvpeXCieAoOynzy7x47fLoQeyv8wUaWkMI2WRXSb7/3nlnn/lhpqA+Z
 5ihakqVBlaPMPX+j+Yh7bYic+flVMfjA0FMfxwTN1d6/7xKwEZaAR7xzJ2QdROlu5lQg
 HfRiYldGLQld2IO4mvIlWhLx3Nm9S+DIC8gGd4I89cWRvfMZDm1bwLsxb+9LHq91/OMW
 ApxQ==
X-Gm-Message-State: APjAAAWO82KdMFxXAUWLS3vYMoxbJqYIqKEZRNpuLYJIyN8eocTK1Mvn
 yvyeHEhbkqtF04UbziDNBG+VHA==
X-Google-Smtp-Source: APXvYqw9xSnr6VR84ZLW/iR6GGOFwBcMBRRNqWVs3lvUADBypD3+x886HqysGOYaJPWekG1DFTeqgg==
X-Received: by 2002:adf:ec8e:: with SMTP id z14mr48515319wrn.269.1565701960475; 
 Tue, 13 Aug 2019 06:12:40 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id r190sm3003442wmf.0.2019.08.13.06.12.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 06:12:39 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <60c79836-de6d-37ae-064c-64b11c014e28@linaro.org>
Date: Tue, 13 Aug 2019 14:12:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813124946.25322-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 03/13] fpu: optimise
 float[16/32/64]_squash_denormal (HACK?)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 1:49 PM, Alex Bennée wrote:
> Using the floatXX_pack_raw functions is slight overkill for basically
> just masking out all but the top bit of the number. This makes the
> final code exactly the same as pre-conversion.
> 
> TODO: is this worth it, can the compiler do better with make_float?
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Hah.  I just suggested something similar vs patch 2.


r~

