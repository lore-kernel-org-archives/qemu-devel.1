Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46248C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1038E20842
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJOliML5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1038E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18DL-0000kj-D5
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18CS-0008En-9o
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:02:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:42942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18CP-0002Yv-Sj
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:02:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id q17so14030857pls.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K4d2aOJKk6Ll04KZGZoQftP8vTqPy7vZDuRH8215P1w=;
 b=GJOliML5Tv9eIfD7EYPXETQw2Pv5NOY7D8wrFOKXxGgQhOuGzwXqUGvcGSiS9LH/AS
 RfSqDgipMAzeNT75qKMHKC2vDmWNOuuk8Kn8A7nYPyV06IA0JpQvCDLP7UEtejrghMCh
 SaLm279QmBZjDRQjX43Fidowkto3qUz7SHwXFSP/pt4n7v1+6gxiGZ/4KFLEO4vokTxc
 c1TW7aBxSzXTU8/V+vmjBcNuNbWAvyd1oux5O9Mh/p0C1yov+iBHqT9Hpxb+NZwjyR7I
 +T8/o5lCjQ2elanbttjkVzKPiOP/gy2NJDIMh6Zy6vqCqI8iWsXYCA1UqbcmkREyfLfM
 Yh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K4d2aOJKk6Ll04KZGZoQftP8vTqPy7vZDuRH8215P1w=;
 b=Edd9vyDGhbgs/WxQWSkuwxcMPfhdemK6IvQtu2/+F9d3MoK7ASaNUY17PRABoo42jW
 KIkl9JjmTOG9M9pSrueouYa2ApTCifmAKiOC0z8n1bPrDvTuQXs+O/Uu7zbDqaysql6J
 UJcO/a8xzYGXdjpeOKLK5R/G9/n58SufIDHt/6rhwo2SnA27LqpeSyxUBG01itL1QMtu
 EQuZjjIEHA141SLytxiQKrcIQUTlXUZ43+/VlXQhLwQVajlHyzwVJxkxXDtsNEnnwO0R
 jJ76cew+q5jck6AjxV7C3ZbGvEF+UeyLwtA9hi+FjkYpDMJQ37crvmcKFl2AQd9E1PnE
 m8Hg==
X-Gm-Message-State: AOAM530/8ohe3gumXepQUU4vEtqOlRPuR4gdYwZaCwdL4efMa8LJ96Iz
 3MY1QSK3qAI+JV/spJ1XoqaMPA==
X-Google-Smtp-Source: ABdhPJzJfJZUwOqxMDWwlZ4ojBT+L4Eeik5zv8M3nYXfF8T0HZz9KNG5TA80mqSdP0UPAnKfIrH5NQ==
X-Received: by 2002:a17:90a:d56:: with SMTP id 22mr3190813pju.58.1596114136058; 
 Thu, 30 Jul 2020 06:02:16 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id g10sm5908822pfr.164.2020.07.30.06.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 06:02:15 -0700 (PDT)
Subject: Re: [RFC v2 30/76] target/riscv: rvv-0.9: floating-point square-root
 instruction
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-31-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <36462872-e635-91a3-9e13-cc82b36a2bf3@linaro.org>
Date: Thu, 30 Jul 2020 06:02:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-31-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
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
>  target/riscv/insn32.decode | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

