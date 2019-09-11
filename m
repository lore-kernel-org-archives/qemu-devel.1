Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892AFC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CC42085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8/Lzav3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CC42085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84iE-0007dk-TE
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i84OF-000794-Vy
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i84OE-00042q-N6
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:18:39 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i84OE-00042M-HH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:18:38 -0400
Received: by mail-qk1-x742.google.com with SMTP id p10so3157849qkg.8
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/u4TANmu6Wkrx3Un2Qo5WWdaB/yEKceJAZP3V7FqtOU=;
 b=V8/Lzav3SqNHHtWg2hpWkVpViYWC53Z8AoZu27C9LWEXNf6hOcaqV8QkiKmUOkeS8t
 k1TxDnK34VzQZstE+Pq1fPdywGontkylq+qETpRAsUZ8JEa10wm163oq4N4gYEpsy0At
 xnOyK4bzy+dzYWThycR5ofXn8Ji9R9TkGMbx3fI7DyXzQvT6aN8F9NG8ICX1uZTa4RqX
 k9PXQCRG5hozklDiYwpj8axmveSe99ZfGzoc19eqUlGzVXG8JN5kYVvcHgCwuxxT1W6W
 8hU4QF3ZPLCV8RMcCWJF4OWKOenoTxT86lm4dtUS70LMtquF/gEW80NOBSbTz4qLY6j8
 DUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/u4TANmu6Wkrx3Un2Qo5WWdaB/yEKceJAZP3V7FqtOU=;
 b=XAakQEZe3nK+GOvBXsowPRv9HUG2egCuK0tEKbf70DXRYlu2Z+vYBTufC/xSgxAJDj
 ERaapxm8jEgTurrtv6OBZB5gGm846yzvXRQ4nJQk0Wldv2MhqBqtfedzaI/iKJlB+kaK
 qsZ8myUljeiELkrLhiduLToace9moYcrH9OOsNU67XYlxBiEgN80cIb+Ms7eDgbuCGKx
 9NmgGdfMNK74au4DcspvjKfJsHMwA7xxs8bDTduVoiUBDy7LF+6QCNGSQ9kNAotf5feU
 U6BZ/8GPwmkHMJv+XNx5fadpVDcCYERffpVP71zc7DiQvN4SIDssvDk4u6tX0EecJWHY
 4DsQ==
X-Gm-Message-State: APjAAAV7d770+5WbvX2SUwc0z0reVxOB2X01gBAncO8Appo4CGjaGLhK
 JFIx/pd435NYfBfKPrjX3xMTYQ==
X-Google-Smtp-Source: APXvYqzwilHKt2Y4GKTguyMrandLoSjD0LVuVumIid4FOZsJerLT6yASwHB9XR7vi5evPt1sah6i2A==
X-Received: by 2002:ae9:f445:: with SMTP id z5mr35317418qkl.121.1568215117587; 
 Wed, 11 Sep 2019 08:18:37 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id s50sm11068749qth.92.2019.09.11.08.18.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 08:18:37 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-14-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c53cbfff-86fa-fc67-098a-070847a5a1b9@linaro.org>
Date: Wed, 11 Sep 2019 11:18:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-14-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: Re: [Qemu-devel] [PATCH v2 13/28] s390x/tcg: MVST: Fix storing back
 the addresses to registers
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
> 24 and 31-bit address space handling is wrong when it comes to storing
> back the addresses to the register.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h      |  2 +-
>  target/s390x/insn-data.def |  2 +-
>  target/s390x/mem_helper.c  | 20 ++++++++------------
>  target/s390x/translate.c   |  8 ++++++--
>  4 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> -uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64_t s)
> +uint32_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint32_t r1, uint32_t r2)
>  {
> +    const uint64_t d = get_address(env, r1);
> +    const uint64_t s = get_address(env, r2);

While you're changing the signature, you could also read R0 implicitly from env
instead of passing it as C.


r~

