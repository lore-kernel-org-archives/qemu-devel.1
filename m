Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB08FC47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C6320643
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfbJ7nkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C6320643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUMeq-0004GC-KT
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 23:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMdm-0002OI-FQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMdl-0006aN-EX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:47:06 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUMdk-0006VE-Tn
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:47:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id x2so1063913pfx.7
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 20:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=VzOxuQaOmRnCftDKnoD+DnBRUs116m0g0t5OD8NTZNU=;
 b=UfbJ7nktDt+2FcqV15SfrO2xFvEou12En65JSpklpxoFUwDl8SLHmWexpR0QyWFV5b
 6DrAQA9jezD9GnWBmvC0IeZLMlWYr0r8cCiBVTE//CkSuxswRrw/9OQGOELUjLABMyVe
 qOmkAxfaVbonML8SOMkwsoSoFjCxk+QkW9ALfookB5dXTCVkQ8CaGpLwg3U8eWLK+WjO
 nc2nMkGDPsu4LunC5KKRyK28Sh0xDaoAhSb7b1ogkNKv5olcuGsJ44HaOod1r/4JWFe+
 3ZrIfIEuXxKvrMukMvmdsFKLzuptQzGbLntC6yQDfO1ROjo99bRyn0HKUW34HyWPWTy6
 G48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VzOxuQaOmRnCftDKnoD+DnBRUs116m0g0t5OD8NTZNU=;
 b=SYd4nT+Yssbdp+GZ1DNoevX1eRIqHjl+39UnV9xPo3rehsW5Byhx4kBHL4lXyCScoh
 2+NK1WZmZFJBDINqqPqQANjvLjH4huSWmascadnSA9VDw/QWTtRYmopiXgb2MsZPvoVh
 d5GEzFsXPB/QEZg9xGMQx6i1SDmq8fCgLtQeW/lIRY3oWlivowXszH45Ru/0GRDO9ZiC
 fcVeKGlbm1UJ6A+8bQeTPiAuUO9TzPNxPErSAsryjIvGk+bj4Rp1jD1HFYFkD9O+BdDz
 1hguzU1h+GMsdWx0NHssBOPMWHnsRBVCgtl0kywnZeSC8XR15rAEQGUau5Uf9OQ2vRPV
 +OxA==
X-Gm-Message-State: AGi0PuZLc1zd/ymEp3KjCGp9xlJv3+52dlCaFW+eSqH3M7P/fa1uov6V
 CZQmwzPspZIMbJ0qDrDC7G+I00BC898=
X-Google-Smtp-Source: APiQypJeCQ4UpxKEkpKroCctd8anjaOihUObOH17Fh3CQP/Pn5AWqbGIbhbt+kvFrS0mAe+whEtPWQ==
X-Received: by 2002:a63:485e:: with SMTP id x30mr2344823pgk.416.1588304822815; 
 Thu, 30 Apr 2020 20:47:02 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i10sm1002949pfa.166.2020.04.30.20.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 20:47:01 -0700 (PDT)
Subject: Re: [PATCH 30/36] target/arm: Convert Neon VQDMULH/VQRDMULH
 3-reg-same to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-31-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fbcdb1c7-60d6-eab2-cb58-d6e12a46f384@linaro.org>
Date: Thu, 30 Apr 2020 20:47:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-31-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert the Neon VQDMULH and VQRDMULH 3-reg-same insns to
> decodetree. These are the last integer operations in the
> 3-reg-same group.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 44 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 24 +-----------------
>  target/arm/neon-dp.decode       |  3 +++
>  3 files changed, 48 insertions(+), 23 deletions(-)

Modulo the other do_3same_32 comments,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

