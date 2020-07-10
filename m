Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A0EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 21:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726F020725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 21:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j08JErDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726F020725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju0Y7-00082W-MD
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 17:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ju0XM-0007be-0F
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 17:26:28 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ju0XK-00035M-77
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 17:26:27 -0400
Received: by mail-pl1-x641.google.com with SMTP id f2so2759566plr.8
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i/9PuibmIK5043Z0IKGrjUTuvFcNFdOGMkqWKsSYb78=;
 b=j08JErDnvopSMkkTMmeKXIOQKloxD03Q2wy7N6cll5rayJDTT4KknVUdqni5cdjIPs
 UfVlIcpWVyyW+PspVrkSWpHBPtbagUnb25Mc/fa57OYvRcPmH4Aq2VACw3XATUz18O6F
 KZpPCA3GdIiHHarPWu2pqRWrLsVJz6A8qg7VUp+Ee1DJ/kVBUTukyyPbelEG6etgWC0+
 YxkZo5SxMWvqQvZILwBdbykM2v+KkykAc/KbPtaswRuKlmPdVI7HYnB62uLAf+O2HWug
 PRvznsOfe77KLL8HVXxTdY9VYM/gETePM8Yo4EF89ihWfeQvwh/T7aEzhohMX/nwTQrH
 Iv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i/9PuibmIK5043Z0IKGrjUTuvFcNFdOGMkqWKsSYb78=;
 b=RERWWf1Z4un7XK6L5ZSLOPjJiH4ojL8vGOOjsbbRlpkEP78JCH/pWKC7MxcxjqgAb+
 H2cauTI2RJ2YAoyHX10Vb0ghDdcZAMaDF3BrVbMrZFv0Ewo28kDDBupG/yaNAM8zb10M
 4nSDphfMG8ItnIYJUFiDTLrggdekR9hs+h9MzOSR9OlwezJBYJp5Sn6PjFYKmskKTVvY
 p3TcveGa2SQlX9M/+9VfHp/7iJ9HO0aa1OyD3d8566Swwx+V7brSF1xErR++bcrdDBla
 /AXBjNWTgy1Espkn2YnaEu9cEIIc0MUTvsYHOjYxUZtajXnYMBQiII5aFliA5cNenBLN
 Tu8A==
X-Gm-Message-State: AOAM531DRNd4+fq5OsySVikfhtLq/RcinVvJ1DEnbMN2pLPGYAM6I/OI
 Su+W/xOL89uSAmuUJLKEiYha4Q==
X-Google-Smtp-Source: ABdhPJxTMbO31lx61Dds1pPgaQ73BNDbnsBvhRYzJgb2dI6ExBh63FGrq98P4ulZnvkoDDzG8cvm+g==
X-Received: by 2002:a17:902:ab94:: with SMTP id
 f20mr18670917plr.232.1594416384479; 
 Fri, 10 Jul 2020 14:26:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id c15sm6415769pgb.4.2020.07.10.14.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 14:26:23 -0700 (PDT)
Subject: Re: [PATCH v1 09/13] target/sh4: revert to using cpu_lduw_code to
 decode gusa
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f3837382-c42a-5b68-be93-066dcfe2afe9@linaro.org>
Date: Fri, 10 Jul 2020 14:26:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200709141327.14631-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, f4bug@amsat.org,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 Claudio Fontana <cfontana@suse.de>, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 7:13 AM, Alex Bennée wrote:
> The translator_ld* functions very much expect us to be decoding one
> instruction at a time. Otherwise we will see weirdness such as:
> 
>   qemu-sh4: warning: plugin_disas: 6 bytes left over
> 
> when we use the disas functions. For what SH4 is doing here (scanning
> ahead in the instruction stream) this is the right function to use.

It is not just scanning ahead.  It does that, but after having done so it may
also commit to translating them all at once.

In the case to which you refer, above, we have translated 4 insns into one
operation.  Just having plugin_disas see the first one is not really correct
either.


r~

> 
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/sh4/translate.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 6192d83e8c66..919da72a0c98 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1915,9 +1915,13 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
>          goto fail;
>      }
>  
> -    /* Read all of the insns for the region.  */
> +    /*
> +     * Read all of the insns for the region. We do this directly with
> +     * cpu_lduw_code to avoid confusing the plugins by decoding
> +     * multiple instructions.
> +     */
>      for (i = 0; i < max_insns; ++i) {
> -        insns[i] = translator_lduw(env, pc + i * 2);
> +        insns[i] = cpu_lduw_code(env, pc + i * 2);
>      }
>  
>      ld_adr = ld_dst = ld_mop = -1;
> 


