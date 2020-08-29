Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F1EC433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 03:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5803220757
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 03:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upu9tEGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5803220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBrCG-0001WX-JF
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 23:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBrBf-00017F-MR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 23:05:51 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBrBc-0000ZT-Gh
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 23:05:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id v16so530233plo.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 20:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SDcZulBgMcPwQLSfSOtHqYtt1Ham5FNBYNeTsT45H5M=;
 b=upu9tEGEOxHKoRK0Iwdu9bYhTtCEEMV9J7gpBIo+bXxXf8JyAVqQWRd4wwXssfiJCY
 2k6Z/opDI6K2JStFXAt9uHFRNOI6vh2RBTfPUj0fF9F/hfV7N/ZnMFgKU83mMTFgoyZf
 5aQHYRADE8uPwr7qGNLvEsRvwU8YUO4apY/nWtvev0QcRMRiR9PPcTRxy0vWzXsiamHq
 KyHHVyJqsoGM8UL1s8XmaLaZ8vXVyp7bRTnB6MIa2zH8emHslEPLGjmsISORGM9Zk7fw
 RTZvpX+mMr41HC0fgCbvMyi/ANAc+fl30V2Ao8d14L8cyHMVUBhWSCJUY0JNeCsQQ7AE
 vT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SDcZulBgMcPwQLSfSOtHqYtt1Ham5FNBYNeTsT45H5M=;
 b=U0JG93K0bkXpNJ9P8xTDAgVhguusW9KYtxAv0Lac9DWAVrShMRw8zUMNobus4/ldj+
 AqGYR3TFCO648Xeuc7AR/mDtZeyJ6rNZkzhDeVcnUw8dZbHKA6dQr66SBd7A2niPiJU5
 9o1WoxvXC1QZLI0dwxLh7j1/gDw8aBOsxiiV69FREPvcfvI1xEqW1+Un7WnCkrBQQ1cc
 P9AXf3tFKDVPgym3qwrWU+kpf3YLWawOKHBW2sHjkYotCLf1S1yvJ21l1yoHlrytTsY2
 7r6hEU0qX53nc27WWcbO2AMw6uy1OxcPNbucIia06qdSDNkS4NVKg//g0ocrTl4D/gIH
 lOQQ==
X-Gm-Message-State: AOAM5318xrngb2BXXKg124jx+0fGBHfJZKwr+wtbJhBn+zPR1KicbtyR
 mH4HEog65Qz15DinwC9yZu3b3g==
X-Google-Smtp-Source: ABdhPJymlZWVf8JUFDK5e6acgjw++WAgJYh0T8BMDXV04hNLKkWYvVU3PuO4w1puu6eATLpYVeypcw==
X-Received: by 2002:a17:902:a982:: with SMTP id
 bh2mr1385398plb.182.1598670347073; 
 Fri, 28 Aug 2020 20:05:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c2sm777540pgb.52.2020.08.28.20.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 20:05:46 -0700 (PDT)
Subject: Re: [RFC PATCH v3 33/34] Hexagon (tests/tcg/hexagon) TCG tests
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-34-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b7ec9b4c-2a2e-2030-4075-45cf8920c41c@linaro.org>
Date: Fri, 28 Aug 2020 20:05:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-34-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: ale@rev.ng, philmd@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> Modify tests/tcg/configure.sh
> Add reference files to tests/tcg/hexagon
> Add Hexagon-specific tests
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---

Looks ok.

Could you please work with Alex Bennee to set up a tests/docker/dockerfile/
script containing the cross-compiler from the Qualcomm SDK?  That way these
tests can be run automatically.

Compare debian-xtensa-cross.docker, which is similar.


r~

