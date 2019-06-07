Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2A9C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E6B208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WM+vVkIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E6B208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51701 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKRg-0006Yq-MK
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47219)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZJQ1-0001sz-O1
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZJQ0-0004Tu-AI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:16:49 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZJQ0-0004Pp-0u
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:16:48 -0400
Received: by mail-oi1-x241.google.com with SMTP id m202so2072637oig.6
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9rL/ygf8vtenwDsVU5n/2ijc6fDEp0HTSLN8mZWuc9w=;
 b=WM+vVkIELdS4giRWSwAjwwWrb5CZj+1yN+8nx9TDikTlymyVfKceIW77X73T51jdH6
 iqCBHqk7P2OH72nyJCMdbztT3vlKP4BQsFtlUA6i1kg76A/zlqgcqYUxsKaOjaPlW/YU
 1OqGRRS5YIrE6b4UNBgTTcR4RbK9NFOGKhdY+nX9D7e7lizOhhZwJXsA/9spQXZAO0R8
 ad3PZvKj/5FT01aJ2v3UHNzGTHSk0bg3iEpmyLSpTh03Y3H8eVeU6m6qpEH2NvUl3WFV
 3DqpdrXPKJPnWmpHxPIYKbYrWQzqv26El0s7yuNRBFTcNM5zm8bO5+ZPhLR8BFhZ/Rx4
 noRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9rL/ygf8vtenwDsVU5n/2ijc6fDEp0HTSLN8mZWuc9w=;
 b=L1t4EjxH0EdATr0OwVfOkJMBEfTyMRm0Plsu1kvNkbiuQDJECkxwvUgcHmf73qtqZX
 TJsG6yBPsJ3EPpiLuNQlYsJd2gyjQJWi+YezzpT28n49o7myHYN/DejCN7XJW+Wvmg4n
 iwu1T0Y4xQt+ta/9xkPB2wkhiv2qyrNIuBG/tFOTLuY9HAzcPO0kygGMqbbKMwfcg49g
 mZJR0eslV/BtalfVVr8o7/LeFCKbUuZQ56Oen/kBJrMXDQ/9fD249rCXynUCeWwks5kp
 y9/XkMLjxyM7L/7KtVVFvYgOJO/8XMC/PZYjIhUE5Luvo6jJTaw8vc4jsTHcq5HwzCBo
 eyGw==
X-Gm-Message-State: APjAAAWq3R4pHbY2e8gaUlXTivBgOOfSA4r5e1gKHQWE5xNMCptl+nA1
 IJSRlRyZyPKCAa9mObW9H48yEwomQg+fYA==
X-Google-Smtp-Source: APXvYqxjs2/ZNIxngA9xf5LjeEUVaumdU3C+vRLVHOElFYUC2QfKHmWMsONy48OBfI8b2Q1AC5/BeA==
X-Received: by 2002:aca:f157:: with SMTP id p84mr4466752oih.80.1559931404206; 
 Fri, 07 Jun 2019 11:16:44 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id q125sm1016515oih.33.2019.06.07.11.16.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 11:16:43 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190607152827.18003-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <62a457b7-dd31-cef5-ebfc-56f6dd93eafd@linaro.org>
Date: Fri, 7 Jun 2019 13:16:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607152827.18003-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-tech: move part to docs/devel,
 delete part
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

On 6/7/19 10:28 AM, Peter Maydell wrote:
> Peter Maydell (2):
>   Convert "translator internals" docs to RST, move to devel manual
>   qemu-tech.texi: Remove "QEMU compared to other emulators" section

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

