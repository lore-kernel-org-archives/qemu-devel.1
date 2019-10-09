Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51540C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C795206C2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DA1RnNdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C795206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iI17e-0001Er-Gx
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 21:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI15Y-00081V-40
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI15W-0007V1-PV
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:48:27 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:35367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI15W-0007Ub-7Z
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:48:26 -0400
Received: by mail-yw1-xc44.google.com with SMTP id r134so237397ywg.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LTIhbkY5pjQ7x09kuR0jISK9syvwmn4F5lxS9m1FLFU=;
 b=DA1RnNdFiZ618U2L4umcbRJLGAQZVTa6tpFtULinW7ei+hiyPw8vlByHsvdYDrHLDN
 e1XJ4ns+TLs6uV1ngYnIKoiga1EsyoLRzwulmqxMLMc9hPWvssIM7kn/w7VXVktHdMT3
 jvGSiPCu2t4g9t2BeYRLhaCrKPMJbZe9Sg8g1XngjBO5Y2L6gZKu7leGaU/QaaBlIM7W
 SKGfOp++gFntAd+Bt3b3ziUBKQqlRn5k6KkV657ooBuhpLCEd54BhD6CsS+cT+CcMS3D
 xK0aJzHKyp22w3uTNI1+KUvAOQ1JM+SDnaMvORCy6x6WPaLh1cXQXNMIQZredSrqW2WT
 loiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LTIhbkY5pjQ7x09kuR0jISK9syvwmn4F5lxS9m1FLFU=;
 b=G95nqsR/yG/NoHfTFWUvSGbMjCBOymJ8Ehgv/nNqiGKolTJK/FAqaEvdpHCPy5vNTa
 6ey646GJj8vYL2KySCpf5Pc89iYIx5IuuBO/3itMe3gKNDvCAxL6XZtn/r0nIVkcxGx2
 OaCOQk0p9mYqrUKIFC/x7EqRu8qCnpJofYs3KWyxnl0EDO77sb/EHlgYpLA/9yrHGrjV
 gFccW6FWJilocY7H2PytFJqpsKMw3PdlHerPqkjveAR2Xub3y+Is5rBoVg2qeEC0RVks
 //zCGE2P/Val4WraMPOEz8gDpG8GO4R6DPTI2gd/rz/K+qOdUovqNBR2zFNY0Kuh+Pyz
 Dmpw==
X-Gm-Message-State: APjAAAU5UVdtQil9K8J8iExosiS5qvdFBG2RfSpUzGktFrGMj6ZN1E/F
 52Wnuiqw6t3WrDutJUG5/wxWvZ2EDWc=
X-Google-Smtp-Source: APXvYqykTq4lmAJ3TkfIM1GDs4qJZ0roUM1k4JUTh8DdPnL6b5mb2FXs/3yv4bGOb0THIacf7DdOjw==
X-Received: by 2002:a81:a9c1:: with SMTP id g184mr1030237ywh.320.1570585705499; 
 Tue, 08 Oct 2019 18:48:25 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id x188sm225347ywb.94.2019.10.08.18.48.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:48:24 -0700 (PDT)
Subject: Re: [PATCH v2 05/21] hw/arm/musicpal.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <01a70b6b-9df5-5100-bbcf-c5c952706c4e@linaro.org>
Date: Tue, 8 Oct 2019 21:48:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:17 PM, Peter Maydell wrote:
> Switch the musicpal code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

