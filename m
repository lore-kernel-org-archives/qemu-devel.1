Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9462BC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C881206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGrUltQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C881206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htI0Q-00074L-IK
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 16:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42477)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htHzE-0006Z7-35
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htHzD-00082B-3S
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:47:43 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htHzB-0007yd-Sd
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:47:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id i18so34845486pgl.11
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b4kVjdpGZbLf/8nRycCme8mAZwkpIzWc4bLvtJCotyQ=;
 b=PGrUltQu7NgHQAKQq8oFBzIuHXcqv+8cD5GZFK/MRCYv7YQlbPBDe1V1iVxqNtvT0b
 rYqXs1uDpiXxXgJXRni972KWKB6YtrI5islbk0RqBw052Mrf0SzjtSJYxhBkVouGSvzO
 pKJ7uhytN3BPKyXkv612aTsxLW6axFmkwJXWhX3ku19nbhZYvOJD5fof/VUlfaQ2E+bb
 TFJoAFDCU0KB+kdSlRfc+jmiFvwddUtAw+iqcPX6/ewR+X9u58PuOWA1GevfkwnMsOnA
 z6GNfCJVwB+9Sb/uIkgWofqwE4eZ1zfFvXGNXQYO0dRN37iPwksvqqcQ5Ga4p49dKxU4
 uZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b4kVjdpGZbLf/8nRycCme8mAZwkpIzWc4bLvtJCotyQ=;
 b=YiAtdNnyoNLgxZNGJFIOaojk15bVfw3fock2VrTwdLDZtccN5T+tU8gNwI5i08olHG
 qTaduZRwfKXf+77VYcm/tdhoKwa7hKK6cgq5DlIHojHgatrkNWHtWeibqMwjVOChHo6S
 5XYwvSs9sRaZAdXltnfuvDy/RzK7jlmvElHTs5J/zO+6uz2XN821at+HRRxtLNpmF4WA
 b6zxNXnwyVHHweuc0UEKT+mmWnD82XlDcY7BlZAF3umMNAIkxZNruLzlbZy4mrPhkNmY
 nBOqxHH6QUWXBu+DFfC9+iMD5+N+oMbrsHiM72FGEI6Fuj5Cydv7AYOi1c2VHNNU/BVe
 Aq8A==
X-Gm-Message-State: APjAAAWo5z4oZ5pcd1D7TkBBSkXjN6ejzSYgkkTpS+A3R5SL8+v6OpdA
 2cVoJhk4PuPmEVyBLf08tQ738A==
X-Google-Smtp-Source: APXvYqw2HVOgbYvHLkEQ3mW9Ow4jS69O8U64sKJHfCXRAssl47VEZV1qYO3QMcjOV+F/bQMMcgYE7w==
X-Received: by 2002:a63:1341:: with SMTP id 1mr13444126pgt.48.1564692459242;
 Thu, 01 Aug 2019 13:47:39 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n17sm76480086pfq.182.2019.08.01.13.47.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 13:47:38 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190801183012.17564-1-peter.maydell@linaro.org>
 <20190801183012.17564-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e109310a-b332-419a-351d-270257f5053e@linaro.org>
Date: Thu, 1 Aug 2019 13:47:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801183012.17564-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 7/7] target/sparc: Switch to
 do_transaction_failed() hook
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
> Switch the SPARC target from the old unassigned_access hook to the
> new do_transaction_failed hook.
> 
> This will cause the "if transaction failed" code paths added in
> the previous commits to become active if the access is to an
> unassigned address. In particular we'll now handle bus errors
> during page table walks correctly (generating a translation
> error with the right kind of fault status).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/sparc/cpu.h         |  8 +++++---
>  target/sparc/cpu.c         |  2 +-
>  target/sparc/ldst_helper.c | 16 ++++++++++++----
>  3 files changed, 18 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


