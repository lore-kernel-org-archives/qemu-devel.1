Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB0C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6373820862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrMDTfpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6373820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJVO-0000F4-8n
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJU9-0007ZZ-40
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJU8-0007dw-6L
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:50:00 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:41756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAJU8-0007db-1Q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:50:00 -0400
Received: by mail-pf1-x431.google.com with SMTP id q7so2752430pfh.8
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nbAmRYOxfA7k1SX2rSFY4zTSP5cyUlaEEmRK84BsP4E=;
 b=WrMDTfpuHs4mh0k+11Fgu3FJx4nA/p1vi6Cg7shV0jEInEXle7Y7k1mPbZe/FfUjLo
 buylNTxlG7lySuFAIp4NQeecF+TZqWwHnA6er8bm053t5TD6uRPJh8Jbg33CbI2a9BxQ
 MfwTw5GVhNvugvGGdfo1uLGnZbMm1+R+vDj27aECXMJy/7Q7+/WSDpbh64VDNk+OmWwT
 iZLnM7ZtVTBA2Txk2WsDBFikAvvuvrXH/NerOIIVZQZIJ0quTLnfN7jxmRgiN3epiMBW
 tmd00/1XhaAIkYS7t5qpYwi3B+eAposW9ADrdaSl/p5IgwrbS4auyECtqgIJjSPcGJmN
 VmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nbAmRYOxfA7k1SX2rSFY4zTSP5cyUlaEEmRK84BsP4E=;
 b=i3NbAzbW8ICzDIl4JD/PV0MgwivZgN7BeZB/0yX4PVTtlEzOwumaUOL1zESTIH6TlV
 sAP22HIGSqsbT1RDGgdDJRQAH8d5AqtQL7ep36m9w5SY94MGtROFyI5ZqZbVFfuBcYAv
 Nbk8oiOdyARLyBLp9u4wBRmSrCjho+Ol864u0n8yJfj7nuNayNbd7XLyXFBZs+ubQG4z
 KmxqN9gpmciZcki1J/tqWfEohlqItvdVCyCf+I9GJgdRzWgcJBN+eIRj7Djv2nygpgJT
 fkEQHYWsrP9s9/P53dLF0jyYCGAXaXxn/io1iATe6fNars0IJSknb+MCUmVM2afvtp86
 9r7w==
X-Gm-Message-State: APjAAAVz1A96eOG1FxNErA4b8XyIkt0M1Mhwm8uKV6ojhA9k607/vRG7
 +XAVaJxfR0ys+qqDz9AambIoh4e09WejIg==
X-Google-Smtp-Source: APXvYqwtssx0wp1N5RxV+P5a29Zs0r+YFwTyUcWQjVF8JuN+x+YOyEQTh7Zh80AXYEeclkf4LFWD7w==
X-Received: by 2002:a63:4c5c:: with SMTP id m28mr520915pgl.333.1568749798644; 
 Tue, 17 Sep 2019 12:49:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s73sm3261748pjb.15.2019.09.17.12.49.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 12:49:57 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20190917184109.12564-1-alex.bennee@linaro.org>
 <20190917184109.12564-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <73df6b9e-d096-f58f-dfeb-aad0c8e50d39@linaro.org>
Date: Tue, 17 Sep 2019 12:49:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917184109.12564-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::431
Subject: Re: [Qemu-devel] [PATCH v1 8/9] tests/tcg: add generic version of
 float_convs
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 2:41 PM, Alex Bennée wrote:
> +    for (i = 0; i < ARRAY_SIZE(round_flags); ++i) {
> +        fesetround(round_flags[i].flag);

If we're going to make this a generic test, perhaps
continue if fesetround fails?


r~

