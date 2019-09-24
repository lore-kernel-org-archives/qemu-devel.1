Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FE1C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B81207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zIcAKBI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B81207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtt6-0000oX-Sq
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 19:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtk3-0000J0-L5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtk0-0006lF-FN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:57:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCtjy-0006jh-B6
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:57:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so2190500pff.6
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+YhPdvI6C1eG7EeDn9MjILwSOYsU6i0pDtAeBrl3JHw=;
 b=zIcAKBI6hLhAuR7xyCjlQ3j5pB8ziyyitaUXsQDTNO9vRjdEX0tIvY7glBHMWuTDrA
 n3rGLub/6ZNLZZLWRy7AZMIdvLxRt67ZCi8dA9IdSR0Mq4LEGcTr3Omg/Ml523CBdqTk
 wxm1DRB0m1Uk2nXDL/GTH0r25I8PJxK8cj9Jx0nF1mwzdE462DzMIJn15MmPAQ+V9DJw
 frEuyw/X+1/OF+xqx0Xz2wWfkzZKrgCte7Nf37jTXMExF5eVCDqn75cxixHcLt16hOJ1
 LI7B5EKrsFvGbZBP6dMSvNJP2s3d/9bgd3TQITpZ6KlS4+BIpe/5RBw9iYoE7U43WZAq
 qlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+YhPdvI6C1eG7EeDn9MjILwSOYsU6i0pDtAeBrl3JHw=;
 b=UytPAe2z1M88msJWlyoUpejYmVqDFF99cvL1qPs8sbzevcUmuJHOuNfTf9rpD8NsKB
 5WVleHpgdNXhkjX/vrw9Y5lWUb2RO0UNw6eNL9975FyPfm28LXft9JgVkoC6sJIBT8d+
 wl5sh7jIzsRwz0yGwgdfn3NlkhbyoL4vAPzcIOOF/x2OtlDeD9Yt8iPNbgbeMe08QY0X
 5jV245BvChx8/uOAhrL9fWnGY8ac71Ukq4oMhnqZT59lbZNlup3mFGDbF0O1UNr+phMu
 Z8R4q1fhzZ+xKdsuoy8Bx4tuJJJgXpKmD6K8mrKyilFklglAYCiArXtdi85emCZBiLqv
 S9hA==
X-Gm-Message-State: APjAAAWgPWEkKsRgxVxA5QqEdthORZHNZxB2sfHJN3zR18OVze8XLYxw
 8KjQHiVMgU9RmM9bK4V/nN8TOQ==
X-Google-Smtp-Source: APXvYqyZKwo87NmT1X32mE13n1+IDK/52T+cyBy86jd0asWop8JFqfxH+tJNL4acbdK3gt/fHk1IJA==
X-Received: by 2002:a17:90a:2a4a:: with SMTP id
 d10mr2438077pjg.72.1569361629860; 
 Tue, 24 Sep 2019 14:47:09 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 1sm3645800pff.39.2019.09.24.14.47.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 14:47:09 -0700 (PDT)
Subject: Re: [PATCH 7/7] target/ppc: remove unnecessary if() around calls to
 set_dfp{64, 128}() in DFP macros
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
 <20190924153556.27575-8-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <92a5c195-6643-b26a-bdab-d5b31c5516a1@linaro.org>
Date: Tue, 24 Sep 2019 14:47:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924153556.27575-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
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

On 9/24/19 8:35 AM, Mark Cave-Ayland wrote:
> Now that the parameters to both set_dfp64() and set_dfp128() are exactly the
> same, there is no need for an explicit if() statement to determine which
> function should be called based upon size. Instead we can simply use the
> preprocessor to generate the call to set_dfp##size() directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/dfp_helper.c | 60 +++++++----------------------------------
>  1 file changed, 10 insertions(+), 50 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

