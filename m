Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4146C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905CE2245C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXgkfQFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905CE2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Ynh-0002id-Kd
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YmW-0001Wv-JT
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:25:20 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:54694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YmU-0007N3-TB
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:25:20 -0400
Received: by mail-pj1-x1034.google.com with SMTP id mt12so7737886pjb.4
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 10:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v0RlbWiTo8KRlB+z/cZJ0MQTmzfaIWBJNl8xqksUh9Q=;
 b=hXgkfQFBHFfHs+8bz5mIee9I0hmknd/cN6gmVabZ31wnTTewylWnckSSzAM00L7cNw
 +tU9qW6mlMVaVKw49xfLYpgLmvL4M4bntFJ7jIVH/ciy90PJpufUz++oOvZ5DxywYn1O
 sKPxF8YdXl/KP6pLZYs++ry9Sf98QPuDmrq5JoQqxAIyRbLSiPZRahAamGxsDGdqr/+W
 S0iGHkli0Pqs31w7rAeD6T6EVnz9SPiksBcJGs8gQbNoKoWdEKds3PAjaFIs/D/ZRuqd
 hzCv7HyDNDFq/Rb/965UkgcpSpPmCgFInT6E/S4sKE/jvbEseMCmTT9t0vdt0lc/22ge
 6D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v0RlbWiTo8KRlB+z/cZJ0MQTmzfaIWBJNl8xqksUh9Q=;
 b=SfrkXQY1V0bhGaqIUqg7iOXEvxYlYt2CbTSpZcxLz5BReBvZnqorE7ncGu1o8lMFKc
 m8OKgc5Vxyylbz8OcgluCSiTANEkeM2YgmY5w5wcX4DoxRPaGylCUTgp4MQepQx9Z/9y
 4ArHJYCWLV65gnHc7tZB1OMzp7y//BUentkuYx3v4a7Ub1YpMgoBDNw78IpiQuq26tgY
 UA2wwY3El8Z69q59QuUM8n4nhrAzDo2ZJUsl48dkD6yuYcsUF4UQJb3qZeLGWEohmbeB
 nkgzMM3HwNw63pq+eZqH13j1Ku4I1lnsHmOXt/EPpZEvMmYf205zMoW4ibV0dNfYfknq
 NXoA==
X-Gm-Message-State: AOAM53162Sw+ijseZBwYotcWRNYrQwfpwgjERcMGybW6VEyEcmj/fZzP
 dKUIkYK9S8Rm9ItARmtOR84Flg==
X-Google-Smtp-Source: ABdhPJw8lfkT9qZevlvgZ/qKtw0Dhy2qERWP0crBCQAIZHK5Mqx+pGI1uXUkRe/PnBP+6T58Wirrmw==
X-Received: by 2002:a17:90a:9d84:: with SMTP id
 k4mr5100721pjp.227.1596216315510; 
 Fri, 31 Jul 2020 10:25:15 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r202sm618129pfc.127.2020.07.31.10.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 10:25:14 -0700 (PDT)
Subject: Re: [RFC v2 75/76] target/riscv: gdb: support vector registers for
 rv64
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-76-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <684f11b4-eb62-601a-1664-afaeca4b1711@linaro.org>
Date: Fri, 31 Jul 2020 10:25:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-76-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Hsiangkai Wang <kai.wang@sifive.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> +    if (env->misa & RVV) {
> +        /* TODO: support vlen other than 128, 256, 512 bits. */
> +        const char *vector_xml_name = NULL;
> +        switch (cpu->cfg.vlen) {
> +        case 128:
> +            vector_xml_name = "riscv-64bit-vector-128b.xml";
> +            break;
> +        case 256:
> +            vector_xml_name = "riscv-64bit-vector-256b.xml";
> +            break;
> +        case 512:
> +            vector_xml_name = "riscv-64bit-vector-512b.xml";
> +            break;
> +        default:
> +            vector_xml_name = NULL;
> +            break;
> +        }

I guess this is ok as-is, but consider mirroring arm_gen_dynamic_svereg_xml().


r~

