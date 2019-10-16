Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19019FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 18:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1CE20663
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 18:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLnD2Dre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1CE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKoO4-0006PH-Lg
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 14:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKoKL-0002lu-EL
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 14:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKoKK-0006za-83
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 14:47:17 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKoKK-0006yA-0d
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 14:47:16 -0400
Received: by mail-pl1-x641.google.com with SMTP id c3so11689400plo.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oT2+I5qdl/QLcnFXPgrdDc5+Ul9qm1xEOgzalw/cvs0=;
 b=zLnD2DrepxfTHtTcvXdKGcyHKW+ovg0E0vsRVCgRPXcrVCzAl7i5DGZ7JnpNm8EjRQ
 FsdsVUyxdXzFo+Nc6M2kvi9DamhCzOEgd8KIXuy0MxCvzGtaui8XOe3eUegrFm/tMCLr
 X8hSPzLgrGdH4miEdndq0XXXrGkzW3nJVbufsXjIgjcIvJGy+wd3IvvQ4rfybIriw44T
 EupJyO+M4sServ4Ip8EN0avK1JUzvi4DKygHjfAa4gtIiDCV3RiHZH1/VcZxmjkMvvvF
 0vhQh/qeOYpt99xJHmS2T/Bodu9yaHu/SqO+68l8ZsbZtRG0LVI/vOaOchqxfWEWy84z
 HBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oT2+I5qdl/QLcnFXPgrdDc5+Ul9qm1xEOgzalw/cvs0=;
 b=UdsBjaDc9qf1RFpI78Rnlr+O0zRGVh+PkY3MzusEDh6tfckHtxqdJUyLwnSUxOu1qS
 28tyFAa9v+S7mAprCsXTvZM3airmZrm0eGF+rNVoverhbhvT+fMMANiseylrPcrM29h7
 TeICI3zyBT9sG5HXaaUzPKh6aEn5azSJiIDaFEEnwbzYWXC3ZyzrPjXbgPV930IvjWaG
 XkEjFjDl4D6emZEgGunnaCPC4cHLPYUaUlv+WsIhVujfJOnQawRlXdC2OaI2dVutUJ/f
 h4fKBuFmf9vxyc7UL/keJOyjAlfNXVrlFbHplB2Of5hZIDs9GwgqIpBJhKgpDEC+Ay35
 Y2fQ==
X-Gm-Message-State: APjAAAUa29bDZeQ1fLG3XACsKQIfg8XO8P7vP5Z7+1krEKlprQL//WXv
 tPCUiGRAMRhin04dJ21xj86KTw==
X-Google-Smtp-Source: APXvYqy3ewcJzxaD6WF1L4Bxpuw6Unn/9Q6FZ9gWUlfhwFZ24tHiqQpHLpdfEQrKMIcpt3+cvKdyXw==
X-Received: by 2002:a17:902:d698:: with SMTP id
 v24mr42533639ply.89.1571251634179; 
 Wed, 16 Oct 2019 11:47:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z20sm28312087pfj.156.2019.10.16.11.47.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Oct 2019 11:47:13 -0700 (PDT)
Subject: Re: [PATCH v3] target/arm/arch_dump: Add SVE notes
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191016163750.11751-1-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <13c4d99b-2e63-af31-1ce3-5f733c957d11@linaro.org>
Date: Wed, 16 Oct 2019 11:47:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016163750.11751-1-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, Dave.Martin@arm.com,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 9:37 AM, Andrew Jones wrote:
> When dumping a guest with dump-guest-memory also dump the SVE
> registers if they are in use.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
> v3:
>   - Pulled sve_bswap64 out of kvm64.c and reused it here
>   - Changed fpsr_offset and sve_size to only align to a
>     16 byte boundary from the note payload offset, not
>     from the note head. Doing this makes it consistent
>     with the documentation and what gcore does. Testing
>     shows that the elf headers and gdb are still happy.
>   - Added blank lines between functions
> 
> 
>  include/elf.h          |   2 +
>  target/arm/arch_dump.c | 124 ++++++++++++++++++++++++++++++++++++++++-
>  target/arm/cpu.h       |  25 +++++++++
>  target/arm/kvm64.c     |  24 --------
>  4 files changed, 149 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

