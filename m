Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035E9C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22752247C3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJArHJ3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22752247C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnIk-0006uH-Tz
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXn6v-00032t-3L
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:11:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:41507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXn6r-0005Rm-GI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:11:36 -0400
Received: by mail-pl1-x635.google.com with SMTP id w11so2609945pll.8
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XyCI56Kus6HKixHVC2EtSFo/DhdSsq+Tss02q0w/cC8=;
 b=yJArHJ3AUsqZXXog7VqY8KE7rfBgVg7AUUm8VXdaBjFyuR7wkY2OL6WdEf50ycLDYG
 MLdCgfFyW3ZcCoaexnhtTB/v5ZZerJNWbdDXPmFMEetuIPpmdYzXKpg7AXxZibEgaF/F
 5cS6doBreOvi9iai4qIbPEByzll5pqrla8yIQ/3uw1e/XBNWdTlFybBuQYl2BPkDjFlZ
 Xgn9HeE+67+jXTg9EmSe81h7AvxaV3Xe3BwiZMwHiePJN5kihJYZAX1Jc0DK6eRe7XcK
 ym+YzTHlxJlu/AWv1eSDifZuOshJx10BaIHiPtT8sfxXGt8O8S+eFVEZwA/Q0825lWiR
 udUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XyCI56Kus6HKixHVC2EtSFo/DhdSsq+Tss02q0w/cC8=;
 b=ruV1L0C0qgTD05WPF0I+pqUtLIbG8gx4ltmlQFxbLftplvsqiWps4xnJ/t2/sWY69t
 h8zA8D7eh2wDDYxYJHnm4F/+8Xetm63TyQHtPTE5GdpOKmsoycV2iARKxQqQdCzIY5m0
 FgzvPcuJtNVnieVT/6suIfLCKI3VPHeuyA435xe8IuG6/3hViZNgInovDACKhWXQA1Kk
 bYYbYJEycdUMSG4/BE6WrjRPMaN26/tR+S9xqUN9gmHVOAmARRsBQai7PP0E4L0cfC2M
 gZVHtWHsNliEBiA91w0CXIzgLQTBz8bc/oxn0jbflggVqKqYbyzLGvoRLW8YeWuje6D8
 d2zA==
X-Gm-Message-State: AOAM532VDLjqpoSxOt3HzsGrdB7qU9UEypmPTQ3GZHwRSEMVdN/DQKal
 iwkSSzftre4nCJQErC2mE2Ai3w==
X-Google-Smtp-Source: ABdhPJzm16gcHCgntLhyLi9YojEjLP01iD3V5MUAHlmaqPGf7717ZZ1K6/WTAq86yy+/+2FThLYwBg==
X-Received: by 2002:a17:90a:34cd:: with SMTP id
 m13mr7418596pjf.201.1603897892046; 
 Wed, 28 Oct 2020 08:11:32 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y27sm6334268pfr.122.2020.10.28.08.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 08:11:31 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] target/riscv: Remove the HS_TWO_STAGE flag
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1603896075.git.alistair.francis@wdc.com>
 <93215b3e15ba7f908eae44885d466dd7e9378b59.1603896075.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <740fc13e-0c16-c442-e0f7-c440531c2d5e@linaro.org>
Date: Wed, 28 Oct 2020 08:11:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <93215b3e15ba7f908eae44885d466dd7e9378b59.1603896075.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 7:42 AM, Alistair Francis wrote:
> @@ -337,7 +324,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       * was called. Background registers will be used if the guest has
>       * forced a two stage translation to be on (in HS or M mode).
>       */
> -    if (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH) {
> +    if ((!riscv_cpu_virt_enabled(env) && riscv_cpu_two_stage_lookup(mmu_idx))
> +        && access_type != MMU_INST_FETCH) {

This access_type check looks like a bug.  And possibly why you said that you
can't use code access for the execute load helpers.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

