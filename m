Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E54DC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D0820862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJ6bV2KW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D0820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJya-0006Xn-3a
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 16:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJxK-0005X1-MK
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAJxJ-0006CH-2V
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:20:10 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAJxI-0006Aq-Gf
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:20:08 -0400
Received: by mail-pl1-x644.google.com with SMTP id q24so1979399plr.13
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=buvB8JkN4MEBVwW189i/vmau63LOa7rloA5cMwtxKBQ=;
 b=XJ6bV2KWQS9hd/SuDD9cIHq3Cb9Xf9qvXM8+r6iT3SUN5W+loiWfWGYaoxllvrulhh
 58/X26tGf/G1UIRHQgmhtsDLNOrHLB2ZzAgWH725F0LuqQOE/0FMsEaCUDiu5Iv/AyKl
 fnETcgvo+UmaOoC40NALwDQ5zrXM3EKF5RwOM5mVBp9HZlAfhf47wkwbI1QJDus1rV59
 4+w+wjrV/cRe/sVQYG17PaYxZw7DGT82Y4RQ9ApBPjiUbfyGZiYyCBFCJoudujLJrJ5/
 rU0O0N7WBsqhZQFKhRGE1ebYDBGdYpaAS7j0ZId2aUdmMw23hgEYKcCsMXQ4sIeL6qwF
 4Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=buvB8JkN4MEBVwW189i/vmau63LOa7rloA5cMwtxKBQ=;
 b=NtSIQAxnZDhJAgDpjy7TutcyL6a47XNma38babmtZ/X7TpjevoiY2lUBtHqyJvvJDf
 WJFrvJsgmnH9HsSRu8paec1vaetwVMruHMrM/A5XU3r2JQ4liDRzZ3ChT+6MS83jURHJ
 7xdK69AesEcA+Ajf+6R9ONsRoDjBeSJmfqkN94t6v7nV0d7Xdp9RZsXgbBfP115ZHkus
 TCXvvrui8ec0uUZ8vCbPAfE7skR/lYoX7jtbDvKpoSwhlAY/rNU8AOv0/cFXWp0//DLh
 WxMMckhRRWwCYusFYUGIUE2MuiAMYuk0kYV4rsKLtBh/Swkce06vbVKBi0ZGcGmsjccD
 N0xQ==
X-Gm-Message-State: APjAAAWCrqwYr853Y0/xQADxmI+fITmQZNo1ispRh0KEJTGKUqVFMMzS
 Huj2KFgFb090rBIJDbld5LIz2A==
X-Google-Smtp-Source: APXvYqw6nEg1PVChyVAD3BNRH+x7h8EWypqqsdgtv0rnB6SvdPmyeYzLk3kFcv8TOLBnnMgMK9F17Q==
X-Received: by 2002:a17:902:ba95:: with SMTP id
 k21mr546941pls.80.1568751607091; 
 Tue, 17 Sep 2019 13:20:07 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z12sm8276990pfj.41.2019.09.17.13.20.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 13:20:06 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190916135806.1269-1-david@redhat.com>
 <20190916135806.1269-19-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <277485f9-4d8e-1cf6-2c46-f43a3e49b2dd@linaro.org>
Date: Tue, 17 Sep 2019 13:20:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916135806.1269-19-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v3 18/29] s390x/tcg: MVCS/MVCP: Use
 access_memmove()
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Dan_Hor=c3=a1k?= <dan@danny.cz>, Cornelia Huck <cohuck@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, qemu-s390x@nongnu.org,
 Cole Robinson <crobinso@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 9:57 AM, David Hildenbrand wrote:
> As we are moving between address spaces, we can use access_memmove_idx()
> without checking for destructive overlaps (especially of real storage
> locations):
>     "Each storage operand is processed left to right. The
>     storage-operand-consistency rules are the same as
>     for MOVE (MVC), except that when the operands
>     overlap in real storage, the use of the common real-
>     storage locations is not necessarily recognized."
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Comment references access_memmove_idx.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

