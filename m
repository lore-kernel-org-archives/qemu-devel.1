Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCAEC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 23:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639A3221FD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 23:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7fhr1vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639A3221FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTZcf-0003Yd-BO
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 19:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTZbE-0002Fz-Kh
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 19:57:28 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTZb7-0000Py-UM
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 19:57:28 -0400
Received: by mail-pf1-x444.google.com with SMTP id f19so2370869pfj.11
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 16:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3jS1icMq1WQjVt63k3IvyMO58GpNJrY8z8sbN6bBpNE=;
 b=v7fhr1vq2nDX764uBEVxTbVR69q7I0kuN8kcr7BESTMdF/+AFobAcynY9MMmI7haqk
 Sza3v8eC0L674MrjViAUu+p++EW2swAkuxYX+6OqASspUWaCp4BvDEkxOxbPVoF5oQWm
 XuBmjzDK6fs6DBVmCrhaMJkL5TZkd/hR4omDvytvhu1zPPyw+9rjT/sK9LdG2G3voX5e
 9Tx0clML8HwfNScPwmpVeeR2wHxl+2WfBByP4M154AyUIKMq9YcZVoM1GQssdVehg9F0
 BMH9TgXyeu8iCTxmVIuHsqqTO5MJ+IH9DPpEzgDbIELI/8oeMXeVg2jCFECZp3b1p7WJ
 9lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3jS1icMq1WQjVt63k3IvyMO58GpNJrY8z8sbN6bBpNE=;
 b=E8MEfaW89S83YqeoO8b9lRhaj4p9t17MaAO5U6KF778EW5cotF9JUmxuJJ6JTop9Jx
 AJ/Vh0/9AydXW3OjjgIz8CBXRaKO0gveAZe0QO850hT5XviYMBi+gqd9OFqg7LuWKAki
 kKwGMRbzRYTu4Epus5Rmiz5kGm0XbZYOhdRhQZqq5cvH2VGph4l5tVBBl+Epa+chk65j
 Ih45ozg1x1Ojm+3/ylLaTOIAFK4XWeDArk0ig1xkVSAzlJIp5VpiwNg5EYqlJCR2yRxf
 Zj2tCn63TVUOJznesSB/DkcDKQF0MDj6mgDak1F/L2ikxl2BiOe0rCZ0/dsgjkco48q3
 +k3A==
X-Gm-Message-State: AOAM531BYBW+UD8y5CgT0sWfg4BPc5dAB/xYUZ6+Y3iekkKPFXdslYqb
 Fg7G4cdWavGPd766Nz365HgOQg==
X-Google-Smtp-Source: ABdhPJzC+ryOEah9uZcOLfUCMOmRxDaKWeYyRCcjhQenJBPOyua4QdNcocXRxkJEUd8uM2OfClZxUg==
X-Received: by 2002:a63:e544:: with SMTP id z4mr5319937pgj.235.1602892640147; 
 Fri, 16 Oct 2020 16:57:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d9sm3908280pjx.47.2020.10.16.16.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 16:57:19 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] [RISCV_PM] Support CSRs required for RISC-V PM
 extension except for ones in hypervisor mode
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201016221138.10371-1-space.monkey.delivers@gmail.com>
 <20201016221138.10371-3-space.monkey.delivers@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b37fb65f-d389-9e2d-2b37-778441f03642@linaro.org>
Date: Fri, 16 Oct 2020 16:57:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016221138.10371-3-space.monkey.delivers@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 space.monkey.delivers@gmail.com, Alistair.Francis@wdc.com,
 kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 3:11 PM, Alexey Baturo wrote:
> Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
> ---
>  target/riscv/cpu.c      |   1 +
>  target/riscv/cpu.h      |  11 ++
>  target/riscv/cpu_bits.h |  66 ++++++++++
>  target/riscv/csr.c      | 264 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 342 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

I'd be delighted to see the J working group address the security concerns.  And
to address the fact that existing hardware will *not* read 0 for the *MTE CSRs,
so it's silly to insist on that retroactively.  Code should be explicitly
checking for J in MISA.


r~


