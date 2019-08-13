Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87DAC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 06:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E932206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 06:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3Ou+CJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E932206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxPrh-0007bK-OU
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 02:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49945)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxPrE-0007Ba-OZ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxPrD-0000il-QJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:00:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxPrD-0000i1-J8
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:00:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so106588397wru.13
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 23:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pn4e9cnUJwfFkH6aJcCvQ/UTgsIFnLRFbXFneTEpG4c=;
 b=Z3Ou+CJDjdF4YDfQ75Cmd0tghrvY1o+HrkLtZsVrqLFNWd6i5Amg98DqEV6vhNIQs4
 E4OeikCq1yinQ7e8gZWR+lc1WZbnuMqOiAZE82fFRC+6ec/YTsRH1XbXtc3+uiDiIJw3
 GyJFsgS1oPBqBbgNtw4bCxQsGO7j6S+YH6Y9yVrFm9t4zxhblrzVJupOR5p3IRFxmHng
 j0Rgf4pveIk8PW7hpMQd3TYIcVVREKMhkNNmNh92MaoF3IOhXZ4IwiVx2kjLsYo2jTZd
 CtQ+pxTAXufbH4/f2mnp5vge4HfNYmfmeQJsimIyz2f9p8/Gc66BI+dwWww+F2jUqG7k
 Bngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pn4e9cnUJwfFkH6aJcCvQ/UTgsIFnLRFbXFneTEpG4c=;
 b=ATJx0A8UfQui6UX7FzZnXznuBIdY335343MPAqZZ6JBgV9QXO8xFAWKjXtyr+7iJEB
 V/48DdCL12FAhDhC4JJ0caeGJZAGt+kDFZ8enFIPLsF1ekNrGkYNQc6kEfraJAMVbJ/W
 Uus4CLFlut5dK1IBASIfg4NzfdJgIWR61xn95qO64kqop4Nmob00AWUI+HotPNeFpm2X
 BMNujGzHnnKBqmj+vQzGzxcRNSs3N1omdaD6+P2G6AUnvgOBN5PT0LEDpjsZElCVuNUX
 Ry3TKV3HNjUCLT76IGwKpiRIwxNv/sI2sqAI2dY5isj52RTmyUKpAxKbABZRwLI0WJ42
 DGFQ==
X-Gm-Message-State: APjAAAVhnAXP187rmnQ6ju8lwT7ExXH41hLK8MAw0zU+r0c7LY79Yt7u
 qyw+6BMPkjUHLQdF+qbIGHRY/g==
X-Google-Smtp-Source: APXvYqz1HU7VRkjsndxkba7/RlVwdPp4gYWBbNYuRh1bQZXovShlAbDc4DwJpvBK+3kUYwwXuksJSQ==
X-Received: by 2002:a5d:4211:: with SMTP id n17mr40793524wrq.137.1565676029681; 
 Mon, 12 Aug 2019 23:00:29 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id w5sm454997wmm.43.2019.08.12.23.00.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 23:00:28 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-22-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9610c359-21a1-338b-c727-85ee24549886@linaro.org>
Date: Tue, 13 Aug 2019 07:00:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810041255.6820-22-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [RFC PATCH v2 21/39] target/i386: introduce insn.h
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

On 8/10/19 5:12 AM, Jan Bobek wrote:
> This header is intended to eventually list all supported instructions
> along with some useful details (e.g. mnemonics, opcode, operands etc.)
> It shall be used (along with some preprocessor magic) anytime we need
> to automatically generate code for every instruction.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/insn.h | 87 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 target/i386/insn.h

Things that are included multiple times should be named *.inc.h.  There are
quite a few that don't follow this in the tree, but we are slowly fixing those.

Though even "insn.inc.h" isn't particularly descriptive, and definitely
overstates the case.  Maybe sse-opcode.inc.h?  While it's not only sse, it is
used by gen_sse_ng().


r~

