Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3CAC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C6C22CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uN2Podeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C6C22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31H9-0004lW-Uj
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 12:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i30yo-0002ba-BX
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i30yn-0008JW-9x
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:39:30 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i30yn-0008IZ-0P
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:39:29 -0400
Received: by mail-pl1-x644.google.com with SMTP id y1so216366plp.9
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LUxprBBpjSfP1xthe+RhtRb0rOXCjhNnZp26xv1bGd8=;
 b=uN2PodegvmJGj4MK+vH56c78Gc7gyJqfDqFB2y4u452Tu+0NXfJVu0FyNc0yrMYxbd
 pRfGkQXKiIJjGIWH0IIvuRssm8cekYGCvp8Pe5gZPuxlFvJU3bGscl/tJ1IxpZPrblsI
 4qtqa1/Nj8kW6dx9pxqepmo7JvnYBJCrUCJRmGowaSpJmgTb9qgxSUvBH9A4zV/A3GIM
 6zn7CNw4l+4b4FTbzkPPUtzw36S42Z5F5wpgCfoGLdjzll/M9KT9JhB7qbJMCQU2y9Eu
 wemjDZDsXkQYnWrATdRxMYd+6/CdRIh15iKr6X9+1aYnsoouBVDfzqceBPZtqEU8PTOR
 kINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LUxprBBpjSfP1xthe+RhtRb0rOXCjhNnZp26xv1bGd8=;
 b=uUWBLquq6fyKoUNR9p4ShvhqHMWLOIaycn7Ti1/fqqFvK6CSGRoIJQGHvgvSS/rTtt
 E4tvy6cvbXMcjBQDY9lF2LAwg0CYKg3i9omUEmxAdGAPGvqEGnGXrk+chlLvFN4ezfSs
 AZHxCIQB9U4vcC6D8Y7e9jrh1DUX7jhY8N2GFqak1aec47aqeegG+ogvA8xz7dtaYD7O
 eIQMXiFLvSzm2ynWSR/ZLmW+ZyAdr+XJSJ9pk9J4Mauy8FPpHkgPVEcoOUlmJn7LIMM0
 OTKLPrzizudoduFBTF1ESzUnYF7yp2xnSYLJ+zzfBHRf7mhuMnwjjC33kG63NZcz9MHv
 mvXg==
X-Gm-Message-State: APjAAAXzHp/bbvc/LOb5Owd2389FI4p+wYy8NT6eAUThMHSXvktWd6GI
 3v89p10F9dpxkqeND2pUD8C+lQ==
X-Google-Smtp-Source: APXvYqwL9qVcLXwyeG2srmzf0Kfhw/Tux0mgs+ZEl8vi+wFaaprA/aBFzNMA6srIZBK5xyvtOXEkUw==
X-Received: by 2002:a17:902:b718:: with SMTP id
 d24mr5142759pls.204.1567010367263; 
 Wed, 28 Aug 2019 09:39:27 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x10sm2628081pjo.4.2019.08.28.09.39.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Aug 2019 09:39:26 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 liuzhiwei <zhiwei_liu@c-sky.com>
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <87k1ax64io.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <876d43a4-7e57-b1c0-11b4-db20798d2098@linaro.org>
Date: Wed, 28 Aug 2019 09:39:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87k1ax64io.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: peter.maydell@linaro.org, palmer@sifive.com, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, laurent@vivier.eu, Alistair.Francis@wdc.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/28/19 2:08 AM, Alex Bennée wrote:
> If you want to do vectors I suggest you look at the TCGvec types for
> passing pointers to vector registers to helpers. In this case you will
> want to ensure your vector registers are properly aligned.

The risc-v vector extension is very different from any other existing vector
extension.  In particular, the locations of the vector elements vary
dynamically.  Except for certain special cases I doubt that risc-v can make
direct use of the generic TCG vector support.


r~

