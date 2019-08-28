Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFF6C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D6520679
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xg16xEln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D6520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i372z-0002m9-2G
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 19:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i372E-0002Kj-J0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i372D-0004EF-Bo
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:07:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i372D-0004Dv-5Y
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 19:07:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id m9so638836pls.8
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XWCSwHAh3iLA0HD5QuvSzlf/05WWkUGMgVp+ZYY/b3w=;
 b=Xg16xElnJcNjrcoBB4okyE4ZGEiYrHl1iLaMmqB/Ntc2mtD/GuAEZXHo8+1dNRYxOI
 +DNBg+/u0xVdG92ksdFsybXm5vcr+SpFO644KjAHpzNAdWi45wqMRrPDjJAJGIHzc0V1
 04ZaeS6/0eghP7NaaI/GQf4HU/W5H4oiselFNwxywM9aCvGHSsoHQB2HI7eWFvb/Sm9F
 TF8yZKmT/oGsvy3kk7nx19Eqsr6ng2inLl8n9f37VAgtHFTsaYM/npQkzXlSODOE1x9C
 wZ19589qpAhSGo1V0Ev0FEVkBwYyksYyPw2DtN1vizhP5/Ovovb7EL1FlhV9UK/Qhd/R
 eJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XWCSwHAh3iLA0HD5QuvSzlf/05WWkUGMgVp+ZYY/b3w=;
 b=dXf4YnVsPyBm0lNG9lFnYMZgM6VUTlpzAgmW1eOJH7siqS4/DDTrZtOivxgU8Y0hy6
 vfJeZCqb8YLaBkHAUeJTWF4flbZFOtyhCUluGGZ6BEkoXXZ5mSDxPPy5/9o8Sdn4KBbZ
 l/+HzzYFeNoFsf+tTBz86DaovnuNf6zk/kVGsW/qbbDnA3868mtZFha4dKTsi+KCUS2y
 dwRg4eIk7itkrAN96N5ubuYQxtBNyqwy+QlQ/OlPoz5VWoIKQ7HhfUxKk0ppUXhWjwa+
 fl/n9y3mebaGhMo1Ff8eQrzqKl89MNUNY25+T/sXABe0Z7Y5KAEde09mW5S6cLKRS5pW
 GIdg==
X-Gm-Message-State: APjAAAVVMUPaoo5Mr/NFX5zfyE71JoqbJgV+lSuuGds9cxLEbMQTOqVG
 n9QynpnkAX23BixesVw2r66aTg==
X-Google-Smtp-Source: APXvYqxZEn+5G+6ml2cCOhtzqIJa87w4MYSem1x8eJoct1SWnj7NwJA8poRA0GgqWmYqVjRH80V7bQ==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr6883631pla.214.1567033643961; 
 Wed, 28 Aug 2019 16:07:23 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e13sm493497pfl.130.2019.08.28.16.07.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Aug 2019 16:07:22 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190826075112.25637-1-david@redhat.com>
 <20190826075112.25637-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2385aa4b-0d67-b6f2-d346-ac66e896f988@linaro.org>
Date: Wed, 28 Aug 2019 16:07:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826075112.25637-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v2 5/7] mips/tcg: Call probe_write() for
 CONFIG_USER_ONLY as well
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pinging the mips maintainers.

r~

On 8/26/19 12:51 AM, David Hildenbrand wrote:
> Let's call it also for CONFIG_USER_ONLY. While at it, add a FIXME and get
> rid of one local variable.
> 
> MIPS code probably needs a bigger refactoring in regards of
> ensure_writable_pages(), similar to s390x, so for example, watchpoints
> can be handled reliably later. The actually accessed addresses should
> be probed only, not full pages.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/mips/op_helper.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 34bcc8d884..08d9a4f9f1 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -4537,16 +4537,14 @@ static inline void ensure_writable_pages(CPUMIPSState *env,
>                                           int mmu_idx,
>                                           uintptr_t retaddr)
>  {
> -#if !defined(CONFIG_USER_ONLY)
> -    target_ulong page_addr;
> +    /* FIXME: Probe the actual accesses (pass and use a size) */
>      if (unlikely(MSA_PAGESPAN(addr))) {
>          /* first page */
>          probe_write(env, addr, 0, mmu_idx, retaddr);
>          /* second page */
> -        page_addr = (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> -        probe_write(env, page_addr, 0, mmu_idx, retaddr);
> +        addr = (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> +        probe_write(env, addr, 0, mmu_idx, retaddr);
>      }
> -#endif
>  }
>  
>  void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
> 


