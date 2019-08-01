Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1C4C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DF22080C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7M39GvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DF22080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htHcR-00069f-Gm
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 16:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56259)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htHbd-0005S6-Dx
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htHbZ-0003eB-GR
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:23:21 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htHbX-0003cj-Dj
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:23:17 -0400
Received: by mail-pg1-x541.google.com with SMTP id r22so7210692pgk.10
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 13:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6pI+YhFdbEDx7Sc31KYBH3UY1F3MlVfiLKxy7EZZ2dQ=;
 b=u7M39GvFeoOL74TAVkelw0Vm7WwzzzMiEeYzXZfcYAQ5FdBfIHbL+xj//2gIDENllM
 EhFk7P2MlmUlxVdxsJnBkmk2EcaLhrN3YxmYroRP87zzkEuRXLP1fboJu8rdHijjfGRr
 Ht+11saVdXOXxbBd1Ud6c/Rwr3mmSdC4j4aowf8hRjOxKFUjV+ueEaibr52WMkn1joDy
 Ned6J/lVIwQLI0MioFwn6B3Hyut+T/h2MDRTb48vUdFs1ZN+o+9Bmtl/e9wcdNt//lwg
 NkeJgr6v6qFyekZ5e/LUL9GVpkrRdNNV0yKIzbX1ZyK71uEqr/xgSoV1LHPlHSRlDuhB
 ORng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6pI+YhFdbEDx7Sc31KYBH3UY1F3MlVfiLKxy7EZZ2dQ=;
 b=kwJy7V1eZ6ZAwV4kkwoEtgLPZiwgNUnvXHrlGp8OG6hnwY4ZEF6esUgq7wdqAFXSSt
 J4X3g6IQiO6KVOgk9iTl52Bt7Gs8FV99S/2VwtwuzhQSmz6+NNLUUUOmoHe0ZTkpmgpk
 8MytFKNLPA1TWJ9p37GNi7pUhYPeJVS4gJ4tn3T5PDQ1ty3wqMIN140bakuTmHe39JlB
 K/5qajD751hXUGb09vomVzSlor8Lv8quyqyKahmr2SemMvX2uWCMkh6sxPUz81DNUM7p
 bJBlGtOkeJ7ifsSipHww2TBd1CvkSshrGQxbWAW+Mu6WF3tLlpHH69rmHcIk5UODDdl6
 QQEQ==
X-Gm-Message-State: APjAAAUL+ViV4Tqe3nh9pQXLSacTgqb8iwji8AIqtkA4BzBAl9YOg5Gz
 hCi0yxkjKo9gJvwDcbdHhT5avQ==
X-Google-Smtp-Source: APXvYqwuM5K6xmQvXoN7xvWobMHOYpiiaHaMWLKkA6qZNrs2ycunBdWWxeUAHuDJV8IIRMo+SiB+Hw==
X-Received: by 2002:a62:e515:: with SMTP id n21mr56210968pff.186.1564690991239; 
 Thu, 01 Aug 2019 13:23:11 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z63sm46166822pfb.98.2019.08.01.13.23.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 13:23:10 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190801183012.17564-1-peter.maydell@linaro.org>
 <20190801183012.17564-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8751735a-3827-c613-9a96-46058044d86d@linaro.org>
Date: Thu, 1 Aug 2019 13:23:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801183012.17564-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 3/7] target/sparc: Check for transaction
 failures in MXCC stream ASI accesses
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/1/19 11:30 AM, Peter Maydell wrote:
> Currently the ld/st_asi helper functions make calls to the
> ld*_phys() and st*_phys() functions for those ASIs which
> imply direct accesses to physical addresses. These implicitly
> rely on the unassigned_access hook to cause them to generate
> an MMU fault if the access fails.
> 
> Switch to using the address_space_* functions instead, which
> return a MemTxResult that we can check. This means that when
> we switch SPARC over to using the do_transaction_failed hook
> we'll still get the same MMU faults we did before.
> 
> This commit converts the ASIs which do MXCC stream source
> and destination accesses.
> 
> It's not clear to me whether raising an MMU fault like this
> is the correct behaviour if we encounter a bus error, but
> we retain the same behaviour that the old unassigned_access
> hook would implement.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/sparc/ldst_helper.c | 57 +++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


