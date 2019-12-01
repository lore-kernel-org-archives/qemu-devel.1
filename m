Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39808C432C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 23:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0ABC2072C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 23:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gt06hMqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0ABC2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibZ2i-0007Vt-5E
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 18:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibZ22-00073f-Bu
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibZ21-0004ll-D0
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:53:38 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:43140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibZ21-0004l4-5K
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:53:37 -0500
Received: by mail-pj1-x1043.google.com with SMTP id g4so3260579pjs.10
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 15:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NQP6J9EzIXNcpATqHBJlSGa2qmZ9jlpIrFMeENA6GaE=;
 b=Gt06hMqZdoIH+Sj+03qrRplJVEYS1Um7qZ+A8H0+mOky1uCNVDpGcvX1jhxOKh3Mgb
 jTNMF87KthgZZxnOz6+ob0QbrjngJmBPI1Dusw9p7io0bbMqDNcmDbKNLUnlq6Hsh8PK
 r0npnHDvBpdoeYHRfKD6hw4xRjUVJNpkphhn3K7ykc83qlHvpVfYIGAQaR0kH61A9Z1m
 GHKv4HRdqQ955oEA0bNpV962v/aeZkRXP/55e3W6dCUlvp8jMcMclp7L5hrLPnQD1fWT
 9xMKWKTkCRNIumIv6YfwXCheVLhA6Onnd9PSF2VeKRwG0bBFS9o4iKCgMAP3xolNBbrI
 kgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NQP6J9EzIXNcpATqHBJlSGa2qmZ9jlpIrFMeENA6GaE=;
 b=tsgCuHJchaQfg4qHimAzmg5KRgGZggW1K2KN+/vhDEvmcBSJau6n8TZNkHQ8ybhDbu
 TIAr/qBEjMCvG83DhlB/0MV/x3cZfaXzUwqyiLaJBnzWd27sdB9iNi0xiHvOU/We3fuZ
 OrHamtl2MNma3VRdRIWPdQjMYwzDF9p+R0++vRPAc5iZyNLKAjOJhUuii5iqIQDZhRxU
 zS6ZqBuFcgYLXsCPDhYFezROg1jydXmbvJEfHYvf3JqKAh+kfsO6Et7JU/3UC/k2Xdb+
 GpVbv9WI3sMyEFGKbLhzmK0Ing/PW18LEqMMziD8LJiH2VYIH1r8AihBLEDix4uYiRt3
 7vzQ==
X-Gm-Message-State: APjAAAVI59RH7tej1PDBQzgU3+CkDS0P+Ynl5jjrUNQGS+0ZGnzV1HlQ
 ybzQ5zbp5Cch+WAzEJWgYE2lMQ==
X-Google-Smtp-Source: APXvYqzXORthMIw9qesdJVhTA7MPfT6z2dJsalkrkz0d51PxIS2bk9wz6CZzoebxPdqdIUVThqqaMg==
X-Received: by 2002:a17:90a:33e8:: with SMTP id
 n95mr32149685pjb.17.1575244416047; 
 Sun, 01 Dec 2019 15:53:36 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u26sm16768710pfn.46.2019.12.01.15.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 15:53:35 -0800 (PST)
Subject: Re: [PATCH 2/2] exec: drop tb_invalidate_phys_addr
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20191127220602.10827-1-jcmvbkbc@gmail.com>
 <20191127220602.10827-3-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <da1eb879-4462-3b38-d949-ed3a36667aae@linaro.org>
Date: Sun, 1 Dec 2019 15:53:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191127220602.10827-3-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 10:06 PM, Max Filippov wrote:
> The only remaining user of tb_invalidate_phys_addr is target/xtensa
> instruction breakpoint code and it is better to use tb_flush there.
> 
> Drop tb_invalidate_phys_addr implementations and declarations.
> Use tb_flush in xtensa IBREAK helpers.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  exec.c                     | 29 ++---------------------------
>  include/exec/exec-all.h    |  3 ---
>  target/xtensa/dbg_helper.c | 19 +++----------------
>  3 files changed, 5 insertions(+), 46 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Though perhaps split in half, so the xtensa patch comes first.


r~

