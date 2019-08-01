Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC732C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B4E206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUn6KRgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B4E206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htHfJ-0007hZ-KY
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 16:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htHe6-0007F4-Tv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htHds-000693-T3
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:25:44 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htHdo-00065e-U8
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:25:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id b13so34706556pfo.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tdH3f1+wXtBougQVDrm8mP/yzoAdeXgP/sV8haVVlJM=;
 b=bUn6KRgUfhPo7YHK0EQITboy5nO6qV6WMIrpdUCP3297cQd/uL96TfU+SGMhkwzcM8
 9Yw6qYimb1KEHadTMy/k6f006iH7BPRjYByCJ4bpKoPV1jIEd+n4xw2xiqUu7/kGNCmF
 1+rUaaV80z9i3kPeBsT0RbKcIo1dTMbE9xsYtuSvSK8XDUsg6HhD1D3GRc1ZFplBVjhY
 1sboVQ1s/N++o4gfNsnAPE63MPM24udcixNB91ZLXoOSzr6c7SbaGU0zSGpkSj8QF0pf
 aliXf40AhlsIvI3relv7BqDoqm9PiPStQKK5zxIgxU4G4ez2ail7mxkvSUhu348nJzUG
 65zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tdH3f1+wXtBougQVDrm8mP/yzoAdeXgP/sV8haVVlJM=;
 b=C9VvM5feH+KqfKFMY2Zk6y1teLoQ5c9Q/UVQJjukxn+vw6PmexuMmJNMoDSXAy+NFv
 lJhSvGHpAUCssEqmKdvNFZnwGDPB8nXoxMkpbwgmuWeW82SgNoxxtJsfg0gMI+1ECz/U
 unwihoE0Tt9GZAkxBYtAILVtFt7tkbqmTf78u7HkCDNLCgU8rfZRJCOguvEU+u6/YVnP
 6pLZ5WOSt3WSq6dUtYNG+NhVn3pDKPNxx6gO3u2Ek7/fWhVTkMFlI0AQwtG1kEuCHGof
 CSAOTbN5ImrebwK1+hg6f1oTeikAIeArmqOeGDa4tbsRB9D2x8cOHE4vf2Eft8BS8sOc
 splg==
X-Gm-Message-State: APjAAAXVe/kChG6m1ua3PWQWqNcRq8LkSKpVcbfI2crutDu8lAYocX4A
 8XY/VjDmW72sDzsTnPAjyygp7g==
X-Google-Smtp-Source: APXvYqxSvtMl56z3IyItdE3SqtcMn8aX5DizdpANF2xCjKLraBpFKXMP1cTxgaPVzIQPk5vVlGq7vQ==
X-Received: by 2002:a63:6686:: with SMTP id
 a128mr112675722pgc.361.1564691133811; 
 Thu, 01 Aug 2019 13:25:33 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a6sm72128170pfa.162.2019.08.01.13.25.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 13:25:33 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190801183012.17564-1-peter.maydell@linaro.org>
 <20190801183012.17564-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e13f1849-39e3-283d-1d7b-01959b9d0ff6@linaro.org>
Date: Thu, 1 Aug 2019 13:25:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801183012.17564-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 4/7] target/sparc: Correctly handle bus
 errors in page table walks
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/1/19 11:30 AM, Peter Maydell wrote:
> Currently we use the ldl_phys() function to read page table entries.
> With the unassigned_access hook in place, if these hit an unassigned
> area of memory then the hook will cause us to wrongly generate
> an exception with a fault address matching the address of the
> page table entry.
> 
> Change to using address_space_ldl() so we can detect and correctly
> handle bus errors and give them their correct behaviour of
> causing a translation error with a suitable fault status register.
> 
> Note that this won't actually take effect until we switch the
> over to using the do_translation_failed hook.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/sparc/mmu_helper.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


