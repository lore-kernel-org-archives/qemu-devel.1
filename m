Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4082DC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 08:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BED42072B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 08:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBj2fhNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BED42072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVX0S-0005R0-VG
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 03:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iVWzV-0004uP-7d
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iVWzT-0007UQ-LY
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:30:04 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iVWzT-0007TA-Dx
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:30:03 -0500
Received: by mail-wm1-x329.google.com with SMTP id q70so8749053wme.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 00:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tcosUfNUBVjsaD6V10vasBr4arbhp7KrufrEmE2Xmeg=;
 b=MBj2fhNX3XvKS9wJPLciZLvsXWC9u5ZdWcETgonuExgw4sSNCiGlvTXO2e1WMq2Jy0
 E94h2gOPw1IWqe37LiUocwsFWqgTFb2Fh3YHmRbKRRNh1644+wcQtTqNB8vh0uYXARS7
 mjQ2g2+NELq+by8wQt+e3GV6i4cdsECAo8V8Cloi9xarLvRwpRaK/h7STeFhWxlra5Vy
 j34lajF0avmySd08HFPIYuPUjJ/Bld8FreQwsn8HPRxOvjItRjro0TwVmxzLNugG3JNM
 xfa8VYdKForFr87yU607NCDh9Zb4Nrt0BRPc1xPJ8OSEcjJD64XNOiIy8/sph5cbVvFo
 1ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tcosUfNUBVjsaD6V10vasBr4arbhp7KrufrEmE2Xmeg=;
 b=K0LDxEBS/YDNCJsB66JBbTtcRjOlmMIj2W1RNhuGFetfQ9nPbT2Q7hMS+cwKcy8VY0
 Qr6xdhZ8RbKNcGKxCf1HeyObs1JCzEQUsZn/b00t9zNde9rXDJBIUDunf1ksm5aQuqiv
 mjkaCCvEsIwb0SiwGTO8zhaUn57c7i2pfqKiNpsFzB8JylRoQXD4ugOsgRMIIHR4WJfD
 V27c4IcyFIBqDptBPQtW27nc7yO08eemJQ5NQliQ07kh1M8ytDT2JLAF7kH7Qa0rwS11
 I84Vsp2h3NhCtG9MZaOhjP+leW2LemxR2gt6P2R7WKiwuU4l6CC2le2z3QqYNRKy9m6i
 /pKA==
X-Gm-Message-State: APjAAAVZuZyRME2h5OkMMan71gWfQerTuq/HdeklOpbxTQWNKS6UDner
 5TNU3tSVgzQb6Ob8nxoTmR7a50nC0B+Y7Q==
X-Google-Smtp-Source: APXvYqw6rmBhOlF29KwK40BALoRK8dz9EcRVw2pitZSNyRWSJ8A1PHZ1SBdiG/BkBbrrWxZS9dK7CA==
X-Received: by 2002:a05:600c:2919:: with SMTP id
 i25mr13014927wmd.158.1573806601825; 
 Fri, 15 Nov 2019 00:30:01 -0800 (PST)
Received: from [192.168.8.102] (56.red-213-99-189.dynamicip.rima-tde.net.
 [213.99.189.56])
 by smtp.gmail.com with ESMTPSA id j63sm9223257wmj.46.2019.11.15.00.30.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Nov 2019 00:30:01 -0800 (PST)
Subject: Re: [PULL 04/11] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191101085140.5205-1-peter.maydell@linaro.org>
 <20191101085140.5205-5-peter.maydell@linaro.org>
 <CAFEAcA-xYWLzsfDAWWmEk4DhXcO5zqKVZMrRp9=4t9MBAasaMA@mail.gmail.com>
 <ac0c7520-2f6b-fb49-c725-37b46272c835@linaro.org>
 <CAFEAcA9KwEzNoyugPNjqBmOb-F7EWWJ=0kf6ysD3mDk_R9v=DA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0955b4bf-87fc-b77a-d5b9-f07293059487@linaro.org>
Date: Fri, 15 Nov 2019 09:29:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9KwEzNoyugPNjqBmOb-F7EWWJ=0kf6ysD3mDk_R9v=DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/13/19 10:30 PM, Peter Maydell wrote:
> Coverity may also be looking at the case where
> TARGET_AARCH64 is not defined. The fallback definition
> of arm_cpu_vq_map_next_smaller() for that situation
> always returns 0.

Yeah, that makes more sense.
I think we can make the fallback g_assert_not_reached().

Testing a patch for all this.


r~

