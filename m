Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB325C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70F520842
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIJo6+IR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70F520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k312G-0001NW-TS
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k311G-0000LV-8o
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:46:34 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k311E-0003OM-MB
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:46:33 -0400
Received: by mail-pj1-x1042.google.com with SMTP id t6so2646366pjr.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=H4FC0b0cAb2rEbJg33NK/LWOQIt4pfkI25nkUMRuyqE=;
 b=SIJo6+IRdeEC8T7igVtkP0wcBUdksXkVHM+zet/VvZTnyYDJ4VRr4Ygtce8A3GF7eo
 un9dapf7DTWNCQ7D5zdB52UE4ljEKWyoGI1wvo2KW1++gugyPHK55jJ1hAu3k98YPMsa
 WYi9RaDcdwfGTGhVpmBC3X0nxnJ/vCw8a7J1ncqgi86YkhtPkB5vMn5Ee/F6Gjl01qv7
 vM5IKqykcVqNfSxpLT5tIzrR2NnDdkgma+ilcpkNIOGM0vOCKya0W64F3XXgtI59/yRV
 0Tw+dn5HSTEpheleLNiwSlA59GA66vxLhU4B5YzejU9ePe8CNmkFhcxituydWlKGdTcb
 pjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H4FC0b0cAb2rEbJg33NK/LWOQIt4pfkI25nkUMRuyqE=;
 b=UN2u1Q1oi71Oni53NDmAFpKEqXjpGk1KNjU1M1jwwtnGwBhL2jkh91znDWvASkKevt
 PqqEj5Ae7vkPqKBbtGkz/Fz1qF0367bJYbB5SwLozEIGzMlg+EwvvX0WgpHdMGwYladp
 ub4WLlAmzMrkbXYsgB/jN+4yrm6WzXjONqJHq5gbblm2S9/xKOqC+nkUxWqDbmmE334D
 TZ2ZEUUCa+ZMeEPTMvvTe5mWjRcNx6OkjuO609OLlOSy9PXc8KK+w3KSBJW1iHUd7PkH
 /1nw8giIDb94ObY4RRIAKtht+J5t4YiYOtTTYHmZuWJFN1MF2/E2CyWAQBNyjB0/EIHj
 o6kg==
X-Gm-Message-State: AOAM532NPSLauIqF3kfdQL/Ws5QE46s++WaCHAX8Yck3dRK40HHZ4ThA
 Sh6tHe8Ol3QYIENnfxbW2SwK0g==
X-Google-Smtp-Source: ABdhPJz2YakCHtQiEukjGX0uOHz+o9oO91Wn3IN50AJdt81MIpOzyTrdb5ePQJG2YFKTpVK4lImafw==
X-Received: by 2002:a17:90a:ca87:: with SMTP id
 y7mr5469422pjt.102.1596563191360; 
 Tue, 04 Aug 2020 10:46:31 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q73sm3526570pjc.11.2020.08.04.10.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 10:46:30 -0700 (PDT)
Subject: Re: [PATCH 07/11] Get rid of the libqemustub.a remainders
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-8-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3a5073bc-7996-c924-a48c-4aa30eee0dc4@linaro.org>
Date: Tue, 4 Aug 2020 10:46:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804170055.2851-8-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 10:00 AM, Thomas Huth wrote:
> libqemustub.a has been removed in commit ebedb37c8d ("Makefile: Remove
> libqemustub.a"). Some remainders have been missed. Remove them now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Makefile                                | 2 +-
>  scripts/coverity-scan/run-coverity-scan | 3 ---
>  tests/test-util-sockets.c               | 3 ++-
>  3 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

