Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC4C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CBD208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aj0BE/p1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CBD208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52340 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0HA-0004sz-Pt
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0CX-000062-M3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0CT-000852-84
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:34:08 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0CR-00082Z-7J
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:34:05 -0400
Received: by mail-pf1-x442.google.com with SMTP id r1so6414898pfq.12
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1Hqv4VPArfpAPGS+fuKf+LlEvW4vDOArfPs296bOIhQ=;
 b=Aj0BE/p1G6cN1PS175l+geJi2rVRVS2p0Z0MjVNWizGnLvOO4vq3HYxKqEGBXVHu5x
 hRJ18q3b1QDgwB2tyiiSqbXbebijilXEpFGSbQAzb92QcTpfJ/8qQcwGBzBU4TLjkcqf
 ytxhJupM/VwzER9RXnczRN7mklxXaV2F/7N8qSGEC46sbVHkFSADs8qwSKBp6KN9D5l7
 nJcVL/29bsny4A/UjDOTJIqK2jLQ9Y8cFIXtYih8bRsrxJsm/keTJSqknM/p0S08Hcd6
 mKdLgZR5UBQMpioO2o4DPssWK0Lb0BWNQ0Q3l6e11OTquu0nUVgeeyGaRmoC8OnDjyvV
 LZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Hqv4VPArfpAPGS+fuKf+LlEvW4vDOArfPs296bOIhQ=;
 b=fMOs+yA+F3r4ubTzhZrrbwJyVNuDd9AUZ9pN+KmX2exb1BpXMQd2/nc/Pt6GWvZhT+
 PQKEowMcWsvXq++fbIPm4QummsHVnzo8OPonY/7dGYj1+yvDolSSwNQJbZcP3ibnpA9e
 TkDjyJl3CeOvzwzcdMn+HXOSuC/jGyN+859PV1gk1fdkHJhbGUy4IeW3itDDO9bx6wb4
 ThOrjUfPz3kMhb4znoFZKXvWbqNP5pe+Jjm+ATn4qPKaNcJKP/2ZCKu0P7gzHhyfw6SR
 zi9+fVZQD6PVpAiCLBefd8v9wisbs8Uh/xxkg2IT8AGJUHhEOJZJIece7PXmE62NPwJM
 PeAw==
X-Gm-Message-State: APjAAAUEjWvTxk4zFNu9ngA0k5r0GsIV9R0Wj/PffRdpW9c06OYPrg/S
 /nonB2znSpk0kByySFJdx0XQlzK0GF0=
X-Google-Smtp-Source: APXvYqwf+eIaf9bLeYYsAWGBJow+6PpnUvZd+DDIUWWJLcxpa3TcXQMO4mIBDdU4ozQX7ozG9odrMA==
X-Received: by 2002:aa7:9087:: with SMTP id i7mr58846773pfa.40.1560810813696; 
 Mon, 17 Jun 2019 15:33:33 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id a16sm19304017pfd.68.2019.06.17.15.33.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:33:32 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-29-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <06ba6178-2ebc-a7ea-7b5a-70920ebc5506@linaro.org>
Date: Mon, 17 Jun 2019 15:33:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-29-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 28/50] target/sh4: fetch code with
 translator_ld
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
Cc: "Emilio G. Cota" <cota@braap.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> There is a small wrinkle with the gUSA instruction. The translator
> effectively treats a (known) gUSA sequence as a single instruction.
> For the purposes of the plugin we end up with a long multi-instruction
> qemu_plugin_insn.
> 
> If the known sequence isn't detected we shall never run this
> translation anyway.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/sh4/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


