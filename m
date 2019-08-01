Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEDFC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC56206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vI9j6qIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC56206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFqo-0006HU-7X
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59029)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htFp9-00059F-Ol
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htFp6-0001aR-Nq
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:29:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htFp4-0001Yw-Uj
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:29:07 -0400
Received: by mail-pf1-x441.google.com with SMTP id t16so34521361pfe.11
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 11:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0VRihQpVS5J/MaK6CW4o9RcG6ZLahoIL7keQrFNuLKo=;
 b=vI9j6qIpthQVwsl8O70+/EqyT6yL0/mZmGMVLNNuUJiOwnPNMrNqQVXUftJx8N8O9i
 9b1oUXx/pice7bBdb9hDOyeWwlDrJs/idl3v61Bk3HyPjDG/39l9jWLJgjzs+Pn1df2c
 V6WYnKWCidRomKhvVsTaeqKquSxq5BxAdNszzYA8ZQw4hOV1qQ9smyNm6uJcD+G+S8Tt
 Z0rdhmwxqgbdO3uS43MdeGfD8hc1fBmtDecM3MXmIGYz8EV7DK1B9IPpXNp9ZB86uqTb
 3UzMt48vLO3p+l21TQe2JvUcqSC2RbyurRNfRTPbSynIXHJYuy7YSKi0kNpIsuU03p/R
 6fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0VRihQpVS5J/MaK6CW4o9RcG6ZLahoIL7keQrFNuLKo=;
 b=XQwTzCJHPed6OPL7K+MJSLx8BQ5tOlYs90q73f18n0+z23QJmu26276rQxBnGoKv3x
 9m3ioSbA6jvBV+2zV/afHHcJ2ZIOMZ41zV2HERligesvTLz+7JUwMNfSveI3TXM+IahT
 hPfL8tVRTAZu7lkB88ycIidx0uZcILJ8oaR6HWYwOBcZbHiE9he1vs5cPA/9DN3awh8a
 AXViSzakSWAsBnWStlFmwH0De69A3tJr5WOO1/RKS3u0jbDUBO3UXIBUPUEmfOsgpfz3
 pw3xhFIT4yAbu6I905hze5akFpJHuzD5WIirULIHm5ZLmWRmt09VCGohHc6Ayvg1PfQm
 67uQ==
X-Gm-Message-State: APjAAAXN/VbTW/t5Q3CtOfKJOpttdbsHlepsFfQSjMyO9/G6oYUrEkAo
 T5cZzrnXEB2hNpsO3+5NgoD5sg==
X-Google-Smtp-Source: APXvYqzlZRMoNQAwf7k6mdscNADppCqeVHyM3XD5++o/dti/+58Xivu9VeXYZJzsFGGCUuP1bjyE5w==
X-Received: by 2002:a17:90a:4f0e:: with SMTP id
 p14mr171469pjh.40.1564684144478; 
 Thu, 01 Aug 2019 11:29:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e11sm85818200pfm.35.2019.08.01.11.29.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 11:29:03 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-24-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <33357c5c-41ca-4072-8958-3611bf301286@linaro.org>
Date: Thu, 1 Aug 2019 11:29:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v4 23/54] tcg: let plugins instrument
 virtual memory accesses
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
> To capture all memory accesses we need hook into all the various
> helper functions that are involved in memory operations as well as the
> injected inline helper calls. A later commit will allow us to resolve
> the actual guest HW addresses by replaying the lookup.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [AJB: drop haddr handling, just deal in vaddr]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - fixes for cpu_neg()
> v4
>   - rebase fixups, moved cpu_neg() fixes down the stack
>   - drop haddr support - will be restored with later helper
>   - reword commit
> ---
>  accel/tcg/atomic_common.inc.c             |  4 +++
>  accel/tcg/atomic_template.h               |  1 +
>  accel/tcg/cpu-exec.c                      |  3 ++
>  accel/tcg/cputlb.c                        | 14 ++++----
>  include/exec/cpu-defs.h                   |  1 +
>  include/exec/cpu_ldst_template.h          | 28 +++++++++-------
>  include/exec/cpu_ldst_useronly_template.h | 29 ++++++++--------
>  tcg/tcg-op.c                              | 40 ++++++++++++++++++-----
>  tcg/tcg.h                                 |  1 +
>  9 files changed, 79 insertions(+), 42 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


