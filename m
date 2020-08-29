Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C9C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 03:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A74E20714
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 03:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RtcqPC4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A74E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBrPm-0003My-MI
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 23:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBrPC-0002xp-Qj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 23:19:50 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBrPB-0003th-6m
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 23:19:50 -0400
Received: by mail-pg1-x543.google.com with SMTP id g1so1325650pgm.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 20:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=j+jrtuXHe6Y8hn73TgbWzIrI1kGibr8d7jfkeKCiBOM=;
 b=RtcqPC4Il4stni9GJD3tZSpGUQOpRRcUp5Tda07BoimWkK6gGs2XH6XJcNKiEpFfvr
 U2hXK/BVgDfIyzV1dTc5eIQ+FKwjvPTZivdorvGpIgjsZ3AdcKtCR6iWH71JqJyzeeTN
 ND58g3Fmb1QiHxyr1lozzFjYWLNtZ1yaBIOMW9Zueu8PvlXU6ONiaVIioGul8muAKYz2
 oDv4ZIV3ZuK2ufUluun7SXt5jlb4pUHaSfvtdfbpIBBOkbKgkHWUI0ych6y7lVbNUyPu
 DTEKgjRgo5IKFwF1WS1uMamHAHJiFW4P96Q5wQF7VbeQ7p95i7j8OC0Q+izHPt6m63su
 ko/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j+jrtuXHe6Y8hn73TgbWzIrI1kGibr8d7jfkeKCiBOM=;
 b=WNKZQIvJ1Y64Gfa1yZ+U/3eXODS2nYnOJymqDKEbXfa8Jop1RtS4dWEW7FYdyV1Nn+
 oY8tt1EgnhRLT9gv1YRz9H/pHCisgCGkbFHiluiqMUASEZ5BUyPbemWQk+NJOwrcAeal
 VT0UR4E7EMEB4kqoblyODwHGn4Jj+ZIkeG5GJT6f44eeO3nsyNLSdkLqCeHEW5rRjJvd
 UjDU0vwpea7bYaPcPugcoNJgbxZ1tAzUJ3Vc6jJBVRxNwHkJ2OyJnbojmfKSlB5m1Vqp
 ABnUXWz+flgR+IHgf8dWjK8UoFLgjoWUYNqCdZTbdqOk2pTgj7tEAHN4MKTdZVlG+N/N
 43dQ==
X-Gm-Message-State: AOAM532gxakqi7OhzP/uaPbbqB46CpZs9Ug50SszYTzsLQqt8zXwZLEY
 cqNb9PdkUjE3E/w7xqeLymq7QQ==
X-Google-Smtp-Source: ABdhPJwMUMB9xA7c6c3p5eMe5hkrm69BatiJ4SsCOsydpHJnYrw3lWIpMl5OQGHGvoVMD27aDZFX6w==
X-Received: by 2002:a63:1d66:: with SMTP id d38mr1249525pgm.50.1598671187712; 
 Fri, 28 Aug 2020 20:19:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j2sm848512pga.12.2020.08.28.20.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 20:19:46 -0700 (PDT)
Subject: Re: [RFC PATCH v3 34/34] Hexagon build infrastructure
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-35-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bf3c6520-b64c-f977-d20f-a1718455b44b@linaro.org>
Date: Fri, 28 Aug 2020 20:19:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-35-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> Add file to default-configs
> Change configure
> Add target/hexagon/Makefile.objs
> Change scripts/qemu-binfmt-conf.sh
> 
> We can build a hexagon-linux-user target and run programs on the Hexagon
> scalar core.  With hexagon-linux-clang installed, "make check-tcg" will
> pass.
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---

This will have to be updated for the meson conversion.

I don't understand it all myself, and all of those generated files will need
special attention.


r~

