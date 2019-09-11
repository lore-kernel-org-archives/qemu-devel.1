Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7DCC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784882084D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkCpAJva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784882084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84Wn-0006Jk-4a
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i84K5-0003u8-NV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i84K4-0001td-Qw
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:14:21 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:34453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i84K4-0001tG-Lo
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:14:20 -0400
Received: by mail-qt1-x844.google.com with SMTP id j1so12944233qth.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uIl3gOebJchDx2nVQOu1VWsryjLi0SyxPET51T79RP4=;
 b=dkCpAJvaFG/JF9aGM2Ko8nocaviRHsLk/Oa8PDq5M7MDjjG+PgK5kPtFIquiRFBALW
 azwHesMgeLBuSQyoj3b1IzgaUyByqecTpguLVceAhOoUgdMWZm145NOcG9ye8J31GPUn
 AK5EFBBhz2zwLKFSRK9jpOqRbco4YQ/SFlWoHUfxJqhPGuvRu1z8MFuT2DQqgYnUwt6d
 /BQtSCJz6pRkwnWcNMdoFtJ5SWWc8E9Bg0OKgpOTogaGEKPmc7Chzm7WB1nxxqXUAZmv
 PtZbH6TNmQ0m90DbkBSFf1P56P41jPE6MeJkWyD417t7C9DMxgseQcPpXfR3QwH+EzKL
 dLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uIl3gOebJchDx2nVQOu1VWsryjLi0SyxPET51T79RP4=;
 b=QVR9sYFyrX7l9H5ctu47bwHJmINsvKU2MhE26ZqCpMKUs6LSkU5+iFidoWmDIgX6hl
 sbevgcukQii8k5QXi7LfH3ukMcw+mtlLMIl1dpDuXsNpfrr6pENxDTJctjVxYO8rWMQs
 OsIKsuEv47j46BUdMvRGwFDjdV2Y3ozgsoVLhAAyIyt5D0Zgtzgku+TVYdG2chlKIPI7
 PA1ci1jOPcGLWZkDL858GWGYuzNPj+D63RoGGnAuQJeg+Q6mfdF5fd6IxjfPpg8zKAVy
 m3PCWfuRHIyos7AHZJX7Xa9O3DSlXN6KMSMG0nLTRfe7kFJzhPnAHPYCLqn77yrEN8Rh
 JkDw==
X-Gm-Message-State: APjAAAWyj2LNn46TTEtenlYsX7fHUWx5IAJZGGLVmCKmh/F/xkAxPGJ4
 jr0Ciu/DyZJ1I5889ZvH9al6SA==
X-Google-Smtp-Source: APXvYqxaa367UUEj95uxT+/EuRP6qcvr555KfwWyU6Rybd9T0XhGIW76jsXqTYyBa5vhkGIV7iNgVw==
X-Received: by 2002:ac8:4655:: with SMTP id f21mr33719970qto.210.1568214859934; 
 Wed, 11 Sep 2019 08:14:19 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id x10sm9047341qtq.75.2019.09.11.08.14.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 08:14:19 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-13-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0415ffb8-ed1f-45b9-70ad-e482eb3037ae@linaro.org>
Date: Wed, 11 Sep 2019 11:14:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH v2 12/28] s390x/tcg: MVST: Check for
 specification exceptions
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> Bit position 32-55 of general register 0 must be zero.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


