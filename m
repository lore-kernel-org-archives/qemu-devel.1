Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86C7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD6020757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IGaDN2yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD6020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2LI-0004E5-16
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 14:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2Iw-00021y-JP
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:49:22 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2Is-0000iR-Br
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:49:17 -0500
Received: by mail-pl1-x644.google.com with SMTP id z1so9050663plo.12
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 11:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2LMBnzvWuNA2JsKt7iJqIrETp+IBDVE/GRNCQ8E8aBs=;
 b=IGaDN2yd+hXfu9O4fM7eGugQ3v/Fh7dscL3PFQmFvNp5h0VD22U5ekmXk/alRBTVWz
 JCiB0E/4vS7SI6mGjbI47g5wrEDp/utyVtR1XSDJ+a/9s+FpcQNGwd55UhW6D98GINmt
 VPSxuxGgjkpOGkwj34prvPYoHdsgE5YsmYMfrsxf5q41o8WGe+DyK9KTpTF9tFtHpdLO
 VEQWi6j4nVISHZpaGRLOKJbP2cqiivujKNepaRw0lxZd2auwMONwuTlqNowY7Vjd4ZCs
 52sPXSX9xXtkBvTY+p8O/Mzm9G881suY3grKeFWdNuCe981lxO0nzREkjjfe0/kqsjHU
 iMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2LMBnzvWuNA2JsKt7iJqIrETp+IBDVE/GRNCQ8E8aBs=;
 b=GDVvB6Q9QQBU4cMq+t1+vyD6UAgpsFe2Ta3fBnCH8TBoh1XpcVulklHZKrnn6rm1no
 +FmO695Sx6hYf080ksm8mi5Tji5z6Xk83B4ZICgG2esatu9jDYnKDgT9Rrc4BhTIhH/T
 A1kdg56anOC4EU8ZlLlFTXvLjGuUWbKXHr04n/zrOzXRsPbABOrbIvYheJDpldw0o0F3
 2rg4gn9+6Iw11OR8GEmVCnOIyRPN5yR7mb4sAz+0hmFd29LOpc8xmsi1QGlO7sSXY4ZN
 l9Nm0sQm2IJ2v66yrsBdRx3DvIGTzY0KkGEucFsTVd+xzeGwYygPMoOaRIgYFxUnVfMi
 Xp/Q==
X-Gm-Message-State: AOAM5309VdDnKNsLDzQEo0Js0qQK/nT7Nlw8tHG0ov9ACHcquHKwXMjy
 UBtiNxjgDpjrk5OeTWuYJvFS/o0jP6Oi8Q==
X-Google-Smtp-Source: ABdhPJy3aEjNXfbf3T98LD8No2riJgFfOx+VFDubuqVM2KHbMbk5q7DFlrwV/wRAmBSS6p2wS8dlPA==
X-Received: by 2002:a17:902:8bc7:b029:d6:c40c:9015 with SMTP id
 r7-20020a1709028bc7b02900d6c40c9015mr12724006plo.17.1604432951954; 
 Tue, 03 Nov 2020 11:49:11 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id s11sm7548834pfh.128.2020.11.03.11.49.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 11:49:10 -0800 (PST)
Subject: Re: [PATCH 09/14] target/arm: add ARMv8.4-SEL2 system registers
To: remi.denis.courmont@huawei.com, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-9-remi.denis.courmont@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d26e76be-9be6-e658-48c7-0f5246508517@linaro.org>
Date: Tue, 3 Nov 2020 11:49:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102105802.39332-9-remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu.h    |  2 ++
>  target/arm/helper.c | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)

These need a new VMStateDescription section in machine.c.


r~

