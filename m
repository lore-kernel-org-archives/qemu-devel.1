Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9319AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A0220661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhXWJtXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A0220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfZH-0001AW-JC
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izfYg-0000jF-Jv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izfYf-0006fd-LG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:42:58 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izfYf-0006YL-E2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:42:57 -0500
Received: by mail-wr1-x443.google.com with SMTP id z9so6737263wrs.10
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L6/LO2cWUF0iL4u9zxdpq74irfsTSLFkpONcYwPsA/0=;
 b=AhXWJtXbZhOcxv2khCmD0F0c+lY/5IgvdEN0VeGYTm0yLW882iqywYfUCrz7+Rz3QI
 4evClUz2sd2tXSDMr5fJVT34Auy1H05Ple0J7bO7te0WZvflyOZQ3OTHVICHQpulPpSs
 sVkP7ncsVAb5d5XtSqJ1QJ1C8rS0qISXfO7AA8Yt31S2wzwt323hF7Ien249Mur2oOm3
 ZYIsoG6VUXNO8v12oThh9R4LclOLb6TqtqMpybnUpEjCWEeciqKokcFAm1LOUBFQpq4o
 g/E8OiYMKAKAViFO+Jk4TBZAU/qCcRmblE4NsRbTvGsWDPXWSGN6SvVedz5lAy6FOLc7
 V+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L6/LO2cWUF0iL4u9zxdpq74irfsTSLFkpONcYwPsA/0=;
 b=goCOjTZCcagKC5RAEqndZeOQkXs/d94baAjYned9wp+xnQyrbmeGD3OvPD0iiBBeCH
 Xpji32I1oz3rQtkvNRkaXGMrAGSx/JXLR2KHexSju9iPlDjf71fvXVY7jr15RqEdqx4r
 Vp2ogvK6BKybDogoSEereER0N07313o0tBpVyovfXbLEdBpdmJYl/VIFDAo31Qf3JjfT
 5aglM2ANCYNivfkDVUnJnb52Tw8FUGL9+D6ojKuLbp/xtel55xwoSa4Ytsd1UAc4NdDB
 Vw72D4ATk5155+S9u5GfBm8DACC/NPhoeGeF0LwAvHBvThPsbU6sW25gPaOaf29UMv/8
 GliQ==
X-Gm-Message-State: APjAAAU4hjM5pFSBe1i+BxI3rlCZXgDPmYJhiNhTMQPLAq7Pj22mI0fR
 PxYZeswDZ1JLFe2IDirDw7LG2g==
X-Google-Smtp-Source: APXvYqz1+6pEaCKR8M5v072gBK4J4A1bk5xFtP4SHeTYtfB/MfwntoeLWWAnIuaMHYhSPn7u+NI6aQ==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr3338038wrv.86.1580989375965; 
 Thu, 06 Feb 2020 03:42:55 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h13sm4166197wrw.54.2020.02.06.03.42.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 03:42:55 -0800 (PST)
Subject: Re: [PATCH v1 02/13] exec: Factor out setting ram settings (madvise
 ...) into qemu_ram_apply_settings()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eefdb545-6dc4-e615-a771-f7b23cd544a5@linaro.org>
Date: Thu, 6 Feb 2020 11:42:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
> Factor all settings out into qemu_ram_apply_settings().
> 
> For memory_try_enable_merging(), the important bit is that it won't be
> called with XEN - which is now still the case as new_block->host will
> remain NULL.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  exec.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

