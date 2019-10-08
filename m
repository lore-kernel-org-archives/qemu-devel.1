Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA4FC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94F12064A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fO0fwlLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94F12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqDt-0002wY-9L
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHq0y-0005yC-Um
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHq0x-00061k-DO
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:59:00 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:33134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHq0x-0005zU-7x
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:58:59 -0400
Received: by mail-yb1-xb44.google.com with SMTP id w141so5366432ybe.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0oq7lHVuJw5Q1nDGVfXS9MroDISPrhdMxL6d2B0nIEI=;
 b=fO0fwlLqoNsJfSDbEFEmmeYC7zEh5r59iTv9mfQ8VC7yuauTb7hyvnC2aLaIuEgfcq
 1DpsiaMIZ3BKYROF7jvCOHyXh9e+n83Btw6BEDQ8uxBcqSgMSgoeM4YqGwRuL05x0N6l
 t5C8WR0M6uWgCkILEvlB32K0PS3vL4ho3ONgxaalBHo8nwq0iZwCxLsBGPpofxzzxLjH
 7324hs3Kzn9M7bPTWJ4B8M62IqPY8Z+n1MeKduxL8YgfTQQgdG9vX/Seb2weuew4rytk
 AKxXkkrcwb1XuhTytXH+zSaFu/wCJyKeJaidNvESenqnQ/4Llu1XtuqWkc1ZdXvmiTXL
 ITog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0oq7lHVuJw5Q1nDGVfXS9MroDISPrhdMxL6d2B0nIEI=;
 b=ppoGFWuH0+s8VMmCwWdrCi/uF4o8hQSEs19XkbZ3j7eSQ/3mDDXdj8reUzAZkWJCLr
 aqV04G59x/7CzF9CiRUM4OvK7Sb2gKmrz/CeX2Ngu6BwOeUvGVSK7OMfSp7rWy7FCAf6
 qMyt64zBksS60BuiZWrJSteS7XyhNyRmARxbI62PqfwhkNZ2xDVZJDUpehOu1Zu9gx71
 7AWPGWWFy1jJBPM9et5LooMUSFtwzWzHF9se3xwgRGn8zcWa6zN/0B0l9R7RHRl1NSUF
 VvRJCMouA0Fygm7I7Z6/AfmRSaTv6BlqbLpXd0zua9BjNLPcy1rFrfcyzwwCmZ4GupKU
 ymgQ==
X-Gm-Message-State: APjAAAWmuN2hUrFIQ3XIO8GYqVSeZIhLjdiG+NV+owZKLfYlZVtv1wA6
 kEMh3ItKhJC2gk0XT/Kezy9BfQ==
X-Google-Smtp-Source: APXvYqykjtjLEe/EiAyqZFNLvBc+aM5GIFDFoSuxgD9tqPGtOKVXCI9I5pWXlgB6Y1M+6efs9Yp9sw==
X-Received: by 2002:a25:8689:: with SMTP id z9mr8395324ybk.156.1570543138166; 
 Tue, 08 Oct 2019 06:58:58 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id w70sm4638205ywa.25.2019.10.08.06.58.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 06:58:57 -0700 (PDT)
Subject: Re: [PATCH v9 04/13] accel: replacing part of CONFIG_PROFILER with
 TBStats
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <34e53812-eeac-ebda-656d-0d5735311178@linaro.org>
Date: Tue, 8 Oct 2019 09:58:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:28 AM, Alex Bennée wrote:
> +struct jit_profile_info {
> +    uint64_t translations;
> +    uint64_t aborted;
> +    uint64_t ops;
> +    unsigned ops_max;
> +    uint64_t del_ops;
> +    uint64_t temps;
> +    unsigned temps_max;
> +    uint64_t host;
> +    uint64_t guest;
> +    uint64_t search_data;
> +};

Hmm.  Maybe better to define a single structure that you can share between the
collection here and the storage in TCGProfile?

Also, "host" and "guest" are not helpful names...

> +    jpi->host += tbs->code.out_len;
> +    jpi->guest += tbs->code.in_len;

... code_int_len and code_out_len are helpful names.

> @@ -1807,6 +1805,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>          tb->tb_stats = NULL;
>      }
>  
> +
>      tcg_func_start(tcg_ctx);
>  
>      tcg_ctx->cpu = env_cpu(env);

Watch the random whitespace.

> +#define stat_per_translation(stat, name) \
> +    (stat->translations.total ? stat->name / stat->translations.total : 0)

Does this really need to go in the header?


> +static void collect_jit_profile_info(void *p, uint32_t hash, void *userp)
> +{
> +    struct jit_profile_info *jpi = userp;
> +    TBStatistics *tbs = p;
> +
> +    jpi->translations += tbs->translations.total;
> +    jpi->ops += tbs->code.num_tcg_ops;
> +    if (stat_per_translation(tbs, code.num_tcg_ops) > jpi->ops_max) {
> +        jpi->ops_max = stat_per_translation(tbs, code.num_tcg_ops);
> +    }
> +    jpi->del_ops += tbs->code.deleted_ops;
> +    jpi->temps += tbs->code.temps;
> +    if (stat_per_translation(tbs, code.temps) > jpi->temps_max) {
> +        jpi->temps_max = stat_per_translation(tbs, code.temps);
> +    }
> +    jpi->host += tbs->code.out_len;
> +    jpi->guest += tbs->code.in_len;
> +    jpi->search_data += tbs->code.search_out_len;
> +}

E.g.

    unsigned long total = tbs->translations.total;

    if (total) {
        unsigned tmp;

        tmp = tbs->code.num_tcg_ops / total;
        jpi->ops_max = MAX(jpi->ops_max, tmp);

        tmp = tbs->code.temps / total;
        jpi->temps_max = MAX(jpi->temps_max, tmp);
    }

It does occur to me to wonder why code.num_guest_inst etc are "unsigned" while
translations.total are "unsigned long", given that they are both accumulations
over many TBs.


r~

