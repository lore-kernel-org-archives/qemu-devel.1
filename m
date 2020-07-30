Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C22C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B182074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bt2EO4GD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B182074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18OR-0002K0-OF
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18Ni-0001lo-G0
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:13:58 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:44086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18Nf-0004TA-QF
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:13:58 -0400
Received: by mail-pl1-x634.google.com with SMTP id w17so14069441ply.11
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C4UeUkrlVs7jXp2utXIJQJa4ULIcanoqKLmny+J/qc8=;
 b=bt2EO4GDj6Uc905+EhorNxApY+B3Q8rbga/C+4mxnPXYcXqtEalkDiLa4fJz72x6GP
 81YT8eh8WnOPXE4wpsC5SNq0JM3zRLJ5W7zP46T4OMcqlla4xthuLX8QlMnBZuDn4upr
 9CONTNCtAnrwcpLhklMe26MKhufWmPFNVze5vW0Df797/Ra0EGFsmRXWYzWGsRzfJFUF
 BCu/XifEhFL9zkAkPAnmgDEnFtVrbKjDbfFXUJp1wUc79OL6zmr+lawtz9reQ+o3LLFj
 1bOdFXuJz8VvNxJQuXkfY0Cs/gNX37zF+MqqBeRUzJ7VjGjg3BZhzXW8hCv+Rvb0nqlG
 tltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C4UeUkrlVs7jXp2utXIJQJa4ULIcanoqKLmny+J/qc8=;
 b=Jyt8ttcf2/ByzAvoKfYSpxTsY/3JLyJEfQPm4ppY3Zi75F0y+BPMa+zaT343imC1gv
 QxYCCYzqAg0bb11/lQFH78CO6XeXDRTts/FKM4OMmm/IDZ0h2IsKuzfqdQ2iH4bbZuOX
 Efhb1Al3mX39NULBcRBLtQpDirE/k5kbdi9mQ1SbFAMZdBKXsv0+jm6ouKUsn8w0EWtN
 MgaiBnld0M7VJjiFlZlK97U7q/D/nc7wz8bk6FOZkV7YTH8GK5HXRZrx4KF1CWQbjGTH
 FpvdQ5d1on3aWHN4+n0CWwkUxGmy6FRVoYHmtNYJvrE2qFDT0I1Tz9XZqCjVnmm4WvO8
 W2Og==
X-Gm-Message-State: AOAM530skh4+SfDydZtU1jbF0Gmn9ouZKGtKfqapP9E53tqIkN5Y7wel
 J08L+W7jKhMU/7LJxRrOiV7e5A==
X-Google-Smtp-Source: ABdhPJxGm8Q5XZ8pi9B4EnENrH2jqoy6xdQ+Ww5nzu6pdgAHU0D1a8QxhUuBOLCTs/LBNV5M4BUzDg==
X-Received: by 2002:a17:90b:4b82:: with SMTP id
 lr2mr3226996pjb.126.1596114834279; 
 Thu, 30 Jul 2020 06:13:54 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x20sm2863184pgc.49.2020.07.30.06.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 06:13:53 -0700 (PDT)
Subject: Re: [RFC v2 33/76] target/riscv: rvv-0.9: find-first-set mask bit
 instruction
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-34-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <42945a77-6fac-dd58-17ae-cf49802cee04@linaro.org>
Date: Thu, 30 Jul 2020 06:13:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-34-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/helper.h                   | 2 +-
>  target/riscv/insn32.decode              | 2 +-
>  target/riscv/insn_trans/trans_rvv.inc.c | 4 ++--
>  target/riscv/vector_helper.c            | 6 +++---
>  4 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

