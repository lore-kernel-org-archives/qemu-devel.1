Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79D7C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723552133D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOyZ2pUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723552133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45798 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbXPD-00024N-Nl
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 17:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51324)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXLc-0007xi-Kr
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXLa-0002m4-7G
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:33:28 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbXLV-0002k4-FA
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:33:24 -0400
Received: by mail-pg1-x542.google.com with SMTP id 196so237513pgc.6
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FWB6SwU2i6bW4tCAqzGhbgtePqP4OCVj2sI0qrB8MNk=;
 b=KOyZ2pUDanB0NS6RRTmeG17bhCEzftjYQ6FIIrOg6wGpJmZKwP18pNX3pa/3/aNS7j
 i13iWg7WhWCKI52yxOnGhLbjXzPnqAOsgAUn9+/lbYMb7SrkwBYR4RXbkjs85l7Fuzxr
 Kio8Gtthy7YkW6QyfRkf0xuitucdXcxrrPOqY8HEoFUyYZdiRziii8a4BWWJvo26lHSO
 788+mBeEs9+GrtVfNGJumpPoZYQSgpq1MQe7qn3l970mMLxbxPMkvkhYnW7mXBabB4xr
 2IvFyNDDVVyhvVU4x52CHmVbKhJc1PTJRM8Oevpl+ERk9m18EOiVWqU7OX2btLPZjCen
 7bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FWB6SwU2i6bW4tCAqzGhbgtePqP4OCVj2sI0qrB8MNk=;
 b=BGvrgygY9zfP9OdG4Dkmge5UGz7Ns6XiEEy7G3UPaWm8ifugZc/FHAtBzAX0Cvl+Mz
 DKwS6mgrDzwB47iUJoaZY+7I/stf1/D9aWh42Kaz/c6c6/Rwd3RDpWO3KYcbwQlK+zFp
 +W37MFwVfwh+m94Qo2pFl9QGQjkMkcFX0zBOtK31y63b/Vja7X6rdxZO11WJNuWXUj02
 ihNSLgD51dYmaPpM71Qw57dikBYZWIbKCv/PpkWpkkdxYqcBD0nnTeyk0ystTPZmrQ+K
 xBU2FD8zxmWjye0K26wa4Aj60GPkh2AxHxBq/0TLEsx+4ro+FflRVEHsOgTAA2S12pXn
 Cezg==
X-Gm-Message-State: APjAAAX9n5sNc+4KtWAH2MequOntYIzno662VrHOEuNkK/rLXnYs6YDX
 4EepR7T7mMZorgJfgDFhA9/mIYlxexo=
X-Google-Smtp-Source: APXvYqzV1wYbPkhTzhPOaCWAIC5XEW13tPh/Lobae71F914QlvqSUr4zPvQdSpJDw3Ra0HU+uZpN1Q==
X-Received: by 2002:a63:26c6:: with SMTP id m189mr8932336pgm.2.1560461597866; 
 Thu, 13 Jun 2019 14:33:17 -0700 (PDT)
Received: from [10.10.150.239] ([149.199.65.200])
 by smtp.gmail.com with ESMTPSA id g13sm623629pfi.93.2019.06.13.14.33.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 14:33:17 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190613163917.28589-1-peter.maydell@linaro.org>
 <20190613163917.28589-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5e3ecd68-23b5-574f-79b0-53081866843c@linaro.org>
Date: Thu, 13 Jun 2019 14:33:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613163917.28589-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH 10/12] target/arm: stop using deprecated
 functions in NEON_2RM_VCVT_F16_F32
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

On 6/13/19 9:39 AM, Peter Maydell wrote:
> Remove some old constructs from NEON_2RM_VCVT_F16_F32 code:
>  * don't use cpu_F0s
>  * don't use tcg_gen_ld_f32
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


