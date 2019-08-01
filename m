Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66A7C32754
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A241920449
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVJ4J3yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A241920449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htEc3-0000CU-Q4
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 13:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39727)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htEYx-0007AQ-HU
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htEYw-00062f-4J
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:08:23 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htEYu-00060e-52
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:08:21 -0400
Received: by mail-pg1-x543.google.com with SMTP id t132so34541583pgb.9
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PbRqNChtTAe3gXF1XdGSKXC2d762ZddNjjaPSW+B/rQ=;
 b=aVJ4J3yBvlsE8ND8+CNH0ZsCSxXO1x1aDmYRwlOVVgKvuYuOUpW3IsdDbIxzt4fzRG
 Q1V6uxtY2p5Yy0CFxH5FcQRRR7+bj7k6+u4C/zbpR0QxU8ZrC1BhzvjQk3exDlsrXyl/
 eEZr3THlxA2o+bBtVE1T15FpmI8NopY2j7147mTUWBC6M7K8XUoN4JwXXCjy7iXdTvuK
 6EJeRr2TEIOUllAU2Du7POeLBissg9anqHkhDLvTx5USGQpd+YDN+qPXA8LwfxMkAPwt
 kC3CtzydxyKhgIDEitQJwDG2W7tlBSO4E7Fmjf7BFIu2twguu6Ziawrct0kJGbcxtuo4
 cwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PbRqNChtTAe3gXF1XdGSKXC2d762ZddNjjaPSW+B/rQ=;
 b=RXiJhtbxUUafIwYyMMq8CS/3W2PCeaSAwHZqVtRru4ez3wpbWT3mPHwD19alSisf06
 H/3W2fJmk5aWPSZZGOMPSOL+qxQY0NaVXpTWt2G/jEPRySZiZ3OwGHUIwiGRE2LnAVHF
 bR6XuVLXEIlYD95LEnGyWgLS2pitiuJdp1hIxhpV4M4L8laEdXs5dbiREnjHsFuq5/yb
 KOSwVC5dBB1055xUs6tu5lJpRt5zFE5nr5v5vvKEHtuiEJmZg2K8Uk0v3sa13N7RUafV
 1FTdGDwtMMthE8BHQ3kl6m6J1wrMZ08c/UCoQxUFm4TyfJ6j003XGlHE48oUSk7M7T1g
 L5pw==
X-Gm-Message-State: APjAAAV3lig5sjwtlt+VPU0ytI1YOT+ood4MFGGns6mX3bJDVYpGbf1N
 93g1F1bZn35hXF5VsUFQmGGSTw==
X-Google-Smtp-Source: APXvYqz80bZ1GLBQ1Q96QB6cY5OygZiytZfcYiKZxBmtZO8EUFJNMD+D8l5TUu/+MVKZFBcaVaEahw==
X-Received: by 2002:a65:5043:: with SMTP id k3mr63508775pgo.406.1564679297748; 
 Thu, 01 Aug 2019 10:08:17 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s22sm79854820pfh.107.2019.08.01.10.08.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 10:08:17 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <86712f49-a013-28ca-8e85-aa2a35da25e0@linaro.org>
Date: Thu, 1 Aug 2019 10:08:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v4 17/54] cputlb: document
 get_page_addr_code
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, aaron@os.amperecomputing.com,
 cota@braap.org, bobby.prani@gmail.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/cputlb.c      |  5 -----
>  include/exec/exec-all.h | 24 +++++++++++++++++++++---
>  2 files changed, 21 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

