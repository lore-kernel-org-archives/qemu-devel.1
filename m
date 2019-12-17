Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256F4C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E067921582
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzo92IS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E067921582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihEtc-0001f3-3q
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihEsn-0000pi-Iy
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihEsm-000433-CA
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:35:33 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihEsm-00042q-4K
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:35:32 -0500
Received: by mail-pl1-x642.google.com with SMTP id f20so4502060plj.5
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 07:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oN/poZbEgaYLI+a3ykjDg0cLCZbVYQH3dL2RlbI+LGY=;
 b=kzo92IS34fxtG1CRwmvqAHRK3N2wiGmFpCfP8HSDnJrM9MKXVJLySt5SdLobqTYZDY
 dDosgkqLhyJLTh6h6htxOOGy0B4flbim8UnAAuqpwltAM0dvVlhRGDEd+0x3esDRH8PC
 m9pt8WDbwaPsjHXMItLKg9JSYBVxc1n2AoPAtZfiiZWomHMgCgohbvc64Bhi4RnbUw8i
 Q53RvuQLrb0TIWAJ1H7SskLSu5P8IC9M1opXjZJgr463I7m4eH9KmkPhqYYbYYEGP2A2
 cEjksCA7tNWqndK+FGCg3410dV4MqFJivkV9Dc+lOQuxc5Zk304V2rqAJeloeefsrONb
 /Xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oN/poZbEgaYLI+a3ykjDg0cLCZbVYQH3dL2RlbI+LGY=;
 b=UIGPVjD720nSX44068gf/vjXhFiin5JJvdozlKIv6VeAzFbq09u9ZX11Ew1+QE8R4F
 VBBIShwq/EhZMRZFYLlYnAAV7ri4qUv5oSTj8hoT51hyYk9MIAtjDQPRYnTnlTNPgkHI
 JK3fX+tAjJnMgHR1ZSBVm/LP3mZnF1qXGKLfpjyKJFBJfid6/gDbcgSnGWRSeqyrHrZL
 HamPgkAMOrecwtfAMztXpXlwBHPZGacgdbuRfKN9rI2MjSfHA0WTXUg0Auh5mXFjkxy3
 KNxQTwa9Cu3pc+O2/7jwWkmp996G24Y7d9mURV7tuSAO4pUUuBIXcDky5Fha46LRwJO6
 mnVQ==
X-Gm-Message-State: APjAAAU9kdE/i9mKYcXfYqL/sT/l8eg5Fyy5w2AhPRkPIvMNyzNAvnOM
 FBEhMkkxGkoP9Dlb58D0njRuuQ==
X-Google-Smtp-Source: APXvYqyuy9dkIf5A/xMAFiCxnHKViRZR12Ty6AzmLVPARyEmmF9r3lkvuExQ0GyZMO2kq1cko2SKLQ==
X-Received: by 2002:a17:90a:2569:: with SMTP id
 j96mr6634310pje.79.1576596931033; 
 Tue, 17 Dec 2019 07:35:31 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id 83sm27883791pgh.12.2019.12.17.07.35.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 07:35:30 -0800 (PST)
Subject: Re: [PATCH v1 03/16] travis.yml: Run tcg tests with tci
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191216110732.24027-1-alex.bennee@linaro.org>
 <20191216110732.24027-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a37e644-c97e-a710-4947-aa18f04e70c9@linaro.org>
Date: Tue, 17 Dec 2019 05:35:26 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216110732.24027-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com, Stefan Weil <sw@weilnetz.de>, f4bug@amsat.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 1:07 AM, Alex Bennée wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> So far we only have compile coverage for tci. But since commit
> 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
> for INDEX_op_ld16u_i64") has been included now, we can also run the
> "tcg" and "qtest" tests with tci, so let's enable them in Travis now.
> Since we don't gain much additional test coverage by compiling all
> targets, and TCI is broken e.g. with the Sparc targets, we also limit
> the target list to a reasonable subset now (which should still get us
> test coverage by tests/boot-serial-test for example).
> 
> Tested-by: Stefan Weil <sw@weilnetz.de>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20191204083133.6198-1-thuth@redhat.com>
> [AJB: just --enable-debug-tcg]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

