Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A53C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CC1217A0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Th/7UqHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CC1217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5I8-0001jb-16
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kb5GZ-0000X1-7T
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:11:11 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kb5GX-0003Jo-OB
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:11:10 -0500
Received: by mail-pf1-x444.google.com with SMTP id e7so1882918pfn.12
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u7nunNRPHn/ShgY0UauRuAHM3FcDcLc/dM07IYU12iY=;
 b=Th/7UqHSuoNfuud97wv9XhsH61qPY1Cw2VW52MjwWs1W+RxQZCSZ9+0Yc1xlJVg1Zb
 L/Wo7JhqVHWFCh0j+Y0yG/k0S8T3Rbr78K556XvpZgeV69f4horet/k92UM/96Za4ykY
 O57GE7YgvxgGzKCVErTc9Gvd+gBrIFJi10fJ6mWUGPcL+nuA0ojfKU92aVApRXUHofcH
 9mqLJ5pZE1JEepDxsONcGEL4NX4tGu1UzHbvd3TrDbeDXQqFGjm6ywvTLxhNZJ3ijBdw
 0rdtINxsI6gjybMDeFyL8xCFehQqTm9DWWft0SlarqdHQk6Iu6/qkvritlqwBVhkvA6K
 ruGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u7nunNRPHn/ShgY0UauRuAHM3FcDcLc/dM07IYU12iY=;
 b=eHAOcAZB/Re10HImd8s4NTZ/Dk52aL8y+2Jh6B+VrC8lxj91ctVnOI8OMoAVYogXiz
 lHCY2GrF21cW4xyinZXvXdAP8WKJHg4uxj+0EoyOhupYQ27Rr8yCGpbGtVhFLApu7sru
 5GWQS6TTQCvU3yNs+QRKRcv5SDZB5RnIeDdCxTATgThPtjh2lbVVPWQVCV5lS1rzEEJI
 HVTikG/jCG6MlkGmAcwlD51O+fSR8/VQuqy/6yBsQTFXPKNBLn5sUNobAi1hmDzR11tO
 Rvq6gd5HZTpX65Do39hzjGLjVfHx+2RBDtBilw4YsVGDUurjrNbbxh5+pgshF/pY7NVr
 WGXQ==
X-Gm-Message-State: AOAM533i2LmEapo6/YtXv+vzrbYF368+EBM7I7A2biqjIC2dML84GyMY
 WaeMu7mi8MHuT/oOoAoAQrHozg==
X-Google-Smtp-Source: ABdhPJxlP9mGzClfGCj/nEVNdjxNdW1SIvFBoBjU2o0pBo7aLE7lQE/VTeaSZOGc7Q7gSVjIaW8dYQ==
X-Received: by 2002:aa7:83c9:0:b029:158:11ce:4672 with SMTP id
 j9-20020aa783c90000b029015811ce4672mr2826867pfn.23.1604682668149; 
 Fri, 06 Nov 2020 09:11:08 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id d4sm3178097pjj.45.2020.11.06.09.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 09:11:06 -0800 (PST)
Subject: Re: [PATCH v2 3/4] linux-user/sparc: Don't restore %g7 in
 sparc64_set_context()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106152738.26026-1-peter.maydell@linaro.org>
 <20201106152738.26026-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ece1b508-d1b8-4fa7-2018-47d30d9d4179@linaro.org>
Date: Fri, 6 Nov 2020 09:11:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106152738.26026-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 7:27 AM, Peter Maydell wrote:
> The kernel does not restore the g7 register in sparc64_set_context();
> neither should we. (We still save it in sparc64_get_context().)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/sparc/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


