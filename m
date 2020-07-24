Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E76BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AC2206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvYECsFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AC2206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz2OK-0000j2-7l
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 14:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz2N2-0008Jr-Ar
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:24:36 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:34669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz2My-0000xd-BY
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:24:36 -0400
Received: by mail-pj1-x1042.google.com with SMTP id cv18so6198278pjb.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FbIHwPpdUXCIFC38gQc7fTqu3mBUsWLE/mGWed0xkMQ=;
 b=hvYECsFw53GCJEu+v9GPzbwCQ1fY4Ouo5rJkDwpF/qLSA+dpfGV2jGeh8X6sZUycTI
 ptJWOtzfMSsvhs2SRIochHWFueMOCjfnHnXPFbCwMfBblv1opqGsmgHdiTMyvF+3kqGs
 nUR80s4igp7VcxwHb4RCpeSXfierRQ7Q8p8DzdUuiaX90/0WIVMQhk3MqNeyf9xdie+l
 XeB/qM+De02Jwj/xbp/UdjIaOM7s2G/8YNNIhwQGlk81kz9TAjQ8cPc0f+5sDgFgBIPv
 bxQax02DvokU/UWeUMerhiaUHsU2t/7vGauJ2mdiwgZdyz/CrJCwG34R//oDjGia48ue
 5gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FbIHwPpdUXCIFC38gQc7fTqu3mBUsWLE/mGWed0xkMQ=;
 b=b/ej49s1iE/BRhCoBjQOCGZleDFqCsm/dvFRVpxXY92EDbVCrVXasypiNS4pT1uC3U
 k5cJOHaGrhAQVeByrGcBDpPjZwKA67MoEL3CMEgMS9lmkMQLJszkfWzf3yUej6wbcGxm
 BSgYhIoB0RX0HjaB34yA4yVT2eF8Jr42QIfgSk9n4Txh/xJwZsuf0eWZTkqJU30MuxNA
 EyzLu+vL2LgDXHXzUeVartgGNRMVDNJBhtJvg8KbO07k0VHbN8StnMq5Y2K+2unVIoe4
 WLs/xN0AlJPK7ljRsalqaDFwavJ18oAhcF6PRB6j+rQAioOzTipPzdVf3HGLoQ6tjQnI
 pBZA==
X-Gm-Message-State: AOAM531vJ7BEG0gSkqdN9YEtlAzmHKtD9N2g1FDkDbPOA1ErumEU0BjB
 jSE2B8yN5lPo62O7aADWObprBg==
X-Google-Smtp-Source: ABdhPJz4PXZhRL29I/V41vpTOIRZzHvUgtO7wDToA2OFKWhUSkryIOR5gA9FeCrc1k1s9YL+KDShKQ==
X-Received: by 2002:a17:902:6b08:: with SMTP id
 o8mr9361434plk.104.1595615067380; 
 Fri, 24 Jul 2020 11:24:27 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 u8sm6465725pjn.24.2020.07.24.11.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 11:24:26 -0700 (PDT)
Subject: Re: [PATCH v3 12/16] linux-user: fix clock_nanosleep()
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200724064509.331-1-alex.bennee@linaro.org>
 <20200724064509.331-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ae84f427-2259-16ae-9f08-458b8cdc523d@linaro.org>
Date: Fri, 24 Jul 2020 11:24:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724064509.331-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: fam@euphon.net, berrange@redhat.com, f4bug@amsat.org,
 Laurent Vivier <laurent@vivier.eu>, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 11:45 PM, Alex Bennée wrote:
> From: Laurent Vivier <laurent@vivier.eu>
> 
> If the call is interrupted by a signal handler, it fails with error EINTR
> and if "remain" is not NULL and "flags" is not TIMER_ABSTIME, it returns
> the remaining unslept time in "remain".
> 
> Update linux-user to not overwrite the "remain" structure if there is no
> error.
> 
> Found with "make check-tcg", linux-test fails on nanosleep test:
> 
>   TEST    linux-test on x86_64
> .../tests/tcg/multiarch/linux-test.c:242: nanosleep
> 
> Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200722174612.2917566-2-laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


