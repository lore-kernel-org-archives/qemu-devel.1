Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7970C3B187
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A428420873
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OC2po4AY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A428420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aYj-0006Rr-Qp
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aXr-0005u5-Pl
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aXp-0002sk-Rf
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:46:03 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1aXp-0002q5-Gz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:46:01 -0500
Received: by mail-pf1-x444.google.com with SMTP id i6so5934768pfc.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r6gPWX3/g+6vIoFJxQ/lWlYIH4Sk+YSoh5tuSdn3GfE=;
 b=OC2po4AYaDMOeO6PtX5B9e++ZvKbOJIgkJp/UWGWw+WM5ja9APJ9UIECk2KYHWvB+b
 YyFKiBhRtCc6p7X45LembX7AzSI0BAqwFhaP8HX74A0w2LFJ4bMmKFYIyKJ6nVfRrGNF
 sjVeAwWrqXfX8Mh0pa4AHSkiCrAt7LmeCaVQTpEwCbIXopJ6E3PIOOapflm7uqCYeSsF
 i6qZ+CqEuth/m8zfMyRZAzRZqT2B81ewkW0IkzNnRVu/2tlLxqbMLyzaaV/wTkxKohzw
 Hb4q0GUNiSvbQDWFvaySoAxZYp8yDyXbi5054qkKO1TVNWmUW7fykY3RQRvJgytk++Uw
 9GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r6gPWX3/g+6vIoFJxQ/lWlYIH4Sk+YSoh5tuSdn3GfE=;
 b=A0YmYvnIzwUp2dVXSpLJz5xfvkIQRQ1PChHb1G1pWg9va7q4g6od1uCtEzcaTsAHaO
 Cn2Z7YvoK7pLKFX+hPLUbpr9BRzrF6lKjNW2YmLUXHa6C3Rf7BkXFwBVxLwmGE5eveWO
 wjgAySwRrPBlODweLWRIegXD6khO7L/915/pyDjeAkcu6BfnMTZkzDhd7db1/ShMAjXm
 9rAn/fc0KbQ9I9fjMM9J7a69EwOu9mKoIHhTlfUC+b9tIOM/P7NUsCIK1p/kZmy7Xi3A
 HTkbgN4Y+R5I4d/a8m0V5oMz1OY/+JgCFGZbtf3a2CNmWKU0ogD5CKdFN/s3hCHTQQXR
 RT2w==
X-Gm-Message-State: APjAAAXn6kX1Zgfs4LSLv5G8nPa4whmUE3u/1lCK7u6HSV1wKsV+kOO7
 1vnpdMDTH99zb2cGRiR/uHK3Bg==
X-Google-Smtp-Source: APXvYqyzIsYJvgsNLzeQN/31uTwwJXEUJhxx7pUC69ilbuvn4A1SlooOsQOlYMTRs+MBwHcjZBjkrw==
X-Received: by 2002:a63:1c4:: with SMTP id 187mr8340628pgb.121.1581446758007; 
 Tue, 11 Feb 2020 10:45:58 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 g7sm5199218pfq.33.2020.02.11.10.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:45:57 -0800 (PST)
Subject: Re: [PATCH 09/13] target/arm: Implement ARMv8.1-PMU extension
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9fb5335e-c8ae-1f3a-4f1d-c4cc87369968@linaro.org>
Date: Tue, 11 Feb 2020 10:45:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
> The ARMv8.1-PMU extension requires:
>  * the evtCount field in PMETYPER<n>_EL0 is 16 bits, not 10
>  * MDCR_EL2.HPMD allows event counting to be disabled at EL2
>  * two new required events, STALL_FRONTEND and STALL_BACKEND
>  * ID register bits in ID_AA64DFR0_EL1 and ID_DFR0
> 
> We already implement the 16-bit evtCount field and the
> HPMD bit, so all that is missing is the two new events:
>   STALL_FRONTEND
>    "counts every cycle counted by the CPU_CYCLES event on which no
>     operation was issued because there are no operations available
>     to issue to this PE from the frontend"
>   STALL_BACKEND
>    "counts every cycle counted by the CPU_CYCLES event on which no
>     operation was issued because the backend is unable to accept
>     any available operations from the frontend"
> 
> QEMU never stalls in this sense, so our implementation is trivial:
> always return a zero count.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


