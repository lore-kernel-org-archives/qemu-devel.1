Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D766C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA2120661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/+x8+7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA2120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfaH-00023A-KI
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izfZ4-00016u-08
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:43:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izfZ3-0007wG-3N
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:43:21 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izfZ2-0007sR-Sv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:43:21 -0500
Received: by mail-wr1-x442.google.com with SMTP id z9so6738849wrs.10
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/jRee7eXr23tMJIbhtLfdE6DG3OxmPbNMZm4UQp72Jw=;
 b=Z/+x8+7PR5+jz8ZCz+wxVbfHRjdG+1R59W/cVxqfvZdEV/0w4LoaSc7UqjeXUEdOVW
 4xFpWJ7C+FoAKu6PNGWKzupIvI/pL+un/5TDGDiGXTRsw8aaBtH71KSqYwfBUX4s9tnS
 CNUewjZUmyY2HvE08lwqtWmbcynwPbXIgGJx5ieWri9bbhCropb8ZJCoHfUKZgJxP3cl
 syEPMHTYQWCCzNzYTq7b9uwCHS0WqeDiA5+L6RL764/BQJpq9rq81RjJnWmAHU/wf4YZ
 DJlALRgc/T9g8QP7ifKpJYq3rJsA64UQISAuZPb/XeejDLLCJvG07Kt+gf4pC/XwFYC6
 rVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/jRee7eXr23tMJIbhtLfdE6DG3OxmPbNMZm4UQp72Jw=;
 b=H1nop4aiIm9uhp/V/laEJMZRRunIcnVdREA0i2vwC7m0JQqs8T0xO6gib0GMv1Iewc
 CafcJnA7qTh7njchZZSTMMcfiF5OimMvlvrjs4IMkNp5Oe2g56dTUIIKIKEUuaLEWSZT
 F440PNUH3dRIpuSYUYoxT/VG1zn0AV+0x+FbGpNHqLGiuF4wWc93Q1uhp8JnghPU4BOp
 ssODdVUhvmry9YwY04GeQ55Ewwc4ASVrph/4QEqWiRGiVe0Iaua/75GoK3t8E4LHm8MC
 rqw4Nc5rihmdKG58g1qufxVftdEf2gE2VWYFW7igIgV9inbKFKjgVsvtbpSwDm9Th1pT
 rI9A==
X-Gm-Message-State: APjAAAXktDuAxwkhfRiCEMC1w0YtGIHbVo/xVT9kxV/OL0kWdqH8gV2p
 l6Qs/Q60ktlhVh6qA5VU3EswKw==
X-Google-Smtp-Source: APXvYqznQm2ExKtI9lqdy8/ZO4RUPEROv39EsS+3rv4NWHaGvb7XVcn1zmZ6+vB9hofn+c9xujHoqw==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr3296637wrq.137.1580989399799; 
 Thu, 06 Feb 2020 03:43:19 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id z6sm3905448wrw.36.2020.02.06.03.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 03:43:19 -0800 (PST)
Subject: Re: [PATCH v1 03/13] exec: Reuse qemu_ram_apply_settings() in
 qemu_ram_remap()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6f2430cd-9d24-78ad-ea60-892b40116262@linaro.org>
Date: Thu, 6 Feb 2020 11:43:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 6:31 PM, David Hildenbrand wrote:
> I don't see why we shouldn't apply all settings to make it look like the
> surrounding RAM (and enable proper VMA merging).
> 
> Note: memory backend settings might have overridden these settings. We
> would need a callback to let the memory backend fix that up.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  exec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


