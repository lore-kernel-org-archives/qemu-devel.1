Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4487AC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1287C20760
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOFoFsfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1287C20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLKy-0005o5-BZ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLJa-0003o9-Ga
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:49:46 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLJY-0002MG-QX
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:49:46 -0400
Received: by mail-pg1-x541.google.com with SMTP id l63so7604094pge.12
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i8LWR1pvbpANLnx8fLYmjiZmvBs5RouawXyYu7q2q9E=;
 b=fOFoFsfe/w0DrH2vLbtxrGx+B9slqYdJwDz95L5Josau+MDGYuRTH89ggw4ydRp5nK
 it5zM/dKmCX1q8mnf5JdaQCrqXtfTmXUE2Po2umDkVLBIqc7+BUO622x13aj3WjKb2GM
 xpcI8rHQAmeWrGgYetxzZqO2Zn2mbrPcp77ScIgsdU/AHuPepGd5is1BL46eYrq3Rabp
 8TKdSSm8oitdG0tENtdtBraB9mdy2MGIqMrBgD0X4+K1tbMtFY1pC5TpcMAKTtpwvhPS
 qGMXhOtyRLOsAjI2KsC6Chk2m9Xfxy2teKe1W2rckFI+1XE6rvg6pEEeshdj0KwJzZdm
 5UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i8LWR1pvbpANLnx8fLYmjiZmvBs5RouawXyYu7q2q9E=;
 b=jNy9fG05BZZRDKriSFVL7nyFE51ydzoyXmWnAMP6UN8jE+e3N1sMtrj5I1Leayu2IU
 sOsTcI4nzlh12cFmYJJw2T5wE5D3gy05Co4NglbAyIIanCyDBTIc5kMBrpS4z69ukzRu
 3FOFRDs/y6atCLhdza/Mu+D6/vZ7tGWa3EuSpwi9UbQJOx8LCfLAW08rPB4NRXa09q2U
 YrfXqJCElJHZZ36roMseVciV+8k4pZR2qpJFoBYDk5h3lC46Jp3QxDqvY5lF/e8nzgKa
 KcP+VBYMBpv80dfYEoQJUhmN2uJZthF2QYh4abDP3gbTX95TKmrsyNJJNHkTI7ZMkBqJ
 Na5g==
X-Gm-Message-State: AOAM530AqlhNhJIGELQ+BhyOQ4ikAE7FyU9T5tLRqbwV4lQvIbLBfAeb
 Eaog3z3gVgu/k2ZyofjLSsb6vQ==
X-Google-Smtp-Source: ABdhPJywDEOebyPOCQjUjeDOJr/hMoJiE5sClxVBpvn2dQqTP6QYTtJvtNlstBgO3Y1drHu0eALUFA==
X-Received: by 2002:a05:6a00:5c:: with SMTP id
 i28mr4528807pfk.274.1594734583415; 
 Tue, 14 Jul 2020 06:49:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s89sm2800115pjj.28.2020.07.14.06.49.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:49:42 -0700 (PDT)
Subject: Re: [PATCH] block/vmdk: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594600440-23217-1-git-send-email-wang.yi59@zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c2de80c9-7b18-cf1a-6526-490bf595261d@linaro.org>
Date: Tue, 14 Jul 2020 06:49:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594600440-23217-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: xue.zhihong@zte.com.cn, qemu-trivial <qemu-trivial@nongnu.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 5:34 PM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  block/vmdk.c | 3 ---
>  1 file changed, 3 deletions(-)

Cc: qemu-trivial
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

