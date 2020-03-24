Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CD1C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C1020775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H14K1NHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C1020775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGl2v-00027K-FP
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGl1s-0001Z9-Jx
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGl1n-0001gq-C5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:59:44 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36488)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGl1n-0001g4-5f
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:59:39 -0400
Received: by mail-pj1-x1042.google.com with SMTP id nu11so1549357pjb.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/AMvqKeoq3ce+Qbx+6L/H/oCNxBmiQyQQ0XVMeVvrhI=;
 b=H14K1NHDDUv1y0Qd1Yc2zFFrVJQxSphee1+X3vTeAwAekqw0QzOdaWAa9JmDgTakjX
 tyxbfUFzZ60D1MXtxpVQZLSebQm8fYJVd0JUNKpMViGL/MpDG0QUoCV0Y10zWzgqZepy
 cJLVLrjPdQWLpPcbja+5y/fDO5T4u+e54EYFiZ2DWAgEnQq8H1jQ+eGUJ0jQXn+3RDtW
 n48benbIlkoL3Qe8rbLZzvXA8KsAiJlqOnoRcKEEpPJOwHSq45YRqu+s8gz4T6iQTND7
 ddsX3s2Zd5/WZIJBq3naQeJaDT8Uo7AtuIXlVIKQj5a4fO/YsrWpVJToBm5lrsfgPysn
 Jgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/AMvqKeoq3ce+Qbx+6L/H/oCNxBmiQyQQ0XVMeVvrhI=;
 b=BAKUipcx9pBDdfRoe3QQZeIqinWmt7T5SsNqgFNCtOOev+XpYH2R5Zc3GuQNch6m7F
 HOXAmWIxc0y75cHGbaraouxDj+c4u/7/QwIPMUxL2lnaDaTdPrkinhOcABAQ8ndOw4nR
 hT3kkyejLJ1IVMo+zsxfThHbQO+7K9xiBaj9jkiAybpGSRKkoGDwd2Fl4PhhVU58d8J/
 /qnf+EQFkw/ItKX0t5g8lZLOFYeD7JxC2YnaYCwdgKx5BQ6wT6QvQqvYLCXux7N/JMca
 +eu9O2Bc/fIkKV2C70yDzXtWOMpyEoS/bUr5D7FDQxRnODA2p6WBr7ZxXpUDpBlOuUlj
 ROGQ==
X-Gm-Message-State: ANhLgQ2Jc6Q0N6TrgZTeaiv+Mj0bjHZfP5TDGB2FdQmJbJKO26ZqW48I
 WetcKiZTAnLroGE8xIk4uzvCfw==
X-Google-Smtp-Source: ADFU+vtBde+exRk/v27idtvXULAP1N7eL6YBonTugNUVKzrK/QMLQCqpcDCGjfMVAZbSofj12tJyIw==
X-Received: by 2002:a17:902:7008:: with SMTP id
 y8mr27313003plk.279.1585061978174; 
 Tue, 24 Mar 2020 07:59:38 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i3sm10220124pgj.13.2020.03.24.07.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 07:59:37 -0700 (PDT)
Subject: Re: [PATCH for-5.0, v1] target/mips: Fix loongson multimedia condition
 instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa622b1d-e28a-c3f1-d18a-73e8a67c8ccf@linaro.org>
Date: Tue, 24 Mar 2020 07:59:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Huacai Chen <chenhc@lemote.com>, aleksandar.qemu.devel@gmail.com,
 aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 5:22 AM, Jiaxun Yang wrote:
> Loongson multimedia condition instructions were previously implemented as
> write 0 to rd due to lack of documentation. So I just confirmed with Loongson
> about their encoding and implemented them correctly.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Acked-by: Huacai Chen <chenhc@lemote.com>
> ---
> v1: Use deposit opreations according to Richard's suggestion.
> ---
>  target/mips/translate.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

