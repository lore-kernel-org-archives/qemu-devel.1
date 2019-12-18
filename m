Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF57C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC5121582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJcHAYc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC5121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdtV-0006Am-OL
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 13:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihdsj-0005j0-AD
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihdsh-0004X1-O8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:17:08 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihdsh-0004SQ-Dr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:17:07 -0500
Received: by mail-pg1-x543.google.com with SMTP id b9so1671332pgk.12
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u6leAVKk6Ni7i3OvVcb4O07P4mjwqpmWf9LdTxLjvEU=;
 b=IJcHAYc7sBEUzaQtfcP37iDL2bQtyy7ofvbaCOtNzpF5yqsRuSy+2yoKoy6ZfiANSo
 jQvmnCu+VOmTzkEacFRZRisqqDlpmHy3OxbQaYCqFvtp68jYD4AC49/XC+yTjaug3kMr
 dBKV4l9diG+s91LVWDLv07Yay3IvE4H9zfKKxELLSuhbrVoRuqFywFP68oGO1CqvUvg4
 9SLZN/3CzzftMtqH5Yzpdm9NyOYGbB3VxCFAMGFOdxtzUvMSusxHPI+4waAdGoj9Be4z
 kX8tGf2TCi6e2aQCqWw27FNKFukKbFv69YbZv3EZFTAmgbjVVlYGSbJrt79Y8Hba7m3u
 g4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u6leAVKk6Ni7i3OvVcb4O07P4mjwqpmWf9LdTxLjvEU=;
 b=MXn5hAWhYH4aIRuTnjW4+voN0Qmd/JT6UhXAwuCxxRpOfDpTePD41vAsa3kSFr59kk
 z6DMAVxfKeeAL/5MHvSU2paOKd6ABuzSOoQVlfjNF1OvmdKG2h935drQe/2hGpFVa/ox
 dRLH1r3X4b3G7MlitEuLje6ayh8Sg8pTAavpUUCkvQy6X9Vfq+E/tDwK2zNkT8PWZZ6s
 3ztenUMjPajAliIpMvsqIhacHMdBcQC4/C5ycyqzufl73FELMk5kHAtuTL71XGpDN6sF
 YUtDZZZls1V2OwPMwda/IFZe2ZZ010HcZRyPvJIjJwiPVMw6jojYkk752E1YUdyfBE8l
 sm9g==
X-Gm-Message-State: APjAAAWx8b5s42pW+uEvb8T0A76bhvyoZo1DIjKa+7YSxZWpUm+03Zdy
 +GvShUQ+yLpYnBt2AaF3TRjRQg==
X-Google-Smtp-Source: APXvYqzVw6QbLTCCEv/0oUUB6KaeolXFNxTzQ8B6tQr6EMXXkyXkVkC2gYYBJ4IdYzZveKyNQ+eNcQ==
X-Received: by 2002:a63:150d:: with SMTP id v13mr4430055pgl.342.1576693026396; 
 Wed, 18 Dec 2019 10:17:06 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id b22sm1479430pft.110.2019.12.18.10.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 10:17:05 -0800 (PST)
Subject: Re: [PATCH v1 01/16] configure: allow disable of cross compilation
 containers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191216110732.24027-1-alex.bennee@linaro.org>
 <20191216110732.24027-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8c4d3bea-80ce-24e8-23a1-57fef7a4eeb1@linaro.org>
Date: Wed, 18 Dec 2019 08:17:02 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216110732.24027-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 Stefan Weil <sw@weilnetz.de>, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 1:07 AM, Alex Bennée wrote:
> Our docker infrastructure isn't quite as multiarch as we would wish so
> lets allow the user to disable it if they want. This will allow us to
> use still run check-tcg on non-x86 CI setups.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> ---
>  configure              | 8 +++++++-
>  tests/tcg/configure.sh | 6 ++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>


r~

