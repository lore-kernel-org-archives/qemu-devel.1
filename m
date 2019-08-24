Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C06C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 22:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA942133F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 22:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4PulgnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA942133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1ebi-0000eE-Sq
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 18:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1eZh-0007eM-8C
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 18:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1eZf-0005IU-FY
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 18:31:57 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1eZf-0005HX-8d
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 18:31:55 -0400
Received: by mail-pl1-x641.google.com with SMTP id gn20so7798107plb.2
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 15:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dgozhzbZhl2DGjesyRZN6LFZeNdvAlJkSBsLs+L5vV0=;
 b=Q4PulgnVIqfuCScSu7i/BTp/1teOlDqCNpwvIZpefFm/9ZU4gIc5zhNXufuvXjuuM/
 m+aQ0vHc6xT1SHuuG8BQIKYrV8J+JGDtB/uSWDfJiSethq/PhWtI31CwCvHJQJU0GQ6y
 sVEZGvtrOsvDMcpyth2JXXJaxq39O3yNePTgnixpE/obxKjKEn382S5MEhRAxiDIBrIy
 4UXX6envFLkWi/A2jHa3tn882J5Vit0WtgPTObfCryGvrJaFv2OONlFCZ4K6JOoJiUcx
 VPLEpH0thpBxJXMevhSSO8IeslwoD5RP7HTCbSXuenP6LL9OijKoRTQjnkiJmRC4oa2Q
 eAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dgozhzbZhl2DGjesyRZN6LFZeNdvAlJkSBsLs+L5vV0=;
 b=FEikzglIEIuBlhAzSDlusnkaegY8VCUz5vH3l7J7+edCtTYH8zaLHk6a2Pcn5iodUS
 /j7ST9fg+zzzs7+IDIJ0lPUgMBBbg9nORDQ6nxvuVT1xzOK2ixW9SRMnRY3gTtqKFefd
 aFdWBxjFS/hzDYDCQ8nS6/+j8oNpaGnx+vNjDLAOBHoZLc7vE1PSSc/a2H+vaferxMlx
 ZgDb3Funt9qn+Gdct8mM99K69dxx9gSYlpmQepXtQx9F9jIuMQI6PN/A22lVJ/6+qwmD
 YA1L7QJZGHeoRnckph4/QP0/xChpIkpfD+kQhqhYAqT5CAXrZyYA3ie7Tbj+/Je1h4a7
 tzjg==
X-Gm-Message-State: APjAAAVJ4oyRl6kB7wMezq+VhVUg6jRwv8QRMC1f+3wyTO0aMrv41z2q
 NJ4v6LnIG9J87Zi8KnCbUcPYUQ==
X-Google-Smtp-Source: APXvYqyOG1jAhsEPVUSZTZsW8PifUu7twsWNoWN/rZMIMt0NeoLrDNzko06ZgLGsSNHdK8yWocjx7A==
X-Received: by 2002:a17:902:1a4:: with SMTP id
 b33mr11511087plb.141.1566685912634; 
 Sat, 24 Aug 2019 15:31:52 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n185sm5827100pga.16.2019.08.24.15.31.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 24 Aug 2019 15:31:51 -0700 (PDT)
To: Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
References: <cover.1566588033.git.tony.nguyen@bt.com>
 <11377fa49c502c61e74f5cab4d20ea89e317597b.1566588034.git.tony.nguyen@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c3d3aedd-21a0-95db-b923-a948b177896e@linaro.org>
Date: Sat, 24 Aug 2019 15:31:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <11377fa49c502c61e74f5cab4d20ea89e317597b.1566588034.git.tony.nguyen@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH 8/9] exec: Delete DEVICE_HOST_ENDIAN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 12:42 PM, Tony Nguyen wrote:
> Simplify code with MemOp short hand for host endianness, 0.
> 
>  typedef enum MemOp {
>      /* snip */
>  #ifdef HOST_WORDS_BIGENDIAN
>      MO_LE    = MO_BSWAP,
>      MO_BE    = 0,
>  #else
>      MO_LE    = 0,
>      MO_BE    = MO_BSWAP,
>  #endif
>      /* snip */
>  };
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  include/exec/cpu-common.h | 8 --------
>  memory.c                  | 2 +-
>  2 files changed, 1 insertion(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


