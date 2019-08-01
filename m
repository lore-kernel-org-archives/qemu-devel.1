Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91342C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD1E20838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpjA7NrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD1E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htGk8-0002r6-IK
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 15:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44263)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htGj7-00028s-NW
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htGj6-0002ji-Ox
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:27:01 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htGj6-0002iq-Ib
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:27:00 -0400
Received: by mail-pg1-x542.google.com with SMTP id k189so15694184pgk.13
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 12:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=51VxjLFlzEPbO73RJXyEKrKot3iKeOi5BPqCsFw8aGE=;
 b=kpjA7NrC2NxXT9y2frPg6omNj9q+rm2MF02sU4+17e9+SDqd/EpldXttIC7vJIiZt4
 VPXzjMKuhhx7I/8vv1aopz4C9FseN4ygdiNFSmJt87v/BmSH0DUhIIF5C237zS3goj0S
 O+YiWTI5oq9c/ukf/lDhSTSKF0EOGIyTiL08wvyqXL4iTL6lfiK1eiTgjIUdUXHLFCPc
 K/ZS7iOLEMkcRzLe0KWJGnG8TR9Y3VIsy8MNOU519IaAm++Zsi7o8W5mvDSqMKZviQjJ
 HU0moPuB8OJ2hgdldpwnUtuC8a9W3v20M8t9+iofNRt2urLAhTOPajLH9P3NRWqTbFIg
 qgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=51VxjLFlzEPbO73RJXyEKrKot3iKeOi5BPqCsFw8aGE=;
 b=lLbu8MshVwgoDh1kPWZEdMA3vrMNZCR3RjW0miIuZvH9jkO3k304jOjM6sSlF2a7De
 Y2l+N3j/+mFklTa+DrrbZSk/ATKeuHXZws/EuDrK4zIUIGopcNgjwj2blckZpH29TqcK
 0b81kLYEv7ecMhGBXFdYruDddCLGtUkFINoTvGZ4pEehgdY4O2LcS/CADREtmukTx25g
 9hD03aD2vaqz3PsT/iJguY0axe+r6pFNYPtWWRikqHfw4DwlUaTbuz9239PI7nLO2Lef
 hZLy0jF591Us41oznYMqPkd16sQ944Zpc2Gbp608ulsDAA1wFhLHSqrQ+DIhyKj007cT
 greA==
X-Gm-Message-State: APjAAAWoI9+J92c+joutdXzYPLzFg/Gx8wjSzLcTmKfOIKiXnu4VIBVr
 Cf7b+MPH4Cmpe3VqQFT713t/rA==
X-Google-Smtp-Source: APXvYqzDj1gejIcJJDOXQf4RlfIzh+mXRGvAdy1rHecYCH4310V9WJckhjxDpI3YQdQ035yL0rv81A==
X-Received: by 2002:a62:7890:: with SMTP id
 t138mr46255816pfc.238.1564687619426; 
 Thu, 01 Aug 2019 12:26:59 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v12sm65415339pgr.86.2019.08.01.12.26.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 12:26:58 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-32-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <09e07904-b8d0-a779-e018-9700795a6e57@linaro.org>
Date: Thu, 1 Aug 2019 12:26:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-32-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v4 31/54] target/arm: fetch code with
 translator_ld
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
Cc: Peter Maydell <peter.maydell@linaro.org>, aaron@os.amperecomputing.com,
 cota@braap.org, bobby.prani@gmail.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Now the arm_ld*_code functions are only used at translate time we can
> just pass down to translator_ld functions.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [AJB: convert from plugin_insn_append to translator_ld]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v4
>   - use translator_ld like the rest of them
> ---
>  target/arm/arm_ldst.h | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


