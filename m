Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4234DC2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03ED920857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBPEDqe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ED920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3GGx-0004au-5j
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 04:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GFo-000427-Hv
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GFn-0006g2-Gj
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:30:20 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:32840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3GFn-0006fn-9Q
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:30:19 -0500
Received: by mail-pg1-x543.google.com with SMTP id 6so7476310pgk.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 01:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PjV188ljJOcj5eD5Q+Bzib1gG/XuNZZpkt8IMeQJWxA=;
 b=mBPEDqe/Lh0jrS3ZlXb73eGTAO+G2rYEMvR8s40NCnxQ6vGAsbtq0hXtFGkeLjqxnB
 xAQWyLaygG7LSbbFa1jChdF+pBmilbrAWWqa/dTLapa3gZkuXfEJYGSxlX+TwypGzMXt
 uAaFQsekdnvARbfH+5pq/OMvcrvazwYbRrMWwyXSbMrVH2x4l/Ao8AwGoPK/364LoAlV
 4wIij/GzZ9/e+obAAjnn3P05R+NQyK5mpHufcZ3mcQrktUC9SlNP2XHopD/qvdSyz4Mc
 HdTBtodlEK9+8nOYXgjfPxASigbrMaeWYrwWKs3E1M/hIO4PtyyukPihx3cEFAwHmfPv
 BSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PjV188ljJOcj5eD5Q+Bzib1gG/XuNZZpkt8IMeQJWxA=;
 b=WIcZCwEJ7k5FyQKYmgXvwWu/4xgac4coK2+tOTVJu/+288undiAR7ydlb9/cet1M+H
 VW15IlvJNp4Kj8bPI+uX+JvNTeufLM5wvrSYqifuWEy8rfq7qR+gRI6DRDrz07WhV3ut
 oUB23Tq6dmVwO4eKPhGy96zIOmsDvOx+llG5xOriiUA1u0Efzr9RNIT1gNwLeCqj7Kxl
 V/qVIPlIxsDQ8FgHoOFi0iwyGgsxJmxhQ4rCcP4ltfezBeAmCl0wpipuYCdYi5MDHxx7
 H6cMqC2OUwRDlL71xUw0Z0BtTKse6hc6xGw+NHLaG9pSYsO4df7EvGhmv/apg0yK8RSm
 o4mQ==
X-Gm-Message-State: APjAAAWt74v/IJh2iLfWkExvlMvYsfyJ9Kxisa0M2lURXG8KH0OSNsfp
 uU0+FUuG35Zx77fFmsCloCkeSw==
X-Google-Smtp-Source: APXvYqxyTVZV8jn9k2Gey0mBy9iJEwqt/4AzJYg+kW+9FYG3b3anof2tr2y4KVfddMUbLekFNquo6A==
X-Received: by 2002:aa7:8815:: with SMTP id c21mr11345865pfo.81.1581845417905; 
 Sun, 16 Feb 2020 01:30:17 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q17sm12803261pfg.123.2020.02.16.01.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2020 01:30:17 -0800 (PST)
Subject: Re: [PATCH v2 19/19] tests/tcg: take into account expected clashes
 pauth-4
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ded4f25b-817e-ec52-120b-8aecb2ebdb9c@linaro.org>
Date: Sun, 16 Feb 2020 01:30:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213225109.13120-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, robert.foley@linaro.org, pbonzini@redhat.com,
 stefanb@linux.vnet.ibm.com, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 2:51 PM, Alex Bennée wrote:
> Pointer authentication isn't perfect so measure the percentage of
> failed checks. As we want to vary the pointer that is authenticated we
> recurse down the stack.
> 

You're no longer recursing.

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/aarch64/pauth-4.c | 54 +++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/tests/tcg/aarch64/pauth-4.c b/tests/tcg/aarch64/pauth-4.c
> index 1040e92aec3..24a639e36ca 100644
> --- a/tests/tcg/aarch64/pauth-4.c
> +++ b/tests/tcg/aarch64/pauth-4.c
> @@ -1,25 +1,45 @@
>  #include <stdint.h>
>  #include <assert.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#define TESTS 1000
>  
>  int main()
>  {
> -  uintptr_t x, y;
> +    int i, count = 0;
> +    float perc;
> +    void *base = malloc(TESTS);
> +
> +    for (i = 0; i < TESTS; i++) {
> +        uintptr_t in, x, y;
> +
> +        in = i + (uintptr_t) base;

There's no reason all of these couldn't be char* or void* instead of casting to
uintptr_t.  Nothing else would have to change.

> +
> +        asm("mov %0, %[in]\n\t"
> +            "pacia %0, sp\n\t"        /* sigill if pauth not supported */
> +            "eor %0, %0, #4\n\t"      /* corrupt single bit */
> +            "mov %1, %0\n\t"
> +            "autia %1, sp\n\t"        /* validate corrupted pointer */
> +            "xpaci %0\n\t"            /* strip pac from corrupted pointer */
> +            : /* out */ "=r"(x), "=r"(y)
> +            : /* in */ [in] "r" (in)

It's weird to have some arguments named and some not.  Why not just use %2,
since this is simple enough?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

