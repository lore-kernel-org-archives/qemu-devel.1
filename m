Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9007AECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08585218DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWBWAWrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08585218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEVy-0007Yv-H7
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1tI-0001hy-Oe
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1Nn-0004JM-Qn
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:07:20 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:33995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI1Nn-0004Iv-LD
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:07:19 -0400
Received: by mail-yb1-xb42.google.com with SMTP id m1so228568ybm.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lJcDxLjZN8EWAGjaDhdXnvgJ0Jgx9VJRnTuXoS6NHYE=;
 b=AWBWAWrhRFL7qaUwhCjcI8vr4wJRMRz2fCCOQuFa4v7Mz2Xs2vjJCm7kg3ZqAt0/4C
 vC5P5gNJGmwjOND0Ct5ALps9Th3hozAIxgL2zGPjDiQBoEPc3hhXMHMk5dekqYitdcLd
 /RbnfdwXWXOpJUGM2UMm9OiHoa/C2ybjT4X3nRbhbSDjlBmP59WSiCHTtRrb3ZjfjUPP
 JSe7IqV4HdkzbpQ7s1JDVJahdcLK5hsCdxVGXeHXIPU4nEDfKNUjnl+b1roczONrVGKT
 K0ajixFUz381fi1tRVz/weg1t2VhKAsaaaOBurII7DG7ZNFRaf/Bfh5FDK1NwZUlOeIc
 n4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lJcDxLjZN8EWAGjaDhdXnvgJ0Jgx9VJRnTuXoS6NHYE=;
 b=nLYqZaKAzTzo4NbYbYbuOGRDxOKarwqwGJn61SpzeGsvQFhxLA4y3/u/8UFa6e4Nmg
 KmOJHE4rOG9532Baen8CEYHQ7Xb/g9IcOqx1/zn1fiWjpl/HPEGaFf+7Ym9IDVwW6lkY
 R+icsckKiZjruq72Scf/ylisl/4KHMF7Tzw1xpE7Rmwxk8RED4M4OkS7RdcoXdSvJDDs
 1J17fRsSNCWWGOj0iErzgEcRLwbxLaCxYdvkcEOV3m4mzC2KGAxA9OJ5mDvKyX8huOIP
 f2JKELPx/xb6a2ZdwnspESgtjaQiQCcbahsK4+oipGg+nHxSMDwG3OR6VRMptXaReWLR
 d6dw==
X-Gm-Message-State: APjAAAVXJ16oWgjgvP+1nmQbGDztDsrpbyxsNwUlW6nsN9lhT8+J6pQ0
 yCdGlYB/NzOpXEkd9UvBvWD8SA==
X-Google-Smtp-Source: APXvYqzpY4ROUXd8G0hwXZHXar6amEaC5KGCRQrcqxNtZ5zVKyTckqhD5vxHBj6hwSAAM8zT3ERyTg==
X-Received: by 2002:a25:abc7:: with SMTP id v65mr514540ybi.59.1570586839088;
 Tue, 08 Oct 2019 19:07:19 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id v63sm211802ywd.100.2019.10.08.19.07.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 19:07:18 -0700 (PDT)
Subject: Re: [PATCH v2 20/21] hw/watchdog/cmsdk-apb-watchdog.c: Switch to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <120aed7a-ef86-900a-c0fa-3525b94584f8@linaro.org>
Date: Tue, 8 Oct 2019 22:06:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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
> Switch the cmsdk-apb-watchdog code away from bottom-half based
> ptimers to the new transaction-based ptimer API.  This just requires
> adding begin/commit calls around the various places that modify the
> ptimer state, and using the new ptimer_init() function to create the
> timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/watchdog/cmsdk-apb-watchdog.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

