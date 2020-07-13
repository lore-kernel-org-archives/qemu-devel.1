Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7B2C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A0020758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bK/FcirU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A0020758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3tP-0007l0-GJ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv3sq-0007Ik-Uo
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:13:00 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv3sp-00052B-AS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:13:00 -0400
Received: by mail-pl1-x642.google.com with SMTP id k5so5908464plk.13
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZQzE3Sq+ALDsZXOd1ZC+ND5/4EpaJmu1O38vaBIUBmk=;
 b=bK/FcirUrGB1W/pdsVGHbBhc8FxcB7tGTlxfuQHtf9vjcK46FYFhDA2BhZbBSOqIyZ
 TCsrOA4ATwip4cnhBbjsT+2w1eRGjHiN54HXZKZFKk4flnWQW/6JsZSZ2iIfVFH30nrp
 TI+FuawG60xR+TPSaoBiHMBwqicUOGxDow+SzU5GxyKBttTrrvr6hE/n1BOmlBqbRJ8W
 DW6xGcmhPE/72oADz4DA1vo0wIsR4K9cEzN9h6bpURi8tcAPboEkmBYWEKzbTkdlD80w
 9eqChFtUP3x8hCowTWTYUDH5N4jIyxXbotVnjbM6a70kZP9NS7L01rbQJnyki0n2UCMM
 UeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZQzE3Sq+ALDsZXOd1ZC+ND5/4EpaJmu1O38vaBIUBmk=;
 b=GXW8gBI8qn4q9DFYzTWA5g3EgXTh547Qk58qFscPzVJ1qjcXXkJucjdetX6Egh7jB7
 PoE2Kmsu3uGWPYTOAa1hP4VJwyqfSHgSHKcIAic9i2nkAKG1Oh9GWdWeHzWIAloiY29V
 TlITxEAfIxdfpqwh//yEDnH/4nSMcXN7QkIcy2x+gSdU295zRwzlHZL3Vx3aA51Fi1YE
 xpef5RNVhHcdL6TiPQ3Cm0kErHF0pvyTZERJY57s+RhQN+6xVKS4kAc6ovuLJiSD1E9B
 GjakuZHmZf6deXqAFAjSYDlj9HYLsENrz2aHiKpbgRhwHSRsDIB9Y7SnCyF5pucIe3n3
 Uqug==
X-Gm-Message-State: AOAM533y6OAuGQBTI5G0cyXlSch7cF+EcRFd5SSbTO9uqCrekqFuMZ6d
 v3XCdizRwhjY9P6u0HaZmVzu+A==
X-Google-Smtp-Source: ABdhPJzX4rjvhqgpxvJRp4A18YAwvBYjDgiGPizZO3Gh4Y2gTHW1rza22jnuywTNZtLWcBai1YEkTg==
X-Received: by 2002:a17:902:d391:: with SMTP id
 e17mr932780pld.70.1594667577763; 
 Mon, 13 Jul 2020 12:12:57 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id f3sm294472pju.54.2020.07.13.12.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 12:12:57 -0700 (PDT)
Subject: Re: [PATCH] target/arm/kvm: Remove superfluous break
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594600400-22823-1-git-send-email-wang.yi59@zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f5bf68e-9b0e-3b69-91c1-f80789f1b079@linaro.org>
Date: Mon, 13 Jul 2020 12:12:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594600400-22823-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: xue.zhihong@zte.com.cn, Peter Maydell <peter.maydell@linaro.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 5:33 PM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous break.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  target/arm/kvm64.c | 1 -
>  1 file changed, 1 deletion(-)

CC: Peter Maydell.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

