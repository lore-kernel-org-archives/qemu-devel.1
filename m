Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BB5C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 18:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142E82084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 18:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRWyFxa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142E82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7lDS-00056B-1m
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 14:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lCm-0004eY-SU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lCl-0000f9-9T
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:49:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7lCk-0000dR-Vi
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:49:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id q17so17044578wrx.10
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dFXsR9v128NtnMafXXiFpsrZ0nj1ZH+ugNm81Pc+b2g=;
 b=HRWyFxa0GXLyF+e9DxGoRjSq/xXa4az/Sr0xZ5GLlvE1aAUYvH6wFjrYr6c5tw3I2B
 uykQmTJ1bbnvZpVNk2+tCLmVJNAmiLg9n8ssVmnNQEwxATgoE6fH3QV7YFnF4v1jX41K
 rdqw3yrIhgaFgqJMUJ0kCeCa652j4Bb7QFAa5/rMJZc//XRzFrHK3ZhYGsqv3af6jDEM
 faWk/VX9AM9SRbW8n0SIM2deuAj//CmH7gGqvEZp+PH3FLZMqYhGSVcWhEcFuqVGlMhX
 b7+ApWGu6l5RKKtKRQvAk/V0wMEt9KDwV9xFfrKetDnqhS2TCJCdZNVcX58z0BjwDrWs
 Hifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dFXsR9v128NtnMafXXiFpsrZ0nj1ZH+ugNm81Pc+b2g=;
 b=XlBpj/rfGbJMylbk7TSPC97g6tgUgjMHU4jKxSSTZ73JO01BVTa1o+aDYDNRQEOwR7
 qzsVc2w84wa17KI2LJIjStBwz5jOz6JrpHb1I067MAU9aw9u5YemHENS681pxCUeRH/K
 PLX3AgcN3nSbgCqnxt0dsEp7vIV3iY34LYlw9rucA9rjk+gTbMoih9zsV3rTpgNCIsCY
 4B/8iEsYHsftgJEdp2UrnuTk5gGmL49d5SQmdNoxuOLtCmoUwYxNhQ/oK92SpgIqFUux
 dhhEokXLEw71rqb4cqaBmS6WuJbApCgFm5yuRdPeyYWBUUtWQP8hKenTjLsvXKGbJNBl
 smNQ==
X-Gm-Message-State: APjAAAWRFksSPusn6AzDxL0PQM3QyRieE/ica/RXzlgolIGLOzV9X1cZ
 Ngty3Jc9mND4XD3x4sOfiX9Xig==
X-Google-Smtp-Source: APXvYqxL7D3yPnCGwaaRCbFtYfQuGYR9H4HyKCeXepSRNjLEBH80n1QreB1u/iwbJAjbcQ7omAthpA==
X-Received: by 2002:a05:6000:188:: with SMTP id
 p8mr422160wrx.220.1568141369089; 
 Tue, 10 Sep 2019 11:49:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s3sm295167wmj.48.2019.09.10.11.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 11:49:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9CD211FF87;
 Tue, 10 Sep 2019 19:49:27 +0100 (BST)
References: <20190910120927.1669283-1-maozhongyi@cmss.chinamobile.com>
 <20190910120927.1669283-3-maozhongyi@cmss.chinamobile.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190910120927.1669283-3-maozhongyi@cmss.chinamobile.com>
Date: Tue, 10 Sep 2019 19:49:27 +0100
Message-ID: <87ef0o0yx4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/migration: fix a typo in comment
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
Cc: tony.nguyen@bt.com, armbru@redhat.com,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Mao Zhongyi <maozhongyi@cmss.chinamobile.com> writes:

> Cc: armbru@redhat.com
> Cc: laurent@vivier.eu
> Cc: tony.nguyen@bt.com
>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/migration/stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index e6c9a6b243..4bc3a249e6 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -194,7 +194,7 @@ static int stressone(unsigned long long ramsizeMB)
>
>      /* We don't care about initial state, but we do want
>       * to fault it all into RAM, otherwise the first iter
> -     * of the loop below will be quite slow. We cna't use
> +     * of the loop below will be quite slow. We can't use
>       * 0x0 as the byte as gcc optimizes that away into a
>       * calloc instead :-) */
>      memset(ram, 0xfe, ramsizeMB * 1024 * 1024);


--
Alex Benn=C3=A9e

