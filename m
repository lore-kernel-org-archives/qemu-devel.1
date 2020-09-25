Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F984C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC8C2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pluNqx8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC8C2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvy4-0005P4-GB
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 18:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvxS-0004xI-RJ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:12:50 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvxL-0008B0-Kw
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:12:50 -0400
Received: by mail-pg1-x541.google.com with SMTP id 5so3748186pgf.5
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pbRU1lwLqJ6zUaUtxwL81oLugHZSrhyk9MFggrU71+k=;
 b=pluNqx8eTNkh51Lwg/bfgeqcyuGLO/aQw5TtUG3CZj5us8gLY9YEpsc2EPMQSdXcfp
 GJKcHIN4h6IZeU6zQg50cS6a5EDV4sdEIFxHGEdFQjadvdi/Jv+aMhDM2ihDeP0UTaeM
 sNlZQb+FSwuv5UiTGAqHVvsgGBUuPdHerlFtH0qW2fHD77A/zX2i2m113PRSjxj+RWaE
 8a07F5tocNSbAVzbbYXhprMpeTiHlmpZjGQWfeMsqzUrL+c5cG8fDqrQV/wFLbob2F/9
 Gq9KaKDSB/fckW5aUh8+od1QnuoAAXc8CCoTzQdlMc9/1Xb7x/eehKba2dr8zV8YKS6T
 PUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pbRU1lwLqJ6zUaUtxwL81oLugHZSrhyk9MFggrU71+k=;
 b=f+3ERM2CXT+ECAjm97GqbDO2M09C52D6dkfWBNugm/lfgaYNJvfl8fyY7SoYgOpvJG
 ritrNjzIMnkajU4UFxysBwSdGWpAVLfVTBOoybb4vXESxoZ7ZPQBFyJRV7Wsjpi9efRA
 QVhvsYYdBvWZlIGxBehlI3aD6RQQVUwG+jaJpMz1Rj835HTijMYbM4sgB8bFqGYI3slu
 wliQ8nb27nLXfh45XF9K2E0qo3UFjEd9DF1vlEmK2kPnRgqrgUJ5W/0rC/wdw9CWASjE
 XyW3wqRbXWSmeEP3rADRXNROEUZ9crsIGFP0hd8ADy7QbfLXTS3N/XGNjGF3zZ6p+Fx2
 L6vw==
X-Gm-Message-State: AOAM53223g8CF4Cs5/Jwo1x6t8OYftMPN4hDH1+Fj+EGVFGDJdjkOW6H
 3HYNKaJ++8wyE2hZYgQwIL/RvQ==
X-Google-Smtp-Source: ABdhPJwdjei5L+Jl6z9PeEct9529fRW7N+hIaTv2t4j87SnbV29ETLmn9Q8NnVSmsq+Mzg/RDQLP3Q==
X-Received: by 2002:a63:5b60:: with SMTP id l32mr859306pgm.134.1601071962188; 
 Fri, 25 Sep 2020 15:12:42 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i2sm3687174pfq.89.2020.09.25.15.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 15:12:41 -0700 (PDT)
Subject: Re: [PATCH v1 8/8] s390x/tcg: Implement CIPHER MESSAGE WITH
 AUTHENTICATION (KMA)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200922103129.12824-1-david@redhat.com>
 <20200922103129.12824-9-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f08c546b-0eeb-43b6-94b0-244b5c66f5b4@linaro.org>
Date: Fri, 25 Sep 2020 15:12:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922103129.12824-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
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

On 9/22/20 3:31 AM, David Hildenbrand wrote:
> As with the other crypto functions, we only implement subcode 0 (query)
> and no actual encryption/decryption. We now implement S390_FEAT_MSA_EXT_8.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/gen-features.c | 1 +
>  target/s390x/insn-data.def  | 1 +
>  target/s390x/translate.c    | 7 +++++++
>  3 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


