Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7ADC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937012073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sX1Vk/Xg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937012073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2OW-0005O8-RH
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2Ns-0004xS-WE
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2Ns-0000C2-25
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:43:04 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2Nr-00007V-SK
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:43:04 -0400
Received: by mail-pl1-x642.google.com with SMTP id g2so2949675plo.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zg2niRARe9to89GeVFUpp4dqwtoOwqCM/pC87M+AflQ=;
 b=sX1Vk/XgOA9hQhJlEYVMwAAKiCwK7aEoWsGYR4jm/JvdFpa2cE1lRq+TCdmT8jLNHK
 XWSqtzvTmQVIbGa6zE/vz6va5d+wJ91ncbGX6pnSsr2LFgnL5HhvarBtBkGB906vgzNH
 W6LwsFLOh43Q/B+1DOs7uw6MDiN+1+GZSBSnu9TlUgKVbT8+DKkAhzQ4BK4NU7rnnbgz
 HuCfo/V6IAxDvKf4BiPQxD9DBBnn7o5aJcyrWzfQV5nLuVKWw27yn+i+GdXrhnVEzm4I
 Y1JKVRB8FTqVdqWhKxZqe39wlmnI3VRNh6sKHszOHhSSU59WhLPK6vroeFNUvbDPLCEC
 Dh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zg2niRARe9to89GeVFUpp4dqwtoOwqCM/pC87M+AflQ=;
 b=OSe8cwWDGMmoyEy+jmRbkYqBm5PNGgTYGM3CszHBvVXwkBcb/WgRQr4VCMwnc0C45h
 OQFqLPIPybWRF8JPphEbrTRJ0A3XplJbb4VG1PfMmiAtJZoaoW6gPQVpIC7TDtAB0BKo
 w3cmRqE9sRxU4sGMvD0un57dJZi5RbCPNC7Yua2xAkzN8a0GffQRCRkCLn+PIVnZueZp
 RC4j3KyH6loMb2CFXo6KRu/a/fkOu2go3ZnmGn3qZSK6vZeXnkxaoY7oOUD8cfSyvt0Q
 aVYPiboWRNjHh7up7FjUkxfHIa0+RWS2knf1l9oafDI72HkRhJHz5bzcZx0rb3flFdEu
 EI3w==
X-Gm-Message-State: ANhLgQ33nAgI/kim56BVYzTRYN2VFdcZCGPAsM0lMX8RRPIVatIuOQIo
 lyFBfp2+PKbPXUKrrN7d6xbPtA==
X-Google-Smtp-Source: ADFU+vuxic+0A1RgDtkjA9HUIfnixL0Wtwk9OQppjyd0Wvcnt9qmh3LOt9SHJvWxEWk9+ytxAiNJ4w==
X-Received: by 2002:a17:902:9a45:: with SMTP id
 x5mr16154300plv.296.1584175382756; 
 Sat, 14 Mar 2020 01:43:02 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 l26sm28470589pff.136.2020.03.14.01.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:43:02 -0700 (PDT)
Subject: Re: [PATCH v5 30/60] target/riscv: vector widening floating-point
 add/subtract instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-31-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f3ba3725-6afa-4c23-2503-53ef7375d3ac@linaro.org>
Date: Sat, 14 Mar 2020 01:43:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-31-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   |  17 +++
>  target/riscv/insn32.decode              |   8 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 131 ++++++++++++++++++++++++
>  target/riscv/vector_helper.c            |  77 ++++++++++++++
>  4 files changed, 233 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

