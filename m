Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D0C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C910206C9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6AdNSF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C910206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOeFB-00037I-ON
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOeEU-0002Re-6q
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:53:38 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOeER-00025I-Gn
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:53:37 -0400
Received: by mail-ot1-x341.google.com with SMTP id y5so3859696otg.5
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=obIunJMCwuIctwMB9KHyMjEcZAsycYX2a/PARzklzgo=;
 b=e6AdNSF8ykaX1FRPeb0Av9rzGcI6O/WKjwfucJ0YWkM2PWqm4XXzoO8A7B/wgLAjgJ
 jwmVw7iegXUiPIuumoqUV+pbHwz5LqTgso0qHLSoAkMhPrcHl/EtqNa538JQbvcmsIee
 mYPulDS/O9ZsiGUJPi5FlBDl/N+8joV6u1R1gb2g14QDvj52ENpUkRvRi5Ka67umkufO
 8f/VJ5hNm8bl2RKyrR226RCuo5+kMTJ09UjHfrU26ZIIB+h/y311oK3EIPkKGRcD/yJW
 0U1v4jHJ0ovP3h+//HxR5TBDApmGa4/blsu4aium9WyQjaOM2muWO3c5v2VlxCUUkKGV
 bOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=obIunJMCwuIctwMB9KHyMjEcZAsycYX2a/PARzklzgo=;
 b=uKGpbWVts4+ECmCNu/pi4TVS+EKfSnQ44/tvGe5LvNkjqxJ27u+FVtzER9VQBzStmL
 kwKmMkx3NvXZfGnzenRKeLy6Os430OJmu5M+LvOj1L9vkmb8MlxoCiINsEm/ml1I88pi
 Vj61wJ04kr58ylVDpRZrpCHxLDjE3lDCp+RZ1ktCQmfAz/GxeOOhLycJR6E2j8cxmJBa
 1nIctvk3+LL9WfUM30ttsgJ6tAr4L52B/uMmB6/FofY0Mw+8Mw1BR7gClpaCk3/ZQ3qe
 VxvTROfArlbr/C0XHiO8OgFu3ccjVdQTPCV5RHzaBOgrDEw2Hw5Trzv3tyCmRMedftwq
 XuaQ==
X-Gm-Message-State: AOAM533wB3p5LvLH8QbnW6cGTS3bavfAKgBtgqIXDWZT+0pMyPKSpzva
 W/aO0xViplwA9jsaCZSu0JGoOg==
X-Google-Smtp-Source: ABdhPJzortVGd43nIZrKjIRjdtZc+WQ0B+CpSCY952bMMF8IDrxjYl/ZrH209h+EJ6RbncHWhg6Nog==
X-Received: by 2002:a9d:5509:: with SMTP id l9mr5179019oth.154.1601718814363; 
 Sat, 03 Oct 2020 02:53:34 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id c12sm1087623otm.61.2020.10.03.02.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 02:53:32 -0700 (PDT)
Subject: Re: [PATCH v4 11/12] target/arm: Reorder meson.build rules
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-12-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1328c0d8-be1d-1cbc-2c58-f17d078a1104@linaro.org>
Date: Sat, 3 Oct 2020 04:53:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929224355.1224017-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.256,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 5:43 PM, Philippe Mathieu-Daudé wrote:
> Reorder the rules to make this file easier to modify.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> I prefer to not squash that with the previous patch,
> as it makes it harder to review.
> ---
>  target/arm/meson.build | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


