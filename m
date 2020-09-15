Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38391C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5292193E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9Ix9Gw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5292193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEfY-0001AO-Fz
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIEWy-00005r-AB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:14:12 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIEW3-0002fE-Pd
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:13:17 -0400
Received: by mail-pl1-x641.google.com with SMTP id j7so1680675plk.11
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qTa2izwtuKNaljIabO3wJpj9EENc8eY/4NTL2lwEBdI=;
 b=x9Ix9Gw1aBHEuKdT7Aoms2Ma8RMhtw3KRsBXT3V67MeQoeGpm4dN7m8ZSGlbntLuzX
 g77lkmPqEIPw0o5PVOXdHVHC+cdnFX2jfTcNkw3xP+s/DMJABCxc2sg1ovb7j6wE85if
 gK2eqWPTgQbXO8Wp8rjPSpE6j2hibjyOa78n3KsoWDwCKPMx+oCDRLAfcqFvCq7cWo+k
 nFkO4FaGDwCIrgDiulwwbnAXoSNt3HJZKYRXNEZ9yb/X5d6nCpDnf8ZAteh7/qwIQsm8
 HzdGi4bL4sMaQwRBlmipckj1iOL/dCUg6XhqZR3H4F+dcvYjLsIz1E3U/KoC87QIZgm6
 S/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qTa2izwtuKNaljIabO3wJpj9EENc8eY/4NTL2lwEBdI=;
 b=jwierUCBAi4r6xBbN8s3DQIhugr33mmV/f/wS1WRbuV+QYXMeveFRwy0R8JT9vKRFQ
 9mYD2qYbhxPGurzJWL0Hhl314D1aRDrLLfl/I5CNpfhF6aNxZlZ8ycXSNSN8TKkjjHI0
 XQtEBW4YoHb33t6ChJIS18UdPm/yErpHly8KeWmKKOINwprssr3om+LxGeeX+b6BUn3q
 PVXQYJp8AQR35hjgBrCX7xh/Rx4pnabJ1GUIyKDHvy6Si26ESWu/0UiGnpnPgzPfR7dq
 T1UKrYgCo0jgQcs5eWMj8dXbZrtwi9OQWyX6NdBgA5vGHa+vX+Yj+srkXBFPEoDOuVfp
 serg==
X-Gm-Message-State: AOAM532/h/2HJWbzlTrmxDopuwg94T5cGqWjlTLz67btpTLe59wJUD/Q
 uR2Hb932htgl2YjZeYYqxtE6eq9xbnUmYw==
X-Google-Smtp-Source: ABdhPJxGRdGWc4O7kgRrGKdvqtt1nnV4ULGMnJ8Na+YB2NB3kOMBpLCWPttyXlz0kr/MIZpX4k11OA==
X-Received: by 2002:a17:902:a701:b029:d0:89f3:28d5 with SMTP id
 w1-20020a170902a701b02900d089f328d5mr20384633plq.17.1600189994501; 
 Tue, 15 Sep 2020 10:13:14 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a23sm11899830pgv.86.2020.09.15.10.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:13:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] linux-user: test, don't assert addr != test in
 pgb_reserved_va
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200915134317.11110-1-alex.bennee@linaro.org>
 <20200915134317.11110-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aff9a7da-4359-eb54-0952-0137e2596b82@linaro.org>
Date: Tue, 15 Sep 2020 10:13:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915134317.11110-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 Bug 1895080 <1895080@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 6:43 AM, Alex Bennée wrote:
> On older kernels which don't implement MAP_FIXED_NOREPLACE the kernel
> may still fail to give us the address we asked for despite having
> already probed the map for a valid hole. Asserting isn't particularly
> useful to the user so let us move the check up and expand the
> error_report a little to give them a fighting chance of working around
> the problem.
> 
> Ameliorates: ee94743034
> Cc: Bug 1895080 <1895080@bugs.launchpad.net>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/elfload.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

