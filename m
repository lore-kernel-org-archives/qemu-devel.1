Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5D3C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8702087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j9/t5MCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8702087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htaVX-0006H8-AZ
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htaUX-0005g6-U3
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htaUV-0007If-Vd
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:33:17 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htaUU-0007H6-Dd
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:33:15 -0400
Received: by mail-pf1-x442.google.com with SMTP id r7so36303297pfl.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y3SBkKt/bAn0VxqA0AbUooNma5BupktkPNhWPGGOtj4=;
 b=j9/t5MCOCeNrtdH+K/H3D03ESAxKCNaE4O5hzmtc8Xs2IzetwqvrGs4aQtl0QpdzEi
 rsRSHuiUJurB1nDjuyL0psutERDXZEGxTkoDJDeK10MeW/CG9vuOZ/5OKAKnPFNawU43
 xOacPF8Z+QFD15ZnxsrIfVKFYC0xNXbaUhKsr0GtroPN4EHDc/dzY/JYIRTY6A7nGXVr
 k0byjX31H3XadDuYLFLKtxT+kUhDJN5AENIFHG5BQt8teklc8+licyIqpFDdunCQiTOz
 YAO6SXeRScSYWZCZj2dyKXr9qsEnDjbNpD1CSoyfQ6JKsYmwSD97yhObrhLKTrKifCvC
 GzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y3SBkKt/bAn0VxqA0AbUooNma5BupktkPNhWPGGOtj4=;
 b=prosa3EzklXZnF+AECvdmwfpGpWZi/6WvPRIUnScRz/cs5GAVD7ep5YtG6Lw1lMosT
 iG72YrFGnbtMn8wv0EM1hHElJrzc97vEmLVPOLxNt0yFbA7YV+0GYcE6hTYlms3swLr9
 XwNa+Ebba22v8GBww9MPva5lhqWXIaBR7ORkdZlJ6zGB8d5T7M5RTvEGhcerYGjiuIK3
 F1NaRrnWdeSyluI5LO2ecz/6JAMcQnpMSThbuEgPsDho0MAVRo7jIbomro6O+Id9m3pI
 eFaafIb7DB2Tfgra8wxy5UJ/gEEHklMmGYl1j9LDeYpViAXQiyjwx6amKQJhVHUfgj3n
 Rzag==
X-Gm-Message-State: APjAAAX9PtH5AggLXNl+BtgmzfTZnT5CCneIBpZMDo64fCM9dhVcYrQM
 qjPS9m0cAF4zDdOoFgkWZC5I8g==
X-Google-Smtp-Source: APXvYqwi63evdxZ7AclrTbZu3+JAKRqYlIZ33XJRToMMh88pQCbuf2wkQ6I9VeGvlaeDPbPQnNCFXw==
X-Received: by 2002:a63:5a0a:: with SMTP id o10mr52639467pgb.282.1564763593161; 
 Fri, 02 Aug 2019 09:33:13 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id c70sm34970414pfb.36.2019.08.02.09.33.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:33:12 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-7-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0c3aa3e7-fed4-e90a-3c2c-47702ddabae0@linaro.org>
Date: Fri, 2 Aug 2019 09:33:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802122540.26385-7-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 06/15] target/arm/cpu: Use div-round-up
 to determine predicate register array size
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/2/19 5:25 AM, Andrew Jones wrote:
> Unless we're guaranteed to always increase ARM_MAX_VQ by a multiple of
> four, then we should use DIV_ROUND_UP to ensure we get an appropriate
> array size.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

