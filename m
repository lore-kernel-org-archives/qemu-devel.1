Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19D5C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F4220665
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQ9Ubn+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F4220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htD1M-0004vm-Oe
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37582)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htCxb-0003CQ-NO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htCxW-0006aU-4B
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:25:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htCxO-0006NB-A0
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:25:32 -0400
Received: by mail-pl1-x642.google.com with SMTP id w24so32368791plp.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gCM1I/MqAWRzSpFbCXcbrgopoWvXgui2878Yjg73wPs=;
 b=AQ9Ubn+ZiCp6wV9SDhwU290EEQ3gqqnWY6q3QiHOXHOFSws/6KPH/Py0AvloJ2oOiw
 gBVcW7gOw/wKlU2F1+OJxfOCqZuCR/KB61xz1up0eGPQ6J9n97mBR+pzXuhzw7yTAUcv
 kRoXCLzQ/S9e70TQQ7wwLdzmqK6icPk65l9kuPOxRPU4FMOGksiTPBuyq5pKWCef8/g1
 mxsqzl5g8fJvg+aLgrcdy4o3zVJ6A8YOk8SXy6/NrF71wud4vLw7oDb4oZYJcPaKB6i9
 acxCLyutlJQuHFW4LrG1YB5l2WqiGAlA4BmuPNmE8B6YB8ScgQZIB3g9ZJvSaFB0fv2p
 3fnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gCM1I/MqAWRzSpFbCXcbrgopoWvXgui2878Yjg73wPs=;
 b=ATB+9Rlc0CNtRrD9f00cP0QPtFhXL4oll4XoSjvXP5FjjLakhsRI0F1WUF5lDsnfVQ
 LP5BToKwBuVvV8fHAoNpjukISskv3qY5FbB8RGxDJ5+t1jL+4MBeajtLRPBzOxjmBgHX
 3gF/GBaUGsh+7xYzuAmknL0Gf+yfvqa9fsOm0SAH3+9ZkZ/wBE6SnwMKT/pakT5L5adB
 fyU4Afk4lFcRqCSe9SZv66mDzUJhCR8cCL9pfz0NU0T9g+7CQb1rzRgpXDMLN0lJPX9p
 DrCzauCDhewBrPzt48sIb6Jl6PFpnQE0UzVKkFI/M+06byV1eUAdRnTBIhCVz8t8zZhU
 ob2g==
X-Gm-Message-State: APjAAAUuf9CymRNXT9V/dpVLJ/S8V78tjj5T/6pJbN64Eurt2uhNZlIC
 BTdWNWObBS65XrYordjXjdHMsw==
X-Google-Smtp-Source: APXvYqxTvsdDACu037ZKig2bruA12RouiA7I0QlOCjd8dOTsD41MWD9ErnApQZQKsuNK9RELPb7Qig==
X-Received: by 2002:a17:902:bd06:: with SMTP id
 p6mr129888332pls.189.1564673106890; 
 Thu, 01 Aug 2019 08:25:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d8sm66664711pgh.45.2019.08.01.08.25.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 08:25:05 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <865def91-1140-f62b-c3c7-db08eba1cb66@linaro.org>
Date: Thu, 1 Aug 2019 08:25:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v4 10/54] translate-all: use
 cpu_in_exclusive_work_context() in tb_flush
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, aaron@os.amperecomputing.com,
 cota@braap.org, bobby.prani@gmail.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> tb_flush will be called by the plugin module from a safe
> work environment. Prepare for that.
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/translate-all.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


