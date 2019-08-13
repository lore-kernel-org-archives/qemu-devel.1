Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1DAC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D3A2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MupC2yGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D3A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWe5-0008Fd-Ia
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57938)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWdf-0007hi-Od
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWde-0002Wg-RO
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:14:59 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxWde-0002VN-GH
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:14:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id v19so1410855wmj.5
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SMQJCoAMTDi1q6mpwI+KqJCmx215XFu1CxLUncpIM5g=;
 b=MupC2yGeQy9IzCU/kXjyBGIpSoRS+Nb4Omm7ReXP5ueHZHrJIUDjeGROq17peJXcIw
 oeUeXf2D1DjsNh+OBYS4y9k+sFE9iJM9VZo+Rw2fKfgbh1QWLNsteGGKXUvezTTH9VGN
 PstRhgvB376/trK14uCyS4Lcwwg27U6mqkEUrtq4JIbK2co6oiNeVuP8FTctmAAf/jEd
 EG5UJJtyTQcYDaeNiy3K0tJoapngyzyDI0GFj5l+KI/QrBRL3WI9GBd1HXHv2NhT3zqT
 CwQhKJDpuHSsX/T10d4VBLTN26ICz7f6hCeIBpNn62nK8Dksy5E2CgeCX1hAqBJrxDSi
 8RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SMQJCoAMTDi1q6mpwI+KqJCmx215XFu1CxLUncpIM5g=;
 b=K6SH0G/OzPKjQM+OUu+5JJ26jsgyrqTAZqoIWgKlHH4+H+yNtCrxkR4Z6FQCNC8sM6
 fORBw10qqXmNTYWbEWISM6iWI3KO+xiMin1a0rHS9Y6+nKQ/VJobBcPhYQe8Y1aG7VS9
 3GwamtGsfLWSOAHHNjh3CLTmSCm8wEfgAenWMdtr+y3o7a3wV5m7JwCpSWRLcKsUGTx5
 gUsoYTwbMIG/hJ9pP8YJE+D/OYY58djYSnW7b+82Y6sIdO5a00uPhF7S90nHpIy/wACN
 nFNJsqwxfsE0yGhXF94AKQtNtCKggHdxs4GmBkpapINjPWHQt+Xfr1S7ffQlGhQHIMH9
 JEJQ==
X-Gm-Message-State: APjAAAXRciclMhL4ti3ClzPxIENTShbDsMbkCv7tiszvLXIwt0IZSd/s
 4WkznTc4FDLVaC4LdDz3A5ubmw==
X-Google-Smtp-Source: APXvYqyJtvmxXodeecDINnHesK56s3hAslSwXkdpVHHWQpjlqvNYTVEQwg7iwkPsk04+ghruJuKKFA==
X-Received: by 2002:a05:600c:24cb:: with SMTP id
 11mr3084579wmu.94.1565702096904; 
 Tue, 13 Aug 2019 06:14:56 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id o9sm13930908wrm.88.2019.08.13.06.14.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 06:14:56 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f18d2e19-50d7-ff8b-eff4-214c133c63d0@linaro.org>
Date: Tue, 13 Aug 2019 14:14:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813124946.25322-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 05/13] fpu: replace LIT64 with UINT64_C
 macros
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
Cc: Peter Maydell <peter.maydell@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 1:49 PM, Alex Bennée wrote:
> In our quest to eliminate the home rolled LIT64 macro we fixup usage
> inside the softfloat code. While we are at it we remove some of the
> extraneous spaces to closer fit the house style.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c                | 118 ++++++++++++++++-----------------
>  include/fpu/softfloat-macros.h |   6 +-
>  2 files changed, 62 insertions(+), 62 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


