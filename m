Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB31ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF43120663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7B9W/yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF43120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK41C-0007Ih-I1
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3Ub-0007Y8-HZ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK3UZ-00089V-Hp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:46:45 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK3UX-00085h-J4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:46:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id k20so3076357pgi.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dESNirl8armO28oQGNDfDZ6Ay9I3M9ghXOLXqmDLpgo=;
 b=V7B9W/yzhQ0N8sbYMjv3r9HqtxWGpM4apy5if3Tks7cJoaVRYfnTxr/JVoy3BHH+vp
 C1od7/O6pLle793bYzCmucYdTer6FIk+opr+IOTDiPxNXQdYM+RB2yoy0KkEzIG6ZNfO
 rsWlBVYknh4ItG1lkl7xL7tp/n9vHKsGiuoxVa+U1DDYfvvUTkkF7vTfEGjR0I1FA/6L
 BWQ1ijvEh0v59+L8aokYkJIWrBsZtZbbFyZrtdN1Ftz1G9Zum/4c/O2OIHMFrynAuJSD
 pLEvGSDzStMvx75Pe8hPHq4mLzFS3EYOY6YWBpwIEC9O2cMjw1h1r8B9mkFpcleJiR17
 nUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dESNirl8armO28oQGNDfDZ6Ay9I3M9ghXOLXqmDLpgo=;
 b=C3Fxy3TFAJKY4ZrD2Apz2VCewck9LUDb3cvIDifaTMzjGaRxsOzouHA46nfjy3v/qE
 W16uw9KSQ8cRlNytNt0RV4tsvAEYTL4fv5noXg9wQ0KI/tK+3RdJaALgo7+tGTpzchf8
 uEu86F/dL3J1SInUxUkHlOLmT5mAw5h6p7Z3zmqvGUVoSWY0Xz8wo1X+cwzv8ZGhycRf
 82nnlbwICXmddpIjtf8rGSUuzAFI/0Yiq+8Dr25CzzmNnWKB+wjtr3qSH5RWeLp+Yzsj
 FNZqlSoI5TJxuvD6H8xW21do1tZe5IqSLnAYSAS+bKd8gvY2mhCaPrMVuU8azxsw9j2V
 uzew==
X-Gm-Message-State: APjAAAVZRHcIG0blPW/Oou08uB2wZndwzzE6mFRnpvkIN7jzM6VRD8oM
 7yIUlIDx9mEuosLTluPJTKFYXw==
X-Google-Smtp-Source: APXvYqzWRm8b11ZYWxgFGgsQmFTN2bopbMwiTXNtcg+kCFAe9wk0oC55Y6PqcfAvhvYliYVBqI6tQA==
X-Received: by 2002:a65:408a:: with SMTP id t10mr34474915pgp.385.1571071596937; 
 Mon, 14 Oct 2019 09:46:36 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b69sm24968947pfb.132.2019.10.14.09.46.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 09:46:36 -0700 (PDT)
Subject: Re: [PATCH v5 44/55] tests/tcg: enable plugin testing
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-45-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7b594021-a722-82f3-a1ed-facc0d6bbf0e@linaro.org>
Date: Mon, 14 Oct 2019 09:46:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-45-alex.bennee@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, robert.foley@futurewei.com,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:49 AM, Alex Bennée wrote:
> If CONFIG_PLUGINS is enabled then lets enable testing for all our TCG
> targets. This is a simple smoke test that ensure we don't crash or
> otherwise barf out by running each plugin against each test.
> 
> There is a minor knock on effect for additional runners which need
> specialised QEMU_OPTS which will also need to declare a plugin version
> of the runner. If this gets onerous we might need to add another
> helper.
> 
> Checking the results of the plugins is left for a later exercise.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v5
>   - fix for the latest changes to check-tcg
>   - extend timeout for plugin tests
>   - add special runner for semihosting with plugin
>   - fix naming of test in call output
>   - add special plugin aware runners for semihosting
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

