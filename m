Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CFEC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311532075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwWZPIqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311532075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84AA-0002kL-L2
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i843k-00068s-NI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i843i-0002UV-Lz
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:57:28 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:39549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i843i-0002Tp-HJ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:57:26 -0400
Received: by mail-qk1-x742.google.com with SMTP id 4so21072469qki.6
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5/gmscF6hvEPxTEv2Heb2SvoZPUVzRrbrJXUExuN+zs=;
 b=SwWZPIqyWtbr3K3mpXh1Mx5+PA+uf6hOVO8zkb4H0MzM0nVsUtOuHzroT4FkINLI6T
 HV/NHB+ncxmCGkxIk7YxGj/aU7ATyP3rTiFMd5ImR+e2NwsdLLkF1h/ul2ikO2/6BvrI
 I+OXhdOWUGoLqFpSA74gkZ+Sz1inYwjYbCdge6GNZP/B600WJs5Fq2g6YA3fGk9XYq0d
 kfGyhu9oTlnmkn9C3D9Vt/Qb6Kht013rDIc/nrqSqwhlvEQ3rRlNZ+eOSc071LmFeALP
 rIjtHhLw/Rc88P9jzms0+onm/KkSsQO2AWXPA3pQgKbaxCxoHhvubKoUsMuU8nj0CMNs
 tTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5/gmscF6hvEPxTEv2Heb2SvoZPUVzRrbrJXUExuN+zs=;
 b=d9V4GoF/D/C2C8B8ZyBjgzKrV4mZBPXm4IJzqqH5HoyOwG7CS9fkodQ7YYaydlqmXQ
 yS4SCkXwTof6tb7Ykr8EduuHTcyN1Hn8pQY1oLZWbgpycQD3tV1If5fmB5jxNgfabn5z
 1m9OLn9w3gwwH1g3gSS31Abzj7eesCsfz7DBQl2mGiSsOGsmmbyYEEu4ZqSUZ+pavkhT
 1Yha8yWuuMBtOmXP/Kj6j+dgkWhSFXkrf+TcSFAK1G8M9WYVVF45aPeP+EptTbQmJO+H
 y+MjOtLfr2o/Hzh1xJcyrc7GZAFkgXr6sgobSog3EqNTH+hiV/+5vvU4aDJ9EtJ/ln74
 nL+w==
X-Gm-Message-State: APjAAAXlo3DVenaoFaFAK5zmU0SHRM+O4H7GTr/mQU0fqSq1z6WZnreq
 kTPBj4f0Kl5NRCpyso47N43ZKQ==
X-Google-Smtp-Source: APXvYqyOvyfR1YScpwTPJ5OAv+z5oPivd6Y7YkKgz37ichj8QO/C+/G4qQFT0Yje8QMbToy8CFaKxg==
X-Received: by 2002:ae9:ec07:: with SMTP id h7mr4777066qkg.309.1568213844301; 
 Wed, 11 Sep 2019 07:57:24 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id t126sm10060559qkh.119.2019.09.11.07.57.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 07:57:23 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9a171b2e-a8fc-d05e-dabc-d76b858e0206@linaro.org>
Date: Wed, 11 Sep 2019 10:57:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: Re: [Qemu-devel] [PATCH v2 07/28] s390x/tcg: MVPG: Check for
 specification exceptions
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
> Perform the checks documented in the PoP.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


