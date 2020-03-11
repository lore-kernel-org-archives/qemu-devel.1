Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17DCC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E462073E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5BxG3pL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E462073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC5Mw-0007X3-QS
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jC5ML-00077A-Iz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jC5MK-0005FM-Fu
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:41:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jC5MK-0005C2-7m
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:41:32 -0400
Received: by mail-pg1-x544.google.com with SMTP id c7so1592790pgw.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 10:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eO1Z640DwGhjBrTEsVNXQChPDN/Zxd6MZsDIz0CFT2w=;
 b=A5BxG3pLEGe8e0TeN07B0iyvE9Gan0Wt6qK6Je3xcDa3yOiZpiJH+RInEZTHCadO8H
 Q3tfNx8y46bOCCkkglUc59E7eibSS1f+rlsP49jYUH2tb6SWg6Z6X5aCWuw4EbhnJy3p
 WOC53qZoOmI9WegbFXSs6lLC47XKaJRpLKTSZo9NMgDDaC4t45yxz72UPCw5wVHccbN1
 wjBNIdYED22bcNF6SJiftLc2DFbEVGsxDKvAgcVutm3bh7U3YJletCt6+4VPNheMjXYN
 /gHAUKkIUBnW7e4+sasWqNKxuDu+fq1S3BPUF9QZolto+dV+3ZIx1Fuo52wJLfucpg2M
 0+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eO1Z640DwGhjBrTEsVNXQChPDN/Zxd6MZsDIz0CFT2w=;
 b=RG/nNyy3uu4w9dVb9xeKgD09XoJf66KOSZhbwFt66V0UiZbX0qrvXT1OAQ2r0Lav2b
 DUCS0gVu+4IEX+LAMzJwrFuQbIhgQrtDml6IlJemBf6x1NoZDcUQpeJfbAJX4Qh6uFIk
 rER2T+VAO6jBqvKtkSxIkVYBJZSS5KXCkthkQpv6RMzFVQHBbEK3LZldQPVsrW8MiMsP
 Lklwrg4A4jPEQl3I+20ZbOZ1N+K7ZhjVHb7L2MKOuEurYMtlpZMV/NJ7P5b4DupCfVSj
 8UF07ziLdvovqV4Vs9CFHbeTwcdYD729m3Sb+TUjsD7/ITd2wGB3GaNDvlobX0TtylCb
 VpLQ==
X-Gm-Message-State: ANhLgQ3T1faCth8DbiiKDAFWjiYuTiN4X8ulnC6M2GwFoP8QMPJbDtfc
 E8iUFVRVPk1l5WL0rqSlk9kIew==
X-Google-Smtp-Source: ADFU+vvLiCEkFpzZuLsl4Eyw2KPFc9KGMSOZHscRAI3Cmn9wHoz1Ex+zqTYp9kaTDAPe2xN3EDiBAw==
X-Received: by 2002:a62:aa19:: with SMTP id e25mr4075786pff.202.1583948490975; 
 Wed, 11 Mar 2020 10:41:30 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 h2sm50112840pgv.40.2020.03.11.10.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 10:41:30 -0700 (PDT)
Subject: Re: [PATCH v4 18/21] linux-user,scripts: add a script to update
 syscall.tbl
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200310103403.3284090-1-laurent@vivier.eu>
 <20200310103403.3284090-19-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e86372fb-0729-0b44-0969-150ef6060600@linaro.org>
Date: Wed, 11 Mar 2020 10:41:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310103403.3284090-19-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Taylor Simpson <tsimpson@quicinc.com>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/10/20 3:34 AM, Laurent Vivier wrote:
> scripts/update-syscalltbl.sh has the list of syscall.tbl to update and
> can copy them from the linux source directory
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  MAINTAINERS                  |  1 +
>  scripts/update-syscalltbl.sh | 49 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>  create mode 100755 scripts/update-syscalltbl.sh

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

