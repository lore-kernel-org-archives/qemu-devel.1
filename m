Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A07C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DDC21556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F69s7tEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DDC21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2vS-00075S-02
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2uM-0006Mp-Nv
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:27:58 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2uK-0005fz-6c
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:27:58 -0500
Received: by mail-pf1-x443.google.com with SMTP id 13so15294165pfy.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 12:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Om639Ofi/g0Iof/mRVhbue/JWW1RecH90mH5vKA2w8A=;
 b=F69s7tEML+b9O5dEQJoWJH+ChD2/yA8pqaJ8LMbPm0F0UFGlocd/v0Au/vYbCGynmV
 BGZaIqx8O0R+qMdtlbN9g9AaP7+npf27RUOt3t2QVMyYlawb0VLdsxxMQxjYDh/3xhAK
 TPv+aTDRLS6yZ1JvHgOox2Bofg+f4Y0x4r7cNwR+MY4AKJXIZm/088AAYPzyZ6UZ0fx9
 P1AH/1fLqVvIM5mpv9KM0xudoF6eMvxY+o4oEzyderW7kZBTUUIPlBLgWVgcfVckHxh4
 L1RF17dDIYcYgdVVzqKWI8+J0RxR+ig3558nCWzIkQz3w7teRLGSAfs2C28+Dnnp5UCw
 buvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Om639Ofi/g0Iof/mRVhbue/JWW1RecH90mH5vKA2w8A=;
 b=YabEoFqoFnoW0SFYsU3Bt7kNGjuLBanEa61g8L7QAzhzjLvuAjSKIxQT7K8/H8TCJJ
 F31/FbkxniwozgJzobDx6xLml8EgzvN1Xl1BCXvHiB6EBqcWg+F/e9CMsY6Trg5cO/7J
 9Xr6Edy+OJN6/9sjuaHcUFK61eGoZPqozA6wKVzml6g6BvsuV70ST0x7pcG2WIMsqm3o
 np4twIRz9aZeYO/WPeFnPoPWy/IAmGjT3JDO1PTVOc/coiLgwUuPBvGM30CjEW2Ebwmw
 DZEkCBolWHsPC6rDHxzFpDbDtALfquRW5bpJwb59OFc6RsuVYSJAyfO4tlulnNoosYYJ
 Q5KA==
X-Gm-Message-State: AOAM53199dVQI26ONVAAWj6J3cc+SOde6ZK46eg76JtPKs49PHZYItf/
 GI+//fZltSbXvyvpAI2lmFXOqA==
X-Google-Smtp-Source: ABdhPJzW91EXGVFamSmiMPlFAho5pQM1eyw6FKrpfE1D3huEg3Djyvf5aYffmzHQKJKf4iUdLlTxkQ==
X-Received: by 2002:a62:38c1:0:b029:18a:d50f:255f with SMTP id
 f184-20020a6238c10000b029018ad50f255fmr13946890pfa.22.1604435274698; 
 Tue, 03 Nov 2020 12:27:54 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id v24sm12179pjh.19.2020.11.03.12.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 12:27:54 -0800 (PST)
Subject: Re: [PATCH v3 7/7] target/riscv: Split the Hypervisor execute load
 helpers
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1604432950.git.alistair.francis@wdc.com>
 <078c49d9759ef845affe35ee690cb4242e511429.1604432950.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c1edecb8-f2e7-3c38-b671-f7efde7623b6@linaro.org>
Date: Tue, 3 Nov 2020 12:27:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <078c49d9759ef845affe35ee690cb4242e511429.1604432950.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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

On 11/3/20 11:51 AM, Alistair Francis wrote:
> Split the hypervisor execute load functions into two seperate functions.
> This avoids us having to pass the memop to the C helper functions.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/helper.h                   |  3 +-
>  target/riscv/op_helper.c                | 36 ++++++-----------------
>  target/riscv/insn_trans/trans_rvh.c.inc | 38 ++++++++++++++++---------
>  3 files changed, 35 insertions(+), 42 deletions(-)

Modulo the access check, which should be shared,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


