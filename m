Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327E5C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3552468F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBrwfxDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3552468F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Pqj-0001wo-35
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 15:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Ppy-0001Qn-GE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Ppx-0005RC-CB
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:32:50 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7Ppx-0005Qd-53
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:32:49 -0500
Received: by mail-pg1-x543.google.com with SMTP id d9so283072pgu.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 12:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RxLRweVsvovvjSRd/aJpY25AKGzdRZNzZJoWjRF6zCY=;
 b=PBrwfxDAnQyXx62ymEjaK9WP5oudmqN8Ly4gQiPAUEc2Qe2Ebfq51cia2yF7EOQWEO
 5v1ekf5lJkvK9wtaBdD6gqirg9Cykl0ZpyDMDLmpqfVemJEGfWaw8XyTHC6qiFLbn1ME
 MDqzUsA0UzGBU/EJ83M2yV+25h07Tgh7zH++HtIOns37/HrW86CVzleeTHj1UlG4LQrP
 3+dNkl2tHJzHSPSSQXbDvib9yno+DUwG85h+VhQ//tQbOewmjkgEFMZWYdad0zQClayp
 S6P8oEu9JStnkPh7/+W74qhPzFRp5RpPBOBLfaArr2yYhcU7kNUxP7KEX3cLkHwsPfc0
 d8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RxLRweVsvovvjSRd/aJpY25AKGzdRZNzZJoWjRF6zCY=;
 b=A2u4SKvFziAv28il6widCc+v0x0bCgOgMgMguJ0AYAXGKxB7Mp+F/PgyL8Hhd/DTnF
 ZWZ82j0o3Vpvpis/xIZYibtZfo69qpxjm792Lfbj6PsPrQBEOycRy/H8GQ3kBpq2V3fF
 5vv0fhMnPYtXi5geAgr0UwlSpPIjfCDuD5JYSuTutYegWItpxXkqJoOWd4C2P61Yzzwy
 mOOGbZm2It+exTifvXD1DnQRQlgdBrarUBfjUW7mMbeEgRtkcCrOvkTAuLR/24dVvWRE
 8/0/eUPfIJ76T0SX6Vza4zfN9rr/rqRmI5AKUqWuO1PEEofR7QRiRqSJAEc6UWpyPE3P
 qxZw==
X-Gm-Message-State: APjAAAUcdBys4ZZiLncwaKfmRQ7Vhejw+AucV2p4AKIp+383Io6dCw2b
 o+r5SaVIdmPc+AXxiIPxrUE9GA==
X-Google-Smtp-Source: APXvYqyfnbIqxT5ouONNIMHqLutghxnOAMq6doC0Un5lnZS0odiD+0xpnkZUXkupQXuNP8mgv2/G+g==
X-Received: by 2002:a63:c546:: with SMTP id g6mr1017673pgd.243.1582835567976; 
 Thu, 27 Feb 2020 12:32:47 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 r3sm8528585pfg.145.2020.02.27.12.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 12:32:47 -0800 (PST)
Subject: Re: [PATCH v5 1/4] target/riscv: add vector extension field in
 CPURISCVState
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
 <20200221094531.61894-2-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <229be418-8fe0-cb5a-3ba5-3ea85f2843f0@linaro.org>
Date: Thu, 27 Feb 2020 12:32:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221094531.61894-2-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 1:45 AM, LIU Zhiwei wrote:
> The 32 vector registers will be viewed as a continuous memory block.
> It avoids the convension between element index and (regno, offset).
> Thus elements can be directly accessed by offset from the first vector
> base address.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

