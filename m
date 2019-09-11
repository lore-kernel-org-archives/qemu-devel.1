Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AEEC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F46920838
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbLrnJOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F46920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i89wB-0002OU-M8
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 17:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i89vK-0001jE-Rn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i89vJ-000279-Sl
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:13:10 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:41397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i89vJ-00026q-OC
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:13:09 -0400
Received: by mail-qt1-x844.google.com with SMTP id j10so27057674qtp.8
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IgkUXb1HqMYBQaZuS+voYnGcYN7P+J1UlbpK846YPFA=;
 b=KbLrnJOUmA7BLoMAU/ir5MDZWt9lR0DWiqxGWIKQyRnHkmBnIZj+E5rmrYIpGdY11Y
 kBBpni3Cvl4xJygWLK8+lWoOU3G/4iOdzDIIKJNS69IzoFt+OGthSZwOp4+coikZ6TBL
 yVxFVSALg2kFyi++aPEhIcXAPg8P/pfbwxPudnQ1bWiC8hjwlklQEDB2LzDRblIJuOoh
 duINbMC7Uy9ePczfAQ7jF0XjxQHbQ0gx30HAVg7qCxJcE426Jkh8rWnughKOen981Oqc
 89oeVxSnPENS2XdEvYG6oQ1WG3pvHX6kMNpS4E1A5vl1QrmRRcfR/vf7JGsMoSO/X4ed
 YsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IgkUXb1HqMYBQaZuS+voYnGcYN7P+J1UlbpK846YPFA=;
 b=cAoxtADHMVjjnsN7BW10FcMTGlkegn85RnrS5ZX50CU6RGxhMK1oElwFJyjnkW+JQ9
 q+03zX35/bN6eQjGD9kojjUoTH0v4g/EYxkxAPwLZWNke6a5gsN9SV6iEFn66C2xUkKh
 zHX53v8JMHYhcZQNRZRmxUrfO8lRfrfSVO1T+SGIoWN6x57I3laW2deUKorQXHfqHxEt
 M98U+q1g47gEgnDgsMAUFK5OWH1DUt04/Vj+LLBtXbIUp3Cw9xoTqMu0yPZ1gdKkSgyj
 M4ZXg5/vDHhySP3DCHdmV7DQ1R/iEMvai/spdg+QG3RNymOqcIa+wnd7kaHgG3/IE6ye
 GHCw==
X-Gm-Message-State: APjAAAXVKaa143w0jJMVBXKCkLc28sy9hRWTh+16E5Mqv/y1rL6oKxo6
 DHIyvCJjuXlHntsWQIihC0ZsyA==
X-Google-Smtp-Source: APXvYqwCbn63ZAXtaBilfd34W3qajMWtOLHs5u7n6plztuzm8fky99xIOcrx0ZepaA/pk2cD/LlSCA==
X-Received: by 2002:a05:6214:16cb:: with SMTP id
 d11mr24033893qvz.241.1568236389031; 
 Wed, 11 Sep 2019 14:13:09 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id c11sm9075387qtq.41.2019.09.11.14.13.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 14:13:08 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-18-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <eddf9cff-9e43-b8f4-f8cf-7beb845a27ba@linaro.org>
Date: Wed, 11 Sep 2019 17:13:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-18-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH v2 17/28] s390x/tcg: MVCS/MVCP: Use
 access_memmove_idx()
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> As we are moving between address spaces, we can use access_memmove_idx()
> without checking for destructive overlaps (especially of real storage
> locations):
>     "Each storage operand is processed left to right. The
>     storage-operand-consistency rules are the same as
>     for MOVE (MVC), except that when the operands
>     overlap in real storage, the use of the common real-
>     storage locations is not necessarily recognized."
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

