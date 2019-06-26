Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FAEC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5E620663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ct4IAQ2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5E620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCoG-0008SZ-As
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44255)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfd-0001aM-IP
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfb-00083x-J3
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCfZ-00081s-Sh
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id w9so5249534wmd.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z8YYx2Y6LaK89T+rtMn/aO9Ykwt2tSeo8pde5EsR2rY=;
 b=Ct4IAQ2TGuZD8EgZDB0Y01hmgPH6ANmw5vj8mpevR2mZdRcfZPwxQWuIAJjdSOUrji
 Fs+7KSbDl+ppcaK4O1IXWMx674XPaKFBhx0gTk/nkRl4i+aQuT44T04dIBNK0tMtIgqU
 dVMTvjrQ2MJ1gPY1Owuh2o4ncA+yA/vmRN//9U5LoZybQo5ftLyqLImeGWj8yVlhYnEC
 jNub3HVe+clIhPxOQAqPcn8jl3j6AvdVvvo2TFQd2nGvl57vjX2LRtFRzMXJqZjdupsf
 q1q0/oZeQmsf0ThPFvkXtHSqORcdTNYvDIm+fOFmhq1LwS9PuFx0jrhRqLhPcYTu1Gf4
 GRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z8YYx2Y6LaK89T+rtMn/aO9Ykwt2tSeo8pde5EsR2rY=;
 b=BHtw0jzHwp4wyvYP+yV0OUeKBwEZy0Iy9yAuBlxt138/J8kLt7Wr5Mhf9qgDRqAXcH
 /4kmG2PFYqwQj/b29Uabo3fZitzCRN1ZnIAkKEWGjijDyGHj9Y/uSb8PRrH3QOYK1cBh
 t5pPpJk3ty6r6alDAQPCaDYysECWzYdr+zAJwUYcpVOyFAelmNzTOYwajw5W6uGAQHoA
 vv5+uJXNpktfn4LOPyGCC7MkByrXBTXLzzRD49ZHY2+90/OqdXumtRR20hpfVX7NnPdU
 i6Uh1W7qcFaAKysspmciu/vUJcHtY+g1DcmIIVQkq90L1iwbBiXQkUlT4jsNgPQ9q5yO
 ZGvA==
X-Gm-Message-State: APjAAAWwC0LwIfjfFKp0rjF723ThOJ9xeP2k8s+YQPdpGDJvhf66shHr
 NANZj1cy5aCNMuM2ytYPN70nIA==
X-Google-Smtp-Source: APXvYqxj5cUq0KtazhvsxNYXLDuIb3eF2rXzAHXaW2EzaWsPYqpDNJH4QSUU9tpKnZbA39sPJW2heA==
X-Received: by 2002:a1c:be05:: with SMTP id o5mr267349wmf.52.1561573760875;
 Wed, 26 Jun 2019 11:29:20 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id r131sm2762724wmf.4.2019.06.26.11.29.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:29:20 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1560942225-24728-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1560942225-24728-2-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <10c6ff6c-22c3-eb18-3c22-f9e48e236b97@linaro.org>
Date: Wed, 26 Jun 2019 17:28:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560942225-24728-2-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 1/8] target/ppc: Optimize emulation of lvsl
 and lvsr instructions
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/19 1:03 PM, Stefan Brankovic wrote:
> Adding simple macro that is calling tcg implementation of appropriate
> instruction if altivec support is active.
> 
> Optimization of altivec instruction lvsl (Load Vector for Shift Left).
> Place bytes sh:sh+15 of value 0x00 || 0x01 || 0x02 || ... || 0x1E || 0x1F
> in destination register. Sh is calculated by adding 2 source registers and
> getting bits 60-63 of result.
> 
> First, the bits [28-31] are placed from EA to variable sh. After that,
> the bytes are created in the following way:
> sh:(sh+7) of X(from description) by multiplying sh with 0x0101010101010101
> followed by addition of the result with 0x0001020304050607. Value obtained
> is placed in higher doubleword element of vD.
> (sh+8):(sh+15) by adding the result of previous multiplication with
> 0x08090a0b0c0d0e0f. Value obtained is placed in lower doubleword element
> of vD.
> 
> Optimization of altivec instruction lvsr (Load Vector for Shift Right).
> Place bytes 16-sh:31-sh of value 0x00 || 0x01 || 0x02 || ... || 0x1E ||
> 0x1F in destination register. Sh is calculated by adding 2 source
> registers and getting bits 60-63 of result.
> 
> First, the bits [28-31] are placed from EA to variable sh. After that,
> the bytes are created in the following way:
> sh:(sh+7) of X(from description) by multiplying sh with 0x0101010101010101
> followed by substraction of the result from 0x1011121314151617. Value
> obtained is placed in higher doubleword element of vD.
> (sh+8):(sh+15) by substracting the result of previous multiplication from
> 0x18191a1b1c1d1e1f. Value obtained is placed in lower doubleword element
> of vD.
> 
> Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
> ---
>  target/ppc/helper.h                 |   2 -
>  target/ppc/int_helper.c             |  18 ------
>  target/ppc/translate/vmx-impl.inc.c | 120 ++++++++++++++++++++++++++----------
>  3 files changed, 88 insertions(+), 52 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

