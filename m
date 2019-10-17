Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8392CFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8A721835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d86Z++PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8A721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8H7-0006PY-Tx
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL7NH-0001iz-MO
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL7NG-0000C3-Ke
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:07:35 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33199)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL7NF-0000BS-DJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:07:34 -0400
Received: by mail-pl1-x644.google.com with SMTP id d22so1278731pls.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S3XXBliVz/ZF54I+8BCWerMQOjV6c1H1RGHFZN2kY/I=;
 b=d86Z++PR1nznwDzEIi7NwRNN22jXx61g2llqXvR0xb13fdtaGcTtAAI+Cit+3t1V3d
 oCXz0Km7qfNq/trS9ASCmoTRLwNpI3Hnw5aSEgjfaGmBxaQBU9phhnb0/pou9nyEOnx/
 q0PmTob48l7ej7aj+i12iSLLp+PGc/9UuQ+NDYWq3rFaJ7HxvF3ns/l7pTzdH+eruW8/
 SAh7HUnPKnA1oOfq+aO5jE40aqgN2i2a/eVE7ByiU2s5KZPPXgVUZIoq6/wPg64KKlS3
 ongXQxd941Yn+/jvVb+y8Cu2POfugMIVXP0b8sZXZ7zbRtCTV9y06Ko5wLg3rlZhVUtk
 b8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S3XXBliVz/ZF54I+8BCWerMQOjV6c1H1RGHFZN2kY/I=;
 b=SC963XkMIIXEbjbxcSDMSIs106qt4Jvsrf56QiLxVIiLW2+aZYpdWVLkepl6STmf+n
 orNT1dPJCW8y3owGvKLwUa2IP9+i5Z6AMN0ZN70PPajMdy7CVMx2ckAEYSaVdF86Ke5a
 aFkqW4t3m4HmdVpjC5vMMmeBs9eLfkI20rYhRw/2ULHMYwZUwamGFD+wQXeyQClLjjNi
 AVcm05m8JqoHzcPFOz0HmbMpT8zAp1HyVZLP9hzqGolcbMzJNEThyKHi5tnFvZWrHVQH
 Dw5vX9MWlMUHFdh0Zr96oKNVFpAXIzYKMSPBKLaqZHgdZN+Hmvpijj+SOYy9em9VCt7o
 YGBA==
X-Gm-Message-State: APjAAAVWF8Xz7rjGSseR7UuTlNIKeD07+x5Au4qwJplv7jYwfPYCtoMj
 JwCju50iTgvjTNJE+IiusC2vOA==
X-Google-Smtp-Source: APXvYqwC9qULRFLKK/7IMhUTqxIRAOASZjWYxvtFkrs0mZvKilX7f6LcQ7yn+t7zqlMyNvw/rjMrCw==
X-Received: by 2002:a17:902:b70b:: with SMTP id
 d11mr4352667pls.339.1571324852080; 
 Thu, 17 Oct 2019 08:07:32 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p189sm2969812pfp.163.2019.10.17.08.07.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:07:31 -0700 (PDT)
Subject: Re: [PATCH 7/8] hw/m68k/mcf5206.c: Switch to transaction-based ptimer
 API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f56543f6-9be9-358f-4080-a32f04d744ec@linaro.org>
Date: Thu, 17 Oct 2019 08:07:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 6:29 AM, Peter Maydell wrote:
> Switch the mcf5206 code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/m68k/mcf5206.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

