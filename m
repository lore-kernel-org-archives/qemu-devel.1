Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAA2C4740A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 15:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6196320640
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 15:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMOnsQgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6196320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBhGr-0005sJ-Dk
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 11:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBhFs-00053W-VL
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 11:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBhFr-0003by-De
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 11:25:00 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBhFr-0003bq-7X
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 11:24:59 -0400
Received: by mail-pl1-x644.google.com with SMTP id d3so4581198plr.1
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bB1j4rEX84ivv+h42P8l+qVSUWexyhqEhC3J+SgOpbg=;
 b=tMOnsQgVBpCfUfRMYScX7fymkcPFqIA9N5DoIZfxgGk5bGKn6eEgAukbrVSEWXq2AA
 5Uy24y75Nl5mMJy7+F2KSDMVUp7RsQUXx7azzs/C1MjYSwxZ2OpZtGJ69Uqq6pRUASMO
 vZxUAUNr3nSiXg9xRkubW0y4ZBl2qmczR4T7vmDe/ks8EZC+XW4gWdV6Eqr3ob7ARwbs
 CE9sVDx0hXN7WEBmxrgXWymT5b+3BIxFqr9+uygs0bs7bty+OaHNlCYmZMTJRnvkjvyB
 PqvZRTSmUgAGXJkYcTgLcTu4mA2occx7nmjNFBENVE3iyU/X49xFTdnyWBECS/RiSKBa
 O35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bB1j4rEX84ivv+h42P8l+qVSUWexyhqEhC3J+SgOpbg=;
 b=G/fdOL5fLSWD/1yv2QQS1gRrbanen3HK/Y5BmwYOwE9mVfT6bPy2YSKpI+fnRk+VJI
 cKNM4Iv0ErsJeOH2U9DK8Fb2S3hjWwJ9fquMEtQ3e7oz4Nd28S8nZzM4PwKvnBShhQEk
 ORxRli29HI90NdL/NkOXmmbKu0W2k98KSxM20L0VMTYeA7D8T7oRuhnMfETXLFZr26LH
 nRHr1+vCH/k1esCRbm2oJjiwkERDRa+SxXe1tnYxhzeOhjcqUg5LpEURWnWvAvOOafMA
 QTIWoZ/dPYxxrYepMTXo6mVoSbaK2bblteIN4GH5Sz7DXgFWyJ8VMqeyE/LCWmKsoZzE
 td2Q==
X-Gm-Message-State: APjAAAXtDPJsB4JaFZLu70MzrMmUD0xbwnH206HEaV3cCiyhCIEIZNO8
 ahagivDwRDzu6L7Z1mzJAc7CLg==
X-Google-Smtp-Source: APXvYqwf8dcwZycnHIzcJpGZVDGird/hnP2CEjP+vThHBA7ZTEeSfxwSKpd/D//sNf/WVAEVrQZEqg==
X-Received: by 2002:a17:902:9f91:: with SMTP id
 g17mr21261100plq.298.1569079498074; 
 Sat, 21 Sep 2019 08:24:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i1sm10824936pfe.136.2019.09.21.08.24.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 21 Sep 2019 08:24:56 -0700 (PDT)
Subject: Re: [PATCH] hw/m68k/next-cube: Avoid static RTC variables and
 introduce control register
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190921091738.26953-1-huth@tuxfamily.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e27eb89c-433f-add0-b9db-43d77a83ef49@linaro.org>
Date: Sat, 21 Sep 2019 08:24:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190921091738.26953-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/19 2:17 AM, Thomas Huth wrote:
> Coverity currently complains that the "if (0x00 & (0x80 >> (phase - 8))"
> in next-cube.c can never be true. Right it is. The "0x00" is meant as value
> of the control register of the RTC, which is currently not implemented yet.
> Thus, let's add a register variable for this now. However, the RTC
> registers are currently defined as static variables in nextscr2_write(),
> which is quite ugly. Thus let's also move the RTC variables to the main
> machine state instead. In the long run, we should likely even refactor
> the whole RTC code into a separate device in a separate file, but that's
> something for calm winter nights later... as a first step, cleaning up
> the static variables and shutting up the warning from Coverity should
> be sufficient.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

>                      /* for now 0x00 */
> -                    if (0x00 & (0x80 >> (phase - 8))) {
> +                    if (rtc->control & (0x80 >> (phase - 8))) {

You might kill the comment too.


r~

