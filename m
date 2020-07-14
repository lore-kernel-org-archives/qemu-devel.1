Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2BAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E585920760
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHVbyzFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E585920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLNq-0000aP-7M
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLMK-0007GP-Ba
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:52:36 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:50469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLMI-0002qm-R4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:52:36 -0400
Received: by mail-pj1-x1044.google.com with SMTP id k71so1625305pje.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uzqNYC8yCkHcda0vOTzyDPkKP1e9rdP24oC6OtiqKzY=;
 b=JHVbyzFmz8y8B1odjR1lKwZkFzmrXI5fOKdBvOn7F6OIEgS24zlpZeUHVctTr/nF+M
 JU2fVtTc67jId45aqHcv+3J83jk9b7yxA28cPxEpJ3qHWnUZ/aSeM4ii335khmydexGq
 X9tpDQ1z+ZgsEC2m9QHPNMhgxSrvdTgecMcO/AaCfNVUIQCK8Dm2p6p+1L4S7KjkLHUt
 OwmYLllpjZzI/Y59p5Eewx27gmqZbf9PBZfuRFYhsmiN+eNUNlBYAA0DhC56AOPMphgt
 pU4abe6F36iT8A0QN18yCLt4VKRfF0IFcIlEXvf+k1b6G1OdEyueuSdDBcebNy1YReBb
 VBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uzqNYC8yCkHcda0vOTzyDPkKP1e9rdP24oC6OtiqKzY=;
 b=diqlLrwv+f4zed+sdjxqmCrFTJq6tyh2V3iLrnMG7Ogq+Qp5axUPsSzBAvPsQgJx9c
 vTvsPheg8OiPlh5N8Z7aYmePCKY6NsZM9NMxY/MFEGxeBWXj9wEIquDK8KhTkVqUZjTt
 72UNXjT4v8sGrbc5vUVi819+Xba6qI5eAf6uJ3Jeypu6qqK8e3/pV6uCdWeuQmVf/E1x
 Vrrv1RwkJes/tSVssugQuQpoY2FIi1Xq9seVWJnwzFuMyzdcMoFK3FTdytiPSS/YAfBG
 MpWQHs3xQ1h7hLbkeBnOgTN8g9Zg0hdPCcnH0g9miOxYyyqMVCal3J2d9vtNcKGutlha
 7gKQ==
X-Gm-Message-State: AOAM530MlFjZrNCOgyxVIXR8gpU/XwhMOdu8xNAAjc5C13XT+4uLi/iv
 ZDIdxI6LY/HnJqeEY+sbgzjLgA==
X-Google-Smtp-Source: ABdhPJy7B2MR8wMvT+7P/8kezXbajLaZeSDTcqi8Uw8VeN8T3hoZxQ8zgu1zuyFOuNWp/G1XGfsWGg==
X-Received: by 2002:a17:90a:c915:: with SMTP id
 v21mr4792889pjt.48.1594734753627; 
 Tue, 14 Jul 2020 06:52:33 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m17sm18156236pfo.182.2020.07.14.06.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:52:32 -0700 (PDT)
Subject: Re: [PATCH] target/sh4: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594600452-23383-1-git-send-email-wang.yi59@zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3718ca42-47aa-3383-d34a-490195dc003c@linaro.org>
Date: Tue, 14 Jul 2020 06:52:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594600452-23383-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
>  target/sh4/translate.c | 3 ---
>  1 file changed, 3 deletions(-)

Cc: qemu-trivial
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

