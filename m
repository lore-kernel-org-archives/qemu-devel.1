Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855A2C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5B3206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdyWDTO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5B3206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFm3-000433-Ik
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58048)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htFk2-00031m-Ed
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htFk1-0007zh-Fe
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:23:54 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htFk1-0007zI-8I
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:23:53 -0400
Received: by mail-pf1-x441.google.com with SMTP id u14so34563667pfn.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QsILWsotU1zPKCkoAYl3syQNnSJIKOShE2ZR3NN8I9k=;
 b=gdyWDTO76UcwQOg2I6s8g1bGE59CS7EqUdcF8IPtLNvC+8h520C73tjBRlKQ0fJcuy
 dffIjxMXBP5s1dUwAhaRR0yQojLvuwTCNDcAxBtreUFFDXiriU7bcTnKkawE9qREQo04
 Jghv0oozYpN6Uocucwq+iSyVfqsOkGIW2gpiBFP1XqqwYACRkRbq6qqcHc3TiSuCLWI5
 MM0jN1qTz1zAYT2bIcJEE07jWuWqlqDcm9FCqMPTJO9uPuL4b2ImFNGTM35V0iutz9tK
 IsnN5fFpKaR4sxbv3lYGVmmCjZV571WvA3ejfNJanYmKgPF7W5jZZCUJsesrQp5NyWjt
 Waiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QsILWsotU1zPKCkoAYl3syQNnSJIKOShE2ZR3NN8I9k=;
 b=cFtgEKBBYFDVJReuz3QWXOQmV9b+vbjAV8CrPEx1sIIO0Q/Z/EQSdGL7pNXsgRN/I+
 G27pnSCdnBLiB9LuOK7/FhTofuL96Zycar0TJQoPHpqzG0ue+6bD6i0kj6v9yTGXtgJg
 8S8otaZYq98NuOUFcxFKeIjW7tMPrDMU+TWZoJQ9cvKN1DErBwb0wKBGrDzz/kGmBQS0
 AnkBCEGoM7nd58sFLsC6oE8NOE1ur6P5wB3wQW1n2j5excapiAarxfEyAzBS8G4ZX1Un
 Xncs9EzJxdKZb1fi0KlMkyzUA6JFulordjDQ3G8QiEC7uayRW5YJ8MyyCclykzgWwlci
 8vDg==
X-Gm-Message-State: APjAAAUQF/koJxrIx0qCjw5zr1iDoo06bMcULROoc/ypFXNLg8IwhTrO
 zXs02+VqnzJEHxGLXLvxFzbXUA==
X-Google-Smtp-Source: APXvYqzxlXRhLAJ3qKvCuTvOZm9v45MJEsB/kNbQb3XT8tETChbW8vBOfx8q+Vkq79iUPu7D3b/r8Q==
X-Received: by 2002:a17:90a:258b:: with SMTP id
 k11mr133835pje.110.1564683831428; 
 Thu, 01 Aug 2019 11:23:51 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id l26sm84036439pgb.90.2019.08.01.11.23.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 11:23:50 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2e849f98-e464-99d2-7e52-319d698143b6@linaro.org>
Date: Thu, 1 Aug 2019 11:23:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v4 22/54] atomic_template: add inline
 trace/plugin helpers
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
Cc: Riku Voipio <riku.voipio@iki.fi>, aaron@os.amperecomputing.com,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> In preparation for plugin support.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v4
>   - move common stuff to atomic_common.inc.c
>   - fix ups for widened uint16_t info
>   - drop haddr in helpers
>   - fix wide lines
> ---
>  accel/tcg/atomic_common.inc.c | 50 +++++++++++++++++++
>  accel/tcg/atomic_template.h   | 93 +++++++++++++++++++++--------------
>  accel/tcg/cputlb.c            |  2 +
>  accel/tcg/user-exec.c         |  2 +
>  4 files changed, 111 insertions(+), 36 deletions(-)
>  create mode 100644 accel/tcg/atomic_common.inc.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


