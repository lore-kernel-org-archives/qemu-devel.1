Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17928C4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DF221929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlK4c6aV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DF221929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4q3-0007H4-UL
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iB4ey-00033M-VC
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iB4ex-0004RU-TY
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:12:20 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iB4ew-0004QH-4H
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:12:18 -0400
Received: by mail-pf1-x441.google.com with SMTP id q12so3167258pff.9
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cE4trpSnP98fjNTUopWYGw+YfZEOE4CvcAUadDHzEes=;
 b=MlK4c6aVjeglSr/xpmgQ6JIuzgz+Z4V+H56whSYZEaHvipFm0mguHr9Dfb1bNNmfK9
 yIsohYOPRW5uZnQv+ETNBStxVT5xowsKXBmsqvG4v7D20Fp8lMl6iZNWKSgubvI/LZy0
 iFKvpkPRiu57FbVyCi0NMPGkV21LhKP/eZmF3BLdaxKAzxffy8pAd8E7JoJM5byWYlSm
 i10ZETXDh9jj5Yx9H88WNqkjlvm0guJQMbvnmERYk0gIyKr6jRbW2DmbtsSMKJxzrsnn
 yXomh4couWMq7bUysYpaF2mwJMwBLH4JwOcvjkk5iU/DSugtfp4NRK8yzJD7rsSYrgzS
 lgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cE4trpSnP98fjNTUopWYGw+YfZEOE4CvcAUadDHzEes=;
 b=beJCO9N2LVb5zuZ6HP7FQ2CVWEMF5KGXU4t8hRSsBzvUf/o0q4rsRC5J+CRGyVaimH
 Rw9oMSdkI8qc16oUwGBWlQ9g26gyhRYoYyn+X8/KLrot15hQgzbB1Cq4CVE9SQTg65mc
 b0WU/Ync3P4cwVrrv5RjuOHtRw+v1cCh/2UaqN46F6BTLQlk67NzmJOE61VDC+21ZRVC
 tOOjt1urlTAyCCH2IWQk+MPoU1ybZhpM7T+javAYUvZ3vIIK1CYsuYVXR3qlsbT3MAsd
 Xhv0bQ3QMch1c6kJ0kDVNA9a/NecA48Gg/Qt2Fp4OOteQMImtPSRZ9qQhdwcopB5WVK0
 m3Jg==
X-Gm-Message-State: APjAAAVk60u4Vu6Hj7VPWkj26NTcqdYx0agVkkywIrdeyabInpG21rXT
 RF/vq3rwygzbA9tz+SveWlv/Pw==
X-Google-Smtp-Source: APXvYqwraMz9vRG0HWEBwssdpewypSRiyKx4fv8k3E1dOW/GDbOvHQIYn80AaxZB32Q9NnU495skvQ==
X-Received: by 2002:a17:90a:778c:: with SMTP id
 v12mr137167pjk.109.1568931136022; 
 Thu, 19 Sep 2019 15:12:16 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 129sm12502083pfd.173.2019.09.19.15.12.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Sep 2019 15:12:15 -0700 (PDT)
Subject: Re: [PATCH v2 14/16] configure: preserve PKG_CONFIG for subdir builds
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190919171015.12681-1-alex.bennee@linaro.org>
 <20190919171015.12681-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <241355ac-cea3-2eb5-392a-13ea1aaf62ac@linaro.org>
Date: Thu, 19 Sep 2019 15:12:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919171015.12681-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 10:10 AM, Alex Bennée wrote:
> The slirp sub-module complains about not being able to find the glib
> library on cross-compiles because it is using the default pkg-config
> tool (which isn't installed in our cross-build docker images).
> Preserve PKG_CONFIG in our host config and pass it down to slirp.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

