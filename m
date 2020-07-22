Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16391C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CD02065F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiNcgETL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CD02065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHhc-0008Sk-3Z
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHgS-0007gH-Sc
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:33:32 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:39607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHgR-0007Vo-66
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:33:32 -0400
Received: by mail-pj1-x1032.google.com with SMTP id b92so1662479pjc.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GK3BhJkUO/xoSlcuPJuuxxH6xyRPKv/IhNgQ+CgWPEk=;
 b=qiNcgETLLvVr4ltx5rpjScN0oohfEhtewXcr7rfKwCBt04afhb/6wEclDCp5HRcKuy
 RxBJxG1JDWpoJ0MzdkR3OC3w/TyUrIDTI2DqJGyjocGJAGAT8osUIThT1Clmu7pxrd/D
 HcH4tJNrD7/SKk9pTQMvWQaNFMSS/ukk4oUsVyL7YOlVe5e2+KWCIrZNp/+LajQc6+S0
 zq8cTswaJ6Jaqx8OC1Gnquhao8Fd7zg0ZCbVh9szeqwcjerAHDYmkZhoL4qeJdxAXtXN
 shiq0YGI1H+96E47fbR4xmpN0Wvczo+Tbzbu6eOBdK7+UoZSwWjIDPJxolCOGS8t4zgx
 GHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GK3BhJkUO/xoSlcuPJuuxxH6xyRPKv/IhNgQ+CgWPEk=;
 b=n3pEe34u3FT9HB2B8xzMksOmD+LQ5jLhXaRU1ymSYsK3WV0y5aiLmUK9Fhn1sXNn5e
 fhxE5PUhKH0Ya4F2I/huzeg7wGkFI9bNYyQvzDGfmFQplLYFGFLPpdjrFzowwvZL11U3
 PwibtpWaqhYImuepHuumX8/Ral+K/KZ/+fZgwp5fJn3PEQZA0gM3iY9RkG/D8Y36TcGQ
 C1Ox4XchOKzV7IlZbonpH0ABQdN0V8ecoM57cb/MMzkfjnV94lf1wiyJa/L3Ak9SQrjI
 JYgFCRdZ4YhS9mx08rhRxaytpJiLWd11UjTGNq4irCpB/hsulbFyk22XjX9o6sGb6TFU
 e3GA==
X-Gm-Message-State: AOAM533sM7f2dNxQhR6gZS13u93hXgUXBqmMYZMAs6HqF/CGvKrcVUYR
 uiO8wRfsy+GGOyFqYHZpup2wfQ==
X-Google-Smtp-Source: ABdhPJzjomjeMf3r74C4RSFk4eEhSpBayuL37AaQQ+Fbx8Eh3r04bDEOVmc8B7ldwDvbzlb5KVBQMg==
X-Received: by 2002:a17:90b:8d6:: with SMTP id
 ds22mr205240pjb.145.1595435609477; 
 Wed, 22 Jul 2020 09:33:29 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 l4sm169189pjr.46.2020.07.22.09.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:33:28 -0700 (PDT)
Subject: Re: [RFC v2 08/76] target/riscv: rvv-0.9: add mstatus VS field
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-9-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <637211bb-d8e4-b589-3843-6d6898595130@linaro.org>
Date: Wed, 22 Jul 2020 09:33:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-9-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: LIU Zhiwei <zhiwei_liu@c-sky.com>
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/cpu.h        |  6 ++++++
>  target/riscv/cpu_bits.h   |  1 +
>  target/riscv/cpu_helper.c | 16 +++++++++++++++-
>  target/riscv/csr.c        | 25 ++++++++++++++++++++++++-
>  4 files changed, 46 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


