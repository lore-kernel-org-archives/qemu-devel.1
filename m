Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A6AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0899A20684
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUEi5tyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0899A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWOm-00027j-W2
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDWMo-00008s-Rr
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:16:15 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDWMg-0002KI-Pq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:16:13 -0400
Received: by mail-pj1-x1041.google.com with SMTP id o16so123278pjr.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Xk+105giE6AcO4qxDPHIvchpBQAEfr1BM07EyyulhGo=;
 b=PUEi5tyvRC/GzOc5jeERnwOgzhjP/uHDQZY1yehW4P5hA1Tg2Zxzt+U1bnOvp7wWvy
 vy0QW4GL5G/KEiG0wVyuGYL2/xc/LixouxW7lMl/l83UJWCcI9cWwUj2zNrSpNaZw2mD
 WD65WDcToy+lLfp3YjBqPuQQ6wsDkMN6qy98NXH/d0CzXB3/w4PYxsAUBvYXMWqagBLA
 gbm6LqYtXDb/OIvyHn4mBUN1HD69q5v9fgvvr1DEIlkd3l2YrjH/7tNi5Hv0zmrKgXSS
 BpTSI9ec3tnRC88C8PUlETv1lM6ja36dBYemudLjUcbJ+h4Cf/jBoA1HNjTYXnvn7vz5
 3T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xk+105giE6AcO4qxDPHIvchpBQAEfr1BM07EyyulhGo=;
 b=OVgginKPuMDwweMd8S4ZU0ReA0h4Gg2YuQGED0Y0iEylYCDLtjCIb3sM5l2M4VASyk
 +EgX2O5Y2YICwf6qMdrm8o7ld5ufF3ew+1qEkc7O8t/j+LpxmmO9u1Bl1d3lDqQl3K+k
 KWO6EVI18PGut+NlNR9Q+Pe49k1BkvTvwsrNj2S8J/d4ZOIC8mYBSblHvqBTHLOzyvpk
 7Mm7zMNS+wrw4fi5Qg+7tPWtcOeU3LFDoH2rtK6zB5T//Y6lhkTdmMF0knRN4m70t06J
 7S4EOP7eWZpp7zun2HnJKzJgiRIyi/18f9d14qkwuycpQj5VLMsBw2x7rdpn7ij+AxDa
 YzXw==
X-Gm-Message-State: AOAM5311IygvkDMcOmmSY2vCMMzvxoiGviyJwjBV7V19jkv+t0lkOPDw
 Kh/HCuSMN+9R1tM6qKcpVZAY2Q==
X-Google-Smtp-Source: ABdhPJzz2AQX0JXKXsC/7B5hz5MP/Ky7LHr7MMA2fqFPdA/gf5Wbp1FGLViDzi5N+iPQvsagLCUYyg==
X-Received: by 2002:a17:90a:3e4f:: with SMTP id
 t15mr3129024pjm.19.1599066964986; 
 Wed, 02 Sep 2020 10:16:04 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm88155pfk.0.2020.09.02.10.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 10:16:04 -0700 (PDT)
Subject: Re: [PATCH 4/6] tcg: Fixes dup_const link error
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-5-luoyonggang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <285c6d4c-6a92-53d0-37d3-e22f71b67033@linaro.org>
Date: Wed, 2 Sep 2020 10:16:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902170054.810-5-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 10:00 AM, Yonggang Luo wrote:
> Rename function dup_const to dup_const_eval for avoid confliction with macro dup_const
> 
> The link error on msys2
> 
> Linking target qemu-system-alpha.exe
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_optimize.c.obj: in function `tcg_optimize':
> E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/optimize.c:1106: undefined reference to `dup_const'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_tcg-op-vec.c.obj: in function `tcg_gen_dupi_vec':
> E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/tcg-op-vec.c:283: undefined reference to `dup_const'
> collect2.exe: error: ld returned 1 exit status
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---

This should not be required.  What compiler is this?


r~

