Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B50C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892A9206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EqTYvkSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892A9206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3kKW-0005bI-Aw
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 14:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3kGE-0001Bh-9m
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:05:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:45003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3kGC-0006SK-Ni
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:05:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id w17so28173447ply.11
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+oJonRURUKUDUwdxnAqYI1jrChZDjkViIux/TCKIeQk=;
 b=EqTYvkSuthyKtToL+4o+EbxJmlT4GswtfbgX26/SnO5n2dtCLMT3jDUckc+oj8apNR
 SkzVI1SFMCePBFxrFYVhtKUrDWxLhTU1f3R+oHnVjfmyyU2av84XttGdmP0OnWEpBiFZ
 k6wFwa9lV/p7kzA2wcBJadgzWVBBx/uRy80tcLbe23Vl5f9j7ISqZlSpOVIzS4E14mMI
 x9sX5bA954GJHublLAQAgtdTPMZFWLC3R8iOyJGOYomOcfyq+9DrGbnfqlan3JHOBjkr
 LSe+U0sNdvhD+iF+SVk3/KJyHJSr6TzHDAOgJkmIvRGhrPkJsBA9WYlacoGXnCd0+Jz6
 xXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+oJonRURUKUDUwdxnAqYI1jrChZDjkViIux/TCKIeQk=;
 b=ZOapN0RR8/HpNb5oA//eQOH5+EzQT1x4p9JtMKnmRdyrmlOtpozNyuBxGzmQHmjadj
 KpFV0NlU4G5lnIQkGkz39q0Y7pvNSsO9Km4rFc2Qa8YuBHzfvod4kLvh+9oMDdyZv7EV
 UtMBesJyLE78T0qGsuS3HA6V7/G4PtejX2ZvctUCgebLmpDZ2z2gIW0zShgVe+NndhOj
 e+NMkjTBFwzQIxguQDDg9GaD4wi9JqpZihgledOaqhpZoGZJ7XjkwFENwVdnqjoGN2BW
 kLoKDor0xnLaF15bbvIYDNSm5Pzvcv7njz/cIdUhvcLTYC5wLAEtMuQL/z2w9n1uQfs4
 3OsQ==
X-Gm-Message-State: AOAM532/t76t4xkwhNDd+yIIN7Jz7+nzxeMPmJiHCaVvi13QaUc9yAlE
 diaMoiWZMZNoDnyZAh1wB8PpaA==
X-Google-Smtp-Source: ABdhPJwkEHbfJBARNqiDUn7vbLXfLsvlJqUfalUXoPOvqV8kQ/s399RvEdxH7yAI+bIdZxn2Zp8Sfw==
X-Received: by 2002:a17:902:b902:: with SMTP id
 bf2mr9193809plb.100.1596737099007; 
 Thu, 06 Aug 2020 11:04:59 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id g9sm8951508pfr.172.2020.08.06.11.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 11:04:58 -0700 (PDT)
Subject: Re: [RFC v3 05/71] target/riscv: rvv-1.0: introduce writable misa.v
 field
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-6-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <88180ccf-6a24-56e4-0be4-3a27ea452a21@linaro.org>
Date: Thu, 6 Aug 2020 11:04:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806104709.13235-6-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:46 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Implementations may have a writable misa.v field. Analogous to the way
> in which the floating-point unit is handled, the mstatus.vs field may
> exist even if misa.v is clear.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

