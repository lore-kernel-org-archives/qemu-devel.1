Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B7C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 03:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F0320815
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 03:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAtFj9DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F0320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJqxy-00089h-G8
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 23:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJqxA-0007ek-LC
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 23:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJqx6-0004vR-Gg
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 23:23:24 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:36042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJqx6-0004uy-8i
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 23:23:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id y22so9557400pfr.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VCTIlSt6DyaJyZSOCNqyZtt1V4lgNOBBMY8Dlhz4lMg=;
 b=FAtFj9DGvzPfzTTvDDGScnfkjxD0KEuTvVGqqza995IOobWitXBoY3iKxst3YSO3WJ
 k3i2tqlEGOtyOkX9StYKhHmGCLwYe+af8hFTNxw6Kgd/CFRx77ArLI+vQxNQ9uDCQZ2a
 Cdi1sn3HciAMjsvydMrtWQn8KkiND0KeJ49B3cBhwuYbxSB1etqxvapxXpNldOO/BWL/
 yi3j8fuCv+hJi62pF9cyrCuyQrFJk1vVU3t8Y6FVcA7kG5SnpDPbMr8XLz2QjmIwP6jx
 7VlCLN8XA0tNa4ve2SAVhG9v+8Jwqi/Hi7bmp0JBDZSZSxbZBfPvd1l46yb+VnK/fC/z
 5/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VCTIlSt6DyaJyZSOCNqyZtt1V4lgNOBBMY8Dlhz4lMg=;
 b=nPC8R7Gz6w93FleRCm3PLLGQjANBMStRhWrI/7U4NAx/ZP0EgEPVgASeYR2x52hceY
 fVKWDDeh1YCB18zS+Ba+eO1hMzx5KPsuRxcn7AmKvOsBfDrjhAULZ5ot5K6MB43Kc7F6
 5z1eSZjRLblmozHPJPXwaOB0umpDzutnAUbZvbPJPc17ZLuhi5WvGgInNAbEFOnzFYMD
 PJEhmB/qb3QCnfTJnhCPnkL4ag+jg2FXi4e6cWyYY98FrPrNeld0JclOgNByY4Fz3sEi
 HtR2J277eE/OsNbMWw2AGCxwDmsEOMYVypKSbhssKhmMhRrgUejNdU8Awn6iRU9YYtPJ
 wT2w==
X-Gm-Message-State: APjAAAWJrfPwWct4lUjbjE0WRPhCPEA8pTLG9H2qrDNbEuyl5ngWOMo4
 03u0wDu7qkFCoVKuAJMfCLSsrg==
X-Google-Smtp-Source: APXvYqye6u/jep5HzZEzDXM9wyiNJdL3KbEpuMzqB9sjv7tGW5xW1FKtSMf/+9T92Xm1A2tO2OO7tw==
X-Received: by 2002:aa7:86cb:: with SMTP id h11mr31173180pfo.59.1571023398919; 
 Sun, 13 Oct 2019 20:23:18 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h66sm19751916pjb.0.2019.10.13.20.23.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 Oct 2019 20:23:18 -0700 (PDT)
Subject: Re: [PULL 00/23] tcg patch queue
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
 <CAL1e-=ioCkAxyjdDvBTeQPMWpUy0W=ej-WiUmZkyTVJYUsd-_A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <35cb0bfc-fc91-8555-9725-0c3fc420d93c@linaro.org>
Date: Sun, 13 Oct 2019 20:23:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ioCkAxyjdDvBTeQPMWpUy0W=ej-WiUmZkyTVJYUsd-_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42a
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/19 4:53 PM, Aleksandar Markovic wrote:
> Just for the sake of being punctual, may I ask you to add "Tested-by:" for Mark
> Cave-Ayland, and "Reviewed-by:" for myself to all 22 ppc host patches, as it
> was indicated in the responses to the last version of the ppc host series?

I did add your r-b to those patches that didn't already have your s-o-b.

I added Mark's T-b to patch 15, which is the one that enables basic altivec.
Mark said that he was testing ppc32 and I know that he's got a G4.  He would
not have tested the later patches with that hardware.


r~

