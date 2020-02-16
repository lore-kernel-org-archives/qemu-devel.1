Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813B7C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C43720857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yp7Vl/go"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C43720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3GBL-0002Tw-FO
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 04:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GA6-000193-Uc
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GA5-0003gj-Vv
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:24:26 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44979)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3GA5-0003gL-QS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:24:25 -0500
Received: by mail-pg1-x541.google.com with SMTP id g3so7326939pgs.11
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 01:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pLlWQaGDzCWFi0r9a394troLGZ0JrgEBlXUdfdBX3+8=;
 b=Yp7Vl/goypwmpf83SsB4FaZS2upWtUOdvp4WTPMUzjpqe9TvyXhNhfp124seuoKxMC
 pwdfTssN6qx8GwvH9PCn7T44krX8xtt03qO5ZfR5j7Sy1WHgg8e+o3qfAjKk6TsE0Fy7
 fpr1XVFF0HdUB6qy+kD1FzsTEtj4CnGxmMhK5Mo94RCt6Sud4xzpDXTM4mL1R/xQAILh
 8iO/ygoPcv+kAd2jL4K9SS3pYwG1vOtfY5g7ZjKz74JgD1myHZF1NaHl5Xq4QBxozzEK
 1O/Fo0mliMKR5+gUz/zHYcLwAYQ/w2mgTwlHVZoSoifUXICuN18CAuXbDiFEVTZ0BTwN
 z+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pLlWQaGDzCWFi0r9a394troLGZ0JrgEBlXUdfdBX3+8=;
 b=bT6eMfQJqNI7FJ6eqqzO4JBatfPOlnVznopGp7/MmsZSf3ILK+hVjhtkeKDBcbRA/0
 Zn98BQi/iygd/KfmVwsGjTrZ7qiusTp1wsoptLeu+mA8ttrYmSomqAGgE3wRagJ2BWl4
 mER+UfGjBuEZdKL+JG+SKUy9wR5CbZA9yqa1XV/lw1lMka9kNCNj8AQYY8M0B0gIrTJ3
 TeohbqC5kpNsSj6je70hvJmagauEcvR9h46rr0XB1hRs98Naj/2oT4xeiTHAJMnH6QxN
 IYobWz335eMepAWdjEn5ELK4aq9ByahCrfJX2JEJ6krU3s33XQ+tiI9SNFO19Xc+5LOf
 daDg==
X-Gm-Message-State: APjAAAV8lwuNYtPr7yYyrKPIM+m2qDUD+nqn/dY/Mk0pWhSkPEieijM5
 BxT7zg8YJMLLMOBmW7ACb+7fYA==
X-Google-Smtp-Source: APXvYqwES5Y+tmAiafRGIGbabSFPIsCs8VTMshyZPFWLglN7AwxPuadnl87+F1SMD5kZwBCMOHHacQ==
X-Received: by 2002:a63:b257:: with SMTP id t23mr11751997pgo.17.1581845064748; 
 Sun, 16 Feb 2020 01:24:24 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 b1sm13423375pgs.27.2020.02.16.01.24.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2020 01:24:24 -0800 (PST)
Subject: Re: [PATCH v2 18/19] tests/tcg: fix typo in configure.sh test for v8.3
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-19-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c931f47b-553e-6941-2076-d72bd278673f@linaro.org>
Date: Sun, 16 Feb 2020 01:24:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213225109.13120-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com, f4bug@amsat.org,
 robhenry@microsoft.com, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 2:51 PM, Alex Bennée wrote:
> Although most people use the docker images this can trip up on
> developer systems with actual valid cross-compilers!
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/configure.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

