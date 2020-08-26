Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39657C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA6320825
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1S+Zlz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA6320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAyBp-0002kZ-6b
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 12:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kAyAX-0000tY-Ha
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:21:01 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:35990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kAyAW-0006Q7-1a
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:21:01 -0400
Received: by mail-lf1-x141.google.com with SMTP id c15so1312365lfi.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=VsS0FU+FSTHf5you0Qj7KNcvTWOftEEBMzEnBr8mFsg=;
 b=S1S+Zlz0hZQnAD0sbvwm3DaiqcHnJYlB/eABBuVPnPq3q3nA75U07PfuPGQ5rYORma
 ch5+0e6JmrGYAtBUZExUVlSmG7o2I7eeaurlElBmXjPpgcqLIuCS/KGs56aF60PXjTth
 AI70LTYUz2vJX7gBaTbs8aFH84xJetc7n8F3OrMlnjvxEz6n237gFg3mL6ZcX177BRrx
 z4sVe6MDpnksQH0Wp37//0+lWybE4mzP8tCjA5QnFMo3oHBvjmTE9PXwRh3/Lat21zcE
 /0BsCJA/A0/9Ndm4ceXUwSN+wQMpUTxQpiZLH0m4z9zrXplaQ2+tf01u/sjt90dPIYoT
 K6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VsS0FU+FSTHf5you0Qj7KNcvTWOftEEBMzEnBr8mFsg=;
 b=T6sZPL0W8PbYEbBkFLYnK4z+bjY1b+ziK0phS8VStj/pAyAWR8tlcJuwAol240IkBN
 D2PuZNWP0BUlAZBwgZxA+9J+LSSQ9MtXduGx406mpSoLkRMbIonjJQZlm0HiFIFWsNqw
 yHSNchBhusjQoI8hdSSSjzuFpRCAG5vJPxB6WHNQdDOuh21CRfRB/N8GRk3kbLjQe8tp
 L2E+qp/KlwX4z6LDnGZq1nT8gAR8Vb2H8liS+opy8JsReGnh9M2r5NXHDar32J+Bvv1j
 nuw9LyyNiawpQgxXUAiUw20sEpuIFhr8zdDzJfxqIYPfJ/818dyCekuxJwT+vdPBFywW
 p1iA==
X-Gm-Message-State: AOAM532VcDJZUMJNh4tZlSL2cVYIptzrDNtIRTfF6LfVS7I0sepbnx9N
 R8J8gCBQFKkt4gY7/S83DGwsqfSGpUDA1A==
X-Google-Smtp-Source: ABdhPJzWwG/9165ttJBw/FB4/Mo+YTFq7zp3yCxR9RUD8Au1JWg6/JLKxWSYlOKGA9uf6yGFtkayiw==
X-Received: by 2002:ac2:5e34:: with SMTP id o20mr848262lfg.187.1598458857665; 
 Wed, 26 Aug 2020 09:20:57 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id u11sm195655ljh.17.2020.08.26.09.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 09:20:57 -0700 (PDT)
Date: Wed, 26 Aug 2020 18:20:56 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 02/77] tests/tcg: Do not require FE_TOWARDZERO
Message-ID: <20200826162056.GG2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200825205950.730499-3-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.066, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 01:58:35PM -0700, Richard Henderson wrote:
> This is optional in ISO C, and not all cpus provide it.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  tests/tcg/multiarch/float_convs.c | 2 ++
>  tests/tcg/multiarch/float_madds.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tests/tcg/multiarch/float_convs.c b/tests/tcg/multiarch/float_convs.c
> index 47e24b8b16..e9be75c2d5 100644
> --- a/tests/tcg/multiarch/float_convs.c
> +++ b/tests/tcg/multiarch/float_convs.c
> @@ -30,7 +30,9 @@ float_mapping round_flags[] = {
>  #ifdef FE_DOWNWARD
>      { FE_DOWNWARD, "downwards" },
>  #endif
> +#ifdef FE_TOWARDZERO
>      { FE_TOWARDZERO, "to zero" }
> +#endif
>  };
>  
>  static void print_input(float input)
> diff --git a/tests/tcg/multiarch/float_madds.c b/tests/tcg/multiarch/float_madds.c
> index eceb4ae38b..e422608ccd 100644
> --- a/tests/tcg/multiarch/float_madds.c
> +++ b/tests/tcg/multiarch/float_madds.c
> @@ -29,7 +29,9 @@ float_mapping round_flags[] = {
>  #ifdef FE_DOWNWARD
>      { FE_DOWNWARD, "downwards" },
>  #endif
> +#ifdef FE_TOWARDZERO
>      { FE_TOWARDZERO, "to zero" }
> +#endif
>  };
>  
>  
> -- 
> 2.25.1
> 

