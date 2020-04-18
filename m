Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758EAC2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 03:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3064F21D91
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 03:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTMPEP8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3064F21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPeCD-0007zP-9w
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 23:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPe7q-0006O4-1n
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPe7o-0004bV-3b
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:26:37 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPe7m-0004Ul-1V
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 23:26:35 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a22so1857071pjk.5
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 20:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4S5+MAzGOSfi/hcjNLQ8N1bIo2gE5EagUU9lnTXma3U=;
 b=KTMPEP8UruJWUkWgHeehierjPMZYwZs7QKLStALLUGGhV1VmGJOZyiAyDRYVTkfFWE
 ObfaKvK99rUX0t+pDYUms5vclJhuL7tfOEc5WwhQ41Lh1Svm1Ui0XINQ2JiVeYJRwXLi
 qo6M17lkHM7xRqXEPZp7D9NBbT8UzNpQv7jyZvDqI8jIYPmfmWEB4Bpxjv0xleN030s9
 Fd5IMEhz68TkoEmyTZUx1TUigPKA4W8MXdfBfJPPDG4ngkOzyMZnbcI0o5itRNU1R/RK
 /o7PPmE5sSSkrgZbcL46mT5vz6Wb3nhLHuK1oWM9oI4K9fPsqdfq0+n8LZYiI9pBv3+8
 PRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4S5+MAzGOSfi/hcjNLQ8N1bIo2gE5EagUU9lnTXma3U=;
 b=hX5RbXa16ygyB6Hv5D2wWQngZy9PV7S/ton1raNQDWN0TKDa0MmIgGQLgTNtD0t2OU
 31QwGsKP1OVDEL4X8zFzTqvZRdjTZeEALBYbpgt2gaJIc96XVE3oUGMYOBPdzenP6GcG
 CBYW1hpLNS4KkkeGnIBEfuZacTNrbZwzhvapSTxLZjXmUl+dzCU9+zN2NENmNXlPbPZh
 H/siYKNsGuIc95Pw+dx7A59liCxjH+RPHnqouXa0LkDhV72WLQtlsGIrZ1ePl0veWVOb
 7+d5R29oW2mTGHJugvpDu5SLKRVngFjn9sAJjGfJ1MM/7VATzKwO9yLj2J9sBuImh5/h
 6H5A==
X-Gm-Message-State: AGi0Puaz/QZZINJb0N3HN41U5LNiaYvZNcFqWHbs1mwz4XhhI//nn+ME
 EDLGNvqM1i5rW76zvji291tEAQ==
X-Google-Smtp-Source: APiQypLi//sjKQBOSAEDAleUuHXeLgnpN7R5PcM75+lth63JYZkwindhSF9eFrNJf7ZsFAc11NJuHQ==
X-Received: by 2002:a17:90a:1503:: with SMTP id
 l3mr7798799pja.87.1587180387229; 
 Fri, 17 Apr 2020 20:26:27 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id x25sm18788027pfm.203.2020.04.17.20.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 20:26:26 -0700 (PDT)
Subject: Re: [PATCH 10/16] target/arm: Use SVEContLdSt for multi-register
 contiguous loads
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-11-richard.henderson@linaro.org>
 <CAFEAcA91-jPRjasTfPiGaNPwiF0Mye-vUU1p8YG8tWyU4yC8fQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c9be891e-b5b3-c075-5c07-01fd913d3438@linaro.org>
Date: Fri, 17 Apr 2020 20:26:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA91-jPRjasTfPiGaNPwiF0Mye-vUU1p8YG8tWyU4yC8fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 6:35 AM, Peter Maydell wrote:
> On Wed, 11 Mar 2020 at 06:44, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/sve_helper.c | 223 ++++++++++++++--------------------------
>>  1 file changed, 79 insertions(+), 144 deletions(-)
> 
> 
>>  #define DO_LDN_1(N) \
>> -void QEMU_FLATTEN HELPER(sve_ld##N##bb_r) \
>> -    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)  \
>> -{                                                                   \
>> -    sve_ld##N##_r(env, vg, addr, desc, 1, GETPC(), sve_ld1bb_tlb);  \
>> +void HELPER(sve_ld##N##bb_r)(CPUARMState *env, void *vg,        \
>> +                             target_ulong addr, uint32_t desc)  \
>> +{                                                               \
>> +    sve_ldN_r(env, vg, addr, desc, GETPC(), MO_8, MO_8, N,      \
>> +              sve_ld1bb_host, sve_ld1bb_tlb);                   \
>>  }
> 
> Deliberately losing the QEMU_FLATTEN here?

Yes, the main helper is now marked QEMU_ALWAYS_INLINE, and there are further
subroutines -- like sve_check_watchpoints -- that we do not necessarily want to
inline.


r~

