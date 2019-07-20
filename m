Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76614C76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 04:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40CB52084C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 04:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfeVQUOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CB52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoh0q-0008Hz-66
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 00:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39463)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoh0d-0007hu-QK
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 00:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoh0c-00086h-En
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 00:30:11 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoh0b-00085I-Cf
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 00:30:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id t16so14984657pfe.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 21:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4noTVdIajPcc9XWgg7e/MG+1pTdguJ909Gz7msr7+Yo=;
 b=CfeVQUOWcY0FZvnnqTRQJI0Cl2E0lq2iF2moRMG5DP/IbWxM+BTqMqfNywbhxUsZBu
 qniBpGBvOkwYTjwkjfLqIf5++umE2xLTkTMoJirW19ncnqpHDD/KZxhQ7UhHXRiK5k7b
 yzEyqg/7Jh1HCAql/l/ekl2+ToEBmSME4DH8DuIc+Rci03lldwTmMi7qfiOxVVxTORxV
 utKz5TrZBmJZftQjb/Tds6PBKeeArK4oBsShpzcku8VBySQDvB3/SmJ9cnbrbVioCU/8
 SOq7opn0Gd2pmcuLX35ooGy1iShPAg4Ty6K9V+LKL1jvI8r7vlVgGp+t7dtKHsodWvOq
 qw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4noTVdIajPcc9XWgg7e/MG+1pTdguJ909Gz7msr7+Yo=;
 b=G6aYiLrLf1m03aCg9lKBTkdnKUNnQjxxy/wahJcVqjI7TPioXebWFsVUJDAQWl4Dtp
 NQ2TOQn5WS8qaRwefhAKLrgg5r69WSe12Y2JvHLqfyNKyRsEnnLkgb10uinr83E5kkkU
 bCMqXZ0aI9pIVrB9DyCW7ZEdJ1v+GOZoeuovgxZ+dqbLUg8+hlfWCT2E25oO2yH7LGc5
 z/++G22AxOMGbUoXZqerYs3bmqTAhQZ9rSWy5ORz67LJrxCfe1egCZKcKRLvq0LrxYAT
 zawf51r6uUjwxV0jZwP6CHfdfNyHYISAY3nw3y8TsD1eDwBJBajRoryzGcc0gway6t3A
 m3IQ==
X-Gm-Message-State: APjAAAWV0HroThu0QFxYP5vve7ocjoKEjijzCunHJiboccB3ZHVP66Z2
 iVFuKoT/cwG6mQZpptFnUh6bow==
X-Google-Smtp-Source: APXvYqxGrjZKjGF52X3pa6obewgq1VJe/Ks2X1O90C7QwRn5j38NkawB7jNf0fpBWZVYtix8hsQ1ag==
X-Received: by 2002:a17:90a:8a0b:: with SMTP id
 w11mr61671536pjn.125.1563597007785; 
 Fri, 19 Jul 2019 21:30:07 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id a128sm32991022pfb.185.2019.07.19.21.30.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 21:30:06 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-11-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6bdee2da-23de-0053-9046-c54be9c533a4@linaro.org>
Date: Fri, 19 Jul 2019 21:30:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-11-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [RISU PATCH v3 10/18] x86.risu: add MMX
 instructions
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

On 7/11/19 3:32 PM, Jan Bobek wrote:
> Add an x86 configuration file with all MMX instructions.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  x86.risu | 321 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 321 insertions(+)
>  create mode 100644 x86.risu

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

