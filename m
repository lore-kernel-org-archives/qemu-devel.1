Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA656C4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708DF2189D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2oj1J3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708DF2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJTB-0005xr-DO
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJQR-0003lR-An
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJQP-0005hq-WC
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:46:10 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAJQP-0005hT-Of
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:46:09 -0400
Received: by mail-pg1-x541.google.com with SMTP id i18so2529975pgl.11
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 12:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pCvB+ztKeOZoegWLKI6FHVrttgtkui0XKV3KuK89r9U=;
 b=L2oj1J3QLPHzj+D8yfPf4nGiOITeqqIXRJ2ZxNJb/0N0LGagu+NwMVaYND2jKGYTn1
 RJAJ2jjI1wbAstdeT2JIcHj/W7Gp3BO28aeqdWODiYTBzvE/+fzZBM6UD5Wewnu5Y69E
 P4W/u63ECSjGqA2SKKyO6sfoS8si4xkgpAU+TvRZUySEKDaVGVkn+XaJ+l8idljgBa+E
 0XIpF/lWadJrA1qd7z7FW5nra+Ffr/VVclKlPckboVSteyxC7yYdQbCWKQQGrXlTxYYP
 iIZQmpepbyEmANeAJTYyKo6S+FV4zs/22qneRmU46MaY5Nh1dIAPh26Q6d4LQHkQh7zj
 UuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pCvB+ztKeOZoegWLKI6FHVrttgtkui0XKV3KuK89r9U=;
 b=m2DxnHNfDYnLM2JjWopeEtzR8apYAROqNNIOa4eVOJ/SbRqWXd34pUDe03hp0sWktn
 lHTnlPcXxkW3TXqw3hgSByrebEP+pIs9Eixpjl4suH+1jl5sYeZyd3dMz5WteHUoE/H+
 M0q84mZ8oDUFuR6Uy2t6LrQJlY4ENl8USHzCcT/eCZ9Ri9jjXrOuLGg1PzckgZrQg2nj
 4MmyCOdGTcRQEIj79xCg8XZvw5w6FuR8bjAtZjFn6SvvpLul1biTjzBdL8EcrFGaxexG
 UcBt6Dl0xNX0j4ajx6xP509LRZHeL+ShPYz0DS2I78YEh+CwchUQwDCGcDLSpvhkgPni
 FYRw==
X-Gm-Message-State: APjAAAVLcIN5QJFDrF/VtxsIbhrxGW6c0fsRrPSJK6vhuDN3K4yG7k3M
 YpQiV0fYrlHZHReWrx6FY9h7kZQegFQHWA==
X-Google-Smtp-Source: APXvYqyA+54f/hQvBsW97e3599EiUGVl7tts2IDt6UPp4NNWtzM107WtYZ/KroExwVTPblC4bN/wTA==
X-Received: by 2002:a63:ec12:: with SMTP id j18mr476699pgh.327.1568749567190; 
 Tue, 17 Sep 2019 12:46:07 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w11sm5614141pfd.116.2019.09.17.12.46.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 12:46:06 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20190917184109.12564-1-alex.bennee@linaro.org>
 <20190917184109.12564-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <afd9bc85-9c79-a456-73c1-fc19e97d1acd@linaro.org>
Date: Tue, 17 Sep 2019 12:46:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917184109.12564-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v1 7/9] tests/tcg: add float_madds test to
 multiarch
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 2:41 PM, Alex Bennée wrote:
> +    /* From https://bugs.launchpad.net/qemu/+bug/1841491 */
> +    add_f32_const(0x1.ffffffffffffcp-1022);
> +    add_f32_const(0x1.0000000000001p-1);
> +    add_f32_const(0x0.0000000000001p-1022);

These three constants do not fit in float32.

> +    add_f32_const(0x8p-152);
> +    add_f32_const(0x8p-152);
> +    add_f32_const(0x8p-152);

Why are you adding 3 of the same?

> +        for (j = 0; j < nums; j++) {
> +            for (k = 0; k < 3; k++) {
> +                a = get_f32(j + ((k)%3));
> +                b = get_f32(j + ((k+1)%3));
> +                c = get_f32(j + ((k+2)%3));

How does this not overflow nums?
There does not appear to be an assert on overflow in get_f<N>.

> +#if defined(__arm__)
> +                r = __builtin_fmaf(a, b, c);
> +#else
> +                r = __builtin_fmaf(a, b, c);
> +#endif

Eh?

> +/* Number of constants in each table */
> +int get_num_f16();
> +int get_num_f32();
> +int get_num_f64();

This is not c++; you want (void) to indicate no arguments.


r~

