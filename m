Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3689CC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E149247B2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihp7HfYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E149247B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXn7F-0002yZ-F7
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXn40-0007IE-NI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:08:36 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXn3z-0004zD-2E
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:08:36 -0400
Received: by mail-pf1-x443.google.com with SMTP id w65so3093033pfd.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sr01ZlkeVZ2zfK5nVSf4EVkQPl53h8E2U0fJuuquGgI=;
 b=ihp7HfYcgMjlqTnUGSRDqA3W0h5fqVs6nj4DF486fBNmS+tyy/3Vb9LXzu3hLCqMv7
 oYsFHpZxgIvyaQK6+GOSobYZbt9xd2xjvs7TYWgiPEx1tU6rvhqc/dAEV7smgWs51Jq6
 XSMOmVv9bylwE2/1TG02yBUmpDKFGeKdKPDyvMTQoRE8vmec/Ko4cPd2rYdEWtBpsUuh
 1/zVc1ev/1lmnBB2SL8Zp3X9ZO9Jq5ABnQryZha9CITjtqQ+YYZ91Bl7sn+R5eWxThoK
 cgWpv9Wkzd9bTFI2OhSTg/uqKPph6U6ZstDheh1+spQ6/2eL08NhDumjmj2oDMl7Vd3l
 QJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sr01ZlkeVZ2zfK5nVSf4EVkQPl53h8E2U0fJuuquGgI=;
 b=o5cB8ARbd6oxZZo3muAWLwYlOo9lGv2IgcYrTaDoZ4GbCzMPSzkg6o4SPGGlcnIGGx
 YzuE7X2f+tZGwDg7UdntUMqXN35SJakOZ/BVbvh+o/yCPfb42/a2qkI6IneEE3pwVYP2
 ZtakSnYu48pTGriYSNxIBrRYWe9I/hJfjfOz5cL5/bAO4MzkpEaVWYkc7OQ1K/PQzXVb
 wpd+Vb4NhcOhMJeawXwBR6S9WPkDkM691XA8GK8BYBOrAWJHEG5ocl9ToysORY21reGK
 U4c9N6AiBwRjTFztXDS+su++ZNlKtCOzl5JKx/EK6chedT4yMjWSKYx8S91JdB1CqELv
 VHWA==
X-Gm-Message-State: AOAM530+0ZObXizQeE1g0NqS09D/bLI7mjS+LLV3kJNyuGZezcqq3nJj
 ON+cnozWClEcnuhFA4KgCj9t0w==
X-Google-Smtp-Source: ABdhPJyhoAhXEVZnd6cIJpjD1WBd4OAATXtDS9eCw2/Y4IGYilWRh+6jD1cdTioUCv2AOF7+0k38gw==
X-Received: by 2002:a62:7d4d:0:b029:152:1b09:f34 with SMTP id
 y74-20020a627d4d0000b02901521b090f34mr8166217pfc.76.1603897713503; 
 Wed, 28 Oct 2020 08:08:33 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l13sm5568767pgp.25.2020.10.28.08.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 08:08:30 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] target/riscv: Set the virtualised MMU mode when
 doing hyp accesses
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1603896075.git.alistair.francis@wdc.com>
 <3f5666c9eb72758011c14a660de99ba86a0b6561.1603896075.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7a193d98-b55b-c53d-09bc-7d205a27b357@linaro.org>
Date: Wed, 28 Oct 2020 08:08:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3f5666c9eb72758011c14a660de99ba86a0b6561.1603896075.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
> When performing the hypervisor load/store operations set the MMU mode to
> indicate that we are virtualised.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/op_helper.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

