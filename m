Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0226C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8379206ED
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fPxw2c5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8379206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aSH-0001Hs-P2
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aQu-0000Fk-Jz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aQs-0007bE-5E
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:38:52 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1aQj-0007UN-7l
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:38:45 -0500
Received: by mail-pj1-x1044.google.com with SMTP id j17so1612015pjz.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bgRe39UrkcomXY7L1G7morRvB0wlq0CEf4d3hqQT3SM=;
 b=fPxw2c5lGZAyzveefWmZxHefL+dty2md53xGCW1WYhSmfgT+sgxcF8NH0GPVL9tWhR
 T/VSenqLMI07/f4/AN7cR71g2y9UqpJLpSi3ixMbuhBEDdiAMrJSkbv0It+TaDE7mPKq
 KPnNhEFrqiVA5aOGPJAOiAySeoGFEoin3TB5rsTaGJdNbqIGc2gZXBYCQancYeJ6ZDEi
 /Lwa7lTMz6JsQI+m1gly5QvdUq4SZt36Tc9qHfwKoloEkgvzl9WHooINCKu/UAfOGi6B
 tu78hFJ46YDYyiCpYOo33nlfWf0q/jxFu/IvWNvj2pzJ3phbecwCHLbw+uvOEBES0mDq
 civg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bgRe39UrkcomXY7L1G7morRvB0wlq0CEf4d3hqQT3SM=;
 b=XS/CpgtJV1WPfoEVSXlqoYIz09AfAcPsLl1scr5JNVVK1cL9uqkkwvKkUUCHoYEq4i
 vcBjchR1VuTIovl3kWQfTjyP4GR7LcVlFdsH2ZGsOhWkXVoz4NklL51yl7HdmuKkXMVl
 tWnAP3QCMW5ejFXyztLWdzhQuZkr9n7MSz8AGFVnwLZkXwSaWMRtNMZXotYC9K9sTpbi
 fBg+cvU7MIS1WgfWLrLpGniFyIyNsDSAmyMe0CwKvuGirVsQlRNOAAu/RywvGCnGFtsm
 JBojyymRK8WN9aVT7XxrFnWE1S0JC/KC0u+TSbdKVtIEtg3RiR4Y1iuhw+fNc/1Eua9z
 bUhQ==
X-Gm-Message-State: APjAAAWnCIOzsAimBqBGqhDITNPJ1oGAJD6J6LpXKmFhBVGKTSzsVWO/
 1GGVkjNYjB6gWYD8ADgIZ9smRQ==
X-Google-Smtp-Source: APXvYqy6giOd/T9bI26+Uzl1tsQ9jdxIGQCqj7VzhbBDLOIOct3iJXEzGzy6D33ZMUmRspKYgmJovQ==
X-Received: by 2002:a17:90a:e397:: with SMTP id
 b23mr5032255pjz.135.1581446319768; 
 Tue, 11 Feb 2020 10:38:39 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z10sm5133184pgz.88.2020.02.11.10.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:38:39 -0800 (PST)
Subject: Re: [PATCH 07/13] target/arm: Define an aa32_pmu_8_1 isar feature
 test function
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a95c4d3a-792d-4725-25b8-88967aedcc55@linaro.org>
Date: Tue, 11 Feb 2020 10:38:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
> Instead of open-coding a check on the ID_DFR0 PerfMon ID register
> field, create a standardly-named isar_feature for "does AArch32 have
> a v8.1 PMUv3" and use it.
> 
> This entails moving the id_dfr0 field into the ARMISARegisters struct.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      |  9 ++++++++-
>  hw/intc/armv7m_nvic.c |  2 +-
>  target/arm/cpu.c      | 28 ++++++++++++++--------------
>  target/arm/cpu64.c    |  6 +++---
>  target/arm/helper.c   |  5 ++---
>  5 files changed, 28 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


