Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6618C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7193E21721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 19:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wi7Sgpe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7193E21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHvOF-0007ou-0H
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 15:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHvKE-00062S-OK
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHvKD-0008CQ-GF
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:39:14 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHvKB-0008C0-O3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 15:39:12 -0400
Received: by mail-yb1-xb41.google.com with SMTP id r68so408678ybf.5
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YvGikPH3Y8tgkRDvhqF37VMNlvkSyrSOi/7xH+tXCTQ=;
 b=Wi7Sgpe/c0N+py6szCGWVkIcIRqEK7Gxxlv3LSQ96ACNfFNZpSoC605Wegyi72SNQ5
 0j0r0Z/63Fx8mv4beiJd0MI6ZeNR03pFUaSBbifOJRZ3riEMlZAjJG1iaRb9giOvn8dG
 6HvencONyWBijWP/kx8P3MEw/G7Gx+tjw2/7dxss9bErCMTrBT2F7K5gep5cqKXYiJMF
 FngDojYEhl3TNSkpCfvBg3hsfqPC6RmkMjRCzzhayw9g891D4mzZkuI6ur4n2S0xKkqS
 QIgtcIW9pEacL2jAVCDP76mJELVkgGjZV32jKxljch81r68iR8q4vGhXukX3xRVxDCUq
 gp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YvGikPH3Y8tgkRDvhqF37VMNlvkSyrSOi/7xH+tXCTQ=;
 b=nTyHywsUuJLFf4jZm3ykAcmDD1Z2euiPThhrA90bnyob0UnNfgmBTrsN4W/tziuv7b
 BhIRLTNSITpLBzQF2qT5fjd7omT2taqmCDIriYbbvOPei4MbzkOIDh4sQItraxfer/Al
 Tl6yJYbKFT+zaAYvZgIQPBmDgRr48iezsCCRXXaau3XgmXolIMg8ugrWNzg3yi0cR83p
 9iHi4DFu6D4ZGqZ6CD9h9FuTATQfWcu/nG3Nj/AK6Yj13xLWlPHBwz2beFXU5D9UAfgk
 sBREplYiXzj2kccqcwCjZ5/WMXaQPJDNpd9q3aq/Chdpm/vB+iliYQ4A/9m5/gCvh6fQ
 xHDQ==
X-Gm-Message-State: APjAAAVem0J/9kb+J0AczD6lBwz2HgLk47A8KmdF29wVuxkmFA8MrQux
 EjHjCvxD4mZTEaSCO9wEykbLXg==
X-Google-Smtp-Source: APXvYqzegixEIt924j8BjNOchwB3ByOy9oVjxoRb1wn97WNxv6XNMgqzPJOtzMu+EtDsRPR/78sYDg==
X-Received: by 2002:a25:2109:: with SMTP id h9mr1738026ybh.56.1570563551096;
 Tue, 08 Oct 2019 12:39:11 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id r63sm4937444ywg.36.2019.10.08.12.39.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 12:39:10 -0700 (PDT)
Subject: Re: [PATCH v9 13/13] configure: remove the final bits of --profiler
 support
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191007152839.30804-1-alex.bennee@linaro.org>
 <20191007152839.30804-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <051b3587-7cd9-5ac9-baa5-26b0c6ea3158@linaro.org>
Date: Tue, 8 Oct 2019 15:39:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007152839.30804-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:28 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 5 -----
>  1 file changed, 5 deletions(-)

Merge this with the patch that removes CONFIG_PROFILER.


r~

