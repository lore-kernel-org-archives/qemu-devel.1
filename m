Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF315C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFEE20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVxV4oGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFEE20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtwsk-0003kk-0C
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 13:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtwrc-0002lQ-9D
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:31:08 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:39062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtwra-0007BF-L3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:31:07 -0400
Received: by mail-pg1-x530.google.com with SMTP id z5so2818611pgb.6
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+O9voR6d2w5/VScNaOa0W4xRCl/1x5Zgbu/5/sqAhuU=;
 b=UVxV4oGEF/XCM2UzybfAqhjtbP70TEanuMqMbA24hPlLe2bBmlhENmf/F/TF6i5M5y
 Hr4gFtrA388c411rziEkBrnyJyvv4pWs8vQZcJXWMz5Qw8haYnMYh3EKo8XmgVbAdrHy
 3h6TBeRyIjez6A+HYovKpq/SZvLeAEtkRVpVrV2TFnxIf3WYZtE7jwU0pYjLr+sCl3b4
 DBW+9pTL/zMwCHDVGE+v5d0OHR2cW96cT62g+owhbrU6qYvp1cAeHEbBIdsia25S5WB9
 G07b6lN210FbhKlC1mTC+bNK3/15FsxjXeuqegoyaDDFNtvamVrw0USAaz59n7a5+siQ
 Ll5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+O9voR6d2w5/VScNaOa0W4xRCl/1x5Zgbu/5/sqAhuU=;
 b=jr2dJ+ysxKbiFL3qz0tNsCHclSEKx3UQDPSlyF37yo11jfu8L9WMncQDoe8lBKenTX
 pPfrlwCP4ecIXxZE1PuUo0liYasToFzk/HMv8lIjwn8ZYlHnWjVUrc1xJ8Dtd5GOxeQN
 tVjg09iZbRQWlG3EoNZ5LJLikzFFxqRLLoBgcaatqxIOgZxtk/3voxnUCglZ/HAPHRO4
 UtNE0q0xa0zQg11J+oGQ+/NVGhSHZSP6P8WEZzW9NbyVF/K0L6UKTPRgiZbQ1jHemQ5E
 UGxbt/9JwuwRFcEaL7kMxwjwxoDyHa1AYsd4Bnq7iZJOarnZYwDxcZwRcGbk5KGnYpTa
 qwkA==
X-Gm-Message-State: AOAM5335h95cbxNasewGncbwYs748KySr732/3purVsBWAOabxCyFrUl
 CD5nEtTaS5FXPGgvwGERS3MliQ==
X-Google-Smtp-Source: ABdhPJxIYU6nEy3jRiloEznw/duAwIPocYPQgQ6u2NqgNFBkNPr7Msp1KbwHXnsf7QpqHwv6bqh/dw==
X-Received: by 2002:a63:6c1:: with SMTP id 184mr61216843pgg.262.1594402265170; 
 Fri, 10 Jul 2020 10:31:05 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d37sm6381792pgd.18.2020.07.10.10.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 10:31:04 -0700 (PDT)
Subject: Re: [RFC 09/65] target/riscv: rvv-0.9: add vlenb register
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-10-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de67dad3-37a4-611f-f18a-cc6d06a0f8dc@linaro.org>
Date: Fri, 10 Jul 2020 10:31:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710104920.13550-10-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Greentime Hu <greentime.hu@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 228b9bdb5d..871c2ddfa1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -317,6 +317,7 @@ static void riscv_cpu_reset(DeviceState *dev)
>      env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
>      env->mcause = 0;
>      env->pc = env->resetvec;
> +    env->vlenb = cpu->cfg.vlen >> 3;
>  #endif
>      cs->exception_index = EXCP_NONE;
>      env->load_res = -1;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c02690ed0d..81c85bf4c2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -111,6 +111,7 @@ struct CPURISCVState {
>      target_ulong vl;
>      target_ulong vstart;
>      target_ulong vtype;
> +    target_ulong vlenb;

I don't see that you need this.  The field is read-only, so the read_vlenb
function can just return

  env_archcpu(env)->cfg.vlen >> 3

directly.


r~

