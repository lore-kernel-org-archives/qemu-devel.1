Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BE2C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A1620709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aV7rQ4KQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A1620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLIo-0007pg-BA
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jFLHb-0006Ak-0f
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jFLHY-0006LT-UE
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:18:05 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jFLHY-0006Hl-OD
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:18:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id k191so2259397pgc.13
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qIB6jkR/s1qqDGOFVH/Kpkhos9XqRZ6Ggi7gQgeb0Qc=;
 b=aV7rQ4KQb1NIoZizYvkfN8iKm5qL/5rycpMKtXzkqRuAOzoRlFnzNlkGiNZW9LWfJF
 eyzTJ4er9mwsujNlxq2Ck2rpZGqdrG/6rS7vD2gzpcZxpvEPyCjrFjQK2o4TRzyoTu6R
 Nkg/UEL+cBlSAjN2a2zyysFk99dGk6f1coH64rPaD/8dUsNzjY7s8Nb2k0njd8U2QDTt
 KxpxQOpcreLePhjsrYyoJPFe7K7z77smYJaB/5szJqB/u1pI9/lkSyzU0EA3erGaUdtE
 mnIVPT4DZI4z1PHVhijKC2hULjO+I3y0L+VbVArwpn0kqOkoe8DrELiWpVRZFuGMxxhf
 8ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qIB6jkR/s1qqDGOFVH/Kpkhos9XqRZ6Ggi7gQgeb0Qc=;
 b=GKbf3h7Ho4DYvtinsGI/LbkELje1UPt56Ydd314i+hv2RYkh3UN/DeD+G58wPy3hCg
 l1ndlpxuOBXuVIH4uD/LaLGXQd/YUYPqMLefDxpO9YSWJbRmILjbBVg9DDJfVWuVZEX7
 6DvpiG/1W5R5jYtWhtiEdR7fkxnzG1kg/0IG1x9XqFzE0dUFK2Y6Ag8fW6fF66NB9fAe
 GBOlrCx8Svf5NJJPMteVkhYzJZ8dFKK/eSiHhi2N344ScmVmSK5/05j0+KlgNer5F7X2
 dXI2Myz0XNBmUA0+tGRJBoSHNJO9K+n6y/raJnAhuUBVVLwTXw3L6heS5SPPKN99CEP5
 Ry8g==
X-Gm-Message-State: ANhLgQ2kj0JLOV77ILDHdfgx2Y4H6i8yREAtBhiCkvwsPEwNMIS5IKs0
 Vo9vI4nZqWdSpIZa+asD0HLN3w==
X-Google-Smtp-Source: ADFU+vtrBCar5/dSIDlFmCHZgDgv4QzKd+QMKMRw+0X1CuRY0LC3t4HQ7Xwx0H/lxm9bSufdfRT36g==
X-Received: by 2002:a62:6244:: with SMTP id w65mr10956199pfb.89.1584724683626; 
 Fri, 20 Mar 2020 10:18:03 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z11sm6096283pfa.149.2020.03.20.10.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 10:18:03 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] thread.h: Fix Coverity version of
 qemu_cond_timedwait()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200319193323.2038-1-peter.maydell@linaro.org>
 <20200319193323.2038-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cec33698-78f7-a593-bf7d-f3808a954a44@linaro.org>
Date: Fri, 20 Mar 2020 10:18:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319193323.2038-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 12:33 PM, Peter Maydell wrote:
> For Coverity's benefit, we provide simpler versions of functions like
> qemu_mutex_lock(), qemu_cond_wait() and qemu_cond_timedwait().  When
> we added qemu_cond_timedwait() in commit 3dcc9c6ec4ea, a cut and
> paste error meant that the Coverity version of qemu_cond_timedwait()
> was using the wrong _impl function, which makes the Coverity parser
> complain:
> 
> "/qemu/include/qemu/thread.h", line 159: warning #140: too many arguments in
>           function call
>       return qemu_cond_timedwait(cond, mutex, ms);
>              ^
> 
> "/qemu/include/qemu/thread.h", line 159: warning #120: return value type does
>           not match the function type
>       return qemu_cond_timedwait(cond, mutex, ms);
>              ^
> 
> "/qemu/include/qemu/thread.h", line 156: warning #1563: function
>           "qemu_cond_timedwait" not emitted, consider modeling it or review
>           parse diagnostics to improve fidelity
>   static inline bool (qemu_cond_timedwait)(QemuCond *cond, QemuMutex *mutex,
>                       ^
> 
> These aren't fatal, but reduce the scope of the analysis. Fix the error.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/qemu/thread.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


