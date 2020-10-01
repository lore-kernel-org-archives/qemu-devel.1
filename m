Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CEFC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64380206C1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etE1scaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64380206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0ev-0007dF-As
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO0Tj-0004r6-OD
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:26:48 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO0Tg-0001Ul-Ue
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:26:43 -0400
Received: by mail-oi1-x242.google.com with SMTP id i17so5966002oig.10
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QdqT/LdQcM0ga2Advqw+1UJaOl2B5GayAatTt8Gbdig=;
 b=etE1scaMHPciPTbKohn+V9xkGXs8jUHfrMmxD4MtXcKNbGSO5EMxmhOzneQhwJG6Gq
 MZDgwjgFWKzzVqtRPYtwGoFyybw1YmG/YIz4CPeRmwl1Tk9kpoiUJlpApSH5PNhm2F7D
 bQXU5daCw1oS383feVbtQC4aF7uMud2SgJPzmCvOztfindRywOa0ZwVLzuON4R2WHVlF
 SVYQG78OFUBLgAQkrx3BGFx8Ze+b5cNoNvQUT/xll2gu+YqY8hjSOvSJwLmKYA/ufEIP
 3v2Vi12KXp4mYkYali2/Pa1nDFG6FElhCxIXTa5b5eWgKoVkwTXLw9rPufIcqH3SNeam
 PDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QdqT/LdQcM0ga2Advqw+1UJaOl2B5GayAatTt8Gbdig=;
 b=aWOFcjU7nSlrp5wBzkd9YdjFs2qBbXa3Ypj16h2jicNJP/9EOKOGGaTaBEt/idvP4B
 qnVU7s1BOZwAgP1LjYiOmKny/cpphlQgl0Aw9SUC7ij/ZCBC4n5O8aVsPvIwKzKo+I19
 iSoqs8WbfQ6g4dWIavwi6GAHv87U7ZVnFOmankx8cSKz7EWX24SD+9LKALJNzB2H6aXz
 3whm3kXUUt/5syVHZk+YijibcPIplTxKc40iPqOQz1QDuaQkLleBqH8ZcdKoKS/JLByl
 wvWHtUvF8gHvA5u4DNjFnTbVyahY5HyjBZGcbXE36o+9t6TTX5S1Qauun7gbKsREIQ+1
 wj8w==
X-Gm-Message-State: AOAM532zc9skZGErwFwNbw+Xf3c8NtXBA/drWMSkvrzj2NXtVPPdxj29
 d+tXoijNQkjx4iHnEoiiGgIMrQ==
X-Google-Smtp-Source: ABdhPJx2ejRpk3zO5biKKONHw9K+26VTSsTI+snleiDNKP0gROxmThFAT0ntHF1MrNUIBfjRV4jU5w==
X-Received: by 2002:aca:fd16:: with SMTP id b22mr303082oii.179.1601565999586; 
 Thu, 01 Oct 2020 08:26:39 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id 91sm1252143ott.55.2020.10.01.08.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 08:26:38 -0700 (PDT)
Subject: Re: [PATCH v1 03/20] s390x/tcg: Implement VECTOR MULTIPLY SUM LOGICAL
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aada8ec1-6776-6674-e795-5f10909a02fe@linaro.org>
Date: Thu, 1 Oct 2020 10:26:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930145523.71087-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 9:55 AM, David Hildenbrand wrote:
> +    /* Multipy both even elements from v2 and v3 */
> +    read_vec_element_i64(l1, get_field(s, v2), 0, ES_64);
> +    read_vec_element_i64(h1, get_field(s, v3), 0, ES_64);
> +    tcg_gen_mulu2_i64(l1, h1, l1, h1);
> +    /* Shift result left by one bit if requested */
> +    if (extract32(get_field(s, m6), 3, 1)) {
> +        tcg_gen_extract2_i64(h1, l1, h1, 63);
> +        tcg_gen_shli_i64(l1, l1, 1);
> +    }

Not a bug, but some hosts require 3 insns for extract2 (so 4 total for this
sequence).

This doubling can also be had via add2:

    tcg_gen_add2_i64(l1, h1, l1, h1, l1, h1);

At which point most hosts will require only 2 insns for this sequence.  The two
hosts that don't have a carry bit (mips, riscv), will still be able to perform
the add in 3 insns.

So add is never more expensive and sometimes half as expensive.

Regardless,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

