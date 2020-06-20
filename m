Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CA6C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 00:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233FB229C6
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 00:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MTu31agN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233FB229C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmRGT-0008UL-DW
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 20:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmRFG-0005uE-F4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 20:20:30 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmRFE-0007jZ-SN
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 20:20:30 -0400
Received: by mail-pf1-x442.google.com with SMTP id b5so5177436pfp.9
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=n6p6/2HsflTlF0NP/E8+DuGE3ZwSEEr4PTYR+4kWUjU=;
 b=MTu31agNZDHK4QcIA/OA8+LkQdcQdBN0o7QX2DLPW2iO/0vEk2cki9ET1vXkE1GtIU
 ZNChzEHtS/TVVqAgYQljDucVasfkU9h487NrzTYSwglvjWWfpX4bGRgNjs+NrE/AVKD9
 g6ZmzEZ16m33icoE+OFic7HvfPJCEPOjP4PDkxwfHcVcU8S4uw/g1jsPshgSewkvP9no
 1g3cFTNBbtx6eKAPCE3r1sINfkFpb9cQqYtVpttsaOYf6Czwg2jIlC/4hgdAxT3y6Zkq
 9/K1yGlBIJlwruecX1h3gG/ipcGVlNslRlCfWRmIZWO0HyZLlOY0JR+04XIylEwtJLuE
 YT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n6p6/2HsflTlF0NP/E8+DuGE3ZwSEEr4PTYR+4kWUjU=;
 b=aSjreTuT5dxXdPtVAV4BgHIItZpIC9nudA5s3FhtnNV0NCMNzmy4gHrlAAYct82Wcc
 A+462V2nxb1WMsKVovav+hkSjRWMXs8f0aOgH0EiUPHEr5cbATakj2uNicEd2MVOaNOP
 hfDaQhSc8cMZU/dJKQmwgkGb+0NucJ/XG+7KPvKw1uOZN+weyQnVqh74JlUGISy964/S
 KCsf2va3ENaslTKf8DzuJBc3uTBb+bjXr7d774RrEzPfQW+ihw+trs8hNgbNbqfKgbHM
 bs0QvvQtF8w+NmQCvTj+Sa9azAF1cAAz3HAH7aLsE0Ne/H6MrpFjwnmPHas8hbXiilyk
 Ygjg==
X-Gm-Message-State: AOAM531NRwf9zErx2zdkr/0kAoKvozVt5Pyw5YHAxT7YcBpKag6JtycW
 eWJvAR68zu+NKLyj+bHEezfmWAjPM+4=
X-Google-Smtp-Source: ABdhPJz6/i+nLne19mDg+5k73A1ZDILXLHuuAoOyMkakamD5jaMOaGiBi73L2Y5y6xFb+ZoDo/zHaA==
X-Received: by 2002:aa7:9818:: with SMTP id e24mr10646998pfl.30.1592612426988; 
 Fri, 19 Jun 2020 17:20:26 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id mw5sm7105235pjb.27.2020.06.19.17.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 17:20:26 -0700 (PDT)
Subject: Re: [PATCH 20/21] target/arm: Convert Neon VTRN to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <306a2904-eea0-8d9c-b7f3-931734d68ffa@linaro.org>
Date: Fri, 19 Jun 2020 17:20:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On 6/16/20 10:08 AM, Peter Maydell wrote:
> Convert the Neon VTRN insn to decodetree. This is the last insn in the
> Neon data-processing group, so we can remove all the now-unused old
> decoder framework.
> 
> It's possible that there's a more efficient implementation of
> VTRN, but for this conversion we just copy the existing approach.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |   2 +-
>  target/arm/translate-neon.inc.c |  90 ++++++++
>  target/arm/translate.c          | 363 +-------------------------------
>  3 files changed, 93 insertions(+), 362 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


