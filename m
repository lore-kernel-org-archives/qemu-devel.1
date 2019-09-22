Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5ECC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1EB2080F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5ljQ25+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1EB2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBtGL-0003ov-Tl
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBt4f-0008M1-9n
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 00:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBt4e-0002qN-9Q
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 00:02:13 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBt4e-0002pN-2x
 for qemu-devel@nongnu.org; Sun, 22 Sep 2019 00:02:12 -0400
Received: by mail-pf1-x443.google.com with SMTP id q10so7016847pfl.0
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 21:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Lb3EeQrSzIyUVdyvEpicOamQhqcf++6Y1nzM2XmSLEA=;
 b=o5ljQ25+FhXMkpZV2b36iqMbRhpRijiL4e8u0qMSMpkMhKpXGEV8pOISuGlNWOJJME
 qlwNjrGKbvWlUDzPx1jIEQsCxj+dYVpG/ydjsEUueIyvg2XkoLEO6c5FntJ0nkf+Nu8g
 HFYm5On+p/T08UX6hZ+KdlLcGO4VfJYUtraJIgwsK71VgMd6NEuJKcQ1C4QrdmoYkn95
 OyjaHHIvamTaZ5otPOy4wh0rc9CgCzEnBmFOXMioxdL4VmO+9oWvvZHhoR2k8iaO1QtU
 B5/PRltPelTUSiysTA9SgvfUTeFrKKKQB55ou4fcC0PWW+XyoT0+b5Y/Ot8wuiKcUBn7
 O9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lb3EeQrSzIyUVdyvEpicOamQhqcf++6Y1nzM2XmSLEA=;
 b=li7+3jMvs6hJSIOuoml68exO9CnLaMhajVl/hDGXwUckQw7tYd/o4URu95ro+j8yZD
 cIKBrvvlupl8JQwCpO8SN9PxH1Mc4eKYhAxZkH5qwbYRivBhNCZHIrJnjfRVFFNe22Q0
 d6vZq1sLHn016NcSUjEB7xixTdX/cS2gESqWo6tOkHYp9YH656unmgmS1Naidqf3PaKr
 RssYED86sVf7y4NB1oBOk75OB6DOFCw/o3Ehh8HNpPCbN6312kQVCS0rqa2nI/5OmyzI
 Ndg9WvpsOrGHNVKhdc6NrU8o91J6+UrQ985RM17Bbn+O/zZDh07AEIJ9nIGDepT8OfWs
 mwDg==
X-Gm-Message-State: APjAAAUhdEP4TEwJW0ABbK1OcTqzb/B/9h3mSNdHJZfSvWU8RV8LGQeO
 gCD/MRCBcAMoVowMW0r92QenRw==
X-Google-Smtp-Source: APXvYqzGhgPQfGGLgvyE2El4CZ++DFKGJT0MDHyCqi3dM1aoBKxNsBGlGbQUNhGZrZ06PZ/aqt2s8g==
X-Received: by 2002:a17:90a:f98f:: with SMTP id
 cq15mr5652614pjb.54.1569124930414; 
 Sat, 21 Sep 2019 21:02:10 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a17sm7184252pfc.26.2019.09.21.21.02.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 21 Sep 2019 21:02:09 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] Move rom and notdirty handling to cputlb
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2f13f98e-3e6c-f147-a8ab-dffff547abd0@linaro.org>
Date: Sat, 21 Sep 2019 21:02:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/19 8:54 PM, Richard Henderson wrote:
> Richard Henderson (20):
>   exec: Use TARGET_PAGE_BITS_MIN for TLB flags
>   exec: Split out variable page size support to exec-vary.c
>   exec: Use const alias for TARGET_PAGE_BITS_VARY
>   exec: Restrict TARGET_PAGE_BITS_VARY assert to CONFIG_DEBUG_TCG
>   exec: Promote TARGET_PAGE_MASK to target_long
>   exec: Tidy TARGET_PAGE_ALIGN
>   exec: Cache TARGET_PAGE_MASK for TARGET_PAGE_BITS_VARY

I didn't mean to include the TARGET_PAGE_BITS_VARY patches.
Ignore the first 7, or review them at your pleasure.  ;-)


r~

