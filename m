Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB26C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 23:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2928820880
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 23:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZK7xT5nC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2928820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwaup-0000Ca-E1
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 19:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42939)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hwau5-0007r5-Cn
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 19:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hwau3-0001MC-QG
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 19:36:05 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hwau3-0001K3-6b
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 19:36:03 -0400
Received: by mail-pf1-x441.google.com with SMTP id w26so2654605pfq.12
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2019 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JqU3IVJi5OC1DT4qD2Hk5+RbETbHYR7Jv0J4+bWcbvk=;
 b=ZK7xT5nCRa6yFx/YAsyPiZHEKzgsi3F+A04djCAu/3YhPGUYyduyhJANZxHM9myBd+
 CcKdvqagIAs1yuwHqXFWXLXvtQ1LgAWG0S4Ef70wHBs0es9+sg7XSlu3Jh+SnSaXsyOD
 sUo1pMsteZlGbSH+pNkfaSsCtleRZoD9hfNIAdsQW3Mv623T/jd55fDNsrM/JsLJ/po6
 erWdtDYrotE90C6KOgCQc0TCXZCvYAwkUgbDVGCxXwvCW3T3zgTZ25zlNiSpHWm89Mgn
 uHYUhmUZi79tu6jS16p4FWae1nXSDsV/vF/sWC6kirqgGUIaiGS2BEZiHOTeYFT7oXyK
 E+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JqU3IVJi5OC1DT4qD2Hk5+RbETbHYR7Jv0J4+bWcbvk=;
 b=YtR9RKuhz3ZAMVq1Tq+945oshUNxf6444yHR2tpGkmNs5feju5ut4yDTnGhFXijICt
 /NXmHCq5a3/mWj9yyW/azZwJS8xs5Zq1T+qHyOlZVuPJXOR5QnkiMbdcgqJi2n6zuOm9
 9OHALYakD0gxNa8Ze1a2m9de0E3aFHXwo+aIr2KaQ5WYAoEozGzN/JRpSsE0NZvhpv42
 wI9+un7Ga8vnxhQBVgwRHY+INre5OSwiJMi1iX9NPb1/XU2N5NV6NV3M8d69rU21w/Jl
 5RdCHaT12G8qbMfRDPM+YtOj3POywA5Tk8z1QN3mWw5snh3WH9cq0AT8LIsaHfkYODZV
 6q9A==
X-Gm-Message-State: APjAAAWaySAzIVo7T9ABhBykR5KdpP3aqLTbNd+LR+afPVsvb+OUcoj3
 BkkxAItF/+Dc9ntvdhAjBk8GdA==
X-Google-Smtp-Source: APXvYqy8trmn3XcKtzVMMs8ISmI9VBS26/cnW4VuP26wYbho90+7hThk1oKWt4ThZpT4LOP06icwsQ==
X-Received: by 2002:a63:b64:: with SMTP id a36mr24382102pgl.215.1565480161169; 
 Sat, 10 Aug 2019 16:36:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h70sm97232877pgc.36.2019.08.10.16.35.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 10 Aug 2019 16:36:00 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7d6ac8e9-00a0-fda2-74ba-327b39460cce@linaro.org>
Date: Sat, 10 Aug 2019 16:35:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/39] rewrite MMX/SSE instruction
 translation
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 9:12 PM, Jan Bobek wrote:
> This is a v2 of the patch series posted in [1]. Patches 1-9 are just
> cleanups; patches 10-39 are something actually interesting. Compared
> to v1, I started using preprocessor more extensively to generate
> repetitive boilerplate code; opinions/alternatives are welcome and
> appreciated.

This is tricky.  I'm not keen on code entirely expanded via macros because it
becomes extremely difficult to debug.  All statements get recorded at the same
line of the location of the expansion, which makes the gdb "step" command
finish the entire function because there is no next line.

Once upon a time I wrote some code that's extremely macro crazy:

https://sourceware.org/git/?p=glibc.git;a=blob_plain;f=soft-fp/op-common.h;hb=HEAD

It has been extremely difficult to maintain over the years.

We have just recently gotten rid of some of the macros in the softmmu code

https://patchwork.ozlabs.org/project/qemu-devel/list/?series=105441

replacing most of them with inline functions.

A lot of what you have needs very little adjustment to address the debugging
problem.  E.g.

> +#define INSNOP_INIT(opT, init_stmt)                                \
> +    static int insnop_init(opT)(CPUX86State *env, DisasContext *s, \
> +                                int modrm, insnop_t(opT) *op)      \
> +    {                                                              \
> +        init_stmt;                                                 \
> +    }
....
> +INSNOP(
> +    M, TCGv,
> +    do {
> +        if (decode_modrm_mod(env, s, modrm) == 3) {
> +            INSNOP_INIT_FAIL;
> +        } else {
> +            INSNOP_INIT_OK(s->A0);
> +        }
> +    } while (0),
> +    do {
> +        assert(*op == s->A0);
> +        gen_lea_modrm(env, s, modrm);
> +    } while (0),
> +    INSNOP_FINALIZE_NOOP)

Rearrange this as

#define INSNOP_INIT(OPT) \
    static bool insnop_##OPT##_init(CPUX86State *env, DisasContext *s, \
                                    int modrm, insnop_##OPT##_t *op)

#define INSNOP_PREPARE(OPT) \
    static void insnop_##OPT##_prepare(CPUX86State *env, DisasContext *s, \
                                       int modrm, insnop_##OPT##_t *op)

INSNOP_INIT(M)
{
    if (decode_modrm_mod(env, s, modrm) == 3) {
        INSNOP_INIT_FAIL;
    } else {
        INSNOP_INIT_OK(s->A0);
    }
}

INSNOP_PREPARE(M)
{
    assert(*op == s->A0);
    gen_lea_modrm(env, s, modrm);
}

etc and suddenly the entire expansion does not occur on a single line.

Further specific commentary to follow.


r~

