Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D686C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187B120870
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+4HoSk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187B120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1B8k-0000rD-MH
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1Aso-0000JN-LI
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1Asn-00067U-Hs
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:49:42 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1Asn-00066s-Az
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:49:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id go14so5706562plb.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QxO2uVfnR+ASBjD1E44tju9xARYVi3V8cmVvh6cGfKU=;
 b=Q+4HoSk6ExxjL5qeds/YT6DBmMr0cgBP3loCMshobrahFbjq+JDOn1FT7FOi9jEcUf
 pBro/03MTfwW1C5w1yhf9xsUnmp0KutH5kXuTkogrS9TbbuwEX7gTIJMZE8dCstjavWF
 wx7vmn+BG9Q+7FgzuHhTDS7hqaWJWjYfLj+PfHXX6yTKIKylocgyNX6pOnVJ9fALSKsn
 EWXUxWJclKpxB2DlXkGjw8OsI0uZR583h5UvKU+5o7WLTDOdJKD9w58bHCmJuIwax9PI
 RHqsQ+z67X9XlriPG/7nTqyhvFwTwmN298k6+60Ou4FU+dDAA9cDL7ybuTHDl835dWl0
 j0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QxO2uVfnR+ASBjD1E44tju9xARYVi3V8cmVvh6cGfKU=;
 b=fT8fMbIoVLupkVGVJaG0pUEC4erv73ozopUdiLarnRhiLhnWUDunKyQ762n+/IpZf0
 bORToUX6PXh0kOTZHVZAwPOfhk43wURtrr6CzC7U2uolB4IE+QSnL75ciWcKcgXtMMt9
 2LWyhRUbzaM9C5g/gbtb7Y5hEfv5e69kbTI6xTtzTgJEZosF8XTm42VN3V5eVMf/dtp5
 Bkc2kQu63uKpyzRgE/qDMDqhHoqozoJwoOAkIC9uG4Vrgi0ttlF4dIldEJvOi+WLpYTj
 cF2dy/AIwMPeBEViSOYkHRUpg3nI3gPFYh2iGRhzzK9mdgjCrOwglVr8ILW13XtdlJcy
 9Ayw==
X-Gm-Message-State: APjAAAV3ofsYRN38clMT92+vNhukTJH1vv+oYaZ+cJzCCIgCIlQgf+P8
 A8N0Mduh+JXaUdfTIoqLqV89tg==
X-Google-Smtp-Source: APXvYqzanQ9kT/4BdN5OgPUL6JfjPxbZxX4Be3SPQD8wywyW89t9/UPFrZdm5nIUoFbsg+O/eOn1uQ==
X-Received: by 2002:a17:902:e413:: with SMTP id
 ci19mr5296312plb.256.1566571780235; 
 Fri, 23 Aug 2019 07:49:40 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id o4sm9068318pje.28.2019.08.23.07.49.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 07:49:39 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190823100741.9621-1-david@redhat.com>
 <20190823100741.9621-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <529817b0-9109-7ec9-674f-181a32966857@linaro.org>
Date: Fri, 23 Aug 2019 07:49:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823100741.9621-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v1 1/9] s390x/tcg: Use guest_addr_valid()
 instead of h2g_valid() in probe_write_access()
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 3:07 AM, David Hildenbrand wrote:
> If I'm not completely wrong, we are dealing with guest addresses here
> and not with host addresses. Use the right check.
> 
> Fixes: c5a7392cfb96 ("s390x/tcg: Provide probe_write_access helper")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

