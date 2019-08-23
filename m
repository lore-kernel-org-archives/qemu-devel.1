Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AD7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C80D206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyBFknSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C80D206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BM4-0006AR-6m
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1BJg-0004YG-2W
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1BJf-00055O-5F
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:17:27 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1BJe-00054w-TQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:17:27 -0400
Received: by mail-pl1-x643.google.com with SMTP id h3so5751862pls.7
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nMLmHrNBrvmow7c+EnnN1MQ042yQtn7S13yBJP6CUNw=;
 b=oyBFknSFmRw3adieePrsiEc/E/zXclpECqyH71Fq+H8urZDa84l/4YBb+fDCh1+znb
 gzSDEHZfGUKyjiSBqTl8eNy19yL744oo6n2ZHVf14jzF2/yLOwEVOtFpr7Gw9wsESEn7
 jOwRDwVzIFPKBMXR5sWbpvDWbYZn2A3Emv+5JtYor653JJFDwHzUDgTZ8vPE0U4f/I/W
 eehfyJJnavHNImbk4mUjZ4q3+3GJHT664QyFVQILn7t9lG+jJPwSCB7l06Vrxf3XRNMW
 TD7F61pyBTZ4BmXWI7LUmKLtGtP5K7vSXAdTArlOJsiMzNkhWhrS9P2mh5FkIQ7Ekkhm
 E1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nMLmHrNBrvmow7c+EnnN1MQ042yQtn7S13yBJP6CUNw=;
 b=MF7FonFTtiT9oDq0h5RwdWREJfIElR7axJi5IHkr2M2q0AlfxaCZ9tcQiwzp8VgB9f
 wo0YHtYYGSpFwngtz61d0xCw49Zyy6JjR6YsINGp/wa8x6oUxQZCmick+m+vJFe+ecB6
 CphvYlqL8muza29w/eTyuYPKqnT9E9hrZUqe5kDIHZHqR6CKo+VBlmcXqkoRKiQgmLMG
 kkIHweQaL0xJkuCnL9E4XDfpPqU/dEwMuJCYON6QNdKNELNwyCwMAGfR6B0iJb2QjSCg
 JUW3StnsuiQVRfwXZHziY1FaoCk7fimey3dlN+2afSam3g8KyXORWvGJP0/WRH7l/iAX
 XqWw==
X-Gm-Message-State: APjAAAWLvrz7DUHzYhzRC44iHRlUd30zEV2B11JgO15LlTUe3r1/8wSM
 WzL0kC/yzEVMCAKnHey8GC2VYA==
X-Google-Smtp-Source: APXvYqyKaKuzwoba/HMntiZBOf6uRN0VPSB94k15peqPcZmbyvNcFygPaVYzoqhIvtTrnFjtPQKDPg==
X-Received: by 2002:a17:902:2bc7:: with SMTP id
 l65mr5153416plb.119.1566573445318; 
 Fri, 23 Aug 2019 08:17:25 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v18sm2368892pgl.87.2019.08.23.08.17.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 08:17:24 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190823100741.9621-1-david@redhat.com>
 <20190823100741.9621-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1f59df55-d50f-ee38-883b-17a79226ee9a@linaro.org>
Date: Fri, 23 Aug 2019 08:17:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823100741.9621-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v1 3/9] tcg: Factor out CONFIG_USER_ONLY
 probe_write() from s390x code
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 3:07 AM, David Hildenbrand wrote:
> Factor it out, we'll do some further changes/extensions to both
> probe_write() implementations soon. Make sure to allow "size = 0".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  accel/tcg/user-exec.c     | 16 ++++++++++++++++
>  include/exec/exec-all.h   |  4 ++--
>  target/s390x/mem_helper.c |  7 -------
>  3 files changed, 18 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


