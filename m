Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D0DC47256
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9E420708
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzbub2Yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9E420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUMUO-0004bH-In
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 23:37:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMTm-00044t-7R
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMTk-00082A-Mn
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:36:45 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUMTk-0007vn-3P
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:36:44 -0400
Received: by mail-pf1-x442.google.com with SMTP id 18so1052666pfv.8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 20:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=0Uj6Xt+Ysy6EzXWRPhCgjEcA7gSi9B8i5OasAu06NjI=;
 b=fzbub2YjtcR2XYpgKoLQhC9ITlL6z0WYsl8KN5cMCtPyQUgE39amg/aXqWRwXA/WDo
 Z78UnrbKkc+ajawhI4/9Jed4X4eq2zAhjT88owcBH1MT/TM2meApANUVSPkLPLv2Vlup
 2dzCN+z0Gc1C34XXwB+nBDMX4x8PVRJY+A3GOLGeil+tlN2tYXM28eT+APYkd0N0FIMk
 qENGFfM+MIJOydGg2jdnp9KatdCrKlUj0faaGdKkCReny5bVHNOd/SY6sxqo2rRxrtay
 U1naRKuLGJiANWSoEunSG7MnzakJCL/AxPE/9i7978gM3ueCVtSOxRp3pemv+FbUqXu7
 BURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Uj6Xt+Ysy6EzXWRPhCgjEcA7gSi9B8i5OasAu06NjI=;
 b=EXDFgKsGvU1K7tR02AgZpoh0d8MmwXWjPDLPEq3YFZ79TU7R7+xwckBZp4hQxCoCJ+
 7RdJ9jWnJdSH6Q2Z90lSAQkFZSKzVXpbpJcsh4GTANe7xH2oBExE1xPl2YYzISpsD5Qf
 4xKaO7J3s9zSgTayHQ/rA+TYJ+LKp6UbGmSkIpeZux6GjVDkpr4XnfGS9xwLTYhozhoc
 Ua74bwIG7clSBE7hITa134oDHWpNwx3DsNAOoHDFvsZVhxl/mD/VT+sEgEIKH1ywjFSZ
 oHVkpVVj0bffnosVTz44FlEX4F1g7MteZxg+XgWsXR0fj35gKbxeAz787dCeA3X8IaMt
 cEfA==
X-Gm-Message-State: AGi0PuYg9kh7nCfa+kViPUgUme6SZk6yVl0+jEO1rD7Vn5OWheBfLixZ
 tSlKdIvufP07xFnV92cNU/n3ELueTic=
X-Google-Smtp-Source: APiQypIdlXEjD/aGkRqVXyi+SNJXQQFhGkOlsJkthC6i5lw4xHwtddKdbjMklzKyk6zSNIvYIEp9qg==
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr2243436pfr.36.1588304202190;
 Thu, 30 Apr 2020 20:36:42 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w12sm999739pfq.133.2020.04.30.20.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 20:36:41 -0700 (PDT)
Subject: Re: [PATCH 28/36] target/arm: Convert Neon VPMAX/VPMIN 3-reg-same
 insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-29-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c915d8e2-34db-ca42-45a0-03c20f8f88aa@linaro.org>
Date: Thu, 30 Apr 2020 20:36:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-29-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::442
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
> Convert the Neon integer VPMAX and VPMIN 3-reg-same insns to
> decodetree. These are 'pairwise' operations.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 71 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 16 +-------
>  target/arm/neon-dp.decode       |  9 +++++
>  3 files changed, 82 insertions(+), 14 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

