Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C12C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 18:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0652171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 18:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GQmH31Zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0652171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvnIH-0002XC-9a
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 14:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44613)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvnHf-00021H-QY
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 14:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvnHe-0004BO-Ua
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 14:37:07 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvnHe-0004Aq-NZ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 14:37:06 -0400
Received: by mail-pg1-x542.google.com with SMTP id n4so2769041pgv.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jd84gn+8okt1QNxzLOlDwimNjPgm4AQWr556sR+wcO0=;
 b=GQmH31Zl+AgyjO7pp5cPWKHujPvPX+JHv10lApNIX3Q8RLsR/DcL/U0xSAP1ACDoz1
 nRAl3S0QzMj57JBzacLq2oQ6By4Plb6NudkYKyHVDxlUKP7VQGWO7+LhJBjpYo6BNaXf
 GQpHrTgDOktiApJ+sKwcxLLtOgFWgVT45C0v1yzClwyuDnxMFKLCr24KMKF1HpTaUoPc
 ElVNS0WHarTRuCgQ3iZRE6R8iZysTclquU+7A0Sd039V6L/Mxn/3MQYPSbbhv6O6GtDr
 15u9J3xdIMPZQsevA0GDtPuTRjg1CXpgZFXeg8ARkZwygOg49JK0bdSl+l1VB7y/R47N
 HOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jd84gn+8okt1QNxzLOlDwimNjPgm4AQWr556sR+wcO0=;
 b=iDF7ma5+n/VWBbquJYLgRQHgV+9oT9Wk0Q1086k9iMdDss6x7Kndz6VYm8Q2pqDWMC
 ZGVpgZTEIheb1nKqAjjDg4XD+3i5CyO30DxEkC3p3afRex3aPKE9aRiLhZc3d2qMPK1Y
 9IcW15jXEdSLadpVM7w9drbp6jXlG4G6qNoUVesbcNQ0BJDOSwILLNZuyvMb/ICpItTV
 X65sveH1EnaVAvJohxC+zGkWygQ1qodsjT4a1rSD5CAhExIUWFgem820oiJSAMpI/k5e
 r5xGoMHnW/pslH9+x9EOStpyTabcGbM5kHgCNR7B38WIMDmIxIlbVkxPlZvHk66rQsfw
 YiEQ==
X-Gm-Message-State: APjAAAX2j6OceS9R9gZlc9RM/m3smSbrWGjlzM5Z3CfHGXlm/kBT4Txm
 yYfwRE7ms5YecS7c7DPP+smdLQ==
X-Google-Smtp-Source: APXvYqx1yQBYoiQdBKWie+DVzs6kNQYUuTFVGWMd97q0xa9uTVp3R51htS2ut8JicByb3qEc/5QlNw==
X-Received: by 2002:a17:90a:db44:: with SMTP id
 u4mr5470660pjx.52.1565289425338; 
 Thu, 08 Aug 2019 11:37:05 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p20sm135745756pgj.47.2019.08.08.11.37.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 11:37:04 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190808164117.23348-1-alex.bennee@linaro.org>
 <20190808164117.23348-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4c8f5977-3582-617f-7782-5ea13ea59c0a@linaro.org>
Date: Thu, 8 Aug 2019 10:58:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808164117.23348-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v1 7/7] targets (various): use
 softfloat-helpers.h where we can
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
Cc: David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, armbru@redhat.com,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 9:41 AM, Alex Bennée wrote:
> Generally the cpu and non-FP helper files just want to manipulate the
> softfloat flags. For this they can just use the -helpers.h include
> which brings in a minimal number of inline helpers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/alpha/helper.c   | 2 +-
>  target/microblaze/cpu.c | 2 +-
>  target/s390x/cpu.c      | 2 +-
>  target/sh4/cpu.c        | 3 +--
>  target/tricore/helper.c | 2 +-
>  target/unicore32/cpu.c  | 1 -
>  6 files changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


