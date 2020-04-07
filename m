Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A003C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9FB206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obHCpLIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9FB206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLr3y-0003ny-8Z
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 12:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jLr2t-0002mA-AA
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jLr2r-00046W-UB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:25:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:41886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jLr2r-00045f-OH
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:25:49 -0400
Received: by mail-pl1-x62d.google.com with SMTP id d24so1424163pll.8
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KXuMds/5V3l8nfm8GjzCu+STRumuLvq6NX8DKPZamfw=;
 b=obHCpLIject4iulXjxZf+4YqmGhZ0nnjSxympxykZqAp/bwnX040Q/G6FPMcLRoK/G
 Y/+pTm2Vo9zyxGm24gDCXcR2N0UAn844+BtjHbVit02sMFXWs/KJHDxsS5RDMVEGu/+F
 8IfY3Zc6BMW8M03BFY9tW9A7KtIzBHHcVGHdHVUvzO3oSuF3Hxf5Jpl3xjB5oicGcsYZ
 HbA84XjrZYxDIs3mHUO2szE8qletUW5RcLenLNbF213FXq+49Jbcw6BsoL8rzSq59vU6
 I2DyKvfH0ssyoxz/fyoaoGDUd4QU4veFvYpvDwHAdkhDfM9ZdesCAWN1NKAKi4w0GMxF
 Z4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KXuMds/5V3l8nfm8GjzCu+STRumuLvq6NX8DKPZamfw=;
 b=HFusYjUoc8V9D91imfL8BKMnYKAeKh35wL2IKDKd0ljfsBQCjNUzCx+duPhphrqX+I
 U8JkQh5o7iyKD711Qi+wz146dN0BaNbLmc/47CgnnJCLsvIQmyngCIlHIqXhKeaGrSSZ
 Oi/z+zsTV/V3LlTMAMvLIp1k2bV2Q9UgjYUuLg/wHaoLDfgn+lZuC9LB/nFPwqX1OH5r
 tL9yr1JgTqf1FC9Lw2orTD5hi0MO7CrdaCEK7Xr//nc0rlVEI1IMHE2fIWWeYJFH4bgG
 Yx6NIbJsJa7BHjuclGv8e/eIzUt2SYqfbp3JQuZFZ64/+g2BrIhse/200qC4J0kJ0qqt
 gLhg==
X-Gm-Message-State: AGi0PuaBiwCIvL7o+P+mBk//JuUA8/mDup9Rc3pUxm5D4WPqb1Ow8279
 HAbIppHzeY6xKtSUoVir6PNwcA==
X-Google-Smtp-Source: APiQypLWAT8zV8HEPBIqw7oPcPj6Qgi5Q2jL4XODfNu/YkbQlIBD7ybYrTF/YLiHX6ZAthrbuP+C4Q==
X-Received: by 2002:a17:902:8509:: with SMTP id
 bj9mr3304913plb.64.1586276748459; 
 Tue, 07 Apr 2020 09:25:48 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m68sm2158816pjb.0.2020.04.07.09.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 09:25:47 -0700 (PDT)
Subject: Re: [PULL 12/13] configure: Add -Werror to PIE probe
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20200407155118.20139-1-alex.bennee@linaro.org>
 <20200407155118.20139-13-alex.bennee@linaro.org>
 <035d422a-8a44-4ef3-1f24-560dfc719fdf@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8a246bd6-6613-f098-130d-f245005dfe00@linaro.org>
Date: Tue, 7 Apr 2020 09:25:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <035d422a-8a44-4ef3-1f24-560dfc719fdf@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 9:08 AM, Mark Cave-Ayland wrote:
> Given that users such as Howard and https://bugs.launchpad.net/bugs/1870911 are
> starting to notice, would it be best to set this configure option as the default for
> Windows builds for now?

I guess so.

I'm mildly annoyed that Howard's compiler is silently accepting -fPIE and then
producing incorrect code, rather than rejecting -fPIE as the docker win32
cross-compiler is doing.


r~

