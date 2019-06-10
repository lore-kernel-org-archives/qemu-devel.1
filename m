Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FECDC4321A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F8B2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZBYUwEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F8B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haRGI-00010m-V6
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 16:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50433)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1haRFB-0000SH-Iv
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1haRFA-0001zm-Ci
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:50:17 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1haRF8-0001jl-CC
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:50:14 -0400
Received: by mail-pg1-x541.google.com with SMTP id v11so5644753pgl.5
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 13:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U8PfD+7I+jePEGpyqltvhMZ5gvA5IKXr+HPT1O4Ndg8=;
 b=kZBYUwEFlKaT9NigtuChF/6Mrl38Nf5q2QUpMgmanA2ccfDOcIcBa/+KtapeKVT5R3
 hfkHTck7MLUbBBmy6DMJZBDipO3rbFe0+/uRX7M0CtUvV+1xPMrxqxsA96XWclphI8Lw
 OZqMQ14de3Mk3fY3O0YB7XvE4VQ7NHWuaWZ3EWH3SPuzWpkSCnAs/2ZgZ/CIYLofQWit
 ez9aLJAnJ3Z8awsyck/OtPfdWO5rGA8UGRgHCEsecB7FXPwDW0XiUDgJ9Zq0vGkaxSYI
 MsmOJQllf2Ns5ng+SPTvsGTEcAEFU6F+FaevYJD1YVCDqlnxWX5o72MybZDZpMCdHsgs
 l2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U8PfD+7I+jePEGpyqltvhMZ5gvA5IKXr+HPT1O4Ndg8=;
 b=b9onO36Jds859n3HrVGJHM7TV/ldf9RE0qFesxem8eMZmwJqAJF2GmwihIvoM8wNs6
 FhvnSCgPpNi9KM77/VNwa3WjiKc662b0HN0LcbnTrwbQWXAp/sCmKrHaOlptuvOQe11r
 PUrVPgyxyWBqPxGyqolsHEEvYWqHKsiZ1qQ+EHrGzm6IUUw/QVAPWTkJyJXGjz9AQmHq
 zzJgeRky/m1gnHfDo9t7r8y6iZoCGPfKUa+hk90O3WzO73wE/EIjkMGol6rxo7VPwVIu
 0TJKiWgBIAJbnpY1GupxxT8C4H71LyWoghyHHa5iAgkKQ2AbCawmh5fiBa7dr2v51NTw
 lJRQ==
X-Gm-Message-State: APjAAAXFtlRMO2V2I4xHjyB3YwVDQLAIKzBXK+/TNj4v4w4k/TAHhNL8
 tscVXaS7n5I8Q/KSHNfPUxk1FQ==
X-Google-Smtp-Source: APXvYqw3Xu76dnMAp0jMZGkErDxmDN/1qX4TwCFq/kJk//ts+M4k9c/lI+FCjmG5+s/Nk66H4XebRg==
X-Received: by 2002:a17:90a:7f93:: with SMTP id
 m19mr23796983pjl.73.1560199804764; 
 Mon, 10 Jun 2019 13:50:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 n21sm384409pjo.0.2019.06.10.13.50.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 13:50:03 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190606193012.37715-1-mrolnik@gmail.com>
 <20190606193012.37715-5-mrolnik@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <35b377ca-dbad-b932-5e33-c5ae63344800@linaro.org>
Date: Mon, 10 Jun 2019 13:50:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606193012.37715-5-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v21 4/7] target/avr: Add instruction
 translation
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 12:30 PM, Michael Rolnik wrote:
> +        if ((ctx.cpc & (TARGET_PAGE_SIZE - 1)) == 0) {
> +            break; /* page boundary */
> +        }

This test isn't right, because this ended the TB if the *first* instruction was
located on the page boundary.  It also fails to allow for a 32-bit opcode to
span 0xff - 0x101, since we did not see an instruction boundary at 0x100.

Since there is no MMU, we do not have to protect against permissions changes.
All we have to worry about is QEMU's code that detects self-modifying code.
This requires the code for each TranslationBlocks be contained within no more
than two pages.  Therefore,

    /* Do not allow the next insn to cross into a third code page.  */
    if ((ctx.npc - pc_start) * 2 >= TARGET_PAGE_SIZE - 4) {
        break;
    }

is the better condition.  Subtracting 4 allows for the next instruction to be a
32-bit opcode.  Limiting to TARGET_PAGE_SIZE allows pc_start to be located
anywhere in the first code page without allowing npc to cross into a third code
page.


r~

