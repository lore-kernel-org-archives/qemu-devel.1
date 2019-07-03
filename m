Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76519C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419C0218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qz3tDa/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419C0218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihL2-0002FQ-Im
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42976)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hihKA-0001a5-2d
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hihK6-0004o1-5j
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:37:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hihK2-0004kl-Dl
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:37:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id u8so2915128wmm.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6/g+clbSiYPNa757ri5gkl1BCA8m+0Si2U/6vy8Kpw4=;
 b=qz3tDa/JaZtj+V38VWBmyVVmHtJgG49RA7gqF5T2wdnd4iSlxhtqsN5uslhsbe6b1q
 uIgw1hMq13VcoyHmTGgSa+rNv4+g+YasfRqmVQnkgx/g5DavbWQ8UGxYnPc+6IIZZqGl
 ZsXNK84digAx1Xsn1ZgIt3yGQ8g5BbG3rTjbgJrRktpmtFJEnT+pQ3R8rMFIucXmVwrY
 3/oh991Ia8pTJA+gv+NSri+Q/k46+/NcaigSoA/Q1LP8KoPBm+1EtyV0Kpg26EcbYuD3
 gSOWwWGJRMb8aVxxSfiHpab/7zmbyCWpx7kLhK4ec2JgTL2ch8pgjwJR+LyHA3Pruuim
 7gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6/g+clbSiYPNa757ri5gkl1BCA8m+0Si2U/6vy8Kpw4=;
 b=MOzJ71bVWhlongb/uVFfWTnaedepGR/DRA6f368Xni+WfRa1hsh4kTE7F0pACyfhaG
 h92GOnd+DAFEFLZfDE1ilNGEd4ycVqDRjXs8ECWAEEjxmnqgzKlGc1aseYd9VId/smbb
 PvCQlScgH66tiBYZ/P17i+pvMDWB4C/l1pUsT3mmvCggpPv/4gD85uAbJaJzJppw0nwt
 yq08sCf709sZImWWWKX4xakbTDijU0dtYal7Keg3b8m6n83InYXFa62KiKQrV1+kASF9
 Wzh7KzOTtoO2QPK/3DMw68NxtAiLeNYVu14rKu3AZ4QZiQ0gP0rFb6uvzJTpaE8NA5oI
 LYIA==
X-Gm-Message-State: APjAAAUyJqrDCaLSmHnds1WkRoQ6x8YtOM7ePwzhHz50vav1z3pLWRW5
 T/k81d2Lyk2InD9qmHtfFfFqPQ==
X-Google-Smtp-Source: APXvYqxLqWO3V3kCWZhIpZ/t0xFgt7hnaKrM1MO10J47Sc2N45MAX9mmKQWqgYdATlcZaMB6ehgUBA==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr9048397wml.124.1562168245023; 
 Wed, 03 Jul 2019 08:37:25 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id g2sm2935095wmh.0.2019.07.03.08.37.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 08:37:23 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-3-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c98ee4eb-44ff-83ff-6fc6-5f97174b0044@linaro.org>
Date: Wed, 3 Jul 2019 17:37:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190701043536.26019-3-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 02/14] risugen_x86_asm: add
 module
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 6:35 AM, Jan Bobek wrote:
> +    VEX_V_UNUSED => 0b1111,

I think perhaps this is a mistake.  Yes, that's what goes in the field, but
what goes in the field is ~(logical_value).

While for general RISU-ish operation, ~(random_number) is just as random as
+(random_number), the difference will be if we ever want to explicitly emit
with this interface a specific vex instruction which also requires the v-register.

> +sub rex_encode(%)
> +{
> +    my (%args) = @_;
> +
> +    $args{w} = 0 unless defined $args{w};
> +    $args{r} = 0 unless defined $args{r};
> +    $args{x} = 0 unless defined $args{x};
> +    $args{b} = 0 unless defined $args{b};
> +
> +    return (value => 0x40
> +            | (($args{w} ? 1 : 0) << 3)
> +            | (($args{r} ? 1 : 0) << 2)
> +            | (($args{x} ? 1 : 0) << 1)
> +            | ($args{b} ? 1 : 0),
> +            len => 1);
> +}

Does

	(defined $args{w} && $args{w}) << 3

work?  That seems tidier to me than splitting these conditions.

> +        return (value => (0xC4 << 16)
> +                | (($args{r} ? 1 : 0) << 15)
> +                | (($args{x} ? 1 : 0) << 14)
> +                | (($args{b} ? 1 : 0) << 13)

Further down in vex_encode, and along the lines of VEX_V_UNUSED, this appears
to be actively wrong, since these bits are encoded as inverses.  What this
*really* means is that because of that, rex_encode and vex_encode will not
encode the same registers for a given instruction.  Which really does feel
bug-like, random inputs or no.


r~

