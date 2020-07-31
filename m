Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12883C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 16:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D112F20663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 16:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmkeI+um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D112F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1YB1-0001ll-3K
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 12:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YAK-0001IC-4K
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 12:45:52 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:34909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YAH-0002P6-NX
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 12:45:51 -0400
Received: by mail-pf1-x434.google.com with SMTP id d188so8705051pfd.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2SpEe3BEg5fTQoDgclaogKKe40Hl6yJfr0ts2CcQfNo=;
 b=DmkeI+umx0CKCLDbNM+SZdG0LqPpqg8w115jcEsmYHyhzgikXNG72z/PLJ+9hqeM2e
 HtiRpu70LucpHbwc9nCCWf+sPx4aarCuTWhDZCgznfr35K+BhGpXO4zIZEuSnXmyq+9x
 69jn/qpGTtyR42Jf0cQVCt8cBXkdObTLsGw/L9MEe9mrOPzYGpgNr+fPXgXSD8JPkVxY
 kWA6qood0XGLGPvjHGOvekZz7rvccmMgin707s5rpzfIpHi0nqXYSt1ZfbYYX4L/EXD5
 4+jw5vZYuxqaUyJ3cn9fdl7W2ZJZkMIegWeL4ejy120nL8Uu4HSMcKZgwW6WTBMpq/tt
 yCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2SpEe3BEg5fTQoDgclaogKKe40Hl6yJfr0ts2CcQfNo=;
 b=eI35DsU3ADng3nKauoqUvxzkDdxy36z7WW1RZCWjOf+cBTPMhkJcsb6mTzmBSAQKhb
 1ERzupf/je8zw62f/zAWVxYWgayRZKfaQrYwyPMIrt16O/OvstSWlc/0u5npyuH21HVx
 F3aCE/7AMn9rUJTLj2V7LiIe8jw0qpgkAAhqCkvvPO/AuUPtMNy3mi+qh3ItULcnzIok
 hQVZhrj7wPIoXkGMdLbSE8aB28uaAz86gb75o9qWeAXlrKIus+XRVypRottFEgrr8CsC
 NwbOZQOcgTE4V2b9w4URaAzA/raLHMMMxiunLNz0sMI1wuFU9r8w6xpZjPkpYQJcieGu
 vGOA==
X-Gm-Message-State: AOAM530/u4VWmvuu7LrzOgGMRY7ehEG2fcQTgi453RCnwP7LaB0C636V
 c/GkemkwN7LqHwcyi3p5aCCfqg==
X-Google-Smtp-Source: ABdhPJxf2ffi1ToTSpKOaF8ZknqLU3ywtGDen05n3K7frjjB0VV9Z352edlbbHFqhyC0+dyXja+GZA==
X-Received: by 2002:aa7:9d04:: with SMTP id k4mr4452882pfp.256.1596213947968; 
 Fri, 31 Jul 2020 09:45:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a24sm10354385pfg.113.2020.07.31.09.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 09:45:47 -0700 (PDT)
Subject: Re: [RFC v2 62/76] target/riscv: rvv-0.9: single-width floating-point
 reduction
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-63-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fbb66f8c-62af-97aa-48bb-1a26d5baeb29@linaro.org>
Date: Fri, 31 Jul 2020 09:45:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-63-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
>  # Vector ordered and unordered reduction sum
> -vfredsum_vs     0000-1 . ..... ..... 001 ..... 1010111 @r_vm
> +vfredsum_vs     000001 . ..... ..... 001 ..... 1010111 @r_vm
> +vfredosum_vs    000011 . ..... ..... 001 ..... 1010111 @r_vm

"The vfredosum instruction is a valid implementation of the vfredsum instruction."

Which is exactly what we're doing here.

Why should we treat them differently?  There is no parallelism that we can
exploit in tcg, unlike in hardware.


r~

