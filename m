Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09616C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 05:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C512C20714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 05:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="LIcbJspK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C512C20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHhLG-0002SP-UI
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 01:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cota@braap.org>) id 1jHhKf-0001vq-8T
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cota@braap.org>) id 1jHhKe-0000y8-1K
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:15:01 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:38436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cota@braap.org>) id 1jHhKd-0000uX-Iq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:14:59 -0400
Received: by mail-qv1-xf41.google.com with SMTP id p60so4347834qva.5
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 22:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=T7lAGOD8K9e8DxesI99aY07CELAdald4LDOlhcowiQI=;
 b=LIcbJspK/rbg9pBbCkTWy00+l1X/aTNhbFlfaGHkv9ytiKOKpBxm3/Uy9Ch7WkRJOV
 vIFPQ7OV0PSyTGjakSgENchr1Z+aFAL+u1/n96yVvc6/9GOyL6paoUNDadWmOxNXmu/R
 ndIffEj4rSXT7rMJsRTklBEyKgBgtHXip/3gBWiDh64myHdw6mjDYWB/AA9hTmVZtY9q
 ZWwikF3vRjSoL+lrw5RQtCBTYpnUtZ1pD/AsTymWZk/EQ0FSNY/y6FA4JPgQXsMfSaTC
 5vzBARz+s+vfHH1hJUDmTDRI8nQozW7MrUo/AirjM7HJp+Uu6/X5cAoYTlofHL5V2nrF
 meng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=T7lAGOD8K9e8DxesI99aY07CELAdald4LDOlhcowiQI=;
 b=ILdJp+WJJPDIUXqRhWxrieFWz2eWk3Byi8spJmO/8ZTEzubpfJxgNYoTjOswqOQfFJ
 hUFBFeLW+6oQBBtFOXgZynA7WVryVVBLFtOgdfwvSiP4UAjxfdi31+m4DWWnBQhd9dw3
 XvznrIiQVd7gpvD1SKknu55/vrrMrP2UUgX8T31jbg1oj95UPlbFXmQXU8Xr/ZKb2XEW
 NMcJJyDzQcDRBiuaC+0i2Y0qB9B8krFNJn7xF32ldy0bYX1sVBnZ6Ogxn/boeONaLUXl
 MapGOGoUiv7WuRQitNaCn8+bCzRN8VDLuTUTftwoWQ496WA2iXt77cnQ+MHjUxl5lD67
 JLxA==
X-Gm-Message-State: ANhLgQ17PqBp7jIZ3VAfQZzJoRtUzzIjoWEkwwmDg8LLuD7JjczOj4Z0
 Pwre7LqOyGxTEg/fgXeIJDrr9g==
X-Google-Smtp-Source: ADFU+vvvDeoeoVzfdL4lRcUg7RsmgpCtAh/cKP9mpqJdxtfuSrWy9xdtLsL41ZNCr8EYVgcvS67vDQ==
X-Received: by 2002:a0c:c3d0:: with SMTP id p16mr9843974qvi.230.1585286098375; 
 Thu, 26 Mar 2020 22:14:58 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id g201sm2932762qke.99.2020.03.26.22.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 22:14:57 -0700 (PDT)
Date: Fri, 27 Mar 2020 01:14:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v8 00/74] per-CPU locks
Message-ID: <20200327051457.GA2815@t420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, peter.puhov@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(Apologies if I missed some Cc's; I was not Cc'ed in patch 0
 so I'm blindly crafting a reply.)

On Thu, Mar 26, 2020 at 15:30:43 -0400, Robert Foley wrote:
> This is a continuation of the series created by Emilio Cota.
> We are picking up this patch set with the goal to apply 
> any fixes or updates needed to get this accepted.

Thanks for picking this up!

> Listed below are the changes for this version of the patch, 
> aside from the merge related changes.
> 
> Changes for V8:
> - Fixed issue where in rr mode we could destroy the BQL twice.

I remember doing little to no testing in record-replay mode, so
there should be more bugs hiding in there :-)

> - Found/fixed bug that had been hit in testing previously during 
> the last consideration of this patch.
>  We reproduced the issue hit in the qtest: bios-tables-test.
>  The issue was introduced by dropping the BQL, and found us
>  (very rarely) missing the condition variable wakeup in
>  qemu_tcg_rr_cpu_thread_fn().

Aah, this one:
  https://patchwork.kernel.org/patch/10838149/#22516931
How did you identify the problem? Was it code inspection or using a tool
like rr? I remember this being hard to reproduce reliably.

On a related note, I've done some work to get QEMU-system to work
under thread sanitizer, since tsan now supports our longjmp-based
coroutines (hurrah!). My idea was to integrate tsan in QEMU (i.e.
bring tsan warnings to 0) before (re)trying to merge the
per-CPU lock patchset; this would minimize the potential for
regressions, which from my personal viewpoint seems like a reasonable
thing to do especially now that I have little time to work on QEMU.

If there's interest in doing the tsan work first, then I'd be
happy to send to the list as soon as this weekend the changes that
I have so far [1].

Thanks,
		Emilio

[1] WIP branch: https://github.com/cota/qemu/commits/tsan

