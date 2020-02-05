Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAFDC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E0C20674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ucCV2ozk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E0C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIQx-0002iX-AE
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izIQ2-0002DW-Nj
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izIQ0-0004Kz-OD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:00:30 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izIQ0-0004CT-FO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:00:28 -0500
Received: by mail-wr1-x444.google.com with SMTP id k11so2118002wrd.9
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 03:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dVy++6v9qouCTYYN65FpPmGQX5wzx57HREdCZKRa/tQ=;
 b=ucCV2ozk82jOaEYhgNz8a5wB/dx8WF4W2aX+BUxMd/R/PUYfQlvGLjCTPSayn8LoPV
 RsiP2j/hTer0iV8JwXBhQAHBKy0ZcaMKyWspmFFe6d/MaZiXNmwdq51vy/MpDB1+ei57
 w3yHOthbtEdJiivEX926X4BdGL5xO7HQDHDwzHg1Ey0WkdaSRgxbBS5eRrXnDkcaxiHl
 eqaEsISEhkpZrLJrrwaxx8SqmCNGOAvOc3bDzhYmIcjIuc79ZsCwfGgIVfp8D1CTaf/Y
 d2GzqzuBaJ8wDz4NDrGq6v08pG9bUdx6S+3m6T3jNR0UhzNObcS0tSiHUl4Q9G0N/Zy5
 DYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dVy++6v9qouCTYYN65FpPmGQX5wzx57HREdCZKRa/tQ=;
 b=Q1p8OHKncRgiZBMPaTovJ7vQgtVBVsw4nbHCm01QONOnZfIJWbMvwYApTE6aeN9Csf
 gm5fhtVdjjU8dbz39A6FfpVHsV/TfKRQcDFU0U4k3f+dda0z2StdKoa+vHdLB5Ye8Ym9
 PUH2PmG5xOR5U6peUF+4hfix2um9LiGYQcA2uRiWa0LBUkppoZqe/7lKnveqI47lWVlr
 JCt0oRN4+JnHsZ5raNb6qwZGubkmGgCA/2aR1THOGhZTDX004bPvJo1rTTJAYGwfuQcF
 CO+5WYKMcECFYYu0JsfCzd78RVA2vVIYxejNl3NzKDLoliWwpxMhTb/wtSb/gP34eV3M
 lujw==
X-Gm-Message-State: APjAAAWSi9no/bWc7PA6p7mtqeTsUNwmEuOzo6x4vsjj/MLgAKlyNgkn
 ogKkD7zo68fp74K2KuSy7lL+ZQ==
X-Google-Smtp-Source: APXvYqwEfrUiA7bz1Ced3UpSIsIXcMLozy1gvsmQGzYGMofOU497P8IiV8HJxLTJiJrRtNQknOIzpg==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr20589922wre.404.1580900427156; 
 Wed, 05 Feb 2020 03:00:27 -0800 (PST)
Received: from [172.27.246.193] ([212.187.182.166])
 by smtp.gmail.com with ESMTPSA id j5sm24771943wrb.33.2020.02.05.03.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 03:00:26 -0800 (PST)
Subject: Re: [PATCH 1/2] exec: flush CPU TB cache in breakpoint_invalidate
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20191127220602.10827-1-jcmvbkbc@gmail.com>
 <20191127220602.10827-2-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bddff04f-3d48-a4d4-85ac-ca19ca7be90c@linaro.org>
Date: Wed, 5 Feb 2020 11:00:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191127220602.10827-2-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, changbin.du@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 10:06 PM, Max Filippov wrote:
> When a breakpoint is inserted at location for which there's currently no
> virtual to physical translation no action is taken on CPU TB cache. If a
> TB for that virtual address already exists but is not visible ATM the
> breakpoint won't be hit next time an instruction at that address will be
> executed.
> 
> Flush entire CPU TB cache in breakpoint_invalidate to force
> re-translation of all TBs for the breakpoint address.
> 
> This change fixes the following scenario:
> - linux user application is running
> - a breakpoint is inserted from QEMU gdbstub for a user address that is
>   not currently present in the target CPU TLB
> - an instruction at that address is executed, but the external debugger
>   doesn't get control.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes RFC->v1:
> - do tb_flush in breakpoint_invalidate unconditionally

I know I had reservations about this, but we now have two patches on list that
fix the problem in this way.

What I would *like* is for each CPUBreakpoint to maintain a list of the TBs to
which it has been applied, so that each can be invalidated.  Our current
management of breakpoints are IMO sloppy.

That said, I don't really have time to work on cleaning this up myself in the
short term, and this is fixing a real bug.  Therefore, I am going to queue this
to tcg-next.

I would still like patch 2/2 to be split, and that can probably go through an
xtensa branch.


r~

> 
>  exec.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index ffdb5185353b..1709b760edc1 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1017,14 +1017,13 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
>  
>  static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
>  {
> -    MemTxAttrs attrs;
> -    hwaddr phys = cpu_get_phys_page_attrs_debug(cpu, pc, &attrs);
> -    int asidx = cpu_asidx_from_attrs(cpu, attrs);
> -    if (phys != -1) {
> -        /* Locks grabbed by tb_invalidate_phys_addr */
> -        tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
> -                                phys | (pc & ~TARGET_PAGE_MASK), attrs);
> -    }
> +    /*
> +     * There may not be a virtual to physical translation for the pc
> +     * right now, but there may exist cached TB for this pc.
> +     * Flush the whole TB cache to force re-translation of such TBs.
> +     * This is heavyweight, but we're debugging anyway.
> +     */
> +    tb_flush(cpu);
>  }
>  #endif
>  
> 


