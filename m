Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E957BC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B403A20657
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMKBUAbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B403A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHNY-00054q-W3
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGHf-0006G3-1y
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZGHe-0008QI-5i
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:55:58 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZGHd-0008OU-Vz
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:55:58 -0400
Received: by mail-ot1-x342.google.com with SMTP id n2so2071865otl.12
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WILb82+ZMb6oXiXXQ/1X3V8uKxg2rHMLbJZJlZqK+TY=;
 b=HMKBUAbp5BE0R1mEYQK0wBOWsUW6zD+gTencUxJm0C+w2Jy4ecsOXflGonuCn9g1qF
 ERePWQ4d0QPNcFmZ0jZs0p+V0PxmXTI2HOLZgtOuApJdj2sCDv/OCD6UeRq9+3JtVDIm
 AfsUPwaoKQO7oLTesfyrE9o/Ot4LTAVsk9j2Tp7wmlGLcgbcxrdU36wcC+qd3yOgAxl3
 xAaAvmS1aoQJlDpKddtxxOnx1c94n/nYUSqb7qnkXIVYB3/W7Ii9zSrZECpAk3r0UaZt
 60BpdKUxpyXeC62LS8l4qSVqjjBtXVhGKgcqMm9w17NHaALK/HsBSllaArV6yDf6dMSx
 tWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WILb82+ZMb6oXiXXQ/1X3V8uKxg2rHMLbJZJlZqK+TY=;
 b=G9uGbv9P+PX4tz9jlWOZhQWsYmPXukDcWZvdzySl3eO88prC2ZGvAypjLjGZdt+gEp
 mU93dK4KzoD3E4PpnvV/jZARB9ojk6QS0sSU99LJ/uQGx5fwdLsv3ECXcJUppnamE0vb
 zfbWfSYpsBosW5UcjK6iuOUEqRdEQJagLmuQfA9EEc+Ud9LwhY/hX+jVCxbM049p2r8u
 g6YrWc6WW7I65Jz5u7ubyR4y2ZhMKQQTWfrdqK+LAXTO0gnkzm5KTB4Di8lKKNqQ3LWk
 IPiEeaq2qjEFyy6U08LJ4e9tZu0xpjmTx/EafhnXAJAoDSocV/XireK0zq3lTkhmxLY+
 YI3Q==
X-Gm-Message-State: APjAAAVF+m52EK06K+9VDMmdHdM0DaAVPsK+P2nqswj9d4knHT66akvi
 6O7L4YL3KDb6mOBU5wx1aboMIqNx0Y4jCw==
X-Google-Smtp-Source: APXvYqy1/rg8/pHdyNxN3rC7Gon8E4aQLULUELdsnMGH9Xb/QE3vYdnFa/H0l5q/wbVBZ4914/7R1A==
X-Received: by 2002:a9d:6b98:: with SMTP id b24mr19207734otq.189.1559919356833; 
 Fri, 07 Jun 2019 07:55:56 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id l31sm851663otc.30.2019.06.07.07.55.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:55:56 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9f3cba01-31fc-3acc-39df-36a38c323931@linaro.org>
Date: Fri, 7 Jun 2019 09:55:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 07/42] target/arm: Convert VMINNM,
 VMAXNM to decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Convert the VMINNM and VMAXNM instructions to decodetree.
> As with VSEL, we leave the trans_VMINMAXNM() function
> in translate.c for the moment.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c       | 41 ++++++++++++++++++++++++------------
>  target/arm/vfp-uncond.decode |  5 +++++
>  2 files changed, 33 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


