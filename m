Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACA3C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22312168B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDFKXo6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22312168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aib-0004qA-UP
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1ah2-00044f-OM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1agv-0003W8-79
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:55:31 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1agv-0003PZ-0p
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:55:25 -0500
Received: by mail-pj1-x1042.google.com with SMTP id gv17so1632263pjb.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CrXYayQlBzAnDNIH9v/PykxwmIx73+zl9SeUi1W1THc=;
 b=kDFKXo6U72jz7asislCYB8xyb5faQYupFWSud9ziim9y3tjRoLHHogphq2e9E19/+0
 h13JYPyXTsPjXEzU0wwLfE7zYWWm0WOaf5wxl0TUGLQcBFc9/KIGFBK3PCQbFI7Uf/zk
 1kl8d28zav83P6Sj9u5dGnNbzhZIPVg/kTwYNv/en8054XCX8D0eB+/DeRToYbS1Rw3k
 j/kh9js8tUnIRf1WrqHHMD9iOStF+Rwz6aXpRemvoH4wLYR8Ktdo04LGY0QCXnsvsC32
 jkihaQONYiaMHyrckYu/5cd2caBrHqfR3ZOSCvV8rLcg3pSpbJ8JJOzmyfCXsD1tDyx5
 b31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CrXYayQlBzAnDNIH9v/PykxwmIx73+zl9SeUi1W1THc=;
 b=YR285c/euOP84jBTyNrB0h+ZCerGdUbWU8a5M0C6wTdxBcBGx0btOHRxXRisHAKJnv
 1+/4Is9Aj2GzIzp65BHEi2eqzM4innuWlgx/nUCZPahC2N+lbsxAnahMoB+GskV1R47X
 Twc/Cnkr5Kl7lsOcWZwyxSAwmQ+a0NSHvcnAekFpNIWDR+ywd93BWEhJQ7U/FrjCyX7T
 YNOEUrkuZea5rIBV5ynxKNqniRlIbKAw4VgPSfeohz0NIfmhV6URGqPcAKMo61FHWGTK
 0NFKH8Rj5OEKMMIBctTRheRyPGCtcqxCZh81ofBMeDeO83dE9cspfvquca2TB0TBmVaR
 YsGA==
X-Gm-Message-State: APjAAAV+G/DvbFvxMBFLBevgndq49pwUR39npwkmiMzxIrGpq0NmuD00
 hRKVnkztcWHZFfpLYhkSMsXPamhO8IU=
X-Google-Smtp-Source: APXvYqw6Opy9yIfHYzBpr27o9cVt7A6IiwAwdeBrGKLJeghJZza5MIhHkcbCYfZDOp5FHZaC/tPRjg==
X-Received: by 2002:a17:90a:bf0c:: with SMTP id
 c12mr4954034pjs.112.1581447318919; 
 Tue, 11 Feb 2020 10:55:18 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z16sm4996348pff.125.2020.02.11.10.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:55:18 -0800 (PST)
Subject: Re: [PATCH 13/13] target/arm: Correct handling of PMCR_EL0.LC bit
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <059ac7e7-c4ca-7456-69f7-80c3cb2cbf09@linaro.org>
Date: Tue, 11 Feb 2020 10:55:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 9:37 AM, Peter Maydell wrote:
> The LC bit in the PMCR_EL0 register is supposed to be:
>  * read/write
>  * RES1 on an AArch64-only implementation
>  * an architecturally UNKNOWN value on reset
> (and use of LC==0 by software is deprecated).
> 
> We were implementing it incorrectly as read-only always zero,
> though we do have all the code needed to test it and behave
> accordingly.
> 
> Instead make it a read-write bit which resets to 1 always, which
> satisfies all the architectural requirements above.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



