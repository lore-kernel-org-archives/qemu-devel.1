Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EA7C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9B420753
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ti5VwFND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9B420753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMusd-0003TD-Po
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 10:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jMurT-0002Vu-2L
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jMurS-0002wy-0M
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:42:26 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jMurR-0002vn-MU
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:42:25 -0400
Received: by mail-pf1-x442.google.com with SMTP id q3so1106332pff.13
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ys9Mf/wf2fe5wmkNgsh2v7D7Fm7qwGWq/7xZxqkD/vU=;
 b=ti5VwFNDd5la5XyCuIe0GLeWTmjaZoPJbuxXU8M/L68yau38X+1z6mb1/eQh6Xh969
 e7GnK2861U68kyD7wYQ80JOg2871DfzNneY2Y2/w7oaCaZm/QQbDOZVspWMySX9lQIeE
 EWiACGdXVKVY+fDgjBt1oiJjzFXYTW125+I8wilwyB+OTzfKa71p+8rccSE7V3thUOub
 GXagnWY9fVPRQtQAicxJTDrmL/xaM1dlNnwY6E1coiz/KpC2RVmvdXrnBY+8P5yZ5kNt
 dmRp79uHtcKMCOSNn+3i0rrwu/4BGGSgp/PZ1oONQ5q7sQVtO26r+uLSaJhzk5xfB5z5
 F/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ys9Mf/wf2fe5wmkNgsh2v7D7Fm7qwGWq/7xZxqkD/vU=;
 b=OHu/lGu0H+Gr7s2KGzGwHbPlh8fXbvS/7Q6Im2p0LyGuQzn10oLXOAS1YMwLy8YaP+
 Mkaz/dbGvTcv1NDMQOmvC2DPKUkbdQY1j/TVq7CDc2viXTmumys+C4G4NV9af3Fc5Uxa
 SIsHWpziJlaGUa16iVpEWRUHjCu6mRvLuhlQ4PPO1ULE8ywX5ifOOeYGGwWjzdhNuTts
 cg1t0ADprL3AlDq4k2/pAQDcNLIlvsz2J1lK4gQw/WIkA0GgJBvcaU4JpzLm4ilwgzrw
 IwzcJS+Ru+pOGpmdp6zQoWcZuSljYgjBBEYP37MUy3+NFliMlTTeot+Yf/3fZtrj8Txe
 imcA==
X-Gm-Message-State: AGi0PuarPiV+aJwKcQRlZB+IK6tKAQiNg1cBQj3HTxYWVWRzZyAIQQh/
 kmXvPTnKZJ/xWNzHfdlXIGkQVw==
X-Google-Smtp-Source: APiQypJnTuFynsg4S1EznT3xotpUz75m8CB53Gm2Nvg79m1uVOcduTtK6hg8myYoO7X8wWFfj+fjaw==
X-Received: by 2002:a62:2e42:: with SMTP id u63mr5382556pfu.69.1586529744256; 
 Fri, 10 Apr 2020 07:42:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y5sm1971961pfg.141.2020.04.10.07.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 07:42:23 -0700 (PDT)
Subject: Re: [PATCH v1 07/11] configure: disable PIE for Windows builds
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f28bb3a9-a55b-1a61-1411-345e3c1ab91a@linaro.org>
Date: Fri, 10 Apr 2020 07:42:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Bug 1871798 <1871798@bugs.launchpad.net>,
 James Le Cuirot <chewi@aura-online.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 2:15 PM, Alex Bennée wrote:
> It seems on some compilers the test can pass but still give you
> broken binaries.
> 
> [AJB untested - please could windows users test]
> 
> Fixes: d2cd29e30736
> Fixes: https://bugs.launchpad.net/qemu/+bug/1871798
> Cc: Bug 1871798 <1871798@bugs.launchpad.net>
> Cc: James Le Cuirot <chewi@aura-online.co.uk>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


