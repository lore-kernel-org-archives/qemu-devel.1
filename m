Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25E3C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E58247C3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkB+ARPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E58247C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnKP-0000db-Ib
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXnDh-0001l1-4X
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:18:41 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXnDf-0006IW-4M
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:18:36 -0400
Received: by mail-pj1-x1043.google.com with SMTP id p21so2712699pju.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Hmt0eMVnOApsZe864FbdLsRBKwDMNvLVNFCzZm8tFlk=;
 b=ZkB+ARPxAgfYzNE07EeqhjYYaxwfWsql0e/r/VGnNtZfLnQXhO+G3o2dtPZiYLx8WH
 p2kBInRvcOh97fbrU6qhc40+7596JHx9P3yABICwMK/tRvj5m78vgiAGjmzD49SIx+jE
 Pp8LMon5QF7U9ZLotazGPTArhUTbN/gV6JPhC+jmZZGN7zGFy7UoEAewIWDNhUOJwzxK
 xFy1U4MJ+9jeawI97/fivLgGhcj/GcIQBpIpwYOYctedBWkQMYwGHsJRYc1gZ7cvWShy
 lXWGEgrfop9hXWrfCyxLxX6ryDvBI6PjVmaPYLQCYl5UJtSAHEG1eNFwFJciZkPNp4xu
 bzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hmt0eMVnOApsZe864FbdLsRBKwDMNvLVNFCzZm8tFlk=;
 b=jdaxa4awx2vsxNlag+jzXL4an9HsXKrntFjEaYjp+jl8K5cDnCyaY+QvtBgnBL+dom
 z6r2oDDhgbGrCWgvxtDydqaB75iZcidTn5zb0pddy8XmngCdPpRKybJ2loSTHuNgkkme
 HOlzAz1gLzHzEIFgKQXJDD9WgAs/Y2VqiWXF9JUG/UYkhYrWNydWS9TfI4CdZmoa+nV+
 LGiDuc6gasbpyGAcCpXrD6PBc8M8yfFn978mO4CibfohoWoe3lu5Sb99AHu5ZckkS8ik
 cyKzdmApiyWqDPwl/4WPABgRYYgbtaFW+J6+GVe4mTNNBOSYfrlPBhdiFjzYGzi2gXS7
 N8tA==
X-Gm-Message-State: AOAM530FETytgZn3UTq8rnH05/B6DfUtyvjWMN1jo/LDdvDpiPelGMc0
 kEIV/E/IMsK8UM9C764F6XNefQ==
X-Google-Smtp-Source: ABdhPJzImGz/Gl+Thm5KsKY/TQA34pjDzoxjBhETLRyrwDYLbQFl+1bQ1SuwzYEhBrnccDh/yObrfw==
X-Received: by 2002:a17:902:7c14:b029:d4:d894:7eed with SMTP id
 x20-20020a1709027c14b02900d4d8947eedmr8150255pll.81.1603898311102; 
 Wed, 28 Oct 2020 08:18:31 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h4sm5745057pgc.13.2020.10.28.08.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 08:18:29 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] target/riscv: Remove the hyp load and store
 functions
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1603896075.git.alistair.francis@wdc.com>
 <5ead43dea141994823a113a2e7f1494df12d32dd.1603896076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8706b460-7a44-2b89-d736-c0e0274f77c1@linaro.org>
Date: Wed, 28 Oct 2020 08:18:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5ead43dea141994823a113a2e7f1494df12d32dd.1603896076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 7:42 AM, Alistair Francis wrote:
> +void helper_hyp_access_check(CPURISCVState *env)
>  {
>      if (env->priv == PRV_M ||
>          (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
>          (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
>              get_field(env->hstatus, HSTATUS_HU))) {
>          return;
>      }

While this works, I think it would be better to compute this into one bit of
TBFLAGS.  Then you can test it during translate and do not need an external
helper at all for the data accesses.

It also means that patch 5 can be simplified...


r~

