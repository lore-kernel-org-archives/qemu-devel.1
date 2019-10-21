Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7C4CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D80621783
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTSgLm/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D80621783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaK0-0004rw-Q7
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMaIQ-0003XS-T7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMaIM-0006Rz-Td
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:12:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMaIJ-0006RN-Oj
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:12:33 -0400
Received: by mail-pf1-x444.google.com with SMTP id 205so8718127pfw.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7dT7OTM688MGA5uoMk+W+s3lsw8gztUVps+2pwnbaMc=;
 b=xTSgLm/1Zbi1WcAThB8Kq/OuEsh+ak1+EIiZT2krL1fDEne6PTHb1p41PVKFW4xjL2
 FpvUshoAgWbZuRoWo7ZsE5P20jsn86qgb/Lak5DxclS/9jAazprZhyDfQwqxcOT9RY+b
 Fkn57VNO+HiwCYBSpfEKkMMTm3PdFtGuokpggWMyV5NYCpXsuPlXKO9K8R683aXhC5Nb
 UePZR0OdTh2yT0jDSsbV6jyTTrnuEAHYGPUIqEPnKvCaTKUTfrtX+zQ45uR0KySOchcB
 xDresRemg42SYctdvpJKlxSs1uPO3QR9BwESc4vPe0Pq9PGZixRttUOI32tkWkpwiDsg
 NN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7dT7OTM688MGA5uoMk+W+s3lsw8gztUVps+2pwnbaMc=;
 b=Z3sVKWCFl8FoWcyIv0QwNSdBwxlbJmZ+V+YU/Zyr72q3Sq8k4StWmG4p2gfTQDcmlK
 eHpf4NfdVBDUSN6SZSqVVws5M2ow4n6lQPJWMfVgCffYhx5YPB9qHnpP2y021qrVqbCl
 pIR5sf5c8X9e3i9PfkZ665Yw2AidCXIGf266tHYwhVP0tSheLuXqru0JQF36ib/AyBgc
 kEUBrLob9o5mhXd11mCUztZ+BzK2mEbSbSVtJDxh5hJbJFkGaUDMbOk9/Edyd4D54Gq1
 Wd9jAnoDuDSOe3p1SX75f6oVg1KHEdmiwZkMxrz/F9TkjDsMYvbsWd2cQ8VGltJP3f9L
 j9HA==
X-Gm-Message-State: APjAAAXGpSRzkuCXfI8qRc7uz18sFy8ACVFHi06bL/jSezPtufsdtdXX
 XRqEskzN6366R/I9p7YJg0zZgg==
X-Google-Smtp-Source: APXvYqzpk0oxpnotJFTywMhWm3gm7KqY9xpIeRuhbuchJJefMJKIsc1Kyp6bADjbTlYopOqYWuOq8Q==
X-Received: by 2002:a63:4d61:: with SMTP id n33mr26257882pgl.158.1571674350469; 
 Mon, 21 Oct 2019 09:12:30 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x19sm23197914pgc.59.2019.10.21.09.12.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 09:12:29 -0700 (PDT)
Subject: Re: [PATCH v2] cputlb: ensure _cmmu helper functions follow the
 naming standard
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191021150910.23216-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0fccf5b5-3fed-cba2-6d06-383252e14652@linaro.org>
Date: Mon, 21 Oct 2019 09:12:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021150910.23216-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 8:09 AM, Alex Bennée wrote:
> We document this in docs/devel/load-stores.rst so lets follow it. The
> 32 bit and 64 bit access functions have historically not included the
> sign so we leave those as is. We also introduce some signed helpers
> which are used for loading immediate values in the translator.
> 
> Fixes: 282dffc8
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - add signed ldsb and ldsw
> ---
>  accel/tcg/cputlb.c               | 24 +++++++++++++++++++++---
>  include/exec/cpu_ldst_template.h |  4 ++--
>  target/cris/translate_v10.inc.c  |  3 +--
>  tcg/tcg.h                        | 20 ++++++++++++++------
>  4 files changed, 38 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued.


r~

