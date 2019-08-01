Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE13DC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FF12084C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4Gkak+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FF12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htHWY-0003CX-Ps
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 16:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54419)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htHVR-0002fg-O5
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htHVQ-0007Sn-Ny
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:16:57 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:32861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htHVQ-0007R9-7T
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:16:56 -0400
Received: by mail-pl1-x643.google.com with SMTP id c14so32606243plo.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 13:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TLQOJQsEVRG3OzxuGviQO+jFTTJ29n9238eeZN7k2gk=;
 b=P4Gkak+0+R+x9pQ3FeBL8SDXi7C4DgZXkv1yPGshIrOXXEKT6kWcjE3Zo9FiP6T7uC
 YEn5ceZ2EYqH+MIgaiBLKnWzpamFcqdlTWtRJDK/adYoBravbdoqWXcA6G7oG+TIQr1m
 2enPyBLuLckAWNvJdGH9AuoWAiGMJnS4hY2TKYG0xs2qbTh0eFv/T6jJqOwlrA1Irady
 5hr7108hZ8USA2bk7sWj/SjNENVFgr5jbInHaq01HmQb72X2UGg5B+ssPWsKxZHoCKUm
 GUCEzlMF2lqJlWByN1FpdgS71iKfVJAl4UyY5oGzPYpXSyyKN6prP0XzMQJYXV832Hmp
 XR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TLQOJQsEVRG3OzxuGviQO+jFTTJ29n9238eeZN7k2gk=;
 b=lDzdNQA8FGFLU20Q0JuOIIje4CYXhcaVAHZbWOfp1HwV/BEYjTL5mYGvlNxc2fKYeQ
 WnfaRkwpJ2fDebo6H0JuT5ELZUlUZJ6jGR4yLccdfEQSuL0SREHwL2etxWoHzDxF83co
 WlDMPTBgZkYD2vtGLzKDMtjB832OCZtCokocnRRnSKE0lG44zdmK5qzJ8NSS6bVZiG2D
 +w9hsUkx/QCq7nWzveIJLTmlim4nORTaBCSF8XbURlSIi/zuqrn9w16sSFFUFfx41fq6
 e3NmrfDsJkNbkcvcziz76rLTb6719slc2lctaV+NR2hmkjxch8pMsv9nDECEZRRyxjzn
 xzzg==
X-Gm-Message-State: APjAAAVgW7YEWFjZGhh3n6K6+sDGHTT1GXj5er0bLvSH7UyPsH8VsK+q
 G7sQeLPWn8jLIyPyot5dfGOwIA==
X-Google-Smtp-Source: APXvYqxDD/t7rwpPAGRBrB/7Sz4DHvW5zPXBwm3h62hW5qWETv3OonQ0FoehQx27L6RjXwKdOh1XIA==
X-Received: by 2002:a17:902:f089:: with SMTP id
 go9mr127358849plb.81.1564690615083; 
 Thu, 01 Aug 2019 13:16:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b36sm9963797pjc.16.2019.08.01.13.16.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 13:16:54 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190801183012.17564-1-peter.maydell@linaro.org>
 <20190801183012.17564-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <529ee51c-e95a-3ef6-804d-ddbcad6cd50e@linaro.org>
Date: Thu, 1 Aug 2019 13:16:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801183012.17564-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH 1/7] target/sparc: Factor out the body of
 sparc_cpu_unassigned_access()
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
> Currently the SPARC target uses the old-style do_unassigned_access
> hook.  We want to switch it over to do_transaction_failed, but to do
> this we must first remove all the direct calls in ldst_helper.c to
> cpu_unassigned_access().  Factor out the body of the hook function's
> code into a new sparc_raise_mmu_fault() and call it from the hook and
> from the various places that used to call cpu_unassigned_access().
> 
> In passing, this fixes a bug where the code that raised the
> MMU exception was directly calling GETPC() from a function that
> was several levels deep in the callstack from the original
> helper function: the new sparc_raise_mmu_fault() instead takes
> the return address as an argument.
> 
> Other than the use of retaddr rather than GETPC() and a comment
> format fixup, the body of the new function has no changes from
> that of the old hook function.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/sparc/ldst_helper.c | 201 +++++++++++++++++++------------------
>  1 file changed, 106 insertions(+), 95 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


