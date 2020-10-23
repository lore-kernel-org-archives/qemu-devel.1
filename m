Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93837C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3FC20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGICWJQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3FC20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0N2-0007Z5-PL
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kW0Ls-0006GW-7x
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:55:40 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:39832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kW0Lq-0004kS-7V
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:55:39 -0400
Received: by mail-pg1-x52e.google.com with SMTP id o7so1702133pgv.6
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gLvUfrphDwZ2K++jmWO2A1JJHtXH+x3MhJqdTjBYNjE=;
 b=VGICWJQlWWp4aPXV96ePhgji9wf6WSv/exuSyeqZq8zotPP86u6pevsdJjLeuvALKb
 X9IpeqIzVFnTE0K8VRdLNHpQKh3IzRvKm7dcW0yVJwXocywB+TsVs4dKYzH+tu2wkcA+
 w5egXZwGhdTGADTILUEQhA8fp0WDFjPTscZ59WiMahriQw9JqpyV8ZS8T9fkXVzsJGV3
 yKiR2j0UBuCKXCjo5/G9a/l6+0M87DssseR56J8V4nl+fTo1KHS+HQ3/xoxd55fmFZvl
 dkd2/1QnSTSdhmGX/pVSufut4fCgGOR/sNEBIVnKiwU4Pu0V8yo6EMKkImYew6fIInrS
 I1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gLvUfrphDwZ2K++jmWO2A1JJHtXH+x3MhJqdTjBYNjE=;
 b=hICJLgxDBxP6yCwi/QPjq6l4qUX7LLp+RMKj9/xRKGcfsXZfZHmaV72320rug/M7bq
 1hfIitoNFBFUp/BHrAOpVC3IvsrBttQao7FX6KFtPpIyC86TXy1a4IEtte/+XOrDO04F
 yqrIBMWpwwd+S57gA+PeAdDKj6fUYx3sRGpvvhMH+FtbOpe9SwXAYOsvsSVjv/UKsreU
 4XnRz8upN/30s5+cXlDnbWnfh+wn8LpSxSY7sSrCRSU6JYAhC1+54Vd00ZbRad9x8viT
 Hq9eYnFdvup6D7HsWxn7kfHQbdQdO/3if0kZFSw7eQLYMxnTpps7zBcEuzH+1BJ1+KfN
 RngA==
X-Gm-Message-State: AOAM530ESIQnaiuW3JkQNpFmM0E+zWTEQwDBPLd1ocQTSY7ZeRAN5l1R
 bBrPWiZr3pVCeSba/5c8UdOx0A==
X-Google-Smtp-Source: ABdhPJx5dj7VAvfjFLTtUZiGdWTwELic4Aa4AoXUwALk33KYPtXzZHNhE+dh52CM0nchZPpds+WY6Q==
X-Received: by 2002:a62:644c:0:b029:155:fdf4:52ed with SMTP id
 y73-20020a62644c0000b0290155fdf452edmr97002pfb.9.1603472136259; 
 Fri, 23 Oct 2020 09:55:36 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h21sm2459692pgi.88.2020.10.23.09.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 09:55:35 -0700 (PDT)
Subject: Re: [PATCH v1 16/16] target/riscv: Consolidate *statush registers
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <ce9e33fdd36df39878df6657ecdc10e42c629b85.1603467169.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8c6d868d-6ce1-0b8c-587b-f555f35a636e@linaro.org>
Date: Fri, 23 Oct 2020 09:55:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ce9e33fdd36df39878df6657ecdc10e42c629b85.1603467169.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.108,
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

On 10/23/20 8:33 AM, Alistair Francis wrote:
> +        qemu_fprintf(f, " %s %016lx\n", "vsstatus ", env->vsstatus);

You need PRIx64 here.


r~

